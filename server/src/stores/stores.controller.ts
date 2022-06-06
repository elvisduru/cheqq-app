import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { GetCurrentUserId } from 'src/common/decorators';
import { CreateStoreDto } from './dto/store.dto';
import { StoresService } from './stores.service';

@Controller('stores')
export class StoresController {
  constructor(private readonly storesService: StoresService) {}

  @Post()
  create(@Body() data: CreateStoreDto) {
    return this.storesService.create(data);
  }

  @Get()
  findAll(@Query() query: any) {
    const filter: Prisma.StoreWhereInput = JSON.parse(query.filter);
    delete query.filter;
    const pagination = {
      take: +query.take,
      skip: +query.skip,
      cursor: +query.cursor,
    };
    return this.storesService.findAll({ ...filter }, pagination);
  }

  @Get('current')
  getOrdersForCurrentUser(@GetCurrentUserId() userId: number) {
    return this.storesService.findAll({ ownerId: userId });
  }

  @Get('tag/:tag')
  findByTag(@Param('tag') tag: string) {
    return this.storesService.findByTag(tag);
  }

  @Get(':id')
  findById(@Param('id') id: string) {
    if (isNaN(+id)) throw new BadRequestException('Invalid id');
    return this.storesService.findById(+id);
  }

  @Patch('current')
  updateCurrent(
    @GetCurrentUserId() userId: number,
    @Body() updateOrderDto: Prisma.StoreUpdateInput,
  ) {
    return this.storesService.updateById(userId, updateOrderDto);
  }

  @Patch(':id')
  updateById(
    @Param('id') id: string,
    @Body() updateOrderDto: Prisma.StoreUpdateInput,
  ) {
    return this.storesService.updateById(+id, updateOrderDto);
  }

  @Delete(':id')
  removeById(@Param('id') id: string) {
    return this.storesService.removeById(+id);
  }
}
