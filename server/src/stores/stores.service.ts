import { Injectable } from '@nestjs/common';
import { Prisma, Store } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateStoreDto } from './dto/store.dto';

@Injectable()
export class StoresService {
  constructor(private prisma: PrismaService) {}

  async create(data: CreateStoreDto): Promise<Store> {
    return this.prisma.store.create({ data });
  }

  async findAll(
    where: Prisma.StoreWhereInput,
    pagination?: { take?: number; skip?: number; cursor: number },
  ): Promise<Store[]> {
    return this.prisma.store.findMany({
      where,
      take: pagination.take || 10,
      skip: pagination.skip || 1,
      cursor: pagination.cursor ? { id: pagination.cursor } : undefined,
      orderBy: {
        id: 'asc',
      },
    });
  }

  async findById(id: number): Promise<Store> {
    return this.prisma.store.findUnique({
      where: {
        id,
      },
    });
  }

  async updateById(
    id: number,
    updateOrderDto: Prisma.StoreUpdateInput,
  ): Promise<Store> {
    return this.prisma.store.update({
      where: { id },
      data: updateOrderDto,
    });
  }

  removeById(id: number) {
    return this.prisma.store.delete({ where: { id } });
  }
}
