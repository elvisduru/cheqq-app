import {
  IsEmail,
  IsJWT,
  IsNotEmpty,
  IsOptional,
  IsString,
} from 'class-validator';

export class AuthDto {
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @IsString()
  password: string;
}

export class TokenDto {
  @IsNotEmpty()
  @IsJWT()
  access_token: string;

  @IsNotEmpty()
  @IsJWT()
  refresh_token: string;
}

export class MagicUrlDto {
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsOptional()
  secret?: string;
}
