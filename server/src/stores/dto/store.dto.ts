import { Prisma } from '@prisma/client';
import {
  IsBoolean,
  IsEmail,
  IsFQDN,
  IsInt,
  IsLocale,
  IsLowercase,
  IsNotEmpty,
  IsObject,
  IsOptional,
  IsPhoneNumber,
  IsString,
  IsUrl,
} from 'class-validator';

export class CreateStoreDto {
  @IsNotEmpty()
  @IsInt()
  ownerId: number;

  @IsNotEmpty()
  @IsInt()
  countryId: number;

  @IsNotEmpty()
  @IsString()
  name: string;

  @IsNotEmpty()
  @IsString()
  @IsLowercase()
  tag: string;

  @IsBoolean()
  status = true;

  @IsFQDN()
  @IsOptional()
  domain?: string;

  @IsNotEmpty()
  @IsString()
  address: string;

  @IsNotEmpty()
  @IsPhoneNumber()
  phone: string;

  @IsEmail()
  @IsOptional()
  order_email?: string;

  @IsNotEmpty()
  @IsLocale()
  language: string;

  @IsNotEmpty()
  @IsString()
  currency: string;

  @IsUrl()
  @IsOptional()
  logo?: string;

  categories: number[];

  @IsBoolean()
  public = false;

  @IsOptional()
  @IsObject()
  addressCoordinates?: Prisma.JsonObject;
}
