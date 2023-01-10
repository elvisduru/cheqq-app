import { Controller, Get, Ip, Param, Query } from '@nestjs/common';
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
    return this.locationsService.findAll(
      { ...filter },
      pagination,
      !!query.states,
    );
  }

  /**
   * Get country by iso2
   */
  @Public()
  @Get('countries/:iso2')
  findCountryByIso2(
    @Param('iso2') iso2: string,
    @Query('states') states: string,
  ) {
    return this.locationsService.findOne({ iso2 }, !!states);
  }

  /**
   * Get location by ip address from request
   */
  @Public()
  @Get('ip')
  findLocationByIp(@Ip() ip: string) {
    return this.locationsService.findLocationByIp(ip);
  }
}
