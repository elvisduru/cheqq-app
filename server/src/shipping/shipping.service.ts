import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { Country, CreateShippingDto } from './dto/create-shipping.dto';
import { UpdateShippingDto } from './dto/update-shipping.dto';

@Injectable()
export class ShippingService {
  constructor(private prisma: PrismaService) {}
  async create(createShippingDto: CreateShippingDto) {
    const { name, storeId, locations, rates } = createShippingDto;

    return this.prisma.shippingZone.create({
      data: {
        store: {
          connect: { id: storeId },
        },
        name,
        rates: {
          create: rates,
        },
        locations: {
          create: locations.map((location) => ({
            states: {
              connect: location.states.map((state) => ({ id: state.id })),
            },
            country: {
              connect: { id: location.id },
            },
          })),
        },
      },
    });
  }

  findAll(storeId: number) {
    return this.prisma.shippingZone.findMany({ where: { storeId } });
  }

  findOne(id: number) {
    return this.prisma.shippingZone.findUnique({ where: { id } });
  }

  async update(id: number, updateShippingDto: UpdateShippingDto) {
    const { name, locations, rates } = updateShippingDto;

    // Update rates
    await this.prisma.$transaction(
      rates.map((rate) =>
        this.prisma.shippingRate.update({ where: { id: rate.id }, data: rate }),
      ),
    );

    return this.prisma.$transaction([
      this.prisma.shippingZone.update({
        where: { id },
        data: {
          name,
          rates: {
            update: rates.map((rate) => ({
              where: { id: rate.id },
              data: rate,
            })),
          },
          locations: {
            set: [],
            create: locations.map((location) => ({
              states: {
                connect: location.states.map((state) => ({ id: state.id })),
              },
              country: {
                connect: { id: location.id },
              },
            })),
          },
        },
      }),
    ]);
  }

  remove(id: number) {
    return this.prisma.shippingZone.delete({ where: { id } });
  }
}
