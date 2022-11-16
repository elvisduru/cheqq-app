import { Injectable } from '@nestjs/common';
import { Prisma, Store } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateStoreDto } from './dto';

@Injectable()
export class StoresService {
  constructor(private prisma: PrismaService) {}

  async create(createStoreDto: CreateStoreDto): Promise<Store> {
    const { categories, ownerId, countryId, ...data } = createStoreDto;

    // Fetch country and states
    const states = await this.prisma.state.findMany({
      where: {
        country_id: countryId,
      },
    });

    return this.prisma.store.create({
      data: {
        ...data,
        owner: {
          connect: { id: ownerId },
        },
        country: { connect: { id: countryId } },
        categories: {
          connect: categories.map((category) => ({ id: category })),
        },
        shippingZones: {
          create: {
            name: 'Domestic',
            locations: {
              create: {
                country: {
                  connect: { id: countryId },
                },
                states: {
                  connect: states.map((state) => ({ id: state.id })),
                },
              },
            },
            rates: {
              create: [
                {
                  transitTime: 'economy',
                  price: 0,
                },
                {
                  transitTime: 'standard',
                  price: 9.99,
                  rateCondition: 'price',
                  rateConditionMin: 15.0,
                },
                {
                  transitTime: 'express',
                  price: 19.99,
                  rateCondition: 'weight',
                  rateConditionMin: 3.0,
                },
              ],
            },
          },
        },
      },
    });
  }

  async findAll(
    where: Prisma.StoreWhereInput,
    pagination?: { take?: number; skip?: number; cursor?: number },
  ): Promise<Store[]> {
    return this.prisma.store.findMany({
      where,
      take: pagination?.take || 10,
      skip: pagination?.skip || 0,
      cursor: pagination?.cursor ? { id: pagination.cursor } : undefined,
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
      include: {
        _count: {
          select: {
            followers: true,
            following: true,
          },
        },
      },
    });
  }

  async findByTag(tag: string) {
    return this.prisma.store.findUnique({
      where: {
        tag,
      },
      include: {
        _count: {
          select: {
            followers: true,
            following: true,
          },
        },
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
