import { IsNotEmpty, IsNumber, IsOptional, IsUrl } from 'class-validator';

export class ImageDto {
  @IsNumber()
  @IsOptional()
  id?: number;

  @IsNotEmpty()
  @IsUrl()
  url: string;

  @IsNumber()
  @IsNotEmpty()
  sortOrder: number;

  @IsNumber()
  @IsNotEmpty()
  userId: number;
}
