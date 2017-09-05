USE Master
GO
CREATE DATABASE [EnterpriseSolutionBD]
GO
USE [EnterpriseSolutionBD]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categoria1]') AND type in (N'U'))
    DROP TABLE [dbo].[Categoria1]
GO
CREATE TABLE [dbo].[Categoria1] (
[ID_categoria_Int] LONG  NOT NULL  
, [ID_Categoria] TEXT(32000)  NOT NULL  
, [ID_Cliente] LONG  NOT NULL  
, [Nombre] TEXT(32000)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[Categoria1] ADD CONSTRAINT [Categoria1_PK] PRIMARY KEY CLUSTERED (
[ID_categoria_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pantalla1]') AND type in (N'U'))
    DROP TABLE [dbo].[Pantalla1]
GO
CREATE TABLE [dbo].[Pantalla1] (
[id_pantalla] TEXT(30)  NOT NULL  
, [Descripcion] TEXT(100)  NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Pantalla1] ADD CONSTRAINT [Pantalla1_PK] PRIMARY KEY CLUSTERED (
[id_pantalla]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Leyenda1]') AND type in (N'U'))
    DROP TABLE [dbo].[Leyenda1]
GO
CREATE TABLE [dbo].[Leyenda1] (
[id_leyenda] TEXT(30)  NOT NULL  
, [texto_leyenda] TEXT(100)  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Leyenda1] ADD CONSTRAINT [Leyenda1_PK] PRIMARY KEY CLUSTERED (
[id_leyenda]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Stock1]') AND type in (N'U'))
    DROP TABLE [dbo].[Stock1]
GO
CREATE TABLE [dbo].[Stock1] (
[Nro_Movimiento_Int] COUNTER  NOT NULL  
, [Fecha] DATETIME  NOT NULL  
, [Tipo] TEXT(10)  NOT NULL  
, [Cantidad] LONG  NOT NULL  
, [Precio] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Distribuidor_Int] LONG  NOT NULL  
, [Nro_Secuencia_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Stock1] ADD CONSTRAINT [Stock1_PK] PRIMARY KEY CLUSTERED (
[Nro_Movimiento_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Control1]') AND type in (N'U'))
    DROP TABLE [dbo].[Control1]
GO
CREATE TABLE [dbo].[Control1] (
[id_pantalla] TEXT(30)  NOT NULL  
, [id_control] TEXT(30)  NOT NULL  
, [id_leyenda] CHAR(10)  NOT NULL  
, [id_elemento] LONG  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Control1] ADD CONSTRAINT [Control1_PK] PRIMARY KEY CLUSTERED (
[id_pantalla]
, [id_control]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Elemento_Usuario]') AND type in (N'U'))
    DROP TABLE [dbo].[Elemento_Usuario]
GO
CREATE TABLE [dbo].[Elemento_Usuario] (
[ID_Elemento] LONG  NOT NULL  
, [ID_Usuario] LONG  NOT NULL  
, [substrae] BIT  NULL  
, [Borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Elemento_Usuario] ADD CONSTRAINT [Elemento_Usuario_PK] PRIMARY KEY CLUSTERED (
[ID_Elemento]
, [ID_Usuario]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Elemento]') AND type in (N'U'))
    DROP TABLE [dbo].[Elemento]
GO
CREATE TABLE [dbo].[Elemento] (
[ID_Elemento] LONG  NOT NULL  
, [descripcion] TEXT(100)  NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Elemento] ADD CONSTRAINT [Elemento_PK] PRIMARY KEY CLUSTERED (
[ID_Elemento]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Elemento_Elemento]') AND type in (N'U'))
    DROP TABLE [dbo].[Elemento_Elemento]
GO
CREATE TABLE [dbo].[Elemento_Elemento] (
[id_elemento_padre] LONG  NOT NULL  
, [id_elemento_hijo] LONG  NOT NULL  
, [substrae] BIT  NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Elemento_Elemento] ADD CONSTRAINT [Elemento_Elemento_PK] PRIMARY KEY CLUSTERED (
[id_elemento_padre]
, [id_elemento_hijo]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DVV1]') AND type in (N'U'))
    DROP TABLE [dbo].[DVV1]
GO
CREATE TABLE [dbo].[DVV1] (
[nombre_tabla] TEXT(100)  NOT NULL  
, [Valor] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[DVV1] ADD CONSTRAINT [DVV1_PK] PRIMARY KEY CLUSTERED (
[nombre_tabla]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Leyenda]') AND type in (N'U'))
    DROP TABLE [dbo].[Leyenda]
GO
CREATE TABLE [dbo].[Leyenda] (
[id_leyenda] TEXT(30)  NOT NULL  
, [texto_leyenda] TEXT(100)  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Leyenda] ADD CONSTRAINT [Leyenda_PK] PRIMARY KEY CLUSTERED (
[id_leyenda]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pantalla]') AND type in (N'U'))
    DROP TABLE [dbo].[Pantalla]
GO
CREATE TABLE [dbo].[Pantalla] (
[id_pantalla] TEXT(30)  NOT NULL  
, [Descripcion] TEXT(100)  NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Pantalla] ADD CONSTRAINT [Pantalla_PK] PRIMARY KEY CLUSTERED (
[id_pantalla]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Concurso1]') AND type in (N'U'))
    DROP TABLE [dbo].[Concurso1]
GO
CREATE TABLE [dbo].[Concurso1] (
[Id_Concurso] COUNTER  NOT NULL  
, [Nombre_concurso] TEXT(32000)  NOT NULL  
, [Puntos_cobertura] LONG  NOT NULL  
, [Puntos_Ventas] LONG  NOT NULL  
, [Puntos_Transmisiones] LONG  NOT NULL  
, [Usar_cobertura] SHORT  NOT NULL  
, [Usar_Transmisiones] SHORT  NOT NULL  
, [Usar_Ventas] SHORT  NOT NULL  
, [DVH] SHORT  NULL  
, [Borrado] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[Concurso1] ADD CONSTRAINT [Concurso1_PK] PRIMARY KEY CLUSTERED (
[Id_Concurso]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BROperation1]') AND type in (N'U'))
    DROP TABLE [dbo].[BROperation1]
GO
CREATE TABLE [dbo].[BROperation1] (
[id] LONGBINARY  NOT NULL  
, [fecha] DATETIME  NOT NULL  
, [tipo] BIT  NOT NULL  
, [path] TEXT(32000)  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[BROperation1] ADD CONSTRAINT [BROperation1_PK] PRIMARY KEY CLUSTERED (
[id]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConcursoDistribuidor]') AND type in (N'U'))
    DROP TABLE [dbo].[ConcursoDistribuidor]
GO
CREATE TABLE [dbo].[ConcursoDistribuidor] (
[ID_Distribuidor_Int] LONG  NOT NULL  
, [id_Concurso] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [Cuota] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[ConcursoDistribuidor] ADD CONSTRAINT [ConcursoDistribuidor_PK] PRIMARY KEY CLUSTERED (
[ID_Distribuidor_Int]
, [id_Concurso]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Error]') AND type in (N'U'))
    DROP TABLE [dbo].[Error]
GO
CREATE TABLE [dbo].[Error] (
[Numerador] LONG  NOT NULL  
, [ID_Error] TEXT(32000)  NOT NULL  
, [Mensaje] TEXT(32000)  NOT NULL  
, [Linea] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [Nro_Secuencia_Int] LONG  NULL  
)
GO

ALTER TABLE [dbo].[Error] ADD CONSTRAINT [Error_PK] PRIMARY KEY CLUSTERED (
[Numerador]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Licencia]') AND type in (N'U'))
    DROP TABLE [dbo].[Licencia]
GO
CREATE TABLE [dbo].[Licencia] (
[ID_Licencia] LONG  NOT NULL  
, [Fecha_Compra] DATETIME  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NULL  
, [ID_Cliente] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Licencia] ADD CONSTRAINT [Licencia_PK] PRIMARY KEY CLUSTERED (
[ID_Licencia]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConcursoDistribuidor1]') AND type in (N'U'))
    DROP TABLE [dbo].[ConcursoDistribuidor1]
GO
CREATE TABLE [dbo].[ConcursoDistribuidor1] (
[ID_Distribuidor_Int] LONG  NOT NULL  
, [id_Concurso] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [Cuota] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[ConcursoDistribuidor1] ADD CONSTRAINT [ConcursoDistribuidor1_PK] PRIMARY KEY CLUSTERED (
[ID_Distribuidor_Int]
, [id_Concurso]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntradasBitacora1]') AND type in (N'U'))
    DROP TABLE [dbo].[EntradasBitacora1]
GO
CREATE TABLE [dbo].[EntradasBitacora1] (
[id] LONGBINARY  NOT NULL  
, [FechaHora] DATETIME  NOT NULL  
, [Modulo] TEXT(32000)  NOT NULL  
, [Mensaje] TEXT(32000)  NOT NULL  
, [DatosAnteriores] TEXT(32000)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [borrado] BIT  NOT NULL  
)
GO

ALTER TABLE [dbo].[EntradasBitacora1] ADD CONSTRAINT [EntradasBitacora1_PK] PRIMARY KEY CLUSTERED (
[id]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provincia]') AND type in (N'U'))
    DROP TABLE [dbo].[Provincia]
GO
CREATE TABLE [dbo].[Provincia] (
[ID_Provincia] LONG  NOT NULL  
, [Nombre] TEXT(100)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[Provincia] ADD CONSTRAINT [Provincia_PK] PRIMARY KEY CLUSTERED (
[ID_Provincia]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Control]') AND type in (N'U'))
    DROP TABLE [dbo].[Control]
GO
CREATE TABLE [dbo].[Control] (
[id_pantalla] TEXT(30)  NOT NULL  
, [id_control] TEXT(30)  NOT NULL  
, [id_leyenda] CHAR(10)  NOT NULL  
, [id_elemento] LONG  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Control] ADD CONSTRAINT [Control_PK] PRIMARY KEY CLUSTERED (
[id_pantalla]
, [id_control]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConcursoProducto1]') AND type in (N'U'))
    DROP TABLE [dbo].[ConcursoProducto1]
GO
CREATE TABLE [dbo].[ConcursoProducto1] (
[ID_Producto_Int] LONG  NOT NULL  
, [ID_Concurso] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
)
GO

ALTER TABLE [dbo].[ConcursoProducto1] ADD CONSTRAINT [ConcursoProducto1_PK] PRIMARY KEY CLUSTERED (
[ID_Producto_Int]
, [ID_Concurso]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Distribuidor1]') AND type in (N'U'))
    DROP TABLE [dbo].[Distribuidor1]
GO
CREATE TABLE [dbo].[Distribuidor1] (
[ID_Distribuidor_Int] COUNTER  NOT NULL  
, [ID_Distribuidor_Real] TEXT(32000)  NOT NULL  
, [Nombre] TEXT(32000)  NOT NULL  
, [ID_Provincia] LONG  NOT NULL  
, [ID_Usuario] LONG  NOT NULL  
, [ID_Cliente] LONG  NOT NULL  
, [Mail] TEXT(32000)  NULL  
)
GO

ALTER TABLE [dbo].[Distribuidor1] ADD CONSTRAINT [Distribuidor1_PK] PRIMARY KEY CLUSTERED (
[ID_Distribuidor_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntradasBitacora]') AND type in (N'U'))
    DROP TABLE [dbo].[EntradasBitacora]
GO
CREATE TABLE [dbo].[EntradasBitacora] (
[id] LONGBINARY  NOT NULL  
, [FechaHora] DATETIME  NOT NULL  
, [Modulo] TEXT(32000)  NOT NULL  
, [Mensaje] TEXT(32000)  NOT NULL  
, [DatosAnteriores] TEXT(32000)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [borrado] BIT  NOT NULL  
)
GO

ALTER TABLE [dbo].[EntradasBitacora] ADD CONSTRAINT [EntradasBitacora_PK] PRIMARY KEY CLUSTERED (
[id]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Config1]') AND type in (N'U'))
    DROP TABLE [dbo].[Config1]
GO
CREATE TABLE [dbo].[Config1] (
[TiempoEsperaServicio] LONG  NOT NULL  
, [Path_FTP] TEXT(32000)  NOT NULL  
, [sistema_bloqueado] SHORT  NOT NULL  
, [DVH] LONG  NOT NULL  
, [borrado] BIT  NOT NULL  
)
GO

ALTER TABLE [dbo].[Config1] ADD CONSTRAINT [Config1_PK] PRIMARY KEY CLUSTERED (
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cliente1]') AND type in (N'U'))
    DROP TABLE [dbo].[Cliente1]
GO
CREATE TABLE [dbo].[Cliente1] (
[ID_Cliente] COUNTER  NOT NULL  
, [Nombre] CHAR(10)  NOT NULL  
, [Mail] TEXT(32000)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NULL  
, [ID_Provincia] LONG  NOT NULL  
, [ID_Usuario] LONG  NULL  
)
GO

ALTER TABLE [dbo].[Cliente1] ADD CONSTRAINT [Cliente1_PK] PRIMARY KEY CLUSTERED (
[ID_Cliente]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Config]') AND type in (N'U'))
    DROP TABLE [dbo].[Config]
GO
CREATE TABLE [dbo].[Config] (
[TiempoEsperaServicio] LONG  NOT NULL  
, [Path_FTP] TEXT(32000)  NOT NULL  
, [sistema_bloqueado] SHORT  NOT NULL  
, [DVH] LONG  NOT NULL  
, [borrado] BIT  NOT NULL  
)
GO

ALTER TABLE [dbo].[Config] ADD CONSTRAINT [Config_PK] PRIMARY KEY CLUSTERED (
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FacturaDetalle]') AND type in (N'U'))
    DROP TABLE [dbo].[FacturaDetalle]
GO
CREATE TABLE [dbo].[FacturaDetalle] (
[Nro_Factura_Int] LONG  NOT NULL  
, [Linea] LONG  NOT NULL  
, [ID_Producto_Int] LONG  NOT NULL  
, [Cantidad] LONG  NOT NULL  
, [Precio] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
)
GO

ALTER TABLE [dbo].[FacturaDetalle] ADD CONSTRAINT [FacturaDetalle_PK] PRIMARY KEY CLUSTERED (
[Nro_Factura_Int]
, [Linea]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Distribuidor]') AND type in (N'U'))
    DROP TABLE [dbo].[Distribuidor]
GO
CREATE TABLE [dbo].[Distribuidor] (
[ID_Distribuidor_Int] COUNTER  NOT NULL  
, [ID_Distribuidor_Real] TEXT(32000)  NOT NULL  
, [Nombre] TEXT(32000)  NOT NULL  
, [ID_Provincia] LONG  NOT NULL  
, [ID_Usuario] LONG  NOT NULL  
, [ID_Cliente] LONG  NOT NULL  
, [Mail] TEXT(32000)  NULL  
)
GO

ALTER TABLE [dbo].[Distribuidor] ADD CONSTRAINT [Distribuidor_PK] PRIMARY KEY CLUSTERED (
[ID_Distribuidor_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tabla1]') AND type in (N'U'))
    DROP TABLE [dbo].[Tabla1]
GO
CREATE TABLE [dbo].[Tabla1] (
)
GO

GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Licencia1]') AND type in (N'U'))
    DROP TABLE [dbo].[Licencia1]
GO
CREATE TABLE [dbo].[Licencia1] (
[ID_Licencia] LONG  NOT NULL  
, [Fecha_Compra] DATETIME  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NULL  
, [ID_Cliente] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Licencia1] ADD CONSTRAINT [Licencia1_PK] PRIMARY KEY CLUSTERED (
[ID_Licencia]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Vendedor1]') AND type in (N'U'))
    DROP TABLE [dbo].[Vendedor1]
GO
CREATE TABLE [dbo].[Vendedor1] (
[ID_Vendedor_Int] COUNTER  NOT NULL  
, [Id_Vendedor_Real] CHAR(10)  NOT NULL  
, [Nombre] TEXT(100)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Distribuidor] LONG  NOT NULL  
, [Nro_Secuencia_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Vendedor1] ADD CONSTRAINT [Vendedor1_PK] PRIMARY KEY CLUSTERED (
[ID_Vendedor_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provincia1]') AND type in (N'U'))
    DROP TABLE [dbo].[Provincia1]
GO
CREATE TABLE [dbo].[Provincia1] (
[ID_Provincia] LONG  NOT NULL  
, [Nombre] TEXT(100)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[Provincia1] ADD CONSTRAINT [Provincia1_PK] PRIMARY KEY CLUSTERED (
[ID_Provincia]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConcursoProducto]') AND type in (N'U'))
    DROP TABLE [dbo].[ConcursoProducto]
GO
CREATE TABLE [dbo].[ConcursoProducto] (
[ID_Producto_Int] LONG  NOT NULL  
, [ID_Concurso] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
)
GO

ALTER TABLE [dbo].[ConcursoProducto] ADD CONSTRAINT [ConcursoProducto_PK] PRIMARY KEY CLUSTERED (
[ID_Producto_Int]
, [ID_Concurso]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Secuencia1]') AND type in (N'U'))
    DROP TABLE [dbo].[Secuencia1]
GO
CREATE TABLE [dbo].[Secuencia1] (
[Nro_Secuencia_Int] COUNTER  NOT NULL  
, [Nro_Secuencia_Real] LONG  NOT NULL  
, [Fecha] DATETIME  NOT NULL  
, [Estado] TEXT(10)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Distribuidor_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Secuencia1] ADD CONSTRAINT [Secuencia1_PK] PRIMARY KEY CLUSTERED (
[Nro_Secuencia_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Secuencia]') AND type in (N'U'))
    DROP TABLE [dbo].[Secuencia]
GO
CREATE TABLE [dbo].[Secuencia] (
[Nro_Secuencia_Int] COUNTER  NOT NULL  
, [Nro_Secuencia_Real] LONG  NOT NULL  
, [Fecha] DATETIME  NOT NULL  
, [Estado] TEXT(10)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Distribuidor_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Secuencia] ADD CONSTRAINT [Secuencia_PK] PRIMARY KEY CLUSTERED (
[Nro_Secuencia_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usuario]') AND type in (N'U'))
    DROP TABLE [dbo].[Usuario]
GO
CREATE TABLE [dbo].[Usuario] (
[id_usuario] LONG  NOT NULL  
, [nombre] TEXT(100)  NOT NULL  
, [id_idioma] LONG  NOT NULL  
, [password] TEXT(32000)  NULL  
, [IntentosFallidos] SHORT  NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
, [ID_Licencia] LONG  NULL  
)
GO

ALTER TABLE [dbo].[Usuario] ADD CONSTRAINT [Usuario_PK] PRIMARY KEY CLUSTERED (
[id_usuario]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Producto]') AND type in (N'U'))
    DROP TABLE [dbo].[Producto]
GO
CREATE TABLE [dbo].[Producto] (
[ID_Producto_Int] LONG  NOT NULL  
, [ID_Producto_Real] TEXT(32000)  NOT NULL  
, [Nombre] TEXT(32000)  NOT NULL  
, [Precio] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Cliente] LONG  NOT NULL  
, [ID_Categoria_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Producto] ADD CONSTRAINT [Producto_PK] PRIMARY KEY CLUSTERED (
[ID_Producto_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Factura1]') AND type in (N'U'))
    DROP TABLE [dbo].[Factura1]
GO
CREATE TABLE [dbo].[Factura1] (
[Nro_Factura_Int] LONG  NOT NULL  
, [Nro_Factura_Real] TEXT(32000)  NOT NULL  
, [Fecha] DATETIME  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_PDV_Int] LONG  NOT NULL  
, [Nro_Secuencia_Int] LONG  NOT NULL  
, [ID_Distribuidor_Int] LONG  NOT NULL  
, [ID_Vendedor_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Factura1] ADD CONSTRAINT [Factura1_PK] PRIMARY KEY CLUSTERED (
[Nro_Factura_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Elemento_Usuario1]') AND type in (N'U'))
    DROP TABLE [dbo].[Elemento_Usuario1]
GO
CREATE TABLE [dbo].[Elemento_Usuario1] (
[ID_Elemento] LONG  NOT NULL  
, [ID_Usuario] LONG  NOT NULL  
, [substrae] BIT  NULL  
, [Borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Elemento_Usuario1] ADD CONSTRAINT [Elemento_Usuario1_PK] PRIMARY KEY CLUSTERED (
[ID_Elemento]
, [ID_Usuario]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Idioma]') AND type in (N'U'))
    DROP TABLE [dbo].[Idioma]
GO
CREATE TABLE [dbo].[Idioma] (
[id_idioma] LONG  NOT NULL  
, [nombre] TEXT(100)  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NULL  
)
GO

ALTER TABLE [dbo].[Idioma] ADD CONSTRAINT [Idioma_PK] PRIMARY KEY CLUSTERED (
[id_idioma]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FacturaDetalle1]') AND type in (N'U'))
    DROP TABLE [dbo].[FacturaDetalle1]
GO
CREATE TABLE [dbo].[FacturaDetalle1] (
[Nro_Factura_Int] LONG  NOT NULL  
, [Linea] LONG  NOT NULL  
, [ID_Producto_Int] LONG  NOT NULL  
, [Cantidad] LONG  NOT NULL  
, [Precio] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
)
GO

ALTER TABLE [dbo].[FacturaDetalle1] ADD CONSTRAINT [FacturaDetalle1_PK] PRIMARY KEY CLUSTERED (
[Nro_Factura_Int]
, [Linea]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Elemento1]') AND type in (N'U'))
    DROP TABLE [dbo].[Elemento1]
GO
CREATE TABLE [dbo].[Elemento1] (
[ID_Elemento] LONG  NOT NULL  
, [descripcion] TEXT(100)  NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Elemento1] ADD CONSTRAINT [Elemento1_PK] PRIMARY KEY CLUSTERED (
[ID_Elemento]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Concurso]') AND type in (N'U'))
    DROP TABLE [dbo].[Concurso]
GO
CREATE TABLE [dbo].[Concurso] (
[Id_Concurso] COUNTER  NOT NULL  
, [Nombre_concurso] TEXT(32000)  NOT NULL  
, [Puntos_cobertura] LONG  NOT NULL  
, [Puntos_Ventas] LONG  NOT NULL  
, [Puntos_Transmisiones] LONG  NOT NULL  
, [Usar_cobertura] SHORT  NOT NULL  
, [Usar_Transmisiones] SHORT  NOT NULL  
, [Usar_Ventas] SHORT  NOT NULL  
, [DVH] SHORT  NULL  
, [Borrado] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[Concurso] ADD CONSTRAINT [Concurso_PK] PRIMARY KEY CLUSTERED (
[Id_Concurso]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Elemento_Elemento1]') AND type in (N'U'))
    DROP TABLE [dbo].[Elemento_Elemento1]
GO
CREATE TABLE [dbo].[Elemento_Elemento1] (
[id_elemento_padre] LONG  NOT NULL  
, [id_elemento_hijo] LONG  NOT NULL  
, [substrae] BIT  NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Elemento_Elemento1] ADD CONSTRAINT [Elemento_Elemento1_PK] PRIMARY KEY CLUSTERED (
[id_elemento_padre]
, [id_elemento_hijo]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Stock]') AND type in (N'U'))
    DROP TABLE [dbo].[Stock]
GO
CREATE TABLE [dbo].[Stock] (
[Nro_Movimiento_Int] COUNTER  NOT NULL  
, [Fecha] DATETIME  NOT NULL  
, [Tipo] TEXT(10)  NOT NULL  
, [Cantidad] LONG  NOT NULL  
, [Precio] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Distribuidor_Int] LONG  NOT NULL  
, [Nro_Secuencia_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Stock] ADD CONSTRAINT [Stock_PK] PRIMARY KEY CLUSTERED (
[Nro_Movimiento_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PuntoDeVenta]') AND type in (N'U'))
    DROP TABLE [dbo].[PuntoDeVenta]
GO
CREATE TABLE [dbo].[PuntoDeVenta] (
[ID_PDV_Int] COUNTER  NOT NULL  
, [ID_PDV_Real] LONG  NOT NULL  
, [Nombre] TEXT(100)  NOT NULL  
, [CUIT] TEXT(13)  NOT NULL  
, [Calle] TEXT(32000)  NOT NULL  
, [Depto] TEXT(32000)  NULL  
, [CodigoPostal] TEXT(32000)  NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Provincia] SHORT  NOT NULL  
, [ID_Distribuidor_Int] LONG  NOT NULL  
, [Nro_Secuencia_Int] LONG  NOT NULL  
, [ID_Vendedor_int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[PuntoDeVenta] ADD CONSTRAINT [PuntoDeVenta_PK] PRIMARY KEY CLUSTERED (
[ID_PDV_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Factura]') AND type in (N'U'))
    DROP TABLE [dbo].[Factura]
GO
CREATE TABLE [dbo].[Factura] (
[Nro_Factura_Int] LONG  NOT NULL  
, [Nro_Factura_Real] TEXT(32000)  NOT NULL  
, [Fecha] DATETIME  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_PDV_Int] LONG  NOT NULL  
, [Nro_Secuencia_Int] LONG  NOT NULL  
, [ID_Distribuidor_Int] LONG  NOT NULL  
, [ID_Vendedor_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Factura] ADD CONSTRAINT [Factura_PK] PRIMARY KEY CLUSTERED (
[Nro_Factura_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Idioma_Leyenda]') AND type in (N'U'))
    DROP TABLE [dbo].[Idioma_Leyenda]
GO
CREATE TABLE [dbo].[Idioma_Leyenda] (
[id_idioma] LONG  NOT NULL  
, [id_leyenda] TEXT(30)  NOT NULL  
, [texto_leyenda] TEXT(100)  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Idioma_Leyenda] ADD CONSTRAINT [Idioma_Leyenda_PK] PRIMARY KEY CLUSTERED (
[id_leyenda]
, [id_idioma]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DVV]') AND type in (N'U'))
    DROP TABLE [dbo].[DVV]
GO
CREATE TABLE [dbo].[DVV] (
[nombre_tabla] TEXT(100)  NOT NULL  
, [Valor] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[DVV] ADD CONSTRAINT [DVV_PK] PRIMARY KEY CLUSTERED (
[nombre_tabla]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PuntoDeVenta1]') AND type in (N'U'))
    DROP TABLE [dbo].[PuntoDeVenta1]
GO
CREATE TABLE [dbo].[PuntoDeVenta1] (
[ID_PDV_Int] COUNTER  NOT NULL  
, [ID_PDV_Real] LONG  NOT NULL  
, [Nombre] TEXT(100)  NOT NULL  
, [CUIT] TEXT(13)  NOT NULL  
, [Calle] TEXT(32000)  NOT NULL  
, [Depto] TEXT(32000)  NULL  
, [CodigoPostal] TEXT(32000)  NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Provincia] SHORT  NOT NULL  
, [ID_Distribuidor_Int] LONG  NOT NULL  
, [Nro_Secuencia_Int] LONG  NOT NULL  
, [ID_Vendedor_int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[PuntoDeVenta1] ADD CONSTRAINT [PuntoDeVenta1_PK] PRIMARY KEY CLUSTERED (
[ID_PDV_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usuario1]') AND type in (N'U'))
    DROP TABLE [dbo].[Usuario1]
GO
CREATE TABLE [dbo].[Usuario1] (
[id_usuario] LONG  NOT NULL  
, [nombre] TEXT(100)  NOT NULL  
, [id_idioma] LONG  NOT NULL  
, [password] TEXT(32000)  NULL  
, [IntentosFallidos] SHORT  NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
, [ID_Licencia] LONG  NULL  
)
GO

ALTER TABLE [dbo].[Usuario1] ADD CONSTRAINT [Usuario1_PK] PRIMARY KEY CLUSTERED (
[id_usuario]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Error1]') AND type in (N'U'))
    DROP TABLE [dbo].[Error1]
GO
CREATE TABLE [dbo].[Error1] (
[Numerador] LONG  NOT NULL  
, [ID_Error] TEXT(32000)  NOT NULL  
, [Mensaje] TEXT(32000)  NOT NULL  
, [Linea] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [Nro_Secuencia_Int] LONG  NULL  
)
GO

ALTER TABLE [dbo].[Error1] ADD CONSTRAINT [Error1_PK] PRIMARY KEY CLUSTERED (
[Numerador]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Idioma1]') AND type in (N'U'))
    DROP TABLE [dbo].[Idioma1]
GO
CREATE TABLE [dbo].[Idioma1] (
[id_idioma] LONG  NOT NULL  
, [nombre] TEXT(100)  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NULL  
)
GO

ALTER TABLE [dbo].[Idioma1] ADD CONSTRAINT [Idioma1_PK] PRIMARY KEY CLUSTERED (
[id_idioma]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cliente]') AND type in (N'U'))
    DROP TABLE [dbo].[Cliente]
GO
CREATE TABLE [dbo].[Cliente] (
[ID_Cliente] COUNTER  NOT NULL  
, [Nombre] CHAR(10)  NOT NULL  
, [Mail] TEXT(32000)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NULL  
, [ID_Provincia] LONG  NOT NULL  
, [ID_Usuario] LONG  NULL  
)
GO

ALTER TABLE [dbo].[Cliente] ADD CONSTRAINT [Cliente_PK] PRIMARY KEY CLUSTERED (
[ID_Cliente]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Vendedor]') AND type in (N'U'))
    DROP TABLE [dbo].[Vendedor]
GO
CREATE TABLE [dbo].[Vendedor] (
[ID_Vendedor_Int] COUNTER  NOT NULL  
, [Id_Vendedor_Real] CHAR(10)  NOT NULL  
, [Nombre] TEXT(100)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Distribuidor] LONG  NOT NULL  
, [Nro_Secuencia_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Vendedor] ADD CONSTRAINT [Vendedor_PK] PRIMARY KEY CLUSTERED (
[ID_Vendedor_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Producto1]') AND type in (N'U'))
    DROP TABLE [dbo].[Producto1]
GO
CREATE TABLE [dbo].[Producto1] (
[ID_Producto_Int] LONG  NOT NULL  
, [ID_Producto_Real] TEXT(32000)  NOT NULL  
, [Nombre] TEXT(32000)  NOT NULL  
, [Precio] LONG  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NOT NULL  
, [ID_Cliente] LONG  NOT NULL  
, [ID_Categoria_Int] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Producto1] ADD CONSTRAINT [Producto1_PK] PRIMARY KEY CLUSTERED (
[ID_Producto_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Idioma_Leyenda1]') AND type in (N'U'))
    DROP TABLE [dbo].[Idioma_Leyenda1]
GO
CREATE TABLE [dbo].[Idioma_Leyenda1] (
[id_idioma] LONG  NOT NULL  
, [id_leyenda] TEXT(30)  NOT NULL  
, [texto_leyenda] TEXT(100)  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[Idioma_Leyenda1] ADD CONSTRAINT [Idioma_Leyenda1_PK] PRIMARY KEY CLUSTERED (
[id_leyenda]
, [id_idioma]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categoria]') AND type in (N'U'))
    DROP TABLE [dbo].[Categoria]
GO
CREATE TABLE [dbo].[Categoria] (
[ID_categoria_Int] LONG  NOT NULL  
, [ID_Categoria] TEXT(32000)  NOT NULL  
, [ID_Cliente] LONG  NOT NULL  
, [Nombre] TEXT(32000)  NOT NULL  
, [DVH] LONG  NOT NULL  
, [Borrado] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[Categoria] ADD CONSTRAINT [Categoria_PK] PRIMARY KEY CLUSTERED (
[ID_categoria_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BROperation]') AND type in (N'U'))
    DROP TABLE [dbo].[BROperation]
GO
CREATE TABLE [dbo].[BROperation] (
[id] LONGBINARY  NOT NULL  
, [fecha] DATETIME  NOT NULL  
, [tipo] BIT  NOT NULL  
, [path] TEXT(32000)  NOT NULL  
, [borrado] BIT  NULL  
, [DVH] LONG  NOT NULL  
)
GO

ALTER TABLE [dbo].[BROperation] ADD CONSTRAINT [BROperation_PK] PRIMARY KEY CLUSTERED (
[id]
)
GO
GO

ALTER TABLE [dbo].[Categoria1] WITH CHECK ADD CONSTRAINT [Cliente1_Categoria1_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente1] (
[ID_Cliente]
)
GO

GO

GO

ALTER TABLE [dbo].[Stock1] WITH CHECK ADD CONSTRAINT [Secuencia1_Stock1_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia1] (
[Nro_Secuencia_Int]
)
ALTER TABLE [dbo].[Stock1] WITH CHECK ADD CONSTRAINT [Distribuidor1_Stock1_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor1] (
[ID_Distribuidor_Int]
)
GO

ALTER TABLE [dbo].[Control1] WITH CHECK ADD CONSTRAINT [Leyenda1_Control1_FK1] FOREIGN KEY (
[id_leyenda]
)
REFERENCES [dbo].[Leyenda1] (
[id_leyenda]
)
ALTER TABLE [dbo].[Control1] WITH CHECK ADD CONSTRAINT [Pantalla1_Control1_FK1] FOREIGN KEY (
[id_pantalla]
)
REFERENCES [dbo].[Pantalla1] (
[id_pantalla]
)
ALTER TABLE [dbo].[Control1] WITH CHECK ADD CONSTRAINT [Elemento1_Control1_FK1] FOREIGN KEY (
[id_elemento]
)
REFERENCES [dbo].[Elemento1] (
[ID_Elemento]
)
GO

ALTER TABLE [dbo].[Elemento_Usuario] WITH CHECK ADD CONSTRAINT [tiene] FOREIGN KEY (
[ID_Elemento]
)
REFERENCES [dbo].[Elemento] (
[ID_Elemento]
)
ALTER TABLE [dbo].[Elemento_Usuario] WITH CHECK ADD CONSTRAINT [Usuario_Elemento_Usuario_FK1] FOREIGN KEY (
[ID_Usuario]
)
REFERENCES [dbo].[Usuario] (
[id_usuario]
)
GO

GO

ALTER TABLE [dbo].[Elemento_Elemento] WITH CHECK ADD CONSTRAINT [es hijo] FOREIGN KEY (
[id_elemento_hijo]
)
REFERENCES [dbo].[Elemento] (
[ID_Elemento]
)
ALTER TABLE [dbo].[Elemento_Elemento] WITH CHECK ADD CONSTRAINT [es padre] FOREIGN KEY (
[id_elemento_padre]
)
REFERENCES [dbo].[Elemento] (
[ID_Elemento]
)
GO

GO

GO

GO

GO

GO

ALTER TABLE [dbo].[ConcursoDistribuidor] WITH CHECK ADD CONSTRAINT [Concurso_ConcursoDistribuidor_FK1] FOREIGN KEY (
[id_Concurso]
)
REFERENCES [dbo].[Concurso] (
[Id_Concurso]
)
ALTER TABLE [dbo].[ConcursoDistribuidor] WITH CHECK ADD CONSTRAINT [Distribuidor_ConcursoDistribuidor_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor] (
[ID_Distribuidor_Int]
)
GO

ALTER TABLE [dbo].[Error] WITH CHECK ADD CONSTRAINT [Secuencia_Error_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia] (
[Nro_Secuencia_Int]
)
GO

ALTER TABLE [dbo].[Licencia] WITH CHECK ADD CONSTRAINT [Cliente_Licencia_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente] (
[ID_Cliente]
)
GO

ALTER TABLE [dbo].[ConcursoDistribuidor1] WITH CHECK ADD CONSTRAINT [Distribuidor1_ConcursoDistribuidor1_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor1] (
[ID_Distribuidor_Int]
)
ALTER TABLE [dbo].[ConcursoDistribuidor1] WITH CHECK ADD CONSTRAINT [Concurso1_ConcursoDistribuidor1_FK1] FOREIGN KEY (
[id_Concurso]
)
REFERENCES [dbo].[Concurso1] (
[Id_Concurso]
)
GO

GO

GO

ALTER TABLE [dbo].[Control] WITH CHECK ADD CONSTRAINT [Leyenda_Control_FK1] FOREIGN KEY (
[id_leyenda]
)
REFERENCES [dbo].[Leyenda] (
[id_leyenda]
)
ALTER TABLE [dbo].[Control] WITH CHECK ADD CONSTRAINT [Pantalla_Control_FK1] FOREIGN KEY (
[id_pantalla]
)
REFERENCES [dbo].[Pantalla] (
[id_pantalla]
)
ALTER TABLE [dbo].[Control] WITH CHECK ADD CONSTRAINT [Elemento_Control_FK1] FOREIGN KEY (
[id_elemento]
)
REFERENCES [dbo].[Elemento] (
[ID_Elemento]
)
GO

ALTER TABLE [dbo].[ConcursoProducto1] WITH CHECK ADD CONSTRAINT [Producto1_ConcursoProducto1_FK1] FOREIGN KEY (
[ID_Producto_Int]
)
REFERENCES [dbo].[Producto1] (
[ID_Producto_Int]
)
ALTER TABLE [dbo].[ConcursoProducto1] WITH CHECK ADD CONSTRAINT [Concurso1_ConcursoProducto1_FK1] FOREIGN KEY (
[ID_Concurso]
)
REFERENCES [dbo].[Concurso1] (
[Id_Concurso]
)
GO

ALTER TABLE [dbo].[Distribuidor1] WITH CHECK ADD CONSTRAINT [Usuario1_Distribuidor1_FK1] FOREIGN KEY (
[ID_Usuario]
)
REFERENCES [dbo].[Usuario1] (
[id_usuario]
)
ALTER TABLE [dbo].[Distribuidor1] WITH CHECK ADD CONSTRAINT [Cliente1_Distribuidor1_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente1] (
[ID_Cliente]
)
ALTER TABLE [dbo].[Distribuidor1] WITH CHECK ADD CONSTRAINT [Provincia1_Distribuidor1_FK1] FOREIGN KEY (
[ID_Provincia]
)
REFERENCES [dbo].[Provincia1] (
[ID_Provincia]
)
GO

GO

GO

ALTER TABLE [dbo].[Cliente1] WITH CHECK ADD CONSTRAINT [Usuario1_Cliente1_FK1] FOREIGN KEY (
[ID_Usuario]
)
REFERENCES [dbo].[Usuario1] (
[id_usuario]
)
ALTER TABLE [dbo].[Cliente1] WITH CHECK ADD CONSTRAINT [Provincia1_Cliente1_FK1] FOREIGN KEY (
[ID_Provincia]
)
REFERENCES [dbo].[Provincia1] (
[ID_Provincia]
)
GO

GO

ALTER TABLE [dbo].[FacturaDetalle] WITH CHECK ADD CONSTRAINT [PuntoDeVenta_FacturaDetalle_FK1] FOREIGN KEY (
)
REFERENCES [dbo].[PuntoDeVenta] (
)
ALTER TABLE [dbo].[FacturaDetalle] WITH CHECK ADD CONSTRAINT [Factura_FacturaDetalle_FK1] FOREIGN KEY (
[Nro_Factura_Int]
)
REFERENCES [dbo].[Factura] (
[Nro_Factura_Int]
)
ALTER TABLE [dbo].[FacturaDetalle] WITH CHECK ADD CONSTRAINT [Producto_FacturaDetalle_FK1] FOREIGN KEY (
[ID_Producto_Int]
)
REFERENCES [dbo].[Producto] (
[ID_Producto_Int]
)
GO

ALTER TABLE [dbo].[Distribuidor] WITH CHECK ADD CONSTRAINT [Provincia_Distribuidor_FK1] FOREIGN KEY (
[ID_Provincia]
)
REFERENCES [dbo].[Provincia] (
[ID_Provincia]
)
ALTER TABLE [dbo].[Distribuidor] WITH CHECK ADD CONSTRAINT [Usuario_Distribuidor_FK1] FOREIGN KEY (
[ID_Usuario]
)
REFERENCES [dbo].[Usuario] (
[id_usuario]
)
ALTER TABLE [dbo].[Distribuidor] WITH CHECK ADD CONSTRAINT [Cliente_Distribuidor_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente] (
[ID_Cliente]
)
GO

GO

ALTER TABLE [dbo].[Licencia1] WITH CHECK ADD CONSTRAINT [Cliente1_Licencia1_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente1] (
[ID_Cliente]
)
GO

ALTER TABLE [dbo].[Vendedor1] WITH CHECK ADD CONSTRAINT [Secuencia1_Vendedor1_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia1] (
[Nro_Secuencia_Int]
)
ALTER TABLE [dbo].[Vendedor1] WITH CHECK ADD CONSTRAINT [Distribuidor1_Vendedor1_FK1] FOREIGN KEY (
[ID_Distribuidor]
)
REFERENCES [dbo].[Distribuidor1] (
[ID_Distribuidor_Int]
)
GO

GO

ALTER TABLE [dbo].[ConcursoProducto] WITH CHECK ADD CONSTRAINT [Producto_ConcursoProducto_FK1] FOREIGN KEY (
[ID_Producto_Int]
)
REFERENCES [dbo].[Producto] (
[ID_Producto_Int]
)
ALTER TABLE [dbo].[ConcursoProducto] WITH CHECK ADD CONSTRAINT [Concurso_ConcursoProducto_FK1] FOREIGN KEY (
[ID_Concurso]
)
REFERENCES [dbo].[Concurso] (
[Id_Concurso]
)
GO

ALTER TABLE [dbo].[Secuencia1] WITH CHECK ADD CONSTRAINT [Distribuidor1_Secuencia1_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor1] (
[ID_Distribuidor_Int]
)
GO

ALTER TABLE [dbo].[Secuencia] WITH CHECK ADD CONSTRAINT [Distribuidor_Secuencia_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor] (
[ID_Distribuidor_Int]
)
GO

ALTER TABLE [dbo].[Usuario] WITH CHECK ADD CONSTRAINT [Licencia_Usuario_FK1] FOREIGN KEY (
[ID_Licencia]
)
REFERENCES [dbo].[Licencia] (
[ID_Licencia]
)
ALTER TABLE [dbo].[Usuario] WITH CHECK ADD CONSTRAINT [Idioma_Usuario_FK1] FOREIGN KEY (
[id_idioma]
)
REFERENCES [dbo].[Idioma] (
[id_idioma]
)
GO

ALTER TABLE [dbo].[Producto] WITH CHECK ADD CONSTRAINT [Cliente_Producto_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente] (
[ID_Cliente]
)
ALTER TABLE [dbo].[Producto] WITH CHECK ADD CONSTRAINT [Categoria_Producto_FK1] FOREIGN KEY (
[ID_Categoria_Int]
)
REFERENCES [dbo].[Categoria] (
[ID_categoria_Int]
)
GO

ALTER TABLE [dbo].[Factura1] WITH CHECK ADD CONSTRAINT [PuntoDeVenta1_Factura1_FK1] FOREIGN KEY (
[ID_PDV_Int]
)
REFERENCES [dbo].[PuntoDeVenta1] (
[ID_PDV_Int]
)
ALTER TABLE [dbo].[Factura1] WITH CHECK ADD CONSTRAINT [Secuencia1_Factura1_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia1] (
[Nro_Secuencia_Int]
)
ALTER TABLE [dbo].[Factura1] WITH CHECK ADD CONSTRAINT [Vendedor1_Factura1_FK1] FOREIGN KEY (
[ID_Vendedor_Int]
)
REFERENCES [dbo].[Vendedor1] (
[ID_Vendedor_Int]
)
ALTER TABLE [dbo].[Factura1] WITH CHECK ADD CONSTRAINT [Distribuidor1_Factura1_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor1] (
[ID_Distribuidor_Int]
)
GO

ALTER TABLE [dbo].[Elemento_Usuario1] WITH CHECK ADD CONSTRAINT [tiene] FOREIGN KEY (
[ID_Elemento]
)
REFERENCES [dbo].[Elemento1] (
[ID_Elemento]
)
ALTER TABLE [dbo].[Elemento_Usuario1] WITH CHECK ADD CONSTRAINT [Usuario1_Elemento_Usuario1_FK1] FOREIGN KEY (
[ID_Usuario]
)
REFERENCES [dbo].[Usuario1] (
[id_usuario]
)
GO

GO

ALTER TABLE [dbo].[FacturaDetalle1] WITH CHECK ADD CONSTRAINT [Factura1_FacturaDetalle1_FK1] FOREIGN KEY (
[Nro_Factura_Int]
)
REFERENCES [dbo].[Factura1] (
[Nro_Factura_Int]
)
ALTER TABLE [dbo].[FacturaDetalle1] WITH CHECK ADD CONSTRAINT [Producto1_FacturaDetalle1_FK1] FOREIGN KEY (
[ID_Producto_Int]
)
REFERENCES [dbo].[Producto1] (
[ID_Producto_Int]
)
GO

GO

GO

ALTER TABLE [dbo].[Elemento_Elemento1] WITH CHECK ADD CONSTRAINT [es hijo] FOREIGN KEY (
[id_elemento_hijo]
)
REFERENCES [dbo].[Elemento1] (
[ID_Elemento]
)
ALTER TABLE [dbo].[Elemento_Elemento1] WITH CHECK ADD CONSTRAINT [es padre] FOREIGN KEY (
[id_elemento_padre]
)
REFERENCES [dbo].[Elemento1] (
[ID_Elemento]
)
GO

ALTER TABLE [dbo].[Stock] WITH CHECK ADD CONSTRAINT [Distribuidor_Stock_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor] (
[ID_Distribuidor_Int]
)
ALTER TABLE [dbo].[Stock] WITH CHECK ADD CONSTRAINT [Secuencia_Stock_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia] (
[Nro_Secuencia_Int]
)
GO

ALTER TABLE [dbo].[PuntoDeVenta] WITH CHECK ADD CONSTRAINT [Provincia_PuntoDeVenta_FK1] FOREIGN KEY (
[ID_Provincia]
)
REFERENCES [dbo].[Provincia] (
[ID_Provincia]
)
ALTER TABLE [dbo].[PuntoDeVenta] WITH CHECK ADD CONSTRAINT [Vendedor_PuntoDeVenta_FK1] FOREIGN KEY (
[ID_Vendedor_int]
)
REFERENCES [dbo].[Vendedor] (
[ID_Vendedor_Int]
)
ALTER TABLE [dbo].[PuntoDeVenta] WITH CHECK ADD CONSTRAINT [Secuencia_PuntoDeVenta_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia] (
[Nro_Secuencia_Int]
)
ALTER TABLE [dbo].[PuntoDeVenta] WITH CHECK ADD CONSTRAINT [Distribuidor_PuntoDeVenta_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor] (
[ID_Distribuidor_Int]
)
GO

ALTER TABLE [dbo].[Factura] WITH CHECK ADD CONSTRAINT [PuntoDeVenta_Factura_FK1] FOREIGN KEY (
[ID_PDV_Int]
)
REFERENCES [dbo].[PuntoDeVenta] (
[ID_PDV_Int]
)
ALTER TABLE [dbo].[Factura] WITH CHECK ADD CONSTRAINT [Vendedor_Factura_FK1] FOREIGN KEY (
[ID_Vendedor_Int]
)
REFERENCES [dbo].[Vendedor] (
[ID_Vendedor_Int]
)
ALTER TABLE [dbo].[Factura] WITH CHECK ADD CONSTRAINT [Distribuidor_Factura_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor] (
[ID_Distribuidor_Int]
)
ALTER TABLE [dbo].[Factura] WITH CHECK ADD CONSTRAINT [Secuencia_Factura_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia] (
[Nro_Secuencia_Int]
)
GO

ALTER TABLE [dbo].[Idioma_Leyenda] WITH CHECK ADD CONSTRAINT [Leyenda_Idioma_Leyenda_FK1] FOREIGN KEY (
[id_leyenda]
)
REFERENCES [dbo].[Leyenda] (
[id_leyenda]
)
ALTER TABLE [dbo].[Idioma_Leyenda] WITH CHECK ADD CONSTRAINT [Idioma_Idioma_Leyenda_FK1] FOREIGN KEY (
[id_idioma]
)
REFERENCES [dbo].[Idioma] (
[id_idioma]
)
ALTER TABLE [dbo].[Idioma_Leyenda] WITH CHECK ADD CONSTRAINT [Idioma_Leyenda_Idioma_Leyenda_FK1] FOREIGN KEY (
)
REFERENCES [dbo].[Idioma_Leyenda] (
)
GO

GO

ALTER TABLE [dbo].[PuntoDeVenta1] WITH CHECK ADD CONSTRAINT [Secuencia1_PuntoDeVenta1_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia1] (
[Nro_Secuencia_Int]
)
ALTER TABLE [dbo].[PuntoDeVenta1] WITH CHECK ADD CONSTRAINT [Vendedor1_PuntoDeVenta1_FK1] FOREIGN KEY (
[ID_Vendedor_int]
)
REFERENCES [dbo].[Vendedor1] (
[ID_Vendedor_Int]
)
ALTER TABLE [dbo].[PuntoDeVenta1] WITH CHECK ADD CONSTRAINT [Provincia1_PuntoDeVenta1_FK1] FOREIGN KEY (
[ID_Provincia]
)
REFERENCES [dbo].[Provincia1] (
[ID_Provincia]
)
ALTER TABLE [dbo].[PuntoDeVenta1] WITH CHECK ADD CONSTRAINT [Distribuidor1_PuntoDeVenta1_FK1] FOREIGN KEY (
[ID_Distribuidor_Int]
)
REFERENCES [dbo].[Distribuidor1] (
[ID_Distribuidor_Int]
)
GO

ALTER TABLE [dbo].[Usuario1] WITH CHECK ADD CONSTRAINT [Licencia1_Usuario1_FK1] FOREIGN KEY (
[ID_Licencia]
)
REFERENCES [dbo].[Licencia1] (
[ID_Licencia]
)
ALTER TABLE [dbo].[Usuario1] WITH CHECK ADD CONSTRAINT [Idioma1_Usuario1_FK1] FOREIGN KEY (
[id_idioma]
)
REFERENCES [dbo].[Idioma1] (
[id_idioma]
)
GO

ALTER TABLE [dbo].[Error1] WITH CHECK ADD CONSTRAINT [Secuencia1_Error1_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia1] (
[Nro_Secuencia_Int]
)
GO

GO

ALTER TABLE [dbo].[Cliente] WITH CHECK ADD CONSTRAINT [Provincia_Cliente_FK1] FOREIGN KEY (
[ID_Provincia]
)
REFERENCES [dbo].[Provincia] (
[ID_Provincia]
)
ALTER TABLE [dbo].[Cliente] WITH CHECK ADD CONSTRAINT [Usuario_Cliente_FK1] FOREIGN KEY (
[ID_Usuario]
)
REFERENCES [dbo].[Usuario] (
[id_usuario]
)
GO

ALTER TABLE [dbo].[Vendedor] WITH CHECK ADD CONSTRAINT [Distribuidor_Vendedor_FK1] FOREIGN KEY (
[ID_Distribuidor]
)
REFERENCES [dbo].[Distribuidor] (
[ID_Distribuidor_Int]
)
ALTER TABLE [dbo].[Vendedor] WITH CHECK ADD CONSTRAINT [Secuencia_Vendedor_FK1] FOREIGN KEY (
[Nro_Secuencia_Int]
)
REFERENCES [dbo].[Secuencia] (
[Nro_Secuencia_Int]
)
GO

ALTER TABLE [dbo].[Producto1] WITH CHECK ADD CONSTRAINT [Categoria1_Producto1_FK1] FOREIGN KEY (
[ID_Categoria_Int]
)
REFERENCES [dbo].[Categoria1] (
[ID_categoria_Int]
)
ALTER TABLE [dbo].[Producto1] WITH CHECK ADD CONSTRAINT [Cliente1_Producto1_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente1] (
[ID_Cliente]
)
GO

ALTER TABLE [dbo].[Idioma_Leyenda1] WITH CHECK ADD CONSTRAINT [Leyenda1_Idioma_Leyenda1_FK1] FOREIGN KEY (
[id_leyenda]
)
REFERENCES [dbo].[Leyenda1] (
[id_leyenda]
)
ALTER TABLE [dbo].[Idioma_Leyenda1] WITH CHECK ADD CONSTRAINT [Idioma1_Idioma_Leyenda1_FK1] FOREIGN KEY (
[id_idioma]
)
REFERENCES [dbo].[Idioma1] (
[id_idioma]
)
GO

ALTER TABLE [dbo].[Categoria] WITH CHECK ADD CONSTRAINT [Cliente_Categoria_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente] (
[ID_Cliente]
)
GO

GO

