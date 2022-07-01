/*
  Warnings:

  - You are about to drop the column `inventoryPolicy` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `mpn` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `orderQuantityMaximum` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `orderQuantityMinimum` on the `Product` table. All the data in the column will be lost.
  - The `weightUnit` column on the `Product` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `BulkPricingRule` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `type` on the `Product` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "WeightUnit" AS ENUM ('lb', 'kg', 'oz', 'g');

-- CreateEnum
CREATE TYPE "DimensionUnit" AS ENUM ('in', 'cm', 'm');

-- DropForeignKey
ALTER TABLE "BulkPricingRule" DROP CONSTRAINT "BulkPricingRule_productId_fkey";

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "inventoryPolicy",
DROP COLUMN "mpn",
DROP COLUMN "orderQuantityMaximum",
DROP COLUMN "orderQuantityMinimum",
ADD COLUMN     "allowBackOrder" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "collectionId" INTEGER,
ADD COLUMN     "currency" TEXT NOT NULL DEFAULT E'USD',
ADD COLUMN     "dimensionUnit" "DimensionUnit" NOT NULL DEFAULT E'cm',
ADD COLUMN     "redirectUrl" TEXT,
DROP COLUMN "type",
ADD COLUMN     "type" "ProductType" NOT NULL,
DROP COLUMN "weightUnit",
ADD COLUMN     "weightUnit" "WeightUnit" NOT NULL DEFAULT E'g',
ALTER COLUMN "inventoryWarningLevel" DROP NOT NULL,
ALTER COLUMN "inventoryWarningLevel" DROP DEFAULT;

-- DropTable
DROP TABLE "BulkPricingRule";

-- DropEnum
DROP TYPE "InventoryPolicy";

-- CreateTable
CREATE TABLE "ProductOption" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "compareAtPrice" DOUBLE PRECISION,

    CONSTRAINT "ProductOption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductVariant" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "compareAtPrice" DOUBLE PRECISION,
    "costPrice" DOUBLE PRECISION,
    "currency" TEXT NOT NULL DEFAULT E'USD',
    "inventoryTracking" BOOLEAN NOT NULL DEFAULT false,
    "allowBackOrder" BOOLEAN NOT NULL DEFAULT false,
    "inventoryLevel" INTEGER NOT NULL DEFAULT 0,
    "inventoryWarningLevel" INTEGER,
    "sku" TEXT,
    "gtin" TEXT,
    "isFreeShipping" BOOLEAN NOT NULL DEFAULT true,
    "fixedShippingRate" DOUBLE PRECISION,
    "imageId" INTEGER,
    "videoId" INTEGER,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "pricingRuleId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProductVariant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Collection" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "pricingRuleId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Collection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingRule" (
    "id" SERIAL NOT NULL,
    "title" TEXT,
    "code" TEXT,
    "shipping" BOOLEAN NOT NULL DEFAULT false,
    "order" BOOLEAN NOT NULL DEFAULT false,
    "quantityMin" INTEGER NOT NULL DEFAULT 1,
    "adjusmentType" "PriceAdjustmentType" NOT NULL DEFAULT E'fixed',
    "adjustmentValue" DOUBLE PRECISION NOT NULL,
    "allocationLimit" INTEGER,
    "usageLimit" INTEGER,
    "usageCount" INTEGER NOT NULL DEFAULT 0,
    "startsAt" TIMESTAMP(3),
    "endsAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PricingRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" SERIAL NOT NULL,
    "storeId" INTEGER NOT NULL,
    "customerId" INTEGER NOT NULL,
    "billingAddressId" INTEGER NOT NULL,
    "shippingAddressId" INTEGER,
    "ipAddress" TEXT,
    "cancelledAt" TIMESTAMP(3),
    "note" TEXT,
    "annotations" JSONB[],
    "status" "OrderStatus" NOT NULL DEFAULT E'PROCESSING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PricingRuleToProduct" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "PricingRule_code_key" ON "PricingRule"("code");

-- CreateIndex
CREATE UNIQUE INDEX "_PricingRuleToProduct_AB_unique" ON "_PricingRuleToProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_PricingRuleToProduct_B_index" ON "_PricingRuleToProduct"("B");

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_collectionId_fkey" FOREIGN KEY ("collectionId") REFERENCES "Collection"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOption" ADD CONSTRAINT "ProductOption_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES "Image"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES "Video"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_pricingRuleId_fkey" FOREIGN KEY ("pricingRuleId") REFERENCES "PricingRule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Collection" ADD CONSTRAINT "Collection_pricingRuleId_fkey" FOREIGN KEY ("pricingRuleId") REFERENCES "PricingRule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES "Store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_billingAddressId_fkey" FOREIGN KEY ("billingAddressId") REFERENCES "Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_shippingAddressId_fkey" FOREIGN KEY ("shippingAddressId") REFERENCES "Address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PricingRuleToProduct" ADD CONSTRAINT "_PricingRuleToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "PricingRule"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PricingRuleToProduct" ADD CONSTRAINT "_PricingRuleToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;
