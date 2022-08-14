import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateFulfillmentServiceDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  email: string;

  @IsNumber()
  @IsNotEmpty()
  storeId: number;
}
