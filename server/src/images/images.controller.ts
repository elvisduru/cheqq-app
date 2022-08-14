import {
  Body,
  Controller,
  Delete,
  Param,
  ParseIntPipe,
  Post,
} from '@nestjs/common';
import { Image } from '@prisma/client';
import { ImageDto } from './dto';
import { ImagesService } from './images.service';

@Controller('images')
export class ImagesController {
  constructor(private readonly imagesService: ImagesService) {}

  @Post()
  create(@Body() data: ImageDto[]): Promise<Image[]> {
    return this.imagesService.create(data);
  }

  @Delete()
  deleteMany(@Body() images: Image[]): Promise<Image[]> {
    return this.imagesService.deleteMany(images);
  }

  @Delete(':id')
  delete(@Param('id', ParseIntPipe) id: number): Promise<Image> {
    return this.imagesService.delete(id);
  }
}
