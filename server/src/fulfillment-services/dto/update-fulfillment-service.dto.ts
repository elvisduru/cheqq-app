import { PartialType } from '@nestjs/swagger';
import { CreateFulfillmentServiceDto } from './create-fulfillment-service.dto';

export class UpdateFulfillmentServiceDto extends PartialType(
  CreateFulfillmentServiceDto,
) {}
