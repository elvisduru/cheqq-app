import { Injectable } from '@nestjs/common';
import { Prisma, Product } from '@prisma/client';
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
      videos,
      options,
      variants,
      collections,
      categories,
      relatedProducts,
      pricingRules,
      giftWrapOptions,
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
        videos: {
          connect: videos?.map((video) => ({ id: video.id })),
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

  async findAll(
    where: Prisma.ProductWhereInput,
    pagination?: { take?: number; skip?: number; cursor?: number },
  ): Promise<Product[]> {
    return this.prisma.product.findMany({
      where,
      take: pagination?.take || undefined,
      skip: pagination?.skip || 0,
      cursor: pagination?.cursor ? { id: pagination.cursor } : undefined,
      orderBy: {
        id: 'asc',
      },
      include: {
        images: true,
        videos: true,
        options: true,
        variants: true,
        collections: true,
        categories: true,
        store: {
          include: {
            country: true,
          },
        },
        brand: true,
        tax: true,
        relatedProducts: true,
        giftWrapOptions: true,
        pricingRules: true,
      },
    });
  }

  async findOne(id: number) {
    return this.prisma.product.findUnique({
      where: { id },
      include: {
        images: true,
        videos: true,
        options: true,
        variants: true,
        collections: true,
        categories: true,
        store: {
          include: {
            country: true,
          },
        },
        brand: true,
        tax: true,
        relatedProducts: true,
        giftWrapOptions: true,
        pricingRules: true,
      },
    });
  }

  async findBySlug(slug: string) {
    return this.prisma.product.findFirstOrThrow({
      where: { slug },
      include: {
        images: true,
        videos: true,
        options: true,
        variants: true,
        collections: true,
        categories: true,
        store: {
          include: {
            country: true,
          },
        },
        brand: true,
        tax: true,
        relatedProducts: true,
        giftWrapOptions: true,
        pricingRules: true,
      },
    });
  }

  async update(id: number, updateProductDto: UpdateProductDto) {
    const {
      id: _,
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

    // handle options and variants
    if (options?.length) {
      // delete all options
      await this.prisma.productOption.deleteMany({
        where: {
          productId: id,
        },
      });
      // create new options
      const newOptions = options.map((option) => {
        const { id: _, ...data } = option;
        return { ...data, productId: id };
      });
      await this.prisma.productOption.createMany({
        data: [...newOptions],
      });
    }

    if (variants?.length) {
      // delete all variants
      await this.prisma.productVariant.deleteMany({
        where: {
          productId: id,
        },
      });
      // create new variants
      const newVariants = variants.map((variant) => {
        const { id: _, ...data } = variant;
        return { ...data, productId: id };
      });
      await this.prisma.productVariant.createMany({
        data: [...newVariants],
      });
    }

    return this.prisma.product.update({
      where: { id },
      data: {
        ...data,
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
    return this.prisma.product.delete({
      where: { id },
    });
  }
}
