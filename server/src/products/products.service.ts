import { Injectable } from '@nestjs/common';
import { Product } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';

@Injectable()
export class ProductsService {
  constructor(private prisma: PrismaService) {}
  async create(createProductDto: CreateProductDto): Promise<Product> {
    const {
      storeId,
      taxId,
      brandId,
      images,
      options,
      variants,
      collections,
      categories,
      ...data
    } = createProductDto;
    const product = await this.prisma.product.create({
      data: {
        ...data,
        tax: (taxId && { connect: { id: taxId } }) || undefined,
        brand: (brandId && { connect: { id: brandId } }) || undefined,
        store: { connect: { id: storeId } },
        images: {
          connect: images?.map((image) => ({ id: image.id })),
        },
        collections: {
          connect: collections?.map((collection) => ({ id: collection })),
        },
        categories: {
          connect: categories?.map((category) => ({ id: category })),
        },
        options: (options && { createMany: { data: options } }) || undefined,
        variants: (variants && { createMany: { data: variants } }) || undefined,
      },
    });

    return product;
  }

  findAll() {
    return `This action returns all products`;
  }

  findOne(id: number) {
    return `This action returns a #${id} product`;
  }

  update(id: number, updateProductDto: UpdateProductDto) {
    const {
      images,
      videos,
      options,
      variants,
      collections,
      categories,
      relatedProducts,
      pricingRules,
      giftWrapOptions,
      ...data
    } = updateProductDto;
    return this.prisma.product.update({
      where: { id },
      data: {
        ...data,
        options: {
          deleteMany: {},
          createMany: (options && { data: options }) || undefined,
        },
        variants: {
          deleteMany: {},
          createMany: (variants && { data: variants }) || undefined,
        },
        collections: {
          set: [],
          connect: collections?.map((collection) => ({ id: collection })),
        },
        images: {
          set: [],
          connect: images?.map((image) => ({ id: image.id })),
        },
        videos: {
          set: [],
          connect: videos?.map((video) => ({ id: video.id })),
        },
        categories: {
          set: [],
          connect: categories?.map((category) => ({ id: category })),
        },
        relatedProducts: {
          set: [],
          connect: relatedProducts?.map((product) => ({ id: product })),
        },
        pricingRules: {
          set: [],
          connect: pricingRules?.map((rule) => ({ id: rule })),
        },
        giftWrapOptions: {
          set: [],
          connect: giftWrapOptions?.map((option) => ({ id: option })),
        },
      },
    });
  }

  remove(id: number) {
    return `This action removes a #${id} product`;
  }
}
