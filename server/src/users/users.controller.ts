import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { UsersService } from './users.service';
import { GetCurrentUserId } from '../common/decorators/get-current-user-id.decorator';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  create(@Body() data: Prisma.UserCreateInput) {
    return this.usersService.create(data);
  }

  @Get()
  findAll() {
    // TODO: implement findAll conditions
    return this.usersService.findAll();
  }

  @Get('current')
  getCurrentUser(@GetCurrentUserId() userId: number) {
    return this.usersService.findById(userId);
  }

  @Get(':id')
  findById(@Param() id: string) {
    return this.usersService.findById(+id);
  }

  @Patch('current')
  updateCurrentUser(
    @GetCurrentUserId() userId: number,
    @Body() updateUserDto: Prisma.UserUpdateInput,
  ) {
    return this.usersService.updateById(userId, updateUserDto);
  }

  @Patch(':id')
  updateById(
    @Param('id') id: string,
    @Body() updateUserDto: Prisma.UserUpdateInput,
  ) {
    return this.usersService.updateById(+id, updateUserDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.usersService.removeById(+id);
  }
}
