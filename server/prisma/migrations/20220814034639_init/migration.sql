-- CreateTable
CREATE TABLE "FulfillmentService" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "storeId" INTEGER NOT NULL,

    CONSTRAINT "FulfillmentService_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "FulfillmentService" ADD CONSTRAINT "FulfillmentService_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES "Store"("id") ON DELETE CASCADE ON UPDATE CASCADE;
