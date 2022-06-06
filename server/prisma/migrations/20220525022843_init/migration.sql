-- AlterTable
ALTER TABLE "User" ADD COLUMN     "magicSecret" TEXT,
ADD COLUMN     "magicSecretExpiry" TIMESTAMP(3);
