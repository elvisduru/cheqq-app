import { IsNotEmpty, IsNumber, IsString, IsUrl } from 'class-validator';

export class ImageDto {
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
