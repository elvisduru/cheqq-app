-- CreateEnum
CREATE TYPE "Plan" AS ENUM ('FREE', 'PRO');

-- CreateEnum
CREATE TYPE "InventoryPolicy" AS ENUM ('deny', 'continue');

-- CreateEnum
CREATE TYPE "ProductAvailability" AS ENUM ('available', 'disabled', 'preorder');

-- CreateEnum
CREATE TYPE "ProductType" AS ENUM ('physical', 'digital');

-- CreateEnum
CREATE TYPE "PriceAdjustmentType" AS ENUM ('fixed', 'percent');

-- CreateEnum
CREATE TYPE "Condition" AS ENUM ('new', 'used', 'refurbished');

-- CreateEnum
CREATE TYPE "OpenGraphType" AS ENUM ('product', 'album', 'book', 'drink', 'food', 'game', 'movie', 'song', 'tv_show');

-- CreateEnum
CREATE TYPE "SubscriptionInterval" AS ENUM ('day', 'week', 'month', 'year');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PROCESSING', 'CANCELLED', 'PENDING_SHIPMENT', 'PARTIALLY_SHIPPED', 'SHIPPED', 'PARTIALLY_DELIVERED', 'DELIVERED', 'PARTIALLY_RETURNED', 'RETURNED');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "email" TEXT NOT NULL,
    "emailVerified" BOOLEAN NOT NULL DEFAULT false,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "avatarUrl" TEXT,
    "password" TEXT,
    "passwordUpdatedAt" TIMESTAMP(3),
    "plan" "Plan" NOT NULL DEFAULT E'FREE',
    "hashedRefreshToken" TEXT,
    "prefs" JSONB NOT NULL DEFAULT '{}',
    "magicSecret" TEXT,
    "magicSecretExpiry" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Store" (
    "id" SERIAL NOT NULL,
    "ownerId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "tag" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "domain" TEXT,
    "address" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "order_email" TEXT,
    "language" TEXT NOT NULL,
    "currency" TEXT NOT NULL,
    "logo" TEXT,
    "banner" TEXT,
    "description" TEXT,
    "public" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Store_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "storeId" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "weight" DOUBLE PRECISION,
    "weightUnit" TEXT,
    "width" DOUBLE PRECISION,
    "height" DOUBLE PRECISION,
    "depth" DOUBLE PRECISION,
    "price" DOUBLE PRECISION NOT NULL,
    "compareAtPrice" DOUBLE PRECISION,
    "costPrice" DOUBLE PRECISION,
    "taxable" BOOLEAN NOT NULL DEFAULT false,
    "taxId" INTEGER,
    "brandId" INTEGER,
    "inventoryTracking" BOOLEAN NOT NULL DEFAULT false,
    "inventoryPolicy" "InventoryPolicy" NOT NULL DEFAULT E'deny',
    "inventoryLevel" INTEGER NOT NULL DEFAULT 0,
    "inventoryWarningLevel" INTEGER NOT NULL DEFAULT 0,
    "isFreeShipping" BOOLEAN NOT NULL DEFAULT true,
    "fixedShippingRate" DOUBLE PRECISION,
    "public" BOOLEAN NOT NULL DEFAULT false,
    "featured" BOOLEAN NOT NULL DEFAULT false,
    "warranty" TEXT,
    "layout" TEXT NOT NULL DEFAULT E'default',
    "gtin" TEXT,
    "mpn" TEXT,
    "searchKeywords" TEXT[],
    "availability" "ProductAvailability" NOT NULL DEFAULT E'available',
    "availabilityLabel" TEXT,
    "preorderReleaseDate" TIMESTAMP(3),
    "preOrderMessage" TEXT,
    "preOrderOnly" BOOLEAN NOT NULL DEFAULT false,
    "minHandlingTime" INTEGER,
    "maxHandlingTime" INTEGER,
    "giftWrap" BOOLEAN NOT NULL DEFAULT false,
    "condition" "Condition" NOT NULL DEFAULT E'new',
    "showCondition" BOOLEAN NOT NULL DEFAULT false,
    "orderQuantityMinimum" INTEGER NOT NULL DEFAULT 1,
    "orderQuantityMaximum" INTEGER,
    "pageTitle" TEXT,
    "metaDescription" TEXT,
    "metaKeywords" TEXT[],
    "viewCount" INTEGER NOT NULL DEFAULT 0,
    "customUrl" TEXT,
    "openGraphTitle" TEXT,
    "openGraphDescription" TEXT,
    "openGraphType" "OpenGraphType" NOT NULL DEFAULT E'product',
    "totalSold" INTEGER NOT NULL DEFAULT 0,
    "reviewCount" INTEGER NOT NULL DEFAULT 0,
    "reviewAverage" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "customFields" JSONB[],
    "subscription" BOOLEAN NOT NULL DEFAULT false,
    "subscriptionInterval" "SubscriptionInterval" NOT NULL,
    "subscriptionLength" INTEGER,
    "subscriptionPrice" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductImage" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "url" TEXT NOT NULL,
    "description" TEXT,
    "sortOrder" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProductImage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductVideo" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "url" TEXT NOT NULL,
    "description" TEXT,
    "sortOrder" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProductVideo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BulkPricingRule" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "quantityMin" INTEGER NOT NULL DEFAULT 1,
    "quantityMax" INTEGER NOT NULL,
    "adjusmentType" "PriceAdjustmentType" NOT NULL DEFAULT E'fixed',
    "adjustmentValue" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BulkPricingRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GiftWrapOption" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GiftWrapOption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Brand" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Brand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "parentCategoryId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tax" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "rate" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Tax_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" SERIAL NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "address1" TEXT NOT NULL,
    "address2" TEXT,
    "city" TEXT NOT NULL,
    "state" TEXT,
    "zip" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_RelatedProducts" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_CategoryToProduct" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_CategoryToStore" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Store_tag_key" ON "Store"("tag");

