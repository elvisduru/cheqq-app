/*
  Warnings:

  - You are about to drop the `_CountryToShippingZone` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_CountryToShippingZone" DROP CONSTRAINT "_CountryToShippingZone_A_fkey";

-- DropForeignKey
ALTER TABLE "_CountryToShippingZone" DROP CONSTRAINT "_CountryToShippingZone_B_fkey";

-- AlterTable
ALTER TABLE "State" ADD COLUMN     "locationId" INTEGER;

-- DropTable
DROP TABLE "_CountryToShippingZone";

-- CreateTable
CREATE TABLE "Location" (
    "id" SERIAL NOT NULL,
    "countryId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "shippingZoneId" INTEGER,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Location" ADD CONSTRAINT "Location_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Location" ADD CONSTRAINT "Location_shippingZoneId_fkey" FOREIGN KEY ("shippingZoneId") REFERENCES "ShippingZone"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "State" ADD CONSTRAINT "State_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE SET NULL ON UPDATE CASCADE;
