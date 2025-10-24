/*
  Warnings:

  - You are about to drop the `EstadoReporte` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Reporte` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "dbo"."Reporte" DROP CONSTRAINT "Reporte_encuestaId_fkey";

-- DropForeignKey
ALTER TABLE "dbo"."Reporte" DROP CONSTRAINT "Reporte_estadoReporteId_fkey";

-- DropTable
DROP TABLE "dbo"."EstadoReporte";

-- DropTable
DROP TABLE "dbo"."Reporte";
