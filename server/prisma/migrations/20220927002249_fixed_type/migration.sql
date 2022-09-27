/*
  Warnings:

  - You are about to drop the column `name` on the `ProductVariant` table. All the data in the column will be lost.
  - Added the required column `currency` to the `ProductVariant` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `ProductVariant` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ProductVariant" DROP COLUMN "name",
ADD COLUMN     "currency" TEXT NOT NULL,
ADD COLUMN     "title" TEXT NOT NULL;
