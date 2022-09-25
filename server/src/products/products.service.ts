import { Injectable } from '@nestjs/common';
import { Product } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';

@Injectable()
export class ProductsService {
  constructor(private prisma: PrismaService) {}
  async create(createProductDto: CreateProductDto): Promise<Product> {
    const { storeId, taxId, brandId, images, options, variants, ...data } =
      createProductDto;
    const product = await this.prisma.product.create({
      data: {
        ...data,
        store: { connect: { id: storeId } },
        images: {
          connect: images.map((image) => ({ id: image.id })),
        },
      },
    });

    if (options) {
      await this.prisma.productOption.createMany({
        data: options.map((option) => ({
          ...option,
          productId: product.id,
        })),
      });
    }

    if (variants) {
      await this.prisma.productVariant.createMany({
        data: variants.map((variant) => ({
          ...variant,
          productId: product.id,
        })),
      });
    }

    if (taxId) {
      await this.prisma.product.update({
        where: { id: product.id },
        data: {
          tax: { connect: { id: taxId } },
        },
      });
    }

    if (brandId) {
      await this.prisma.product.update({
        where: { id: product.id },
        data: {
          brand: { connect: { id: brandId } },
        },
      });
    }

    return product;
  }

  findAll() {
    return `This action returns all products`;
  }

  findOne(id: number) {
    return `This action returns a #${id} product`;
  }

  update(id: number, updateProductDto: UpdateProductDto) {
    return `This action updates a #${id} product`;
  }

  remove(id: number) {
    return `This action removes a #${id} product`;
  }
}
