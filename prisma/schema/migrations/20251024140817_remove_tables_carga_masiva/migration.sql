/*
  Warnings:

  - You are about to drop the `CargaMasivaArchivo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CargaMasivaDetalle` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CargaMasivaError` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "dbo"."CargaMasivaDetalle" DROP CONSTRAINT "CargaMasivaDetalle_cargaMasivaArchivoId_fkey";

-- DropForeignKey
ALTER TABLE "dbo"."CargaMasivaError" DROP CONSTRAINT "CargaMasivaError_cargaMasivaDetalleId_fkey";

-- DropTable
DROP TABLE "dbo"."CargaMasivaArchivo";

-- DropTable
DROP TABLE "dbo"."CargaMasivaDetalle";

-- DropTable
DROP TABLE "dbo"."CargaMasivaError";
