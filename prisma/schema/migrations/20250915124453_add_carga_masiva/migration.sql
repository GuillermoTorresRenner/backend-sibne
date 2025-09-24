-- CreateTable
CREATE TABLE "public"."CargaMasivaArchivo" (
    "id" SERIAL NOT NULL,
    "NombreArchivo" TEXT NOT NULL,
    "FechaIngreso" TIMESTAMP(3) NOT NULL,
    "Estado" TEXT NOT NULL,

    CONSTRAINT "CargaMasivaArchivo_pkey" PRIMARY KEY ("id")
);
