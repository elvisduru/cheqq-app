import { Prisma } from '@prisma/client';
import {
  IsArray,
  IsEnum,
  IsJSON,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export enum rateType {
  carrier = 'carrier',
  custom = 'custom',
}

export enum rateCondition {
  weight = 'weight',
  price = 'price',
}

export enum transitTime {
  economy = 'economy',
  standard = 'standard',
  express = 'express',
  economyInternational = 'economyInternational',
  standardInternational = 'standardInternational',
  expressInternational = 'expressInternational',
  custom = 'custom',
}

export enum Carrier {
  DHL = 'DHL',
  UPS = 'UPS',
  USPS = 'USPS',
}

export class CreateShippingDto {
  @IsOptional()
  @IsNumber()
  id?: number;

  @IsNumber()
  @IsNotEmpty()
  storeId: number;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsArray()
  locations: Country[];

  @IsArray()
  rates: ShippingRate[];
}

export class ShippingRate {
  @IsOptional()
  @IsNumber()
  id?: number;

  @IsEnum(rateType)
  type: rateType;

  @IsEnum(transitTime)
  transitTime: transitTime;

  @IsString()
  customRateName?: string;

  @IsNumber()
  @IsNotEmpty()
  price: number;

  @IsEnum(rateCondition)
  rateCondition?: rateCondition;

  @IsNumber()
  rateConditionMin?: number;

  @IsNumber()
  rateConditionMax?: number;

  @IsEnum(Carrier)
  carrier?: Carrier; // TODO: Carrier enum

  @IsString({ each: true })
  services?: string[];

  @IsNumber()
  handlingFeePercent?: number;

  @IsNumber()
  handlingFeeFlat?: number;
}

export class Country {
  @IsOptional()
  @IsNumber()
  id?: number;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  iso3: string;

  @IsString()
  @IsNotEmpty()
  iso2: string;

  @IsString()
  @IsNotEmpty()
  numeric_code: string;

  @IsString()
  @IsNotEmpty()
  phone_code: string;

  @IsString()
  @IsNotEmpty()
  capital: string;

  @IsString()
  @IsNotEmpty()
  currency: string;

  @IsString()
  @IsNotEmpty()
  currency_name: string;

  @IsString()
  @IsNotEmpty()
  currency_symbol: string;

  @IsString()
  @IsNotEmpty()
  tld: string;

  @IsString()
  native: string | null;

  @IsString()
  @IsNotEmpty()
  region: string;

  @IsString()
  @IsNotEmpty()
  subregion: string;

  @IsArray()
  timezones: Prisma.JsonArray;

  @IsJSON()
  translations: Prisma.JsonObject;

  @IsString()
  latitude: string;

  @IsString()
  longitude: string;

  @IsString()
  emoji: string;

  @IsString()
  emojiU: string;

  @IsArray()
  states?: State[];
}

export class State {
  @IsOptional()
  @IsNumber()
  id?: number;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  state_code: string;

  @IsString()
  @IsNotEmpty()
  latitude: string;

  @IsString()
  @IsNotEmpty()
  longitude: string;

  @IsString()
  type: string | null;
}
