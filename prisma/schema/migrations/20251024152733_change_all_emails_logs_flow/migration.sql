/*
  Warnings:

  - You are about to drop the column `listaEmpresas` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `empresaId` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `estado` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `fechaHoraRegistro` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `msje` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `para` on the `EmailLogs` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "dbo"."EmailLogs" DROP CONSTRAINT "EmailLogs_empresaId_fkey";

-- AlterTable
ALTER TABLE "EmailConfig" DROP COLUMN "listaEmpresas";

-- AlterTable
ALTER TABLE "EmailLogs" DROP COLUMN "empresaId",
DROP COLUMN "estado",
DROP COLUMN "fechaHoraRegistro",
DROP COLUMN "msje",
DROP COLUMN "para",
ADD COLUMN     "contactoId" INTEGER,
ADD COLUMN     "estadoEmailId" INTEGER;

-- CreateTable
CREATE TABLE "ListaEmpresasEmail" (
    "id" SERIAL NOT NULL,
    "empresaId" TEXT NOT NULL,
    "emailConfigId" INTEGER NOT NULL,

    CONSTRAINT "ListaEmpresasEmail_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "EmailLogs" ADD CONSTRAINT "EmailLogs_contactoId_fkey" FOREIGN KEY ("contactoId") REFERENCES "Contacto"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmailLogs" ADD CONSTRAINT "EmailLogs_estadoEmailId_fkey" FOREIGN KEY ("estadoEmailId") REFERENCES "EstadoEmail"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListaEmpresasEmail" ADD CONSTRAINT "ListaEmpresasEmail_empresaId_fkey" FOREIGN KEY ("empresaId") REFERENCES "Empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListaEmpresasEmail" ADD CONSTRAINT "ListaEmpresasEmail_emailConfigId_fkey" FOREIGN KEY ("emailConfigId") REFERENCES "EmailConfig"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
