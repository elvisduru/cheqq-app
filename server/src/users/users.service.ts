import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';

// type UserData = Omit<
//   User,
//   'password' | 'hashedRefreshToken' | 'magicSecret' | 'magicSecretExpiry'
// >;

type User = Prisma.UserGetPayload<{
  select: {
    id: true;
    name: true;
    email: true;
    active: true;
    avatarUrl: true;
    emailVerified: true;
    plan: true;
    prefs: true;
    passwordUpdatedAt: true;
    stores: {
      select: {
        name: true;
        tag: true;
        logo: true;
      };
    };
  };
}>;

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.UserCreateInput): Promise<Omit<User, 'stores'>> {
    return this.prisma.user.create({ data });
  }

  async findAll(params?: Prisma.UserFindManyArgs): Promise<User[]> {
    return this.prisma.user.findMany({
      ...params,
      include: {
        stores: {
          select: {
            name: true,
            tag: true,
            logo: true,
          },
        },
      },
    });
  }

  async findById(id: number): Promise<User> {
    return this.prisma.user.findUnique({
      where: {
        id,
      },
      include: {
        stores: {
          select: {
            name: true,
            tag: true,
            logo: true,
          },
        },
      },
    });
  }

  async findOne(where: Prisma.UserWhereUniqueInput): Promise<User> {
    return this.prisma.user.findUnique({
      where,
      include: {
        stores: {
          select: {
            name: true,
            tag: true,
            logo: true,
          },
        },
      },
    });
  }

  async updateById(
    id: number,
    updateOrderDto: Prisma.UserUpdateInput,
  ): Promise<User> {
    return this.prisma.user.update({
      where: { id },
      data: updateOrderDto,
      include: {
        stores: {
          select: {
            name: true,
            tag: true,
            logo: true,
          },
        },
      },
    });
  }

  async removeById(id: number): Promise<Prisma.UserGetPayload<{}>> {
    return this.prisma.user.delete({ where: { id } });
  }
}
