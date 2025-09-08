-- CreateEnum
CREATE TYPE "public"."role" AS ENUM ('ADMIN', 'USER');

-- CreateTable
CREATE TABLE "public"."ArchivoAdjunto" (
    "Id" SERIAL NOT NULL,
    "NombreArchivo" TEXT,
    "Tipo" TEXT,
    "Ext" TEXT,
    "FileData" BYTEA,

    CONSTRAINT "ArchivoAdjunto_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."AspNetRoleClaims" (
    "Id" SERIAL NOT NULL,
    "RoleId" TEXT NOT NULL,
    "ClaimType" TEXT,
    "ClaimValue" TEXT,

    CONSTRAINT "AspNetRoleClaims_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."AspNetRoles" (
    "Id" TEXT NOT NULL,
    "Name" TEXT,
    "NormalizedName" TEXT,
    "ConcurrencyStamp" TEXT,

    CONSTRAINT "AspNetRoles_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."AspNetUserClaims" (
    "Id" SERIAL NOT NULL,
    "UserId" TEXT NOT NULL,
    "ClaimType" TEXT,
    "ClaimValue" TEXT,

    CONSTRAINT "AspNetUserClaims_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."AspNetUserLogins" (
    "LoginProvider" TEXT NOT NULL,
    "ProviderKey" TEXT NOT NULL,
    "ProviderDisplayName" TEXT,
    "UserId" TEXT NOT NULL,

    CONSTRAINT "AspNetUserLogins_pkey" PRIMARY KEY ("LoginProvider","ProviderKey")
);

-- CreateTable
CREATE TABLE "public"."AspNetUserRoles" (
    "UserId" TEXT NOT NULL,
    "RoleId" TEXT NOT NULL,

    CONSTRAINT "AspNetUserRoles_pkey" PRIMARY KEY ("UserId","RoleId")
);

-- CreateTable
CREATE TABLE "public"."AspNetUserTokens" (
    "UserId" TEXT NOT NULL,
    "LoginProvider" TEXT NOT NULL,
    "Name" TEXT NOT NULL,
    "Value" TEXT,

    CONSTRAINT "AspNetUserTokens_pkey" PRIMARY KEY ("UserId","LoginProvider","Name")
);

