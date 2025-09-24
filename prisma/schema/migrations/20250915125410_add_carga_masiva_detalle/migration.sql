/*
  Warnings:

  - You are about to drop the column `Estado` on the `CargaMasivaArchivo` table. All the data in the column will be lost.
  - You are about to drop the column `FechaIngreso` on the `CargaMasivaArchivo` table. All the data in the column will be lost.
  - You are about to drop the column `NombreArchivo` on the `CargaMasivaArchivo` table. All the data in the column will be lost.
  - Added the required column `estado` to the `CargaMasivaArchivo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombreArchivo` to the `CargaMasivaArchivo` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."CargaMasivaArchivo" DROP COLUMN "Estado",
DROP COLUMN "FechaIngreso",
DROP COLUMN "NombreArchivo",
ADD COLUMN     "estado" TEXT NOT NULL,
ADD COLUMN     "fechaIngreso" TIMESTAMP(3),
ADD COLUMN     "nombreArchivo" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "public"."CargaMasivaDetalle" (
    "id" SERIAL NOT NULL,
    "cargaMasivaArchivoId" INTEGER NOT NULL,
    "nombreHoja" TEXT NOT NULL,
    "fechaIngreso" TIMESTAMP(3),
    "estado" TEXT NOT NULL,
    "registrosCargado" INTEGER NOT NULL,
    "registrosConError" INTEGER NOT NULL,
    "totalRegistros" INTEGER NOT NULL,

    CONSTRAINT "CargaMasivaDetalle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CargaMasivaError" (
    "id" SERIAL NOT NULL,
    "cargaMasivaArchivoId" INTEGER NOT NULL,
    "linea" INTEGER NOT NULL,
    "columna" INTEGER NOT NULL,
    "nombreCampo" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "cargaMasivaDetalleId" INTEGER NOT NULL,
    "empresaId" TEXT NOT NULL,

    CONSTRAINT "CargaMasivaError_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."CargaMasivaDetalle" ADD CONSTRAINT "CargaMasivaDetalle_cargaMasivaArchivoId_fkey" FOREIGN KEY ("cargaMasivaArchivoId") REFERENCES "public"."CargaMasivaArchivo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CargaMasivaError" ADD CONSTRAINT "CargaMasivaError_cargaMasivaDetalleId_fkey" FOREIGN KEY ("cargaMasivaDetalleId") REFERENCES "public"."CargaMasivaDetalle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
