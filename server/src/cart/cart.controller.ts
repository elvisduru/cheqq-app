import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Post,
} from '@nestjs/common';
import { Public } from 'src/common/decorators';
import { CartService } from './cart.service';
import { CartItemDto, CreateCartDto } from './dto/create-cart.dto';

@Public()
@Controller('cart')
export class CartController {
  constructor(private readonly cartService: CartService) {}

  @Post()
  create(@Body() createCartDto: CreateCartDto) {
    return this.cartService.create(createCartDto);
  }

  @Post(':id/items')
  addItem(
    @Param('id', ParseIntPipe) id: number,
    @Body() cartItem: CartItemDto,
  ) {
    return this.cartService.addCartItem(id, cartItem);
  }

  @Get()
  findAll() {
    return this.cartService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.cartService.findOne(+id);
  }

  @Delete(':id/item/:itemId')
  removeCartItem(@Param('id', ParseIntPipe) id: number) {
    return this.cartService.removeCartItem(id);
  }

  @Delete(':id')
  deleteCart(@Param('id', ParseIntPipe) id: number) {
    return this.cartService.deleteCart(id);
  }
}
