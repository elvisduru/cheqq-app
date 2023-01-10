import { PartialType } from '@nestjs/swagger';
import { CartItemDto, CreateCartDto } from './create-cart.dto';

export class UpdateCartDto extends PartialType(CreateCartDto) {}
export class UpdateCartItemDto extends PartialType(CartItemDto) {}
