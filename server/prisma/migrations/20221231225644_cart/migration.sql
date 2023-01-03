-- CreateTable
CREATE TABLE "Cart" (
    "id" SERIAL NOT NULL,
    "customerId" INTEGER,
    "email" TEXT NOT NULL,
    "currency" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Cart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CartItem" (
    "id" SERIAL NOT NULL,
    "cartId" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,
    "variantId" INTEGER,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "coupon" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CartItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LineItem" (
    "id" SERIAL NOT NULL,
    "orderId" INTEGER NOT NULL,
    "quantityOrdered" INTEGER NOT NULL,
    "quantityShipped" INTEGER,
    "quantityPending" INTEGER,
    "quantityCancelled" INTEGER,
    "quantityReturned" INTEGER,
    "quantityDelivered" INTEGER,
    "shippingMethod" TEXT NOT NULL,
    "shippingCarrier" TEXT,
    "minDaysInTransit" INTEGER NOT NULL,
    "maxDaysInTransit" INTEGER NOT NULL,
    "isReturnable" BOOLEAN NOT NULL,
    "daysToReturn" INTEGER,
    "policyUrl" TEXT,
    "targetCountry" TEXT,
    "price" INTEGER NOT NULL,
    "currency" TEXT NOT NULL,
    "imageLink" TEXT,
    "title" TEXT NOT NULL,
    "gtin" TEXT,
    "brand" TEXT,
    "mpn" TEXT,
    "condition" "Condition" NOT NULL,
    "attributes" JSONB[],
    "additionalFees" JSONB[],
    "returns" JSONB[],
    "cancellations" JSONB[],
    "annotations" JSONB[],
    "adjustments" JSONB[],

    CONSTRAINT "LineItem_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Cart" ADD CONSTRAINT "Cart_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_variantId_fkey" FOREIGN KEY ("variantId") REFERENCES "ProductVariant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LineItem" ADD CONSTRAINT "LineItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
