/*
  Warnings:

  - You are about to drop the column `concurrencyStamp` on the `Role` table. All the data in the column will be lost.
  - You are about to drop the column `normalizedName` on the `Role` table. All the data in the column will be lost.
  - You are about to drop the `UsuarioLogin` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE "Contacto" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "password" TEXT,
ADD COLUMN     "roleId" TEXT DEFAULT 'cb226eb3-bfd1-4772-8463-ebb062d1b870',
ADD COLUMN     "updatedAt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Role" DROP COLUMN "concurrencyStamp",
DROP COLUMN "normalizedName";

-- DropTable
DROP TABLE "dbo"."UsuarioLogin";

-- CreateTable
CREATE TABLE "ContactoLogin" (
    "id" TEXT NOT NULL,
    "loginProvider" TEXT NOT NULL,
    "providerKey" TEXT NOT NULL,
    "providerDisplayName" TEXT,
    "userId" TEXT NOT NULL,

    CONSTRAINT "ContactoLogin_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Contacto" ADD CONSTRAINT "Contacto_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE SET NULL ON UPDATE CASCADE;
