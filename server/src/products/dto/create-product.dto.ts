import {
  IsArray,
  IsBoolean,
  IsEnum,
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

export class CreateProductDto {
  @IsNumber()
  @IsNotEmpty()
  storeId: number;

  @IsOptional()
  @IsNumber({}, { each: true })
  collections: number[];

  @IsNotEmpty()
  @IsEnum(ProductType)
  type: ProductType;

  @IsOptional()
  @IsString()
  title: string;

  @IsOptional()
  @IsString()
  description: string;

  @IsOptional()
  @IsArray()
  tags: string[];

  @IsOptional()
  @IsNumber()
  weight: number;

  @IsOptional()
  @IsEnum(WeightUnit)
  weightUnit: WeightUnit;

  @IsOptional()
  @IsNumber()
  width: number;

  @IsOptional()
  @IsNumber()
  height: number;

  @IsOptional()
  @IsNumber()
  depth: number;

  @IsOptional()
  @IsEnum(DimensionUnit)
  dimensionUnit: DimensionUnit;

  @IsOptional()
  @IsNumber()
  price: number;

  @IsOptional()
  @IsNumber()
  compareAtPrice: number;

  @IsOptional()
  @IsNumber()
  costPrice: number;

  @IsOptional()
  @IsString()
  currency: string;

  @IsOptional()
  @IsBoolean()
  taxable: boolean;

  @IsOptional()
  @IsBoolean()
  taxId: number;

  @IsOptional()
  @IsNumber({}, { each: true })
  categories: number[];

  @IsOptional()
  @IsNumber()
  brandId: number;

  @IsOptional()
  @IsNumber({}, { each: true })
  options: number[];

  @IsOptional()
  @IsNumber({}, { each: true })
  variants: number[];
}
