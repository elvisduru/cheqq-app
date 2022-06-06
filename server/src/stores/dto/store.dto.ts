import {
  IsBoolean,
  IsEmail,
  IsFQDN,
  IsIn,
  IsInt,
  IsLocale,
  IsLowercase,
  IsNotEmpty,
  IsOptional,
  IsPhoneNumber,
  IsString,
  IsUrl,
} from 'class-validator';

enum StoreCategory {
  'Fashion' = 'Fashion',
  'Food & Grocery' = 'Food & Grocery',
  'Electronics' = 'Electronics',
  'Health & Beauty' = 'Health & Beauty',
  'Home & Office' = 'Home & Office',
  'Collectibles & Art' = 'Collectibles & Art',
  'Sports & Outdoors' = 'Sports & Outdoors',
  'Books, Movies & Music' = 'Books, Movies & Music',
  'Toys & Games' = 'Toys & Games',
  'Baby Essentials' = 'Baby Essentials',
  'Scientific & Industrial' = 'Scientific & Industrial',
  'Automotive' = 'Automotive',
  'Pet Supplies' = 'Pet Supplies',
  'Others' = 'Others',
}

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

  @IsIn(Object.values(StoreCategory))
  category: string;

  @IsBoolean()
  public: boolean = false;
}
