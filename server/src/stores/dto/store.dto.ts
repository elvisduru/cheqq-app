import { Prisma } from '@prisma/client';
import {
  IsBoolean,
  IsEmail,
  IsFQDN,
  IsInt,
  IsLocale,
  IsLowercase,
  IsNotEmpty,
  IsNumber,
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
  @IsString()
  name: string;

  @IsNotEmpty()
  @IsString()
  @IsLowercase()
  tag: string;

  @IsBoolean()
  status: boolean = true;

  @IsFQDN()
  @IsOptional()
  domain?: string | null;

  @IsNotEmpty()
  @IsString()
  address: string;

  @IsNotEmpty()
  @IsString()
  country: string;

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
  public: boolean = false;

  @IsNotEmpty()
  @IsObject()
  addressCoordinates: Prisma.JsonObject;
}
