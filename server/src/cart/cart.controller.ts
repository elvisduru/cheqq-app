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
import { Public } from 'src/common/decorators';
import { CartService } from './cart.service';
import { CartItemDto, CreateCartDto } from './dto/create-cart.dto';
import { UpdateCartDto, UpdateCartItemDto } from './dto/update-cart-dto';

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

  @Patch(':id')
  updateCart(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateCartDto: UpdateCartDto,
  ) {
    return this.cartService.updateCart(id, updateCartDto);
  }

  @Patch(':id/items/:itemId')
  updateCartItem(
    @Param('itemId', ParseIntPipe) id: number,
    @Body() updateCartItemDto: UpdateCartItemDto,
  ) {
    return this.cartService.updateCartItem(id, updateCartItemDto);
  }

  @Delete(':id/items/:itemId')
  removeCartItem(@Param('itemId', ParseIntPipe) id: number) {
    return this.cartService.removeCartItem(id);
  }

  @Delete(':id')
  deleteCart(@Param('id', ParseIntPipe) id: number) {
    return this.cartService.deleteCart(id);
  }
}
