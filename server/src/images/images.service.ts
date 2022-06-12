import { Injectable } from '@nestjs/common';
import { Image } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { ImageDto } from './dto';

@Injectable()
export class ImagesService {
  constructor(private prisma: PrismaService) {}

  async create(data: ImageDto[]): Promise<Image[]> {
    return this.prisma.$transaction(
      data.map((image) => this.prisma.image.create({ data: image })),
    );
  }

  async delete(id: number): Promise<Image> {
    return this.prisma.image.delete({ where: { id } });
  }

  async deleteMany(images: Image[]) {
    return this.prisma.$transaction(
      images.map((image) =>
        this.prisma.image.delete({ where: { id: image.id } }),
      ),
    );
  }
}
