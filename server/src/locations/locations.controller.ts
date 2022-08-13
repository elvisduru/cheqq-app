import { Controller, Get, Query } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { Public } from 'src/common/decorators';
import { LocationsService } from './locations.service';

@Controller('locations')
export class LocationsController {
  constructor(private readonly locationsService: LocationsService) {}

  @Public()
  @Get('countries')
  findCountries(@Query() query: any) {
    const filter: Prisma.CountryWhereInput = query?.filter
      ? JSON.parse(query.filter)
      : {};
    delete query.filter;
    const pagination = {
      take: +query.take,
      skip: +query.skip,
      cursor: +query.cursor,
    };
    return this.locationsService.findAll({ ...filter }, pagination);
  }
}
