import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { AuthDto } from './dto';
import * as argon2 from 'argon2';
import { Tokens } from './types';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { Prisma } from '@prisma/client';
import { MailerService } from '@derech1e/mailer';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
    private configService: ConfigService,
    private mailerService: MailerService,
  ) {}

  async signupLocal(data: AuthDto): Promise<Tokens> {
    // Check if user exists
    const user = await this.prisma.user.findUnique({
      where: { email: data.email },
    });

    if (user) throw new ForbiddenException('User already exists');

    const hash = await this.hashData(data.password);
    const newUser = await this.prisma.user.create({
      data: {
        email: data.email,
        password: hash,
      },
    });

    const tokens = await this.getTokens(newUser.id, newUser.email);
    await this.updateHashedRefreshToken(newUser.id, tokens.refresh_token);
    return tokens;
  }

  async signinLocal(data: AuthDto): Promise<Tokens> {
    const user = await this.prisma.user.findUnique({
      where: { email: data.email },
    });

    if (!user) throw new ForbiddenException('No user found');
    const passwordMatches = await argon2.verify(user.password, data.password);
    if (!passwordMatches) throw new ForbiddenException('Wrong password');
    const tokens = await this.getTokens(user.id, user.email);
    await this.updateHashedRefreshToken(user.id, tokens.refresh_token);
    return tokens;
  }

  async logout(userId: number) {
    await this.prisma.user.updateMany({
      where: {
        id: userId,
        hashedRefreshToken: {
          not: null,
        },
      },
      data: { hashedRefreshToken: null },
    });
  }

  async refreshTokens(userId: number, refreshToken: string): Promise<Tokens> {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });
    if (!user || !user.hashedRefreshToken)
      throw new ForbiddenException('Access Denied');
    const refreshTokenMatches = await argon2.verify(
      user.hashedRefreshToken,
      refreshToken,
    );
    if (!refreshTokenMatches) throw new ForbiddenException('Access Denied');
    const tokens = await this.getTokens(user.id, user.email);
    await this.updateHashedRefreshToken(user.id, tokens.refresh_token);
    return tokens;
  }

  async magicUrl(email: string) {
    let user: Prisma.UserGetPayload<{ select: { email: true; id: true } }>;
    
    // Find user
    const foundUser = await this.prisma.user.findUnique({
      where: { email },
    });

    // If user does not exist, create new user
    if (foundUser) {
      user = foundUser;
    } else {
      user = await this.prisma.user.create({
        data: {
          email,
        },
      });
    }

    const magicToken = await this.jwtService.signAsync(
      {
        sub: user.id,
        email,
      },
      {
        secret: this.configService.get<string>('JWT_MAGIC_URL_SECRET'),
        expiresIn: '1h',
      },
    );

    const hashedMagicToken = await this.hashData(magicToken);

    // Send Email with magic token
    const res = await this.mailerService.sendMail({
      to: email,
      subject: 'Sign in to Cheqq',
      template: 'signin',
      context: {
        url: `${this.configService.get<string>('APP_URL')}/magic-link/${hashedMagicToken}`,
      },
    });
    return res.response;
  }

  hashData(data: string) {
    return argon2.hash(data);
  }

  async updateHashedRefreshToken(userId: number, refreshToken: string) {
    const hashedRefreshToken = await this.hashData(refreshToken);
    await this.prisma.user.update({
      where: { id: userId },
      data: { hashedRefreshToken },
    });
  }

  async getTokens(userId: number, email: string) {
    const [access_token, refresh_token] = await Promise.all([
      this.jwtService.signAsync(
        {
          sub: userId,
          email,
        },
        {
          secret: this.configService.get<string>('JWT_ACCESS_SECRET'),
          expiresIn: '15m',
        },
      ),
      this.jwtService.signAsync(
        {
          sub: userId,
          email,
        },
        {
          secret: this.configService.get<string>('JWT_REFRESH_SECRET'),
          expiresIn: '7d',
        },
      ),
    ]);

    return {
      access_token,
      refresh_token,
    };
  }
}
