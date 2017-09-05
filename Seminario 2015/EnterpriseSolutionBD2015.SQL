USE Master
GO
CREATE DATABASE [EnterpriseSolutionBD2015]
GO
USE [EnterpriseSolutionBD2015]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Elemento_Usuario]') AND type in (N'U'))
    DROP TABLE [dbo].[Elemento_Usuario]
GO
CREATE TABLE [dbo].[Elemento_Usuario] (
[ID_Elemento] bigint  NOT NULL  
, [ID_Usuario] bigint  NOT NULL  
, [substrae] bit  NULL  
, [Borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
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
[ID_Elemento] bigint  NOT NULL  
, [descripcion] nvarchar(max)  NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
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
[id_elemento_padre] bigint  NOT NULL  
, [id_elemento_hijo] bigint  NOT NULL  
, [substrae] bit  NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[Elemento_Elemento] ADD CONSTRAINT [Elemento_Elemento_PK] PRIMARY KEY CLUSTERED (
[id_elemento_padre]
, [id_elemento_hijo]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Leyenda]') AND type in (N'U'))
    DROP TABLE [dbo].[Leyenda]
GO
CREATE TABLE [dbo].[Leyenda] (
[id_leyenda] nvarchar(100)  NOT NULL  
, [descripcion_leyenda] nvarchar(max)  NOT NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
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
[id_pantalla] varchar(30)  NOT NULL  
, [Descripcion] varchar(100)  NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[Pantalla] ADD CONSTRAINT [Pantalla_PK] PRIMARY KEY CLUSTERED (
[id_pantalla]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConcursoDistribuidor]') AND type in (N'U'))
    DROP TABLE [dbo].[ConcursoDistribuidor]
GO
CREATE TABLE [dbo].[ConcursoDistribuidor] (
[ID_Distribuidor_Int] bigint  NOT NULL  
, [id_Concurso] bigint  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
, [Cuota] smallint  NULL  
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
[Numerador] bigint identity  NOT NULL  
, [ID_Error] char(10)  NOT NULL  
, [Mensaje] char(10)  NOT NULL  
, [Linea] bigint  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
, [Nro_Secuencia_Int] bigint  NULL  
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
[ID_Licencia] bigint  NOT NULL  
, [Fecha_Compra] datetime  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NULL  
, [ID_Cliente] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[Licencia] ADD CONSTRAINT [Licencia_PK] PRIMARY KEY CLUSTERED (
[ID_Licencia]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provincia]') AND type in (N'U'))
    DROP TABLE [dbo].[Provincia]
GO
CREATE TABLE [dbo].[Provincia] (
[ID_Provincia] bigint  NOT NULL  
, [Nombre] nvarchar(max)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NULL  
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
[id_pantalla] varchar(30)  NOT NULL  
, [id_control] varchar(30)  NOT NULL  
, [id_leyenda] char(10)  NOT NULL  
, [id_elemento] bigint  NOT NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[Control] ADD CONSTRAINT [Control_PK] PRIMARY KEY CLUSTERED (
[id_pantalla]
, [id_control]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntradasBitacora]') AND type in (N'U'))
    DROP TABLE [dbo].[EntradasBitacora]
GO
CREATE TABLE [dbo].[EntradasBitacora] (
[id] uniqueidentifier  NOT NULL  
, [FechaHora] datetime  NOT NULL  
, [Modulo] char(10)  NOT NULL  
, [Mensaje] char(10)  NOT NULL  
, [DatosAnteriores] char(10)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [borrado] bit  NOT NULL  
)
GO

ALTER TABLE [dbo].[EntradasBitacora] ADD CONSTRAINT [EntradasBitacora_PK] PRIMARY KEY CLUSTERED (
[id]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Config]') AND type in (N'U'))
    DROP TABLE [dbo].[Config]
GO
CREATE TABLE [dbo].[Config] (
[TiempoEsperaServicio] bigint  NOT NULL  
, [Path_FTP] char(10)  NOT NULL  
, [sistema_bloqueado] smallint  NOT NULL  
, [DVH] bigint  NOT NULL  
, [borrado] bit  NOT NULL  
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
[Nro_Factura_Int] bigint  NOT NULL  
, [Linea] bigint  NOT NULL  
, [ID_Producto_Int] bigint  NOT NULL  
, [Cantidad] bigint  NOT NULL  
, [Precio] decimal(10,2)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
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
[ID_Distribuidor_Int] bigint identity  NOT NULL  
, [ID_Distribuidor_Real] nvarchar(max)  NOT NULL  
, [Nombre] nvarchar(max)  NOT NULL  
, [ID_Provincia] bigint  NOT NULL  
, [ID_Usuario] bigint  NOT NULL  
, [ID_Cliente] bigint  NOT NULL  
, [Mail] nvarchar(max)  NULL  
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConcursoProducto]') AND type in (N'U'))
    DROP TABLE [dbo].[ConcursoProducto]
GO
CREATE TABLE [dbo].[ConcursoProducto] (
[ID_Producto_Int] bigint  NOT NULL  
, [ID_Concurso] bigint  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
)
GO

ALTER TABLE [dbo].[ConcursoProducto] ADD CONSTRAINT [ConcursoProducto_PK] PRIMARY KEY CLUSTERED (
[ID_Producto_Int]
, [ID_Concurso]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Secuencia]') AND type in (N'U'))
    DROP TABLE [dbo].[Secuencia]
GO
CREATE TABLE [dbo].[Secuencia] (
[Nro_Secuencia_Int] bigint identity  NOT NULL  
, [Nro_Secuencia_Real] bigint  NOT NULL  
, [Fecha] datetime  NOT NULL  
, [Estado] varchar(10)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
, [ID_Distribuidor_Int] bigint  NOT NULL  
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
[id_usuario] bigint  NOT NULL  
, [nombre] varchar(100)  NOT NULL  
, [id_idioma] bigint  NOT NULL  
, [password] nvarchar(max)  NULL  
, [IntentosFallidos] smallint  NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
, [ID_Licencia] bigint  NULL  
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
[ID_Producto_Int] bigint identity  NOT NULL  
, [ID_Producto_Real] char(10)  NOT NULL  
, [Nombre] char(10)  NOT NULL  
, [Precio] numeric(10,2)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
, [ID_Cliente] bigint  NOT NULL  
, [ID_Categoria_Int] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[Producto] ADD CONSTRAINT [Producto_PK] PRIMARY KEY CLUSTERED (
[ID_Producto_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Idioma]') AND type in (N'U'))
    DROP TABLE [dbo].[Idioma]
GO
CREATE TABLE [dbo].[Idioma] (
[id_idioma] bigint  NOT NULL  
, [nombre_idioma] nvarchar(max)  NOT NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NULL  
)
GO

ALTER TABLE [dbo].[Idioma] ADD CONSTRAINT [Idioma_PK] PRIMARY KEY CLUSTERED (
[id_idioma]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Concurso]') AND type in (N'U'))
    DROP TABLE [dbo].[Concurso]
GO
CREATE TABLE [dbo].[Concurso] (
[Id_Concurso] bigint identity  NOT NULL  
, [Nombre_concurso] nvarchar(max)  NOT NULL  
, [Puntos_cobertura] bigint  NOT NULL  
, [Puntos_Ventas] bigint  NOT NULL  
, [Puntos_Transmisiones] bigint  NOT NULL  
, [Usar_cobertura] bit  NOT NULL  
, [Usar_Transmisiones] bit  NOT NULL  
, [Usar_Ventas] bit  NOT NULL  
, [DVH] bigint  NULL  
, [Borrado] bit  NULL  
)
GO

ALTER TABLE [dbo].[Concurso] ADD CONSTRAINT [Concurso_PK] PRIMARY KEY CLUSTERED (
[Id_Concurso]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Stock]') AND type in (N'U'))
    DROP TABLE [dbo].[Stock]
GO
CREATE TABLE [dbo].[Stock] (
[Nro_Movimiento_Int] bigint identity  NOT NULL  
, [Fecha] datetime  NOT NULL  
, [Tipo] varchar(10)  NOT NULL  
, [Cantidad] decimal(10,2)  NOT NULL  
, [Precio] decimal(10,2)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
, [ID_Distribuidor_Int] bigint  NOT NULL  
, [Nro_Secuencia_Int] bigint  NOT NULL  
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
[ID_PDV_Int] bigint identity  NOT NULL  
, [ID_PDV_Real] bigint  NOT NULL  
, [Nombre] varchar(100)  NOT NULL  
, [CUIT] varchar(13)  NOT NULL  
, [Calle] char(10)  NOT NULL  
, [Depto] char(10)  NULL  
, [CodigoPostal] char(10)  NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
, [ID_Provincia] smallint  NOT NULL  
, [ID_Distribuidor_Int] bigint  NOT NULL  
, [Nro_Secuencia_Int] bigint  NOT NULL  
, [ID_Vendedor_int] bigint  NOT NULL  
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
[Nro_Factura_Int] bigint identity  NOT NULL  
, [Nro_Factura_Real] char(10)  NOT NULL  
, [Fecha] datetime  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
, [ID_PDV_Int] bigint  NOT NULL  
, [Nro_Secuencia_Int] bigint  NOT NULL  
, [ID_Distribuidor_Int] bigint  NOT NULL  
, [ID_Vendedor_Int] bigint  NOT NULL  
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
[id_idioma] bigint  NOT NULL  
, [id_leyenda] nvarchar(100)  NOT NULL  
, [texto_leyenda] nvarchar(max)  NOT NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[Idioma_Leyenda] ADD CONSTRAINT [Idioma_Leyenda_PK] PRIMARY KEY CLUSTERED (
[id_idioma]
, [id_leyenda]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DVV]') AND type in (N'U'))
    DROP TABLE [dbo].[DVV]
GO
CREATE TABLE [dbo].[DVV] (
[nombre_tabla] varchar(100)  NOT NULL  
, [Valor] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[DVV] ADD CONSTRAINT [DVV_PK] PRIMARY KEY CLUSTERED (
[nombre_tabla]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cliente]') AND type in (N'U'))
    DROP TABLE [dbo].[Cliente]
GO
CREATE TABLE [dbo].[Cliente] (
[ID_Cliente] bigint identity  NOT NULL  
, [Nombre] nvarchar(max)  NOT NULL  
, [Mail] nvarchar(max)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NULL  
, [ID_Provincia] bigint  NOT NULL  
, [ID_Usuario] bigint  NULL  
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
[ID_Vendedor_Int] bigint identity  NOT NULL  
, [Id_Vendedor_Real] nvarchar(max)  NOT NULL  
, [Nombre] nvarchar(max)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NOT NULL  
, [ID_Distribuidor] bigint  NOT NULL  
, [Nro_Secuencia_Int] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[Vendedor] ADD CONSTRAINT [Vendedor_PK] PRIMARY KEY CLUSTERED (
[ID_Vendedor_Int]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categoria]') AND type in (N'U'))
    DROP TABLE [dbo].[Categoria]
GO
CREATE TABLE [dbo].[Categoria] (
[ID_categoria_Int] bigint identity  NOT NULL  
, [ID_Categoria] char(10)  NOT NULL  
, [ID_Cliente] bigint  NOT NULL  
, [Nombre] char(10)  NOT NULL  
, [DVH] bigint  NOT NULL  
, [Borrado] bit  NULL  
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
[id] uniqueidentifier  NOT NULL  
, [fecha] datetime  NOT NULL  
, [tipo] bit  NOT NULL  
, [path] char(10)  NOT NULL  
, [borrado] bit  NULL  
, [DVH] bigint  NOT NULL  
)
GO

ALTER TABLE [dbo].[BROperation] ADD CONSTRAINT [BROperation_PK] PRIMARY KEY CLUSTERED (
[id]
)
GO
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

GO

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

ALTER TABLE [dbo].[Categoria] WITH CHECK ADD CONSTRAINT [Cliente_Categoria_FK1] FOREIGN KEY (
[ID_Cliente]
)
REFERENCES [dbo].[Cliente] (
[ID_Cliente]
)
GO

GO

