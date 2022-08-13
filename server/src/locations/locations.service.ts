import { Injectable } from '@nestjs/common';
import { Country, Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class LocationsService {
  constructor(private prisma: PrismaService) {}

  async findAll(
    where: Prisma.CountryWhereInput,
    pagination?: { take?: number; skip?: number; cursor?: number },
  ): Promise<Country[]> {
    return this.prisma.country.findMany({
      where,
      take: pagination?.take || undefined,
      skip: pagination?.skip || 0,
      cursor: pagination?.cursor ? { id: pagination.cursor } : undefined,
      orderBy: {
        id: 'asc',
      },
      include: {
        states: true,
      },
    });
  }
}
