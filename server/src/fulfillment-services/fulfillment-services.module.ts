import { Module } from '@nestjs/common';
import { FulfillmentServicesService } from './fulfillment-services.service';
import { FulfillmentServicesController } from './fulfillment-services.controller';

@Module({
  controllers: [FulfillmentServicesController],
  providers: [FulfillmentServicesService]
})
export class FulfillmentServicesModule {}
