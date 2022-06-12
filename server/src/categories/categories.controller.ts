import { Controller, Get, Query } from '@nestjs/common';
import { Public } from 'src/common/decorators';
import { CategoriesService } from './categories.service';

@Controller('categories')
export class CategoriesController {
  constructor(private readonly categoriesService: CategoriesService) {}

  @Public()
  @Get()
  findAll(@Query() query: any) {
    return this.categoriesService.findAll(query);
  }
}
