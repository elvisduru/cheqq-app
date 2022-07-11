/*
  Warnings:

  - Made the column `addressCordinates` on table `Store` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Store" ALTER COLUMN "addressCordinates" SET NOT NULL;
