import { Controller, Delete, Get, Patch, Post } from '@nestjs/common';
import { OrdersService } from './orders.service';

@Controller('orders')
export class OrdersController {
  constructor(private readonly ordersService: OrdersService) {}

  @Post()
  create() {}

  @Post('current')
  getOrdersForCurrentUser() {}

  @Get()
  findAll() {}

  @Get(':id')
  findById() {}

  @Patch('current')
  updateCurrent() {}

  @Patch(':id')
  updateById() {}

  @Delete(':id')
  remove() {}
}
