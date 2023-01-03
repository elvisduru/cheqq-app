import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  UseGuards,
} from '@nestjs/common';
import {
  GetCurrentUser,
  GetCurrentUserId,
  Public,
} from 'src/common/decorators';
import { RefreshTokenGuard } from 'src/common/guards';
import { AuthService } from './auth.service';
import { AuthDto, MagicUrlDto, TokenDto } from './dto';

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
    return this.authService.magicUrl({ ...data });
  }

  @Public()
  @Get('magic-link/:secret')
  verifyMagicToken(@Param('secret') secret: string) {
    return this.authService.verifyMagicToken(secret);
  }
}
