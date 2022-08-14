import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateFulfillmentServiceDto } from './dto/create-fulfillment-service.dto';
import { UpdateFulfillmentServiceDto } from './dto/update-fulfillment-service.dto';

@Injectable()
export class FulfillmentServicesService {
  constructor(private prisma: PrismaService) {}

  create(createFulfillmentServiceDto: CreateFulfillmentServiceDto) {
    return this.prisma.fulfillmentService.create({
      data: createFulfillmentServiceDto,
    });
  }

  update(id: number, updateFulfillmentServiceDto: UpdateFulfillmentServiceDto) {
    return this.prisma.fulfillmentService.update({
      where: { id },
      data: updateFulfillmentServiceDto,
    });
  }

  findAll() {
    return this.prisma.fulfillmentService.findMany();
  }

  findAllForStore(storeId: number) {
    return this.prisma.fulfillmentService.findMany({
      where: { storeId },
    });
  }

  findOne(id: number) {
    return this.prisma.fulfillmentService.findUnique({ where: { id } });
  }

  delete(id: number) {
    return this.prisma.fulfillmentService.delete({ where: { id } });
  }
}
