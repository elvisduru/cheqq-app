-- AlterTable
ALTER TABLE "Product" ADD COLUMN     "tags" TEXT[],
ALTER COLUMN "sku" DROP NOT NULL;
