/*
  Warnings:

  - The primary key for the `ArchivoAdjunto` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Ext` on the `ArchivoAdjunto` table. All the data in the column will be lost.
  - You are about to drop the column `FileData` on the `ArchivoAdjunto` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `ArchivoAdjunto` table. All the data in the column will be lost.
  - You are about to drop the column `NombreArchivo` on the `ArchivoAdjunto` table. All the data in the column will be lost.
  - You are about to drop the column `Tipo` on the `ArchivoAdjunto` table. All the data in the column will be lost.
  - The primary key for the `CategoriaTransaccion` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Categoria` on the `CategoriaTransaccion` table. All the data in the column will be lost.
  - You are about to drop the column `FormularioId` on the `CategoriaTransaccion` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `CategoriaTransaccion` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `CategoriaTransaccion` table. All the data in the column will be lost.
  - The primary key for the `Comuna` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Id` on the `Comuna` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Comuna` table. All the data in the column will be lost.
  - You are about to drop the column `Old_Id` on the `Comuna` table. All the data in the column will be lost.
  - You are about to drop the column `ProvinciaId` on the `Comuna` table. All the data in the column will be lost.
  - You are about to drop the column `RegionId` on the `Comuna` table. All the data in the column will be lost.
  - The primary key for the `Contacto` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Cargo` on the `Contacto` table. All the data in the column will be lost.
  - You are about to drop the column `DigitoVerificador` on the `Contacto` table. All the data in the column will be lost.
  - You are about to drop the column `Email` on the `Contacto` table. All the data in the column will be lost.
  - You are about to drop the column `EmpresaId` on the `Contacto` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Contacto` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Contacto` table. All the data in the column will be lost.
  - You are about to drop the column `Rut` on the `Contacto` table. All the data in the column will be lost.
  - You are about to drop the column `Telefono` on the `Contacto` table. All the data in the column will be lost.
  - You are about to drop the column `TipoContactoId` on the `Contacto` table. All the data in the column will be lost.
  - The primary key for the `EmailConfig` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Asunto` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `Descripcion` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `EncuestaId` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `EstadoEmailId` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `FechaGeneracionEnvio` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `ListaEmpresas` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `EmailConfig` table. All the data in the column will be lost.
  - You are about to drop the column `Plantilla` on the `EmailConfig` table. All the data in the column will be lost.
  - The primary key for the `EmailLogs` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Email` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `Estado` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `FechaEnvio` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `Mensaje` on the `EmailLogs` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `EmailLogs` table. All the data in the column will be lost.
  - The primary key for the `Empresa` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Direccion` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `Dv` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `Habilitado` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `InstensidadEnergiaFormObligada` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `RazonSocial` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `Rut` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `SectorEconomicoId` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `SectorEconomicoSiiId` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `SectorEnergeticoId` on the `Empresa` table. All the data in the column will be lost.
  - You are about to drop the column `SubSectorEconomicoId` on the `Empresa` table. All the data in the column will be lost.
  - The primary key for the `Encuesta` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Activo` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `Anio` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `ArchivoAdjuntoid` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `FechaCreacion` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `FechaInicio` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `FechaTermino` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `MargenError` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Encuesta` table. All the data in the column will be lost.
  - You are about to drop the column `ValorDolar` on the `Encuesta` table. All the data in the column will be lost.
  - The primary key for the `EncuestaEmpresa` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `EmpresaId` on the `EncuestaEmpresa` table. All the data in the column will be lost.
  - You are about to drop the column `EncuestaId` on the `EncuestaEmpresa` table. All the data in the column will be lost.
  - You are about to drop the column `EstadoEmpresaId` on the `EncuestaEmpresa` table. All the data in the column will be lost.
  - The primary key for the `EncuestaPlanta` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `EncuestaId` on the `EncuestaPlanta` table. All the data in the column will be lost.
  - You are about to drop the column `EstadoProcesoId` on the `EncuestaPlanta` table. All the data in the column will be lost.
  - You are about to drop the column `FechaAsignacion` on the `EncuestaPlanta` table. All the data in the column will be lost.
  - You are about to drop the column `FechaFinalizacion` on the `EncuestaPlanta` table. All the data in the column will be lost.
  - You are about to drop the column `FechaInicio` on the `EncuestaPlanta` table. All the data in the column will be lost.
  - You are about to drop the column `FechaTransaccion` on the `EncuestaPlanta` table. All the data in the column will be lost.
  - You are about to drop the column `PlantaId` on the `EncuestaPlanta` table. All the data in the column will be lost.
  - The primary key for the `Energetico` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Activo` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `CodigoStr` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `DensidadUnidadMedidaId` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `DensidadValor` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `Descripcion` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `EnergeticoGrupoId` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `LibreDisposicion` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `PedirHumedad` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `PedirPoderCalorifico` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `PoderCalorificoUMedidaId` on the `Energetico` table. All the data in the column will be lost.
  - You are about to drop the column `PoderCalorificoValor` on the `Energetico` table. All the data in the column will be lost.
  - The primary key for the `EnergeticoGrupos` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Id` on the `EnergeticoGrupos` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `EnergeticoGrupos` table. All the data in the column will be lost.
  - The primary key for the `EnergeticoUnidadMedida` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `EnergeticoId` on the `EnergeticoUnidadMedida` table. All the data in the column will be lost.
  - You are about to drop the column `UnidadMedidaId` on the `EnergeticoUnidadMedida` table. All the data in the column will be lost.
  - The primary key for the `EstadoEmail` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Id` on the `EstadoEmail` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `EstadoEmail` table. All the data in the column will be lost.
  - The primary key for the `EstadoEmpresa` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Id` on the `EstadoEmpresa` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `EstadoEmpresa` table. All the data in the column will be lost.
  - The primary key for the `EstadoProceso` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Id` on the `EstadoProceso` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `EstadoProceso` table. All the data in the column will be lost.
  - The primary key for the `FactorConversion` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Factor` on the `FactorConversion` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `FactorConversion` table. All the data in the column will be lost.
  - You are about to drop the column `UDestinoId` on the `FactorConversion` table. All the data in the column will be lost.
  - You are about to drop the column `UOrigenId` on the `FactorConversion` table. All the data in the column will be lost.
  - The primary key for the `Formulario` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `CodigoNav` on the `Formulario` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Formulario` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Formulario` table. All the data in the column will be lost.
  - You are about to drop the column `Orden` on the `Formulario` table. All the data in the column will be lost.
  - The primary key for the `Planta` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Activo` on the `Planta` table. All the data in the column will be lost.
  - You are about to drop the column `Codigo` on the `Planta` table. All the data in the column will be lost.
  - You are about to drop the column `ComunaId` on the `Planta` table. All the data in the column will be lost.
  - You are about to drop the column `EmpresaId` on the `Planta` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Planta` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Planta` table. All the data in the column will be lost.
  - The primary key for the `Provincia` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Id` on the `Provincia` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Provincia` table. All the data in the column will be lost.
  - You are about to drop the column `RegionId` on the `Provincia` table. All the data in the column will be lost.
  - The primary key for the `Region` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Id` on the `Region` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `Region` table. All the data in the column will be lost.
  - You are about to drop the column `Numero` on the `Region` table. All the data in the column will be lost.
  - You are about to drop the column `Posicion` on the `Region` table. All the data in the column will be lost.
  - The primary key for the `SectorEconomico` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Activo` on the `SectorEconomico` table. All the data in the column will be lost.
  - You are about to drop the column `CodigoStr` on the `SectorEconomico` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `SectorEconomico` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `SectorEconomico` table. All the data in the column will be lost.
  - The primary key for the `SectorEnergetico` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `CodigoStr` on the `SectorEnergetico` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `SectorEnergetico` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `SectorEnergetico` table. All the data in the column will be lost.
  - The primary key for the `SubSectorEconomico` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Activo` on the `SubSectorEconomico` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `SubSectorEconomico` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `SubSectorEconomico` table. All the data in the column will be lost.
  - You are about to drop the column `SectorEconomicoId` on the `SubSectorEconomico` table. All the data in the column will be lost.
  - The primary key for the `TipoContacto` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Id` on the `TipoContacto` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `TipoContacto` table. All the data in the column will be lost.
  - The primary key for the `TipoTransporte` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `CodigoStr` on the `TipoTransporte` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `TipoTransporte` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `TipoTransporte` table. All the data in the column will be lost.
  - You are about to drop the column `Orden` on the `TipoTransporte` table. All the data in the column will be lost.
  - The primary key for the `TipoUsoProceso` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `CodigoStr` on the `TipoUsoProceso` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `TipoUsoProceso` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `TipoUsoProceso` table. All the data in the column will be lost.
  - You are about to drop the column `Orden` on the `TipoUsoProceso` table. All the data in the column will be lost.
  - The primary key for the `Transaccion` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `CantPoderCalorifico` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `CantidadCapInstalada` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `CantidadIn` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `CantidadNoAprovechada` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `CantidadOut` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `CantidadTCalIn` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `CantidadTCalOut` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `CategoriaTransaccionId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `DatosStr` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `Detalle` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `EncuestaId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `EnergeticoInId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `EnergeticoOutId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `FechaIngreso` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `FormularioId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `Localidad` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `MercadoSpot` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `NombreEmpresaDestino` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `NombreEmpresaOrigen` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `Observacion` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `PaisId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `PlantaId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `PorcentajeHumedad` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `RegionDestId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `SectorEconomicoDestId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `StockFinal` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `StockInicial` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `SubCategoria` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `SubSectorEconomicoDestId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `SubTecnologia` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `TecnologiaId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `UnidadMedidaCapInstaladaId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `UnidadMedidaInId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `UnidadMedidaNoAprovechadaId` on the `Transaccion` table. All the data in the column will be lost.
  - You are about to drop the column `UnidadMedidaOutId` on the `Transaccion` table. All the data in the column will be lost.
  - The primary key for the `UnidadMedida` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `CodigoStr` on the `UnidadMedida` table. All the data in the column will be lost.
  - You are about to drop the column `DestinoId` on the `UnidadMedida` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `UnidadMedida` table. All the data in the column will be lost.
  - You are about to drop the column `Nombre` on the `UnidadMedida` table. All the data in the column will be lost.
  - You are about to drop the column `OrigenId` on the `UnidadMedida` table. All the data in the column will be lost.
  - You are about to drop the column `TipoUnidad` on the `UnidadMedida` table. All the data in the column will be lost.
  - You are about to drop the column `VisibleSelect` on the `UnidadMedida` table. All the data in the column will be lost.
  - You are about to drop the `AspNetUserTokens` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `AspNetUsers` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CargaMasivaArchivo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CargaMasivaDetalle` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CargaMasivaError` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `EstadoReporte` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `IntensidadEnergEncuestaEmpresa` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Pais` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Reporte` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SectorEconomicoSii` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Tecnologia` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TipoOtroUso` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TipoPerdida` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TransaccionIntensidadEnergia` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `ext` to the `ArchivoAdjunto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fileData` to the `ArchivoAdjunto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombreArchivo` to the `ArchivoAdjunto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tipo` to the `ArchivoAdjunto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `categoria` to the `CategoriaTransaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `formularioId` to the `CategoriaTransaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `CategoriaTransaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Comuna` table without a default value. This is not possible if the table is not empty.
  - Added the required column `provinciaId` to the `Comuna` table without a default value. This is not possible if the table is not empty.
  - Added the required column `regionId` to the `Comuna` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cargo` to the `Contacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `digitoVerificador` to the `Contacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email` to the `Contacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `empresaId` to the `Contacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Contacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rut` to the `Contacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `telefono` to the `Contacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tipoContactoId` to the `Contacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `asunto` to the `EmailConfig` table without a default value. This is not possible if the table is not empty.
  - Added the required column `descripcion` to the `EmailConfig` table without a default value. This is not possible if the table is not empty.
  - Added the required column `estadoEmailId` to the `EmailConfig` table without a default value. This is not possible if the table is not empty.
  - Added the required column `listaEmpresas` to the `EmailConfig` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `EmailConfig` table without a default value. This is not possible if the table is not empty.
  - Added the required column `plantilla` to the `EmailConfig` table without a default value. This is not possible if the table is not empty.
  - Added the required column `empresaId` to the `EmailLogs` table without a default value. This is not possible if the table is not empty.
  - Added the required column `estado` to the `EmailLogs` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fechaHoraRegistro` to the `EmailLogs` table without a default value. This is not possible if the table is not empty.
  - Added the required column `msje` to the `EmailLogs` table without a default value. This is not possible if the table is not empty.
  - Added the required column `para` to the `EmailLogs` table without a default value. This is not possible if the table is not empty.
  - Added the required column `habilitado` to the `Empresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Empresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `instensidadEnergiaFormObligada` to the `Empresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rut` to the `Empresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sectorEconomicoId` to the `Empresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sectorEnergeticoId` to the `Empresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subSectorEconomicoId` to the `Empresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `activo` to the `Encuesta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `empresaId` to the `EncuestaEmpresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `encuestaId` to the `EncuestaEmpresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `estadoEmpresaId` to the `EncuestaEmpresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `encuestaId` to the `EncuestaPlanta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `estadoProcesoId` to the `EncuestaPlanta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fechaAsignacion` to the `EncuestaPlanta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `plantaId` to the `EncuestaPlanta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `activo` to the `Energetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigoStr` to the `Energetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `descripcion` to the `Energetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `energeticoGrupoId` to the `Energetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `libreDisposicion` to the `Energetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Energetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pedirHumedad` to the `Energetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pedirPoderCalorifico` to the `Energetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `EnergeticoGrupos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `energeticoId` to the `EnergeticoUnidadMedida` table without a default value. This is not possible if the table is not empty.
  - Added the required column `unidadMedidaId` to the `EnergeticoUnidadMedida` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `EstadoEmail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `EstadoEmpresa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `EstadoProceso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `factor` to the `FactorConversion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `uDestinoId` to the `FactorConversion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `uOrigenId` to the `FactorConversion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigoNav` to the `Formulario` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Formulario` table without a default value. This is not possible if the table is not empty.
  - Added the required column `orden` to the `Formulario` table without a default value. This is not possible if the table is not empty.
  - Added the required column `activo` to the `Planta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigo` to the `Planta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `comunaId` to the `Planta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `empresaId` to the `Planta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Planta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Provincia` table without a default value. This is not possible if the table is not empty.
  - Added the required column `regionId` to the `Provincia` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Region` table without a default value. This is not possible if the table is not empty.
  - Added the required column `numero` to the `Region` table without a default value. This is not possible if the table is not empty.
  - Added the required column `posicion` to the `Region` table without a default value. This is not possible if the table is not empty.
  - Added the required column `activo` to the `SectorEconomico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigoStr` to the `SectorEconomico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `SectorEconomico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigoStr` to the `SectorEnergetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `SectorEnergetico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `activo` to the `SubSectorEconomico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `SubSectorEconomico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sectorEconomicoId` to the `SubSectorEconomico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `TipoContacto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigoStr` to the `TipoTransporte` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `TipoTransporte` table without a default value. This is not possible if the table is not empty.
  - Added the required column `orden` to the `TipoTransporte` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigoStr` to the `TipoUsoProceso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `TipoUsoProceso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `orden` to the `TipoUsoProceso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cantidadTCalOut` to the `Transaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `encuestaId` to the `Transaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `formularioId` to the `Transaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `plantaId` to the `Transaccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigoStr` to the `UnidadMedida` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `UnidadMedida` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tipoUnidad` to the `UnidadMedida` table without a default value. This is not possible if the table is not empty.
  - Added the required column `visibleSelect` to the `UnidadMedida` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."ArchivoAdjunto" DROP CONSTRAINT "ArchivoAdjunto_pkey",
DROP COLUMN "Ext",
DROP COLUMN "FileData",
DROP COLUMN "Id",
DROP COLUMN "NombreArchivo",
DROP COLUMN "Tipo",
ADD COLUMN     "ext" TEXT NOT NULL,
ADD COLUMN     "fileData" BYTEA NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombreArchivo" TEXT NOT NULL,
ADD COLUMN     "tipo" TEXT NOT NULL,
ADD CONSTRAINT "ArchivoAdjunto_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."CategoriaTransaccion" DROP CONSTRAINT "CategoriaTransaccion_pkey",
DROP COLUMN "Categoria",
DROP COLUMN "FormularioId",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "categoria" TEXT NOT NULL,
ADD COLUMN     "formularioId" INTEGER NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "CategoriaTransaccion_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Comuna" DROP CONSTRAINT "Comuna_pkey",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "Old_Id",
DROP COLUMN "ProvinciaId",
DROP COLUMN "RegionId",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "provinciaId" INTEGER NOT NULL,
ADD COLUMN     "regionId" INTEGER NOT NULL,
ADD CONSTRAINT "Comuna_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Contacto" DROP CONSTRAINT "Contacto_pkey",
DROP COLUMN "Cargo",
DROP COLUMN "DigitoVerificador",
DROP COLUMN "Email",
DROP COLUMN "EmpresaId",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "Rut",
DROP COLUMN "Telefono",
DROP COLUMN "TipoContactoId",
ADD COLUMN     "cargo" TEXT NOT NULL,
ADD COLUMN     "digitoVerificador" TEXT NOT NULL,
ADD COLUMN     "email" TEXT NOT NULL,
ADD COLUMN     "empresaId" TEXT NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "rut" INTEGER NOT NULL,
ADD COLUMN     "telefono" TEXT NOT NULL,
ADD COLUMN     "tipoContactoId" INTEGER NOT NULL,
ADD CONSTRAINT "Contacto_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."EmailConfig" DROP CONSTRAINT "EmailConfig_pkey",
DROP COLUMN "Asunto",
DROP COLUMN "Descripcion",
DROP COLUMN "EncuestaId",
DROP COLUMN "EstadoEmailId",
DROP COLUMN "FechaGeneracionEnvio",
DROP COLUMN "Id",
DROP COLUMN "ListaEmpresas",
DROP COLUMN "Nombre",
DROP COLUMN "Plantilla",
ADD COLUMN     "asunto" TEXT NOT NULL,
ADD COLUMN     "descripcion" TEXT NOT NULL,
ADD COLUMN     "encuestaId" INTEGER,
ADD COLUMN     "estadoEmailId" INTEGER NOT NULL,
ADD COLUMN     "fechaGeneracionEnvio" TIMESTAMP(3),
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "listaEmpresas" TEXT NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "plantilla" TEXT NOT NULL,
ADD CONSTRAINT "EmailConfig_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."EmailLogs" DROP CONSTRAINT "EmailLogs_pkey",
DROP COLUMN "Email",
DROP COLUMN "Estado",
DROP COLUMN "FechaEnvio",
DROP COLUMN "Id",
DROP COLUMN "Mensaje",
DROP COLUMN "Nombre",
ADD COLUMN     "emailConfigId" INTEGER,
ADD COLUMN     "empresaId" TEXT NOT NULL,
ADD COLUMN     "estado" TEXT NOT NULL,
ADD COLUMN     "fechaHoraEnvio" TIMESTAMP(3),
ADD COLUMN     "fechaHoraRegistro" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "msje" TEXT NOT NULL,
ADD COLUMN     "para" TEXT NOT NULL,
ADD CONSTRAINT "EmailLogs_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Empresa" DROP CONSTRAINT "Empresa_pkey",
DROP COLUMN "Direccion",
DROP COLUMN "Dv",
DROP COLUMN "Habilitado",
DROP COLUMN "Id",
DROP COLUMN "InstensidadEnergiaFormObligada",
DROP COLUMN "Nombre",
DROP COLUMN "RazonSocial",
DROP COLUMN "Rut",
DROP COLUMN "SectorEconomicoId",
DROP COLUMN "SectorEconomicoSiiId",
DROP COLUMN "SectorEnergeticoId",
DROP COLUMN "SubSectorEconomicoId",
ADD COLUMN     "direccion" TEXT,
ADD COLUMN     "dv" TEXT,
ADD COLUMN     "habilitado" BOOLEAN NOT NULL,
ADD COLUMN     "id" TEXT NOT NULL,
ADD COLUMN     "instensidadEnergiaFormObligada" BOOLEAN NOT NULL,
ADD COLUMN     "nombre" TEXT,
ADD COLUMN     "razonSocial" TEXT,
ADD COLUMN     "rut" INTEGER NOT NULL,
ADD COLUMN     "sectorEconomicoId" INTEGER NOT NULL,
ADD COLUMN     "sectorEconomicoSiiId" INTEGER,
ADD COLUMN     "sectorEnergeticoId" INTEGER NOT NULL,
ADD COLUMN     "subSectorEconomicoId" INTEGER NOT NULL,
ADD CONSTRAINT "Empresa_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Encuesta" DROP CONSTRAINT "Encuesta_pkey",
DROP COLUMN "Activo",
DROP COLUMN "Anio",
DROP COLUMN "ArchivoAdjuntoid",
DROP COLUMN "FechaCreacion",
DROP COLUMN "FechaInicio",
DROP COLUMN "FechaTermino",
DROP COLUMN "Id",
DROP COLUMN "MargenError",
DROP COLUMN "Nombre",
DROP COLUMN "ValorDolar",
ADD COLUMN     "activo" BOOLEAN NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Encuesta_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."EncuestaEmpresa" DROP CONSTRAINT "EncuestaEmpresa_pkey",
DROP COLUMN "EmpresaId",
DROP COLUMN "EncuestaId",
DROP COLUMN "EstadoEmpresaId",
ADD COLUMN     "empresaId" TEXT NOT NULL,
ADD COLUMN     "encuestaId" INTEGER NOT NULL,
ADD COLUMN     "estadoEmpresaId" INTEGER NOT NULL,
ADD CONSTRAINT "EncuestaEmpresa_pkey" PRIMARY KEY ("empresaId", "encuestaId");

-- AlterTable
ALTER TABLE "public"."EncuestaPlanta" DROP CONSTRAINT "EncuestaPlanta_pkey",
DROP COLUMN "EncuestaId",
DROP COLUMN "EstadoProcesoId",
DROP COLUMN "FechaAsignacion",
DROP COLUMN "FechaFinalizacion",
DROP COLUMN "FechaInicio",
DROP COLUMN "FechaTransaccion",
DROP COLUMN "PlantaId",
ADD COLUMN     "encuestaId" INTEGER NOT NULL,
ADD COLUMN     "estadoProcesoId" INTEGER NOT NULL,
ADD COLUMN     "fechaAsignacion" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "fechaFinalizacion" TIMESTAMP(3),
ADD COLUMN     "fechaInicio" TIMESTAMP(3),
ADD COLUMN     "fechaTransaccion" TIMESTAMP(3),
ADD COLUMN     "plantaId" INTEGER NOT NULL,
ADD CONSTRAINT "EncuestaPlanta_pkey" PRIMARY KEY ("encuestaId", "plantaId");

-- AlterTable
ALTER TABLE "public"."Energetico" DROP CONSTRAINT "Energetico_pkey",
DROP COLUMN "Activo",
DROP COLUMN "CodigoStr",
DROP COLUMN "DensidadUnidadMedidaId",
DROP COLUMN "DensidadValor",
DROP COLUMN "Descripcion",
DROP COLUMN "EnergeticoGrupoId",
DROP COLUMN "Id",
DROP COLUMN "LibreDisposicion",
DROP COLUMN "Nombre",
DROP COLUMN "PedirHumedad",
DROP COLUMN "PedirPoderCalorifico",
DROP COLUMN "PoderCalorificoUMedidaId",
DROP COLUMN "PoderCalorificoValor",
ADD COLUMN     "activo" BOOLEAN NOT NULL,
ADD COLUMN     "codigoStr" TEXT NOT NULL,
ADD COLUMN     "densidadUnidadMedidaId" INTEGER,
ADD COLUMN     "densidadValor" DOUBLE PRECISION,
ADD COLUMN     "descripcion" TEXT NOT NULL,
ADD COLUMN     "energeticoGrupoId" INTEGER NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "libreDisposicion" BOOLEAN NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "pedirHumedad" BOOLEAN NOT NULL,
ADD COLUMN     "pedirPoderCalorifico" BOOLEAN NOT NULL,
ADD COLUMN     "poderCalorificoUMedidaId" INTEGER,
ADD COLUMN     "poderCalorificoValor" DOUBLE PRECISION,
ADD CONSTRAINT "Energetico_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."EnergeticoGrupos" DROP CONSTRAINT "EnergeticoGrupos_pkey",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "EnergeticoGrupos_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."EnergeticoUnidadMedida" DROP CONSTRAINT "EnergeticoUnidadMedida_pkey",
DROP COLUMN "EnergeticoId",
DROP COLUMN "UnidadMedidaId",
ADD COLUMN     "energeticoId" INTEGER NOT NULL,
ADD COLUMN     "unidadMedidaId" INTEGER NOT NULL,
ADD CONSTRAINT "EnergeticoUnidadMedida_pkey" PRIMARY KEY ("energeticoId", "unidadMedidaId");

-- AlterTable
ALTER TABLE "public"."EstadoEmail" DROP CONSTRAINT "EstadoEmail_pkey",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "EstadoEmail_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."EstadoEmpresa" DROP CONSTRAINT "EstadoEmpresa_pkey",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "EstadoEmpresa_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."EstadoProceso" DROP CONSTRAINT "EstadoProceso_pkey",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "EstadoProceso_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."FactorConversion" DROP CONSTRAINT "FactorConversion_pkey",
DROP COLUMN "Factor",
DROP COLUMN "Id",
DROP COLUMN "UDestinoId",
DROP COLUMN "UOrigenId",
ADD COLUMN     "factor" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "uDestinoId" INTEGER NOT NULL,
ADD COLUMN     "uOrigenId" INTEGER NOT NULL,
ADD CONSTRAINT "FactorConversion_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Formulario" DROP CONSTRAINT "Formulario_pkey",
DROP COLUMN "CodigoNav",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "Orden",
ADD COLUMN     "codigoNav" TEXT NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "orden" INTEGER NOT NULL,
ADD CONSTRAINT "Formulario_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Planta" DROP CONSTRAINT "Planta_pkey",
DROP COLUMN "Activo",
DROP COLUMN "Codigo",
DROP COLUMN "ComunaId",
DROP COLUMN "EmpresaId",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "activo" BOOLEAN NOT NULL,
ADD COLUMN     "codigo" INTEGER NOT NULL,
ADD COLUMN     "comunaId" INTEGER NOT NULL,
ADD COLUMN     "empresaId" TEXT NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "Planta_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Provincia" DROP CONSTRAINT "Provincia_pkey",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "RegionId",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "regionId" INTEGER NOT NULL,
ADD CONSTRAINT "Provincia_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Region" DROP CONSTRAINT "Region_pkey",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "Numero",
DROP COLUMN "Posicion",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "numero" INTEGER NOT NULL,
ADD COLUMN     "posicion" INTEGER NOT NULL,
ADD CONSTRAINT "Region_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."SectorEconomico" DROP CONSTRAINT "SectorEconomico_pkey",
DROP COLUMN "Activo",
DROP COLUMN "CodigoStr",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "activo" BOOLEAN NOT NULL,
ADD COLUMN     "codigoStr" TEXT NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "SectorEconomico_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."SectorEnergetico" DROP CONSTRAINT "SectorEnergetico_pkey",
DROP COLUMN "CodigoStr",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "codigoStr" TEXT NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "SectorEnergetico_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."SubSectorEconomico" DROP CONSTRAINT "SubSectorEconomico_pkey",
DROP COLUMN "Activo",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "SectorEconomicoId",
ADD COLUMN     "activo" BOOLEAN NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "sectorEconomicoId" INTEGER NOT NULL,
ADD CONSTRAINT "SubSectorEconomico_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."TipoContacto" DROP CONSTRAINT "TipoContacto_pkey",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD CONSTRAINT "TipoContacto_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."TipoTransporte" DROP CONSTRAINT "TipoTransporte_pkey",
DROP COLUMN "CodigoStr",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "Orden",
ADD COLUMN     "codigoStr" TEXT NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "orden" INTEGER NOT NULL,
ADD CONSTRAINT "TipoTransporte_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."TipoUsoProceso" DROP CONSTRAINT "TipoUsoProceso_pkey",
DROP COLUMN "CodigoStr",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "Orden",
ADD COLUMN     "codigoStr" TEXT NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "orden" INTEGER NOT NULL,
ADD CONSTRAINT "TipoUsoProceso_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."Transaccion" DROP CONSTRAINT "Transaccion_pkey",
DROP COLUMN "CantPoderCalorifico",
DROP COLUMN "CantidadCapInstalada",
DROP COLUMN "CantidadIn",
DROP COLUMN "CantidadNoAprovechada",
DROP COLUMN "CantidadOut",
DROP COLUMN "CantidadTCalIn",
DROP COLUMN "CantidadTCalOut",
DROP COLUMN "CategoriaTransaccionId",
DROP COLUMN "DatosStr",
DROP COLUMN "Detalle",
DROP COLUMN "EncuestaId",
DROP COLUMN "EnergeticoInId",
DROP COLUMN "EnergeticoOutId",
DROP COLUMN "FechaIngreso",
DROP COLUMN "FormularioId",
DROP COLUMN "Id",
DROP COLUMN "Localidad",
DROP COLUMN "MercadoSpot",
DROP COLUMN "NombreEmpresaDestino",
DROP COLUMN "NombreEmpresaOrigen",
DROP COLUMN "Observacion",
DROP COLUMN "PaisId",
DROP COLUMN "PlantaId",
DROP COLUMN "PorcentajeHumedad",
DROP COLUMN "RegionDestId",
DROP COLUMN "SectorEconomicoDestId",
DROP COLUMN "StockFinal",
DROP COLUMN "StockInicial",
DROP COLUMN "SubCategoria",
DROP COLUMN "SubSectorEconomicoDestId",
DROP COLUMN "SubTecnologia",
DROP COLUMN "TecnologiaId",
DROP COLUMN "UnidadMedidaCapInstaladaId",
DROP COLUMN "UnidadMedidaInId",
DROP COLUMN "UnidadMedidaNoAprovechadaId",
DROP COLUMN "UnidadMedidaOutId",
ADD COLUMN     "cantidadTCalOut" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "encuestaId" INTEGER NOT NULL,
ADD COLUMN     "formularioId" INTEGER NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "plantaId" INTEGER NOT NULL,
ADD CONSTRAINT "Transaccion_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "public"."UnidadMedida" DROP CONSTRAINT "UnidadMedida_pkey",
DROP COLUMN "CodigoStr",
DROP COLUMN "DestinoId",
DROP COLUMN "Id",
DROP COLUMN "Nombre",
DROP COLUMN "OrigenId",
DROP COLUMN "TipoUnidad",
DROP COLUMN "VisibleSelect",
ADD COLUMN     "codigoStr" TEXT NOT NULL,
ADD COLUMN     "destinoId" INTEGER,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "origenId" INTEGER,
ADD COLUMN     "tipoUnidad" TEXT NOT NULL,
ADD COLUMN     "visibleSelect" BOOLEAN NOT NULL,
ADD CONSTRAINT "UnidadMedida_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "public"."AspNetUserTokens";

-- DropTable
DROP TABLE "public"."AspNetUsers";

-- DropTable
DROP TABLE "public"."CargaMasivaArchivo";

-- DropTable
DROP TABLE "public"."CargaMasivaDetalle";

-- DropTable
DROP TABLE "public"."CargaMasivaError";

-- DropTable
DROP TABLE "public"."EstadoReporte";

-- DropTable
DROP TABLE "public"."IntensidadEnergEncuestaEmpresa";

-- DropTable
DROP TABLE "public"."Pais";

-- DropTable
DROP TABLE "public"."Reporte";

-- DropTable
DROP TABLE "public"."SectorEconomicoSii";

-- DropTable
DROP TABLE "public"."Tecnologia";

-- DropTable
DROP TABLE "public"."TipoOtroUso";

-- DropTable
DROP TABLE "public"."TipoPerdida";

-- DropTable
DROP TABLE "public"."TransaccionIntensidadEnergia";

-- CreateTable
CREATE TABLE "public"."Role" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Usuario" (
    "id" TEXT NOT NULL,
    "habilitado" BOOLEAN NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "eliminado" BOOLEAN NOT NULL,
    "primerIngreso" BOOLEAN NOT NULL,
    "empresaId" TEXT,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UsuarioRole" (
    "userId" TEXT NOT NULL,
    "roleId" TEXT NOT NULL,

    CONSTRAINT "UsuarioRole_pkey" PRIMARY KEY ("userId","roleId")
);

-- AddForeignKey
ALTER TABLE "public"."CategoriaTransaccion" ADD CONSTRAINT "CategoriaTransaccion_formularioId_fkey" FOREIGN KEY ("formularioId") REFERENCES "public"."Formulario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Comuna" ADD CONSTRAINT "Comuna_provinciaId_fkey" FOREIGN KEY ("provinciaId") REFERENCES "public"."Provincia"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Comuna" ADD CONSTRAINT "Comuna_regionId_fkey" FOREIGN KEY ("regionId") REFERENCES "public"."Region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Contacto" ADD CONSTRAINT "Contacto_tipoContactoId_fkey" FOREIGN KEY ("tipoContactoId") REFERENCES "public"."TipoContacto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Contacto" ADD CONSTRAINT "Contacto_empresaId_fkey" FOREIGN KEY ("empresaId") REFERENCES "public"."Empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EmailConfig" ADD CONSTRAINT "EmailConfig_estadoEmailId_fkey" FOREIGN KEY ("estadoEmailId") REFERENCES "public"."EstadoEmail"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EmailLogs" ADD CONSTRAINT "EmailLogs_emailConfigId_fkey" FOREIGN KEY ("emailConfigId") REFERENCES "public"."EmailConfig"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EmailLogs" ADD CONSTRAINT "EmailLogs_empresaId_fkey" FOREIGN KEY ("empresaId") REFERENCES "public"."Empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Empresa" ADD CONSTRAINT "Empresa_sectorEconomicoId_fkey" FOREIGN KEY ("sectorEconomicoId") REFERENCES "public"."SectorEconomico"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Empresa" ADD CONSTRAINT "Empresa_sectorEnergeticoId_fkey" FOREIGN KEY ("sectorEnergeticoId") REFERENCES "public"."SectorEnergetico"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Empresa" ADD CONSTRAINT "Empresa_subSectorEconomicoId_fkey" FOREIGN KEY ("subSectorEconomicoId") REFERENCES "public"."SubSectorEconomico"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EncuestaEmpresa" ADD CONSTRAINT "EncuestaEmpresa_empresaId_fkey" FOREIGN KEY ("empresaId") REFERENCES "public"."Empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EncuestaEmpresa" ADD CONSTRAINT "EncuestaEmpresa_encuestaId_fkey" FOREIGN KEY ("encuestaId") REFERENCES "public"."Encuesta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EncuestaEmpresa" ADD CONSTRAINT "EncuestaEmpresa_estadoEmpresaId_fkey" FOREIGN KEY ("estadoEmpresaId") REFERENCES "public"."EstadoEmpresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EncuestaPlanta" ADD CONSTRAINT "EncuestaPlanta_encuestaId_fkey" FOREIGN KEY ("encuestaId") REFERENCES "public"."Encuesta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EncuestaPlanta" ADD CONSTRAINT "EncuestaPlanta_plantaId_fkey" FOREIGN KEY ("plantaId") REFERENCES "public"."Planta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EncuestaPlanta" ADD CONSTRAINT "EncuestaPlanta_estadoProcesoId_fkey" FOREIGN KEY ("estadoProcesoId") REFERENCES "public"."EstadoProceso"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Energetico" ADD CONSTRAINT "Energetico_poderCalorificoUMedidaId_fkey" FOREIGN KEY ("poderCalorificoUMedidaId") REFERENCES "public"."UnidadMedida"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Energetico" ADD CONSTRAINT "Energetico_densidadUnidadMedidaId_fkey" FOREIGN KEY ("densidadUnidadMedidaId") REFERENCES "public"."UnidadMedida"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Energetico" ADD CONSTRAINT "Energetico_energeticoGrupoId_fkey" FOREIGN KEY ("energeticoGrupoId") REFERENCES "public"."EnergeticoGrupos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EnergeticoUnidadMedida" ADD CONSTRAINT "EnergeticoUnidadMedida_energeticoId_fkey" FOREIGN KEY ("energeticoId") REFERENCES "public"."Energetico"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EnergeticoUnidadMedida" ADD CONSTRAINT "EnergeticoUnidadMedida_unidadMedidaId_fkey" FOREIGN KEY ("unidadMedidaId") REFERENCES "public"."UnidadMedida"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."FactorConversion" ADD CONSTRAINT "FactorConversion_uOrigenId_fkey" FOREIGN KEY ("uOrigenId") REFERENCES "public"."UnidadMedida"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."FactorConversion" ADD CONSTRAINT "FactorConversion_uDestinoId_fkey" FOREIGN KEY ("uDestinoId") REFERENCES "public"."UnidadMedida"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Planta" ADD CONSTRAINT "Planta_empresaId_fkey" FOREIGN KEY ("empresaId") REFERENCES "public"."Empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Planta" ADD CONSTRAINT "Planta_comunaId_fkey" FOREIGN KEY ("comunaId") REFERENCES "public"."Comuna"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SubSectorEconomico" ADD CONSTRAINT "SubSectorEconomico_sectorEconomicoId_fkey" FOREIGN KEY ("sectorEconomicoId") REFERENCES "public"."SectorEconomico"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_plantaId_fkey" FOREIGN KEY ("plantaId") REFERENCES "public"."Planta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Transaccion" ADD CONSTRAINT "Transaccion_encuestaId_fkey" FOREIGN KEY ("encuestaId") REFERENCES "public"."Encuesta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UnidadMedida" ADD CONSTRAINT "UnidadMedida_origenId_fkey" FOREIGN KEY ("origenId") REFERENCES "public"."UnidadMedida"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UnidadMedida" ADD CONSTRAINT "UnidadMedida_destinoId_fkey" FOREIGN KEY ("destinoId") REFERENCES "public"."UnidadMedida"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Usuario" ADD CONSTRAINT "Usuario_empresaId_fkey" FOREIGN KEY ("empresaId") REFERENCES "public"."Empresa"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UsuarioRole" ADD CONSTRAINT "UsuarioRole_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UsuarioRole" ADD CONSTRAINT "UsuarioRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "public"."Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
