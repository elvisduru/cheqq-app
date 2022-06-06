import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBody } from '@nestjs/swagger';
import { Prisma } from '@prisma/client';
import { Request } from 'express';
import {
  GetCurrentUser,
  GetCurrentUserId,
  Public,
} from 'src/common/decorators';
import { AccessTokenGuard, RefreshTokenGuard } from 'src/common/guards';
import { AuthService } from './auth.service';
import { AuthDto, MagicUrlDto, TokenDto } from './dto';
import { Tokens } from './types';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Public()
  @Post('local/signup')
  @HttpCode(HttpStatus.CREATED)
  signupLocal(@Body() data: AuthDto): Promise<TokenDto> {
    return this.authService.signupLocal(data);
  }

  @Public()
  @Post('local/signin')
  @HttpCode(HttpStatus.OK)
  signinLocal(@Body() data: AuthDto): Promise<TokenDto> {
    return this.authService.signinLocal(data);
  }

  @Get('logout')
  logout(@GetCurrentUserId() userId: number) {
    this.authService.logout(userId);
  }

  @Public()
  @UseGuards(RefreshTokenGuard)
  @Get('refresh')
  refreshTokens(
    @GetCurrentUserId() userId: number,
    @GetCurrentUser('refreshToken') refreshToken: string,
  ): Promise<TokenDto> {
    return this.authService.refreshTokens(userId, refreshToken);
  }

  @Public()
  @Post('magic-link')
  @HttpCode(HttpStatus.OK)
  magicUrl(@Body() data: MagicUrlDto) {
    return this.authService.magicUrl(data.email);
  }

  @Public()
  @Get('magic-link/:secret')
  verifyMagicToken(@Param('secret') secret: string) {
    return this.authService.verifyMagicToken(secret);
  }
}
