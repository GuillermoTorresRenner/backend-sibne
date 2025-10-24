/*
  Warnings:

  - The primary key for the `UsuarioLogin` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Usuario` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UsuarioRole` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UsuarioToken` table. If the table is not empty, all the data it contains will be lost.
  - The required column `id` was added to the `UsuarioLogin` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "dbo"."UsuarioLogin" DROP CONSTRAINT "UsuarioLogin_userId_fkey";

-- DropForeignKey
ALTER TABLE "dbo"."UsuarioRole" DROP CONSTRAINT "UsuarioRole_RoleId_fkey";

-- DropForeignKey
ALTER TABLE "dbo"."UsuarioRole" DROP CONSTRAINT "UsuarioRole_UserId_fkey";

-- DropForeignKey
ALTER TABLE "dbo"."UsuarioToken" DROP CONSTRAINT "UsuarioToken_userId_fkey";

-- AlterTable
ALTER TABLE "UsuarioLogin" DROP CONSTRAINT "UsuarioLogin_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "UsuarioLogin_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "dbo"."Usuario";

-- DropTable
DROP TABLE "dbo"."UsuarioRole";

-- DropTable
DROP TABLE "dbo"."UsuarioToken";
