import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
} from '@nestjs/common';
import { CreateFulfillmentServiceDto } from './dto/create-fulfillment-service.dto';
import { UpdateFulfillmentServiceDto } from './dto/update-fulfillment-service.dto';
import { FulfillmentServicesService } from './fulfillment-services.service';

@Controller('fulfillment-services')
export class FulfillmentServicesController {
  constructor(
    private readonly fulfillmentServicesService: FulfillmentServicesService,
  ) {}

  @Post()
  create(@Body() createFulfillmentServiceDto: CreateFulfillmentServiceDto) {
    return this.fulfillmentServicesService.create(createFulfillmentServiceDto);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateFulfillmentServiceDto: UpdateFulfillmentServiceDto,
  ) {
    return this.fulfillmentServicesService.update(
      id,
      updateFulfillmentServiceDto,
    );
  }

  @Get()
  findAll() {
    return this.fulfillmentServicesService.findAll();
  }

  @Get('/store/:storeId')
  findAllForStore(@Param('storeId', ParseIntPipe) storeId: number) {
    return this.fulfillmentServicesService.findAllForStore(storeId);
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.fulfillmentServicesService.findOne(id);
  }

  @Delete(':id')
  delete(@Param('id', ParseIntPipe) id: number) {
    return this.fulfillmentServicesService.delete(id);
  }
}
