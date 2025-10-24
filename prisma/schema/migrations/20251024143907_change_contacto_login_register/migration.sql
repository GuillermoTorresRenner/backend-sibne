/*
  Warnings:

  - You are about to drop the column `providerDisplayName` on the `ContactoLogin` table. All the data in the column will be lost.
  - You are about to drop the column `providerKey` on the `ContactoLogin` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `ContactoLogin` table. All the data in the column will be lost.
  - Added the required column `contactoId` to the `ContactoLogin` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `loginProvider` on the `ContactoLogin` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "LoginProviders" AS ENUM ('EMAIL_Y_PASSWORD', 'CLAVE_UNICA');

-- AlterTable
ALTER TABLE "ContactoLogin" DROP COLUMN "providerDisplayName",
DROP COLUMN "providerKey",
DROP COLUMN "userId",
ADD COLUMN     "contactoId" INTEGER NOT NULL,
DROP COLUMN "loginProvider",
ADD COLUMN     "loginProvider" "LoginProviders" NOT NULL;

-- AddForeignKey
ALTER TABLE "ContactoLogin" ADD CONSTRAINT "ContactoLogin_contactoId_fkey" FOREIGN KEY ("contactoId") REFERENCES "Contacto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
