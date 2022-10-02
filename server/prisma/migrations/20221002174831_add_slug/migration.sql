/*
  Warnings:

  - You are about to drop the column `shortUrl` on the `Product` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Product" DROP COLUMN "shortUrl",
ADD COLUMN     "slug" TEXT NOT NULL DEFAULT '';
