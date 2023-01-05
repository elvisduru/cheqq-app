import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CartItemDto, CreateCartDto } from './dto/create-cart.dto';

@Injectable()
export class CartService {
  constructor(private prisma: PrismaService) {}

  create(createCartDto: CreateCartDto) {
    const { customerId, cartItems, ...rest } = createCartDto;
    return this.prisma.cart.create({
      data: {
        ...rest,
        customer: customerId ? { connect: { id: customerId } } : undefined,
        cartItems: cartItems ? { create: cartItems } : undefined,
      },
      include: {
        cartItems: {
          include: {
            product: {
              select: {
                title: true,
                price: true,
                images: true,
                currency: true,
                currency_symbol: true,
                store: {
                  select: {
                    name: true,
                    tag: true,
                  },
                },
              },
            },
            variant: {
              select: {
                title: true,
                price: true,
                image: true,
              },
            },
          },
        },
        customer: true,
        _count: {
          select: {
            cartItems: true,
          },
        },
      },
    });
  }

  async addCartItem(cartId: number, cartItem: CartItemDto) {
    const { productId, variantId, ...rest } = cartItem;

    // Check if cartItem already exists
    const existingCartItem = await this.prisma.cartItem.findFirst({
      where: {
        cartId,
        productId,
        variantId,
      },
    });

    if (existingCartItem) {
      return this.prisma.cartItem.update({
        where: {
          id: existingCartItem.id,
        },
        data: {
          ...cartItem,
        },
        include: {
          cart: {
            include: {
              cartItems: {
                include: {
                  product: {
                    select: {
                      title: true,
                      price: true,
                      images: true,
                      currency: true,
                      currency_symbol: true,
                      store: {
                        select: {
                          name: true,
                          tag: true,
                        },
                      },
                    },
                  },
                  variant: {
                    select: {
                      title: true,
                      price: true,
                      image: true,
                    },
                  },
                },
              },
              customer: true,
              _count: {
                select: {
                  cartItems: true,
                },
              },
            },
          },
        },
      });
    } else {
      return this.prisma.cartItem.create({
        data: {
          ...rest,
          cart: { connect: { id: cartId } },
          product: productId ? { connect: { id: productId } } : undefined,
          variant: variantId ? { connect: { id: variantId } } : undefined,
        },
        include: {
          cart: {
            include: {
              cartItems: {
                include: {
                  product: {
                    select: {
                      title: true,
                      price: true,
                      images: true,
                      currency: true,
                      currency_symbol: true,
                      store: {
                        select: {
                          name: true,
                          tag: true,
                        },
                      },
                    },
                  },
                  variant: {
                    select: {
                      title: true,
                      price: true,
                      image: true,
                    },
                  },
                },
              },
              customer: true,
              _count: {
                select: {
                  cartItems: true,
                },
              },
            },
          },
        },
      });
    }
  }

  findAll() {
    return this.prisma.cart.findMany({
      include: {
        cartItems: {
          include: {
            product: {
              select: {
                title: true,
                price: true,
                images: true,
                currency: true,
                currency_symbol: true,
                store: {
                  select: {
                    name: true,
                    tag: true,
                  },
                },
              },
            },
            variant: {
              select: {
                title: true,
                price: true,
                image: true,
              },
            },
          },
        },
        customer: true,
        _count: {
          select: {
            cartItems: true,
          },
        },
      },
    });
  }

  findOne(id: number) {
    return this.prisma.cart.findUnique({
      where: { id },
      include: {
        cartItems: {
          include: {
            product: {
              select: {
                title: true,
                price: true,
                images: true,
                currency: true,
                currency_symbol: true,
                store: {
                  select: {
                    name: true,
                    tag: true,
                  },
                },
              },
            },
            variant: {
              select: {
                title: true,
                price: true,
                image: true,
              },
            },
          },
        },
        customer: true,
        _count: {
          select: {
            cartItems: true,
          },
        },
      },
    });
  }

  async removeCartItem(cartItemId: number) {
    const { cart } = await this.prisma.cartItem.delete({
      where: { id: cartItemId },
      include: {
        cart: {
          include: {
            cartItems: {
              include: {
                product: {
                  select: {
                    title: true,
                    price: true,
                    images: true,
                    currency: true,
                    currency_symbol: true,
                    store: {
                      select: {
                        name: true,
                        tag: true,
                      },
                    },
                  },
                },
                variant: {
                  select: {
                    title: true,
                    price: true,
                    image: true,
                  },
                },
              },
            },
            customer: true,
            _count: {
              select: {
                cartItems: true,
              },
            },
          },
        },
      },
    });

    if (cart._count.cartItems === 0) {
      await this.prisma.cart.delete({
        where: { id: cart.id },
      });
    } else {
      return cart;
    }
  }

  deleteCart(cartId: number) {
    return this.prisma.cart.delete({
      where: { id: cartId },
    });
  }
}
