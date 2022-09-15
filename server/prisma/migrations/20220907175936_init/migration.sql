/*
  Warnings:

  - You are about to drop the column `currency` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `giftWrap` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `maxHandlingTime` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `minHandlingTime` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `preorderReleaseDate` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `compareAtPrice` on the `ProductOption` table. All the data in the column will be lost.
  - You are about to drop the column `price` on the `ProductOption` table. All the data in the column will be lost.
  - You are about to drop the column `currency` on the `ProductVariant` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Product" DROP COLUMN "currency",
DROP COLUMN "giftWrap",
DROP COLUMN "maxHandlingTime",
DROP COLUMN "minHandlingTime",
DROP COLUMN "preorderReleaseDate",
ADD COLUMN     "preOrderReleaseDate" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "ProductOption" DROP COLUMN "compareAtPrice",
DROP COLUMN "price",
ADD COLUMN     "values" TEXT[];

-- AlterTable
ALTER TABLE "ProductVariant" DROP COLUMN "currency",
ALTER COLUMN "price" DROP NOT NULL;
