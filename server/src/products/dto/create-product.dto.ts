import {
  Image,
  Prisma,
  ProductOption,
  ProductVariant,
  Video,
} from '@prisma/client';
import {
  IsArray,
  IsBoolean,
  IsDate,
  IsEnum,
  IsInt,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export enum ProductType {
  physical = 'physical',
  digital = 'digital',
}

export enum WeightUnit {
  kg = 'kg',
  g = 'g',
  oz = 'oz',
  lb = 'lb',
}

export enum DimensionUnit {
  cm = 'cm',
  m = 'm',
  in = 'in',
}

enum ProductAvailability {
  available = 'available',
  disabled = 'disabled',
  preorder = 'preorder',
}

enum Condition {
  new = 'new',
  used = 'used',
  refurbished = 'refurbished',
}

enum OpenGraphType {
  product = 'product',
  album = 'album',
  book = 'book',
  drink = 'drink',
  food = 'food',
  game = 'game',
  movie = 'movie',
  song = 'song',
  tv_show = 'tv_show',
}

enum SubscriptionInterval {
  day = 'day',
  week = 'week',
  month = 'month',
  year = 'year',
}

export class CreateProductDto {
  @IsNotEmpty()
  @IsInt()
  storeId: number;

  @IsOptional()
  @IsNumber({}, { each: true })
  collections?: number[];

  @IsNotEmpty()
  @IsEnum(ProductType)
  type: ProductType;

  @IsNotEmpty()
  @IsString()
  title: string;

  @IsNotEmpty()
  @IsString()
  description: string;

  @IsOptional()
  @IsArray()
  tags?: string[];

  @IsOptional()
  @IsNumber()
  weight?: number;

  @IsOptional()
  @IsEnum(WeightUnit)
  weightUnit?: WeightUnit;

  @IsOptional()
  @IsNumber()
  width?: number;

  @IsOptional()
  @IsNumber()
  height?: number;

  @IsOptional()
  @IsNumber()
  depth?: number;

  @IsOptional()
  @IsEnum(DimensionUnit)
  dimensionUnit?: DimensionUnit;

  @IsOptional()
  @IsNumber()
  price?: number;

  @IsOptional()
  @IsNumber()
  compareAtPrice?: number;

  @IsOptional()
  @IsNumber()
  costPrice?: number;

  @IsNotEmpty()
  @IsString()
  currency: string;

  @IsOptional()
  @IsBoolean()
  taxable?: boolean;

  @IsOptional()
  @IsBoolean()
  taxId?: number;

  @IsOptional()
  @IsNumber({}, { each: true })
  categories?: number[];

  @IsOptional()
  @IsNumber()
  brandId?: number;

  @IsOptional()
  options?: ProductOption[];

  @IsOptional()
  variants?: ProductVariant[];

  @IsOptional()
  @IsBoolean()
  inventoryTracking?: boolean;

  @IsOptional()
  @IsBoolean()
  allowBackOrder?: boolean;

  @IsOptional()
  @IsNumber()
  inventoryLevel?: number;

  @IsOptional()
  @IsNumber()
  inventoryWarningLevel?: number;

  @IsOptional()
  @IsString()
  sku?: string;

  @IsOptional()
  @IsString()
  gtin?: string;

  @IsOptional()
  @IsBoolean()
  isFreeShipping?: boolean;

  @IsOptional()
  @IsNumber()
  fixedShippingRate?: number;

  @IsOptional()
  @IsBoolean()
  public = false;

  @IsOptional()
  @IsBoolean()
  featured = false;

  @IsOptional()
  @IsNumber({}, { each: true })
  relatedProducts?: number[];

  @IsOptional()
  @IsString()
  warranty?: string;

  @IsOptional()
  @IsString()
  layout?: string; // TODO: Layout enum

  @IsOptional()
  @IsEnum(ProductAvailability)
  availability?: ProductAvailability;

  @IsOptional()
  @IsString()
  availabilityLabel?: string;

  @IsOptional()
  @IsDate()
  preOrderReleaseDate?: Date;

  @IsOptional()
  @IsString()
  preOrderMessage?: string;

  @IsOptional()
  @IsBoolean()
  preOrderOnly = false;

  @IsOptional()
  @IsString()
  redirectUrl?: string;

  @IsOptional()
  @IsEnum(Condition)
  condition: Condition;

  @IsOptional()
  @IsBoolean()
  showCondition = false;

  @IsOptional()
  @IsString({ each: true })
  searchKeywords?: string[];

  @IsOptional()
  @IsString()
  pageTitle?: string;

  @IsOptional()
  @IsString()
  metaDescription?: string;

  @IsOptional()
  @IsString({ each: true })
  metaKeywords?: string[];

  @IsOptional()
  @IsNumber()
  viewCount = 0;

  @IsOptional()
  @IsString()
  customUrl?: string;

  @IsOptional()
  @IsString()
  openGraphTitle?: string;

  @IsOptional()
  @IsString()
  openGraphDescription?: string;

  @IsOptional()
  @IsEnum(OpenGraphType)
  openGraphType?: OpenGraphType;

  @IsOptional()
  @IsNumber()
  totalSold = 0;

  @IsOptional()
  @IsNumber()
  reviewCount = 0;

  @IsOptional()
  @IsNumber()
  reviewAverage = 0;

  @IsOptional()
  @IsArray()
  customFields?: Prisma.JsonArray;

  @IsOptional()
  @IsNumber({}, { each: true })
  pricingRules?: number[];

  @IsOptional()
  @IsArray()
  images?: Image[];

  @IsOptional()
  @IsArray()
  videos?: Video[];

  @IsOptional()
  @IsBoolean()
  subscription = false;

  @IsOptional()
  @IsEnum(SubscriptionInterval)
  subscriptionInterval?: SubscriptionInterval;

  @IsOptional()
  @IsNumber()
  subscriptionLength?: number;

  @IsOptional()
  @IsNumber()
  subscriptionPrice?: number;

  @IsOptional()
  @IsNumber({}, { each: true })
  giftWrapOptions?: number[];

  @IsOptional()
  @IsDate()
  createdAt?: Date;

  @IsOptional()
  @IsDate()
  updatedAt?: Date;
}
