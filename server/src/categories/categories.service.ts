import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';

type LeanCategory = Prisma.CategoryGetPayload<{
  select: { id: true; name: true; parentCategoryId?: true };
}>;

type CategoryWithSubCategories = Prisma.CategoryGetPayload<{
  select: {
    id: true;
    name: true;
    subCategories: {
      select: { id: true; name: true; parentCategoryId: true };
    };
  };
}>;

@Injectable()
export class CategoriesService {
  constructor(private prisma: PrismaService) {}

  async findAll(
    query: any,
  ): Promise<LeanCategory[] | CategoryWithSubCategories[]> {
    if (query.root) {
      return this.prisma.category.findMany({
        where: {
          parentCategoryId: null,
        },
        select: {
          id: true,
          name: true,
        },
      });
    }
    if (query.subCategories) {
      return this.prisma.category.findMany({
        where: {
          parentCategoryId: null,
        },
        select: {
          id: true,
          name: true,
          subCategories: {
            select: {
              id: true,
              name: true,
              parentCategoryId: true,
            },
          },
        },
      });
    }
    return this.prisma.category.findMany({
      select: {
        id: true,
        name: true,
        parentCategoryId: true,
      },
    });
  }
}
