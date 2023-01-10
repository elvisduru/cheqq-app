import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { Country, Prisma } from '@prisma/client';
import axios from 'axios';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class LocationsService {
  constructor(private prisma: PrismaService) {}

  async findAll(
    where: Prisma.CountryWhereInput,
    pagination?: { take?: number; skip?: number; cursor?: number },
    states?: boolean,
  ): Promise<Country[]> {
    return this.prisma.country.findMany({
      where,
      take: pagination?.take || undefined,
      skip: pagination?.skip || 0,
      cursor: pagination?.cursor ? { id: pagination.cursor } : undefined,
      orderBy: {
        id: 'asc',
      },
      include: states ? { states: true } : undefined,
    });
  }

  async findOne(
    where: Prisma.CountryWhereInput,
    states?: boolean,
  ): Promise<Country> {
    return this.prisma.country.findFirstOrThrow({
      where,
      include: states ? { states: true } : undefined,
    });
  }

  async findLocationByIp(ip: string) {
    console.log(ip);
    // Find location from ipapi.co using axios
    const { data } = await axios.get(
      `https://ipapi.co/${ip.replace('::ffff:', '')}/json/`,
    );

    if (data.ip === '::1') {
      return this.findOne({ iso2: 'NG' });
    }

    if (data.error)
      throw new InternalServerErrorException(
        'Unable to find country from ip address',
      );
    // Find country from database
    return this.findOne({ iso2: data.country_code });
  }
}
