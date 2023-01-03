/*
  Warnings:

  - A unique constraint covering the columns `[tempId]` on the table `Cart` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
CREATE SEQUENCE "cart_tempid_seq";
ALTER TABLE "Cart" ALTER COLUMN "tempId" SET DEFAULT nextval('cart_tempid_seq');
ALTER SEQUENCE "cart_tempid_seq" OWNED BY "Cart"."tempId";

-- CreateIndex
CREATE UNIQUE INDEX "Cart_tempId_key" ON "Cart"("tempId");
