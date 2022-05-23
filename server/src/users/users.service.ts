import { Injectable } from '@nestjs/common';
import { Prisma, User } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.UserCreateInput): Promise<User> {
    return this.prisma.user.create({ data });
  }

  async findAll(params?: Prisma.UserFindManyArgs): Promise<User[]> {
    return this.prisma.user.findMany({ ...params });
  }

  async findById(id: number): Promise<User> {
    return this.prisma.user.findUnique({
      where: {
        id,
      },
    });
  }

  async findOne(where: Prisma.UserWhereUniqueInput): Promise<User> {
    return this.prisma.user.findUnique({
      where,
    });
  }

  async updateById(
    id: number,
    updateOrderDto: Prisma.UserUpdateInput,
  ): Promise<User> {
    return this.prisma.user.update({
      where: { id },
      data: updateOrderDto,
    });
  }

  async removeById(id: number): Promise<User> {
    return this.prisma.user.delete({ where: { id } });
  }
}
