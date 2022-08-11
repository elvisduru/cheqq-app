import { MailerModule } from '@derech1e/mailer';
import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_GUARD } from '@nestjs/core';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { AccessTokenGuard } from './common/guards';
import { OrdersModule } from './orders/orders.module';
import { PrismaModule } from './prisma/prisma.module';
import { UsersModule } from './users/users.module';
import { HandlebarsAdapter } from '@derech1e/mailer/dist/adapters/handlebars.adapter';
import { join } from 'path';
import { StoresModule } from './stores/stores.module';
import { CategoriesModule } from './categories/categories.module';
import { ImagesModule } from './images/images.module';
import { ProductsModule } from './products/products.module';
import { ShippingModule } from './shipping/shipping.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MailerModule.forRootAsync({
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        transport: {
          host: configService.get('SMTP_HOST'),
          port: configService.get<number>('SMTP_PORT'),
          auth: {
            user: configService.get('SMTP_USERNAME'),
            pass: configService.get('SMTP_PASSWORD'),
          },
          secure: true,
          pool: true,
        },
        defaults: {
          from: 'Cheqq <hi@cheqq.me>',
        },
        // preview: {
        //   dir: join(process.env.PWD, 'preview'),
        //   open: {
        //     app: 'msedge',
        //     wait: false
        //   }
        // },
        template: {
          dir: join(process.env.PWD, 'templates/pages'),
          adapter: new HandlebarsAdapter(),
          options: {
            strict: true,
          },
        },
      }),
    }),
    UsersModule,
    OrdersModule,
    AuthModule,
    PrismaModule,
    StoresModule,
    CategoriesModule,
    ImagesModule,
    ProductsModule,
    ShippingModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: AccessTokenGuard,
    },
  ],
})
export class AppModule {}
