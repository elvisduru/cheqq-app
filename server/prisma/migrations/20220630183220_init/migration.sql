/*
  Warnings:

  - Added the required column `storeId` to the `PricingRule` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "PricingRule" ADD COLUMN     "storeId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "PricingRule" ADD CONSTRAINT "PricingRule_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES "Store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
