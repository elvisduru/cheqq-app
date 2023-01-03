/*
  Warnings:

  - You are about to drop the column `tempId` on the `Cart` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "Cart_tempId_key";

-- AlterTable
ALTER TABLE "Cart" DROP COLUMN "tempId";