-- CreateIndex
CREATE UNIQUE INDEX "_RelatedProducts_AB_unique" ON "_RelatedProducts"("A", "B");

-- CreateIndex
CREATE INDEX "_RelatedProducts_B_index" ON "_RelatedProducts"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CategoryToProduct_AB_unique" ON "_CategoryToProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_CategoryToProduct_B_index" ON "_CategoryToProduct"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CategoryToStore_AB_unique" ON "_CategoryToStore"("A", "B");

-- CreateIndex
CREATE INDEX "_CategoryToStore_B_index" ON "_CategoryToStore"("B");

-- AddForeignKey
ALTER TABLE "Store" ADD CONSTRAINT "Store_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES "Store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "Brand"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_taxId_fkey" FOREIGN KEY ("taxId") REFERENCES "Tax"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductImage" ADD CONSTRAINT "ProductImage_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVideo" ADD CONSTRAINT "ProductVideo_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BulkPricingRule" ADD CONSTRAINT "BulkPricingRule_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GiftWrapOption" ADD CONSTRAINT "GiftWrapOption_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_parentCategoryId_fkey" FOREIGN KEY ("parentCategoryId") REFERENCES "Category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RelatedProducts" ADD CONSTRAINT "_RelatedProducts_A_fkey" FOREIGN KEY ("A") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RelatedProducts" ADD CONSTRAINT "_RelatedProducts_B_fkey" FOREIGN KEY ("B") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToProduct" ADD CONSTRAINT "_CategoryToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToProduct" ADD CONSTRAINT "_CategoryToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToStore" ADD CONSTRAINT "_CategoryToStore_A_fkey" FOREIGN KEY ("A") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToStore" ADD CONSTRAINT "_CategoryToStore_B_fkey" FOREIGN KEY ("B") REFERENCES "Store"("id") ON DELETE CASCADE ON UPDATE CASCADE;
