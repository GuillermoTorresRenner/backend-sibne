/*
  Warnings:

  - You are about to drop the column `regionId` on the `Comuna` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "dbo"."Comuna" DROP CONSTRAINT "Comuna_regionId_fkey";

-- AlterTable
ALTER TABLE "Comuna" DROP COLUMN "regionId";

-- AddForeignKey
ALTER TABLE "Comuna" ADD CONSTRAINT "Comuna_provinciaId_fkey" FOREIGN KEY ("provinciaId") REFERENCES "Provincia"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Provincia" ADD CONSTRAINT "Provincia_regionId_fkey" FOREIGN KEY ("regionId") REFERENCES "Region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
