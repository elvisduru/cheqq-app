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
  currency: string;

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
