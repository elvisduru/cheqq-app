-- AlterTable
ALTER TABLE "ShippingRate" ADD COLUMN     "currency" TEXT NOT NULL DEFAULT 'NGN',
ADD COLUMN     "currency_symbol" TEXT NOT NULL DEFAULT '₦';
