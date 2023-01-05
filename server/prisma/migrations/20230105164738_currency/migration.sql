/*
  Warnings:

  - You are about to drop the column `currency` on the `ProductVariant` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Product" ADD COLUMN     "currency_symbol" TEXT NOT NULL DEFAULT '₦';

-- AlterTable
ALTER TABLE "ProductVariant" DROP COLUMN "currency";
