import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateShippingDto } from './dto/create-shipping.dto';
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

  findAll() {
    return this.prisma.shippingZone.findMany();
  }

  findAllForStore(storeId: number) {
    return this.prisma.shippingZone.findMany({
      where: { storeId },
      include: {
        rates: true,
        locations: {
          include: { states: true, country: true },
        },
      },
    });
  }

  findOne(id: number) {
    return this.prisma.shippingZone.findUnique({ where: { id } });
  }

  async update(id: number, updateShippingDto: UpdateShippingDto) {
    const { name, locations, rates } = updateShippingDto;

    // Delete shippingZoneId from rates
    rates.forEach((rate) => {
      delete rate.shippingZoneId;
    });

    const deleteShippingRates = this.prisma.shippingRate.deleteMany({
      where: { shippingZoneId: id },
    });

    const updateShippingZone = this.prisma.shippingZone.update({
      where: { id },
      data: {
        name,
        rates: {
          create: rates,
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
    });

    return this.prisma.$transaction([deleteShippingRates, updateShippingZone]);
  }

  remove(id: number) {
    return this.prisma.shippingZone.delete({ where: { id } });
  }
}
