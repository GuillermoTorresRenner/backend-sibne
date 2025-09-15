/*
  Warnings:

  - A unique constraint covering the columns `[empresaId]` on the table `Usuario` will be added. If there are existing duplicate values, this will fail.
  - Made the column `direccion` on table `Empresa` required. This step will fail if there are existing NULL values in that column.
  - Made the column `dv` on table `Empresa` required. This step will fail if there are existing NULL values in that column.
  - Made the column `nombre` on table `Empresa` required. This step will fail if there are existing NULL values in that column.
  - Made the column `razonSocial` on table `Empresa` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `anio` to the `Encuesta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fechaCreacion` to the `Encuesta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `margenError` to the `Encuesta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Encuesta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cantidadIn` to the `Transaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cantidadOut` to the `Transaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cantidadTCalIn` to the `Transaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `categoriaTransaccionId` to the `Transaccion` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."Comuna" DROP CONSTRAINT "Comuna_provinciaId_fkey";

-- AlterTable
ALTER TABLE "public"."Empresa" ALTER COLUMN "direccion" SET NOT NULL,
ALTER COLUMN "dv" SET NOT NULL,
ALTER COLUMN "nombre" SET NOT NULL,
ALTER COLUMN "razonSocial" SET NOT NULL;

-- AlterTable
ALTER TABLE "public"."Encuesta" ADD COLUMN     "anio" INTEGER NOT NULL,
ADD COLUMN     "archivoAdjuntoid" INTEGER,
ADD COLUMN     "fechaCreacion" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "fechaInicio" TIMESTAMP(3),
ADD COLUMN     "fechaTermino" TIMESTAMP(3),
ADD COLUMN     "margenError" INTEGER NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "valorDolar" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "public"."Transaccion" ADD COLUMN     "cantPoderCalorifico" DOUBLE PRECISION,
ADD COLUMN     "cantidadCapInstalada" DOUBLE PRECISION,
ADD COLUMN     "cantidadIn" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "cantidadNoAprovechada" DOUBLE PRECISION,
ADD COLUMN     "cantidadOut" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "cantidadTCalIn" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "categoriaTransaccionId" INTEGER NOT NULL,
ADD COLUMN     "datos" JSONB NOT NULL DEFAULT '{}',
ADD COLUMN     "detalle" TEXT,
ADD COLUMN     "energeticoInId" INTEGER,
ADD COLUMN     "energeticoOutId" INTEGER,
ADD COLUMN     "energeticoRegionDestId" INTEGER,
ADD COLUMN     "fechaIngreso" TIMESTAMP(3),
ADD COLUMN     "localidad" TEXT,
ADD COLUMN     "mercadoSpot" BOOLEAN,
ADD COLUMN     "nombreEmpresaDestino" TEXT,
ADD COLUMN     "nombreEmpresaOrigen" TEXT,
ADD COLUMN     "observacion" TEXT,
ADD COLUMN     "paisId" INTEGER,
ADD COLUMN     "porcentajeHumedad" DOUBLE PRECISION,
ADD COLUMN     "regionDestId" INTEGER,
ADD COLUMN     "sectorEconomicoDestId" INTEGER,
ADD COLUMN     "stockFinal" DOUBLE PRECISION,
ADD COLUMN     "stockInicial" DOUBLE PRECISION,
ADD COLUMN     "subCategoria" TEXT,
ADD COLUMN     "subSectorEconomicoDestId" INTEGER,
ADD COLUMN     "subTecnologia" TEXT,
ADD COLUMN     "tecnologiaId" INTEGER,
ADD COLUMN     "unidadMedidaCapInstaladaId" INTEGER,
ADD COLUMN     "unidadMedidaInId" INTEGER,
ADD COLUMN     "unidadMedidaNoAprovechadaId" INTEGER,
ADD COLUMN     "unidadMedidaOutId" INTEGER;

-- CreateTable
CREATE TABLE "public"."EstadoReporte" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "EstadoReporte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."IntensidadEnergEncuestaEmpresa" (
    "id" SERIAL NOT NULL,
    "empresaId" TEXT NOT NULL,
    "encuestaId" INTEGER NOT NULL,
    "procesoTerminado" BOOLEAN NOT NULL,
    "fechaHoraRegistro" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "IntensidadEnergEncuestaEmpresa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Pais" (
    "id" SERIAL NOT NULL,
    "iso2" TEXT NOT NULL,
    "iso3" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "numeroIso" INTEGER NOT NULL,

    CONSTRAINT "Pais_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Reporte" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "consultaSql" TEXT NOT NULL,
    "esStoredProcedure" BOOLEAN NOT NULL,
    "activo" BOOLEAN NOT NULL,
    "fechaGeneracionArchivo" TIMESTAMP(3),
    "estadoReporteId" INTEGER NOT NULL,
    "encuestaId" INTEGER,

    CONSTRAINT "Reporte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."SectorEconomicoSii" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "codigoStr" TEXT NOT NULL,
    "activo" BOOLEAN NOT NULL,

    CONSTRAINT "SectorEconomicoSii_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Tecnologia" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "Tecnologia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TipoOtroUso" (
    "id" SERIAL NOT NULL,
    "codigoStr" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "activo" BOOLEAN NOT NULL,
    "orden" INTEGER NOT NULL,

    CONSTRAINT "TipoOtroUso_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TipoPerdida" (
    "id" SERIAL NOT NULL,
    "codigoStr" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "orden" INTEGER NOT NULL,

    CONSTRAINT "TipoPerdida_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TransaccionIntensidadEnergia" (
    "id" SERIAL NOT NULL,
    "consumoEnergia" DOUBLE PRECISION NOT NULL,
    "ventaMonetariaAnual" DOUBLE PRECISION NOT NULL,
    "unidad" TEXT NOT NULL,
    "formularioId" INTEGER NOT NULL,
    "fechaHoraRegistro" TIMESTAMP(3) NOT NULL,
    "intensidadEnergEncuestaEmpresaId" INTEGER NOT NULL,

    CONSTRAINT "TransaccionIntensidadEnergia_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_empresaId_key" ON "public"."Usuario"("empresaId");

-- AddForeignKey
ALTER TABLE "public"."Empresa" ADD CONSTRAINT "Empresa_sectorEconomicoSiiId_fkey" FOREIGN KEY ("sectorEconomicoSiiId") REFERENCES "public"."SectorEconomicoSii"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Encuesta" ADD CONSTRAINT "Encuesta_archivoAdjuntoid_fkey" FOREIGN KEY ("archivoAdjuntoid") REFERENCES "public"."ArchivoAdjunto"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."IntensidadEnergEncuestaEmpresa" ADD CONSTRAINT "IntensidadEnergEncuestaEmpresa_empresaId_fkey" FOREIGN KEY ("empresaId") REFERENCES "public"."Empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."IntensidadEnergEncuestaEmpresa" ADD CONSTRAINT "IntensidadEnergEncuestaEmpresa_encuestaId_fkey" FOREIGN KEY ("encuestaId") REFERENCES "public"."Encuesta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Reporte" ADD CONSTRAINT "Reporte_estadoReporteId_fkey" FOREIGN KEY ("estadoReporteId") REFERENCES "public"."EstadoReporte"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Reporte" ADD CONSTRAINT "Reporte_encuestaId_fkey" FOREIGN KEY ("encuestaId") REFERENCES "public"."Encuesta"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_energeticoRegionDestId_fkey" FOREIGN KEY ("energeticoRegionDestId") REFERENCES "public"."Energetico"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_formularioId_fkey" FOREIGN KEY ("formularioId") REFERENCES "public"."Formulario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_categoriaTransaccionId_fkey" FOREIGN KEY ("categoriaTransaccionId") REFERENCES "public"."CategoriaTransaccion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_energeticoInId_fkey" FOREIGN KEY ("energeticoInId") REFERENCES "public"."Energetico"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_energeticoOutId_fkey" FOREIGN KEY ("energeticoOutId") REFERENCES "public"."Energetico"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_unidadMedidaInId_fkey" FOREIGN KEY ("unidadMedidaInId") REFERENCES "public"."UnidadMedida"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_unidadMedidaOutId_fkey" FOREIGN KEY ("unidadMedidaOutId") REFERENCES "public"."UnidadMedida"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_unidadMedidaNoAprovechadaId_fkey" FOREIGN KEY ("unidadMedidaNoAprovechadaId") REFERENCES "public"."UnidadMedida"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_unidadMedidaCapInstaladaId_fkey" FOREIGN KEY ("unidadMedidaCapInstaladaId") REFERENCES "public"."UnidadMedida"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_regionDestId_fkey" FOREIGN KEY ("regionDestId") REFERENCES "public"."Region"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_sectorEconomicoDestId_fkey" FOREIGN KEY ("sectorEconomicoDestId") REFERENCES "public"."SectorEconomico"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_subSectorEconomicoDestId_fkey" FOREIGN KEY ("subSectorEconomicoDestId") REFERENCES "public"."SubSectorEconomico"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_tecnologiaId_fkey" FOREIGN KEY ("tecnologiaId") REFERENCES "public"."Tecnologia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_paisId_fkey" FOREIGN KEY ("paisId") REFERENCES "public"."Pais"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TransaccionIntensidadEnergia" ADD CONSTRAINT "TransaccionIntensidadEnergia_intensidadEnergEncuestaEmpres_fkey" FOREIGN KEY ("intensidadEnergEncuestaEmpresaId") REFERENCES "public"."IntensidadEnergEncuestaEmpresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
