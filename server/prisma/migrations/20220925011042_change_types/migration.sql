/*
  Warnings:

  - Made the column `price` on table `Product` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Product" ALTER COLUMN "weightUnit" DROP NOT NULL,
ALTER COLUMN "weightUnit" DROP DEFAULT,
ALTER COLUMN "dimensionUnit" DROP NOT NULL,
ALTER COLUMN "dimensionUnit" DROP DEFAULT,
ALTER COLUMN "price" SET NOT NULL,
ALTER COLUMN "price" SET DEFAULT 0;
