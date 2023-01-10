import {
  IsArray,
  IsEmail,
  IsInt,
  IsISO4217CurrencyCode,
  IsNotEmpty,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator';

export class CreateCartDto {
  @IsOptional()
  @IsInt()
  customerId?: number;

  @IsISO4217CurrencyCode()
  @IsNotEmpty()
  currency: string;

  @IsString()
  @IsNotEmpty()
  currency_symbol: string;

  @IsArray()
  @IsNotEmpty()
  cartItems: CartItemDto[];
}

export class CartItemDto {
  @IsNotEmpty()
  @IsInt()
  productId: number;

  @IsNotEmpty()
  @IsInt()
  quantity: number;

  @IsOptional()
  @IsInt()
  variantId?: number;

  @IsOptional()
  @IsString()
  coupon?: string;
}