-- CreateTable
CREATE TABLE "public"."AspNetUsers" (
    "Id" TEXT NOT NULL,
    "UserName" TEXT NOT NULL,
    "NormalizedUserName" TEXT,
    "Email" TEXT,
    "NormalizedEmail" TEXT,
    "EmailConfirmed" BOOLEAN NOT NULL,
    "PasswordHash" TEXT,
    "SecurityStamp" TEXT,
    "ConcurrencyStamp" TEXT,
    "PhoneNumber" TEXT,
    "PhoneNumberConfirmed" BOOLEAN NOT NULL,
    "TwoFactorEnabled" BOOLEAN NOT NULL,
    "LockoutEnd" TIMESTAMP(3),
    "LockoutEnabled" BOOLEAN NOT NULL,
    "AccessFailedCount" INTEGER NOT NULL,
    "Habilitado" BOOLEAN NOT NULL,
    "Nombre" TEXT,
    "Apellido" TEXT,
    "Eliminado" BOOLEAN NOT NULL,
    "PrimerIngreso" BOOLEAN NOT NULL,

    CONSTRAINT "AspNetUsers_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."CargaMasivaArchivo" (
    "Id" SERIAL NOT NULL,
    "NombreArchivo" TEXT,
    "FechaIngreso" TIMESTAMP(3),
    "Estado" TEXT,

    CONSTRAINT "CargaMasivaArchivo_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."CargaMasivaDetalle" (
    "Id" SERIAL NOT NULL,
    "CargaMasivaArchivoId" INTEGER NOT NULL,
    "NombreHoja" TEXT,
    "FechaIngreso" TIMESTAMP(3),
    "Estado" TEXT,
    "RegistrosCargado" INTEGER NOT NULL,
    "RegistrosConError" INTEGER NOT NULL,
    "TotalRegistros" INTEGER NOT NULL,

    CONSTRAINT "CargaMasivaDetalle_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."CargaMasivaError" (
    "Id" SERIAL NOT NULL,
    "CargaMasivaArchivoId" INTEGER NOT NULL,
    "Linea" INTEGER NOT NULL,
    "Columna" INTEGER NOT NULL,
    "NombreCampo" TEXT,
    "Descripcion" TEXT,
    "CargaMasivaDetalleId" INTEGER NOT NULL,
    "EmpresaId" TEXT,

    CONSTRAINT "CargaMasivaError_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."CategoriaTransaccion" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "Categoria" TEXT,
    "FormularioId" INTEGER NOT NULL,

    CONSTRAINT "CategoriaTransaccion_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Comuna" (
    "Id" SERIAL NOT NULL,
    "ProvinciaId" INTEGER NOT NULL,
    "RegionId" INTEGER NOT NULL,
    "Nombre" TEXT,
    "Old_Id" INTEGER,

    CONSTRAINT "Comuna_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Contacto" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "Cargo" TEXT,
    "Email" TEXT,
    "Telefono" TEXT,
    "EmpresaId" TEXT NOT NULL,
    "TipoContactoId" INTEGER NOT NULL,
    "DigitoVerificador" TEXT,
    "Rut" INTEGER NOT NULL,

    CONSTRAINT "Contacto_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."EmailConfig" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "Descripcion" TEXT,
    "Asunto" TEXT,
    "Plantilla" TEXT,
    "EncuestaId" INTEGER,
    "EstadoEmailId" INTEGER NOT NULL,
    "ListaEmpresas" TEXT,
    "FechaGeneracionEnvio" TIMESTAMP(3),

    CONSTRAINT "EmailConfig_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."EmailLogs" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "Email" TEXT,
    "Estado" TEXT,
    "FechaEnvio" TIMESTAMP(3),
    "Mensaje" TEXT,

    CONSTRAINT "EmailLogs_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Empresa" (
    "Id" TEXT NOT NULL,
    "Rut" INTEGER NOT NULL,
    "Dv" TEXT,
    "Nombre" TEXT,
    "RazonSocial" TEXT,
    "Habilitado" BOOLEAN NOT NULL,
    "SectorEnergeticoId" INTEGER NOT NULL,
    "SectorEconomicoId" INTEGER NOT NULL,
    "SubSectorEconomicoId" INTEGER NOT NULL,
    "Direccion" TEXT,
    "SectorEconomicoSiiId" INTEGER,
    "InstensidadEnergiaFormObligada" BOOLEAN NOT NULL,

    CONSTRAINT "Empresa_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Encuesta" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "Anio" INTEGER NOT NULL,
    "FechaCreacion" TIMESTAMP(3) NOT NULL,
    "FechaInicio" TIMESTAMP(3),
    "FechaTermino" TIMESTAMP(3),
    "MargenError" INTEGER NOT NULL,
    "Activo" BOOLEAN NOT NULL,
    "ArchivoAdjuntoid" INTEGER,
    "ValorDolar" DOUBLE PRECISION,

    CONSTRAINT "Encuesta_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."EncuestaEmpresa" (
    "EncuestaId" INTEGER NOT NULL,
    "EmpresaId" TEXT NOT NULL,
    "EstadoEmpresaId" INTEGER NOT NULL,

    CONSTRAINT "EncuestaEmpresa_pkey" PRIMARY KEY ("EncuestaId","EmpresaId")
);

-- CreateTable
CREATE TABLE "public"."EncuestaPlanta" (
    "EncuestaId" INTEGER NOT NULL,
    "PlantaId" INTEGER NOT NULL,
    "EstadoProcesoId" INTEGER NOT NULL,
    "FechaAsignacion" TIMESTAMP(3) NOT NULL,
    "FechaFinalizacion" TIMESTAMP(3),
    "FechaInicio" TIMESTAMP(3),
    "FechaTransaccion" TIMESTAMP(3),

    CONSTRAINT "EncuestaPlanta_pkey" PRIMARY KEY ("EncuestaId","PlantaId")
);

-- CreateTable
CREATE TABLE "public"."Energetico" (
    "Id" SERIAL NOT NULL,
    "Activo" BOOLEAN NOT NULL,
    "CodigoStr" TEXT,
    "Nombre" TEXT,
    "Descripcion" TEXT,
    "LibreDisposicion" BOOLEAN NOT NULL,
    "DensidadUnidadMedidaId" INTEGER,
    "DensidadValor" DOUBLE PRECISION,
    "PoderCalorificoUMedidaId" INTEGER,
    "PoderCalorificoValor" DOUBLE PRECISION,
    "PedirHumedad" BOOLEAN NOT NULL,
    "PedirPoderCalorifico" BOOLEAN NOT NULL,
    "EnergeticoGrupoId" INTEGER NOT NULL,

    CONSTRAINT "Energetico_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."EnergeticoGrupos" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,

    CONSTRAINT "EnergeticoGrupos_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."EnergeticoUnidadMedida" (
    "EnergeticoId" INTEGER NOT NULL,
    "UnidadMedidaId" INTEGER NOT NULL,

    CONSTRAINT "EnergeticoUnidadMedida_pkey" PRIMARY KEY ("EnergeticoId","UnidadMedidaId")
);

-- CreateTable
CREATE TABLE "public"."EstadoEmail" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,

    CONSTRAINT "EstadoEmail_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."EstadoEmpresa" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,

    CONSTRAINT "EstadoEmpresa_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."EstadoProceso" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,

    CONSTRAINT "EstadoProceso_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."EstadoReporte" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,

    CONSTRAINT "EstadoReporte_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."FactorConversion" (
    "Id" SERIAL NOT NULL,
    "Factor" DOUBLE PRECISION NOT NULL,
    "UOrigenId" INTEGER NOT NULL,
    "UDestinoId" INTEGER NOT NULL,

    CONSTRAINT "FactorConversion_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Formulario" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "Orden" INTEGER NOT NULL,
    "CodigoNav" TEXT,

    CONSTRAINT "Formulario_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."IntensidadEnergEncuestaEmpresa" (
    "Id" SERIAL NOT NULL,
    "EmpresaId" TEXT,
    "EncuestaId" INTEGER NOT NULL,
    "ProcesoTerminado" BOOLEAN NOT NULL,
    "FechaHoraRegistro" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "IntensidadEnergEncuestaEmpresa_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Pais" (
    "Id" SERIAL NOT NULL,
    "Iso2" TEXT,
    "Iso3" TEXT,
    "Nombre" TEXT,
    "NumeroIso" INTEGER NOT NULL,

    CONSTRAINT "Pais_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Planta" (
    "Id" SERIAL NOT NULL,
    "Codigo" INTEGER NOT NULL,
    "Nombre" TEXT,
    "Activo" BOOLEAN NOT NULL,
    "ComunaId" INTEGER NOT NULL,
    "EmpresaId" TEXT NOT NULL,

    CONSTRAINT "Planta_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Provincia" (
    "Id" SERIAL NOT NULL,
    "RegionId" INTEGER NOT NULL,
    "Nombre" TEXT,

    CONSTRAINT "Provincia_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Region" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "Numero" INTEGER NOT NULL,
    "Posicion" INTEGER NOT NULL,

    CONSTRAINT "Region_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Reporte" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "Descripcion" TEXT,
    "ConsultaSql" TEXT,
    "Activo" BOOLEAN NOT NULL,
    "EsStoredProcedure" BOOLEAN NOT NULL,
    "EstadoReporteId" INTEGER NOT NULL,
    "EncuestaId" INTEGER,
    "FechaGeneracionArchivo" TIMESTAMP(3),

    CONSTRAINT "Reporte_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."SectorEconomico" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "CodigoStr" TEXT,
    "Activo" BOOLEAN NOT NULL,

    CONSTRAINT "SectorEconomico_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."SectorEconomicoSii" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "CodigoStr" TEXT,
    "Activo" BOOLEAN NOT NULL,

    CONSTRAINT "SectorEconomicoSii_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."SectorEnergetico" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "CodigoStr" TEXT,

    CONSTRAINT "SectorEnergetico_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."SubSectorEconomico" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,
    "SectorEconomicoId" INTEGER NOT NULL,
    "Activo" BOOLEAN NOT NULL,

    CONSTRAINT "SubSectorEconomico_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Tecnologia" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,

    CONSTRAINT "Tecnologia_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."TipoContacto" (
    "Id" SERIAL NOT NULL,
    "Nombre" TEXT,

    CONSTRAINT "TipoContacto_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."TipoOtroUso" (
    "Id" SERIAL NOT NULL,
    "CodigoStr" TEXT,
    "Nombre" TEXT,
    "Activo" BOOLEAN NOT NULL,
    "Orden" INTEGER NOT NULL,

    CONSTRAINT "TipoOtroUso_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."TipoPerdida" (
    "Id" SERIAL NOT NULL,
    "CodigoStr" TEXT,
    "Nombre" TEXT,
    "Orden" INTEGER NOT NULL,

    CONSTRAINT "TipoPerdida_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."TipoTransporte" (
    "Id" SERIAL NOT NULL,
    "CodigoStr" TEXT,
    "Nombre" TEXT,
    "Orden" INTEGER NOT NULL,

    CONSTRAINT "TipoTransporte_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."TipoUsoProceso" (
    "Id" SERIAL NOT NULL,
    "CodigoStr" TEXT,
    "Nombre" TEXT,
    "Orden" INTEGER NOT NULL,

    CONSTRAINT "TipoUsoProceso_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."Transaccion" (
    "Id" SERIAL NOT NULL,
    "CantidadIn" DOUBLE PRECISION NOT NULL,
    "CantidadOut" DOUBLE PRECISION NOT NULL,
    "CantidadTCalIn" DOUBLE PRECISION NOT NULL,
    "CantidadTCalOut" DOUBLE PRECISION NOT NULL,
    "CategoriaTransaccionId" INTEGER NOT NULL,
    "EnergeticoInId" INTEGER,
    "EnergeticoOutId" INTEGER,
    "FechaIngreso" TIMESTAMP(3),
    "FormularioId" INTEGER NOT NULL,
    "PlantaId" INTEGER NOT NULL,
    "EncuestaId" INTEGER NOT NULL,
    "UnidadMedidaInId" INTEGER,
    "UnidadMedidaOutId" INTEGER,
    "DatosStr" TEXT,
    "RegionDestId" INTEGER,
    "SectorEconomicoDestId" INTEGER,
    "SubSectorEconomicoDestId" INTEGER,
    "CantPoderCalorifico" DOUBLE PRECISION,
    "PorcentajeHumedad" DOUBLE PRECISION,
    "NombreEmpresaOrigen" TEXT,
    "StockFinal" DOUBLE PRECISION,
    "StockInicial" DOUBLE PRECISION,
    "NombreEmpresaDestino" TEXT,
    "MercadoSpot" BOOLEAN,
    "Localidad" TEXT,
    "TecnologiaId" INTEGER,
    "UnidadMedidaNoAprovechadaId" INTEGER,
    "CantidadNoAprovechada" DOUBLE PRECISION,
    "UnidadMedidaCapInstaladaId" INTEGER,
    "CantidadCapInstalada" DOUBLE PRECISION,
    "Observacion" TEXT,
    "PaisId" INTEGER,
    "SubTecnologia" TEXT,
    "Detalle" TEXT,
    "SubCategoria" TEXT,

    CONSTRAINT "Transaccion_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."TransaccionIntensidadEnergia" (
    "Id" SERIAL NOT NULL,
    "ConsumoEnergia" DOUBLE PRECISION NOT NULL,
    "VentaMonetariaAnual" DOUBLE PRECISION NOT NULL,
    "Unidad" TEXT,
    "FormularioId" INTEGER NOT NULL,
    "FechaHoraRegistro" TIMESTAMP(3) NOT NULL,
    "IntensidadEnergEncuestaEmpresaId" INTEGER NOT NULL,

    CONSTRAINT "TransaccionIntensidadEnergia_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."UnidadMedida" (
    "Id" SERIAL NOT NULL,
    "CodigoStr" TEXT,
    "Nombre" TEXT,
    "TipoUnidad" TEXT,
    "DestinoId" INTEGER,
    "OrigenId" INTEGER,
    "VisibleSelect" BOOLEAN NOT NULL,

    CONSTRAINT "UnidadMedida_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "public"."users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT,
    "surname" TEXT,
    "role" "public"."role" NOT NULL DEFAULT 'USER',
    "lastConnection" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "refreshToken" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "public"."users"("email");
