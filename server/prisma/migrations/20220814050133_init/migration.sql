-- CreateEnum
CREATE TYPE "ProcessingTime" AS ENUM ('none', 'sameDay', 'nextDay', 'twoDays');

-- AlterTable
ALTER TABLE "Store" ADD COLUMN     "processingTime" "ProcessingTime" NOT NULL DEFAULT 'none';
