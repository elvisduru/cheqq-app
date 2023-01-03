import { MailerService } from '@derech1e/mailer';
import {
  BadRequestException,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import * as argon2 from 'argon2';
import { randomBytes } from 'crypto';
import { PrismaService } from 'src/prisma/prisma.service';
import { AuthDto, MagicUrlDto } from './dto';
import { Tokens } from './types';

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

    if (user) throw new BadRequestException('User already exists');

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

  async magicUrl({ email, redirectUrl }: MagicUrlDto) {
    // Find user
    const foundUser = await this.prisma.user.findUnique({
      where: { email },
    });

    // If user does not exist, create new user
    if (!foundUser) {
      await this.prisma.user.create({
        data: {
          email,
        },
      });
    }

    // Create secret and save for user
    const secret = randomBytes(32).toString('hex');
    await this.prisma.user.update({
      where: { email },
      data: {
        magicSecret: secret,
        magicSecretExpiry: new Date(Date.now() + 3600000),
      },
    });

    // Send Email with magic token
    const res = await this.mailerService.sendMail({
      to: email,
      subject: 'Sign in to Cheqq',
      template: 'signin',
      context: {
        url: `${this.configService.get<string>(
          'APP_URL',
        )}/magic-link?email=${email}&secret=${secret}${
          redirectUrl ? `&redirect=${redirectUrl}` : ''
        }`,
      },
    });
    return res.response;
  }

  async verifyMagicToken(secret: string) {
    if (!secret) throw new ForbiddenException('No secret provided');
    const user = await this.prisma.user.findFirst({
      where: { magicSecret: secret, magicSecretExpiry: { gt: new Date() } },
    });
    if (!user) throw new ForbiddenException('No user found');

    const tokens = await this.getTokens(user.id, user.email);
    const hashedRefreshToken = await this.hashData(tokens.refresh_token);
    await this.prisma.user.update({
      where: { id: user.id },
      data: {
        hashedRefreshToken,
        magicSecret: null,
        magicSecretExpiry: null,
        active: true,
      },
    });
    return tokens;
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
