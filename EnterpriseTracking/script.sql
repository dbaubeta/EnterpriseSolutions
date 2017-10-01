USE [master]
GO
/****** Object:  Database [EnterpriseSolutionsBD]    Script Date: 10/1/2017 12:09:38 AM ******/
CREATE DATABASE [EnterpriseSolutionsBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EnterpriseSolutionBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EnterpriseSolutionBD.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EnterpriseSolutionBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EnterpriseSolutionBD_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EnterpriseSolutionsBD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET ARITHABORT OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET RECOVERY FULL 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET  MULTI_USER 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EnterpriseSolutionsBD', N'ON'
GO
USE [EnterpriseSolutionsBD]
GO
/****** Object:  Table [dbo].[BROperation]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BROperation](
	[id] [uniqueidentifier] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[tipo] [bit] NOT NULL,
	[path] [nvarchar](max) NOT NULL,
	[borrado] [bit] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [BROperation_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDExterno] [nvarchar](max) NOT NULL,
	[IDCliente] [bigint] NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NULL,
 CONSTRAINT [Categoria_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[Mail] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NULL,
	[IDProvincia] [bigint] NOT NULL,
	[IDUsuario] [bigint] NULL,
 CONSTRAINT [Cliente_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Concurso]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Concurso](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[PuntosCobertura] [bigint] NOT NULL,
	[PuntosVentas] [bigint] NOT NULL,
	[PuntosTransmisiones] [bigint] NOT NULL,
	[UsarCobertura] [bit] NOT NULL,
	[UsarTransmisiones] [bit] NOT NULL,
	[UsarVentas] [bit] NOT NULL,
	[DVH] [bigint] NULL,
	[Borrado] [bit] NULL,
 CONSTRAINT [Concurso_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConcursoDistribuidor]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConcursoDistribuidor](
	[IDDistribuidor] [bigint] NOT NULL,
	[IDConcurso] [bigint] NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[Cuota] [smallint] NULL,
 CONSTRAINT [ConcursoDistribuidor_PK] PRIMARY KEY CLUSTERED 
(
	[IDDistribuidor] ASC,
	[IDConcurso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConcursoProducto]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConcursoProducto](
	[IDProducto] [bigint] NOT NULL,
	[IDConcurso] [bigint] NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
 CONSTRAINT [ConcursoProducto_PK] PRIMARY KEY CLUSTERED 
(
	[IDProducto] ASC,
	[IDConcurso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Config]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Config](
	[TiempoEsperaServicio] [bigint] NOT NULL,
	[PathFTP] [nvarchar](max) NOT NULL,
	[SistemaBloqueado] [smallint] NOT NULL,
	[DVH] [bigint] NOT NULL,
	[borrado] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Distribuidor]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distribuidor](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDReal] [nvarchar](max) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[IDProvincia] [bigint] NOT NULL,
	[IDUsuario] [bigint] NOT NULL,
	[IDCliente] [bigint] NOT NULL,
	[Mail] [nvarchar](max) NULL,
 CONSTRAINT [Distribuidor_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DVV]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DVV](
	[NombreTabla] [varchar](100) NOT NULL,
	[Valor] [bigint] NOT NULL,
 CONSTRAINT [DVV_PK] PRIMARY KEY CLUSTERED 
(
	[NombreTabla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Elemento]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elemento](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](400) NULL,
	[Tipo] [int] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Elemento_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ElementoElemento]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ElementoElemento](
	[IDPadre] [bigint] NOT NULL,
	[IDHijo] [bigint] NOT NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Elemento_Elemento_PK] PRIMARY KEY CLUSTERED 
(
	[IDPadre] ASC,
	[IDHijo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EntradasBitacora]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntradasBitacora](
	[id] [uniqueidentifier] NOT NULL,
	[FechaHora] [datetime] NOT NULL,
	[Modulo] [nvarchar](max) NOT NULL,
	[Mensaje] [nvarchar](max) NOT NULL,
	[DatosAnteriores] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[borrado] [bit] NOT NULL,
 CONSTRAINT [EntradasBitacora_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Error]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Error](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDError] [nvarchar](max) NOT NULL,
	[Mensaje] [nvarchar](max) NOT NULL,
	[Linea] [bigint] NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[IDSecuencia] [bigint] NULL,
 CONSTRAINT [Error_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Factura]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[NroFactura] [nvarchar](max) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[IDPuntoVenta] [bigint] NOT NULL,
	[IDSecuencia] [bigint] NOT NULL,
	[IDDistribuidor] [bigint] NOT NULL,
	[IDVendedor] [bigint] NOT NULL,
 CONSTRAINT [Factura_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FacturaDetalle]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaDetalle](
	[IDFactura] [bigint] NOT NULL,
	[Linea] [bigint] NOT NULL,
	[IDProducto] [bigint] NOT NULL,
	[Cantidad] [bigint] NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
 CONSTRAINT [FacturaDetalle_PK] PRIMARY KEY CLUSTERED 
(
	[IDFactura] ASC,
	[Linea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NULL,
	[borrado] [bit] NULL,
 CONSTRAINT [Idioma_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IdiomaLeyenda]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IdiomaLeyenda](
	[IDIdioma] [bigint] NOT NULL,
	[IDLeyenda] [nvarchar](100) NOT NULL,
	[Texto] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Idioma_Leyenda_PK] PRIMARY KEY CLUSTERED 
(
	[IDIdioma] ASC,
	[IDLeyenda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producto]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDReal] [nvarchar](max) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[Precio] [numeric](10, 2) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[IDCliente] [bigint] NOT NULL,
	[IDCategoria] [bigint] NOT NULL,
 CONSTRAINT [Producto_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[ID] [bigint] NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NULL,
 CONSTRAINT [Provincia_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PuntoDeVenta]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PuntoDeVenta](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDReal] [bigint] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[CUIT] [varchar](13) NOT NULL,
	[Calle] [nvarchar](max) NOT NULL,
	[Depto] [nvarchar](max) NULL,
	[CodigoPostal] [nvarchar](max) NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[IDProvincia] [bigint] NOT NULL,
	[IDDistribuidor] [bigint] NOT NULL,
	[IDSecuencia] [bigint] NOT NULL,
	[IDVendedor] [bigint] NOT NULL,
 CONSTRAINT [PuntoDeVenta_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Secuencia]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Secuencia](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDReal] [bigint] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[IDDistribuidor] [bigint] NOT NULL,
 CONSTRAINT [Secuencia_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stock](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Tipo] [varchar](10) NOT NULL,
	[Cantidad] [decimal](10, 2) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[IDDistribuidor] [bigint] NOT NULL,
	[IDSecuencia] [bigint] NOT NULL,
	[IDProducto] [bigint] NOT NULL,
 CONSTRAINT [Stock_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NOT NULL,
	[IDIdioma] [bigint] NOT NULL,
	[password] [nvarchar](max) NULL,
	[IntentosFallidos] [smallint] NULL,
	[Habilitado] [bit] NOT NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Usuario_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UsuarioElemento]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioElemento](
	[IDElemento] [bigint] NOT NULL,
	[IDUsuario] [bigint] NOT NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Elemento_Usuario_PK] PRIMARY KEY CLUSTERED 
(
	[IDElemento] ASC,
	[IDUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vendedor]    Script Date: 10/1/2017 12:09:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendedor](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDReal] [nvarchar](max) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[IDDistribuidor] [bigint] NOT NULL,
	[IDSecuencia] [bigint] NOT NULL,
 CONSTRAINT [Vendedor_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'idioma', 3591)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Idioma_Leyenda', 424087)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'IdiomaLeyenda', 1016278)
SET IDENTITY_INSERT [dbo].[Elemento] ON 

INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (1, N'Principal', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3, N'UsuarioLista', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (4, N'UsuarioLista_btnNuevoUsuario', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (5, N'UsuarioLista_btnEditarUsuario', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (6, N'UsuarioLista_btnEliminarUsuario', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (11, N'UsuarioEdicion', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (187, N'Administrador', 1, 1410)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (188, N'Distribuidor', 1, 1317)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (190, N'Cliente', 1, 757)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (348, N'GrupoLista', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (349, N'GrupoLista_btnNuevoGrupo', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (350, N'GrupoLista_btnEditarGrupo', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (351, N'GrupoLista_btnEliminarGrupo', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (509, N'GrupoEdicion', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (1507, N'IdiomaLista', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (1508, N'IdiomaLista_btnNuevoIdioma', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (1509, N'IdiomaLista_btnEditarIdioma', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (1510, N'IdiomaLista_btnEliminarIdioma', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (1519, N'IdiomaEdicion', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (2168, N'UsuarioAsignarPermisos', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (2491, N'UsuarioLista_btnAsignarPermisosUsuario', 0, 0)
SET IDENTITY_INSERT [dbo].[Elemento] OFF
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 3, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 4, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 5, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 6, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 11, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 348, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 349, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 350, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 351, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 509, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1507, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1508, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1509, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1510, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1519, 0)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (188, 1, 0)
SET IDENTITY_INSERT [dbo].[Idioma] ON 

INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH], [borrado]) VALUES (1, N'Español', 1344, 0)
INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH], [borrado]) VALUES (2, N'Ingles', 1101, 0)
INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH], [borrado]) VALUES (3, N'Inglesx', 1146, 1)
SET IDENTITY_INSERT [dbo].[Idioma] OFF
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnAceptar', N'Aceptar', 1781)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnAsignarPermisosUsuario', N'Asignar Permisos', 4267)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnCancelar', N'Cancelar', 1959)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnEditarGrupo', N'Modificar Grupo', 2966)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnEditarIdioma', N'Modificar Idioma', 3106)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnEditarUsuario', N'Modificar', 2628)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnEliminarGrupo', N'Eliminar Grupo', 3089)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnEliminarIdioma', N'Eliminar Idioma', 3229)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnEliminarUsuario', N'Eliminar', 2751)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnLogin', N'Ingresar', 1705)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnModalNo', N'No', 1244)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnModalOk', N'Aceptar', 1756)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnModalSi', N'Si', 1242)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnNuevoGrupo', N'Nuevo Grupo', 2505)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnNuevoIdioma', N'Nuevo Idioma', 2645)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnNuevoUsuario', N'Nuevo Usuario', 2943)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'ContraseñaUsuarioRequerido', N'La contraseña es requerida', 5554)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EstaSeguroBorrarElementoSeleccionado', N'Esta seguro que desea eliminar el item seleccionado?', 8677)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EstaSeguroBorrarIdiomaSeleccionado', N'Esta seguro que desea eliminar el idioma seleccionado?', 8643)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EstaSeguroSalir', N'Esta seguro que desea salir y perder los cambios?', 6174)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdElementosSeleccionados_columna0', N'ID', 3681)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdElementosSeleccionados_columna1', N'Elementos seleccionados', 5885)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdElementosSeleccionados_columna2', N'Seleccionar', 4670)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdGrupoDisponibles_columna2', N'Seleccionar', 4063)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdGrupos_columna0', N'ID Grupo', 2598)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdGrupos_columna1', N'Nombre', 2512)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdGruposDisponibles_columna0', N'ID', 3189)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdGruposDisponibles_columna1', N'Grupo', 3574)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdGruposDisponibles_columna2', N'Seleccionar', 4178)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdIdiomas_columna0', N'ID', 2111)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdIdiomas_columna1', N'Nombre', 2582)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna0', N'ID Leyenda', 2960)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna1', N'Texto leyenda referencia', 4460)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna2', N'Nuevo texto de leyenda', 4207)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdPermisosDisponibles_columna0', N'Permiso', 3993)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdPermisosDisponibles_columna1', N'Permiso', 3994)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdPermisosDisponibles_columna2', N'Seleccionar', 4388)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdUsuarios_columna0', N'ID', 2260)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdUsuarios_columna1', N'Nombre usuario', 3539)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdUsuarios_columna2', N'Idioma', 2716)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdUsuarios_columna3', N'Habilitado', 3131)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'HayLeyendasFaltantes', N'Hay leyendas faltantes para el idioma. Todas las leyendas deben completarse.', 9236)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblContraseña', N'Contraseña', 2701)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblDescripcionSistema', N'Una herramienta indispensable para administrar su red de distribución, comprender y satisfacer las necesidades de stock de sus clientes y asegurarse las mas amplia cobertura de sus productos en el mercado.', 21886)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblEnterpriseTracking', N'Enterprise Tracking', 4147)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblGrupoID', N'ID del Grupo', 2068)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblGrupoListaTitulo', N'Administración de Grupos', 4536)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblGrupoNombre', N'Noombre del Grupo', 3119)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblIdiomaListaTitulo', N'Administración de Idiomas', 4676)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblIngresesusdatos', N'Credenciales', 3184)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblLenguajeNombre', N'Nombre de Lenguaje', 3472)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblLenguajeReferencia', N'Lenguaje de Referencia', 4274)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblPassword', N'Contraseña', 2383)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblRememberme', N'Recordarme ?', 2511)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblUsuario', N'Usuario', 1851)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblUsuarioabilitado', N'Habilitado?', 3116)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblUsuarioID', N'ID Usuario', 2165)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblUsuarioIdioma', N'Idioma', 2297)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblUsuarioListaTitulo', N'Administración de Usuarios', 4974)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblUsuarioNombre', N'Nombre', 2329)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'ListaSecuencias', N'.', 1631)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'ListaTablas', N'.', 1203)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonConcursos', N'Concursos', 2939)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonConcursos_Concurso', N'Adm. de Concursos', 4463)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonIdioma', N'Idiomas', 2326)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonIdioma_Idioma', N'Adm. de Idiomas', 3601)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonLogout', N'Cerrar sesión', 3083)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes', N'Reportes', 2725)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_InvasionZonas', N'Invasión de Zonas', 5089)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_ProyeccionVtas', N'Proyeccion de ventas', 5406)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_RAnkingDistVend', N'Ranking de Distribuidores/Vendedores', 7000)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_Stock', N'Informe de Stock', 3985)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_ValStockFIFO', N'Valorización de Stock (FIFO)', 5650)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_ValStockLIFO', N'Valorización de Stock (LIFO)', 5662)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_ValStockPPP', N'Valorización de Stock (PPP)', 5546)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_VtasxCatProd', N'Ventas por Categoria y Producto', 6157)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonReportes_VtasxDistVend', N'Ventas por Distribuidor/Vendedor', 6467)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonSecuencias', N'Secuencias', 3075)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonSecuencias_CargaManual', N'Carga manual de secuencia', 5584)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonSecuencias_PanelControl', N'Panel de Control', 4874)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonSecuencias_Transmisiones', N'Adm. de Transmisiones', 5510)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonSeguridad', N'Seguridad', 2861)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonSeguridad_Grupo', N'Adm. de Grupos de permisos', 4933)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonSeguridad_Usuario', N'Adm. de Usuarios', 4224)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonTablas', N'Tablas del sistema', 3350)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonTablas_Categoria', N'Adm. de Categorias', 4237)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonTablas_Cliente', N'Adm. de clientes', 3863)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonTablas_Distribuidor', N'Adm. de Distribuidores', 5052)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonTablas_Producto', N'Adm. de productos', 4143)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'msjErrorContraseñaIncorrecta', N'La contraseña ingresada es incorrecta', 6830)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'msjErrorUsuarioIncorrecto', N'El usuario ingresado no existe.', 5655)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_GrupoEdicion', N'Pantalla Modificacion de Grupo', 4959)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_GrupoLista', N'Pantalla Lista de Grupos', 4172)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_GrupoLista_btnEditarGrupo', N'Modificar Grupo', 4925)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_GrupoLista_btnEliminarGrupo', N'Eliminar Grupo', 5048)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_GrupoLista_btnNuevoGrupo', N'Agregar Grupo', 4636)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_IdiomaEdicion', N'Pantalla modificacion de Idioma', 5131)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_IdiomaLista', N'Pantalla Lista de Idiomas', 4312)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_IdiomaLista_btnEditarIdioma', N'Modificar Idiomas', 5250)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_IdiomaLista_btnEliminarIdioma', N'Eliminar Idiomas', 5373)
GO
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_IdiomaLista_btnNuevoIdioma', N'Agregar Idiomas', 4961)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_Principal', N'Pantalla Ingreso al sistema', 4408)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_UsuarioAsignarPermisos', N'Pantalla Asignar Permisos a Usuarios', 5793)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_UsuarioEdicion', N'Pantalla Modificacion de Grupo', 5178)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_UsuarioLista', N'Pantalla Lista de Usuarios', 4610)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_UsuarioLista_btnAsignarPermisosUsuario', N'Asignar Permisos a Usuarios', 7465)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_UsuarioLista_btnEditarUsuario', N'Modificar Usuario', 5582)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_UsuarioLista_btnEliminarUsuario', N'Eliminar Usuario', 5705)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Permiso_UsuarioLista_btnNuevoUsuario', N'Agregar Usuario', 5293)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'RequiredFieldValidatorErrorPassword', N'Contraseña requerida', 5836)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'RequiredFieldValidatorErrorUsuario', N'Usuario requerido', 5318)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'RequiredFieldValidatorLenguajeNombre', N'Nombre es requerido', 5589)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'RequiredFieldValidatorNuevaLeyenda', N'Dato requerido', 4917)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloAsignarPermisosUsuario', N'Asignar Permisos', 4616)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloEditarGrupo', N'Modificar Grupo de permisos', 4462)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloEditarIdioma', N'Modificar Idioma', 3455)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloEditarUsuario', N'Modificar Usuario', 3753)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloNuevoGrupo', N'Nuevo Grupo', 2854)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloNuevoIdioma', N'Nuevo Idioma', 2994)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloNuevoUsuario', N'Nuevo Usuario', 3292)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtContraseña', N'Ingrese contraseña', 3520)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtGrupoNombre', N'Ingrese un nombre para el grupo', 4470)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtLenguajeNombre', N'Ingrese nombre del lenguaje', 4431)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtNuevoTextoLeyenda', N'Ingrese nuevo texto', 4066)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtUsuario', N'Ingrese usuario', 2670)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtUsuarioID', N'ID del usuario', 2576)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtUsuarioNombre', N'Nombre de usuario', 3408)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnAceptar', N'Ok', 1264)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnAsignarPermisosUsuario', N'Assign Permissions', 4502)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnCancelar', N'Cancel', 1749)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnEditarGrupo', N'Edit Group', 2447)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnEditarIdioma', N'Edit Language', 2796)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnEditarUsuario', N'Edit User', 2556)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnEliminarGrupo', N'Delete Group', 2868)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnEliminarIdioma', N'Delete Language', 3217)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnEliminarUsuario', N'Delete User', 2977)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnLogin', N'Login', 1384)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnModalNo', N'No', 1245)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnModalOk', N'OK', 1207)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnModalSi', N'Yes', 1360)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnNuevoGrupo', N'Add Group', 2246)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnNuevoIdioma', N'Add Language', 2595)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnNuevoUsuario', N'Add User', 2355)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'ContraseñaUsuarioRequerido', N'Password is required', 4907)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EstaSeguroBorrarElementoSeleccionado', N'Are you sure to delete the selected item?', 7552)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EstaSeguroBorrarIdiomaSeleccionado', N'Are you sure to delete the selected Language?', 7695)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EstaSeguroSalir', N'Are you sure you want to leave and lose your changes?', 6519)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdElementosSeleccionados_columna0', N'ID', 3682)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdElementosSeleccionados_columna1', N'Selected Elements', 5212)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdElementosSeleccionados_columna2', N'Select', 4151)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdGrupoDisponibles_columna2', N'Select', 3544)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdGrupos_columna0', N'Group ID', 2599)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdGrupos_columna1', N'Name', 2287)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdGruposDisponibles_columna0', N'ID', 3190)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdGruposDisponibles_columna1', N'Group', 3575)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdGruposDisponibles_columna2', N'Select', 3659)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdIdiomas_columna0', N'ID', 2112)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdIdiomas_columna1', N'Name', 2357)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdLeyendas_columna0', N'ID Legend', 2846)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdLeyendas_columna1', N'Reference Legend', 3617)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdLeyendas_columna2', N'New Legend', 3005)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdPermisosDisponibles_columna0', N'ID', 3400)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdPermisosDisponibles_columna1', N'Permission', 4325)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdPermisosDisponibles_columna2', N'Select', 3869)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdUsuarios_columna0', N'ID', 2261)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdUsuarios_columna1', N'User Name', 2953)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdUsuarios_columna2', N'Language', 2926)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdUsuarios_columna3', N'Enabled', 2806)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'HayLeyendasFaltantes', N'All legends are required.', 4429)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblContrase&#241;a', N'Password', 2426)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblContraseña', N'Password', 2384)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblDescripcionSistema', N'A must-have tool to manage your distribution network, understand and satisfy the stock needs of your customers, and ensure a wider product coverage in the market.', 17614)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblEnterpriseTracking', N'Enterprise Tracking', 4148)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblGrupoID', N'Group ID', 1728)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblGrupoListaTitulo', N'Groups Management', 3732)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblGrupoNombre', N'Group Name', 2442)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblIdiomaListaTitulo', N'Languages Management', 4081)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblIngresesusdatos', N'Credentials', 3101)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblLenguajeNombre', N'Language name', 3039)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblLenguajeReferencia', N'Reference Language', 3934)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblPassword', N'Password', 2066)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblRememberme', N'Remember me?', 2509)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblUsuario', N'User', 1523)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblUsuarioabilitado', N'Enabled?', 2791)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblUsuarioID', N'User ID', 1837)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblUsuarioIdioma', N'Language', 2507)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblUsuarioListaTitulo', N'Users Management', 3841)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblUsuarioNombre', N'Name', 2104)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'ListaSecuencias', N'.', 1632)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'ListaTablas', N'.', 1204)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonConcursos', N'Contests', 2832)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonConcursos_Concurso', N'Contests Management', 4824)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonIdioma', N'Languages', 2536)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonIdioma_Idioma', N'Languages Management', 4279)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonLogout', N'Logout', 2290)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes', N'Reports', 2625)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_InvasionZonas', N'Zone Invation', 4615)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_ProyeccionVtas', N'Sales Proyection', 5038)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_RAnkingDistVend', N'Distributors/Salesmen Ranking', 6363)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_Stock', N'Stock Report', 3669)
GO
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_ValStockFIFO', N'Stock Valorization(FIFO)', 5271)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_ValStockLIFO', N'Stock Valorization(LIFO)', 5283)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_ValStockPPP', N'Stock Valorization(PPP)', 5167)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_VtasxCatProd', N'Product/Category Sales', 5338)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonReportes_VtasxDistVend', N'Distributors/Salesmen Sales', 6005)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonSecuencias', N'Sequences', 2989)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonSecuencias_CargaManual', N'Manual sequence Load', 5139)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonSecuencias_PanelControl', N'Control Panel', 4642)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonSecuencias_Transmisiones', N'Transmissions Management', 5993)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonSeguridad', N'Security', 2798)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonSeguridad_Grupo', N'Permission Groups management', 5384)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonSeguridad_Usuario', N'Users Management', 4364)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonTablas', N'System Tables', 2901)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonTablas_Categoria', N'Categories Management', 4710)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonTablas_Cliente', N'Customers Management', 4442)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonTablas_Distribuidor', N'Distributors Management', 5331)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnuButtonTablas_Producto', N'Products Management', 4469)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'msjErrorContrase&#241;aIncorrecta', N'Wrong password', 4587)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'msjErrorUsuarioIncorrecto', N'User does not exist.', 4572)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_GrupoEdicion', N'Group Edit Screen', 3691)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_GrupoLista', N'Group List Screen', 3523)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_GrupoLista_btnEditarGrupo', N'Edit Groups', 4521)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_GrupoLista_btnEliminarGrupo', N'Delete Groups', 4942)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_GrupoLista_btnNuevoGrupo', N'Add Groups', 4320)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_IdiomaEdicion', N'Language Edit Screen', 4040)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_IdiomaLista', N'Language List Screen', 3872)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_IdiomaLista_btnEditarIdioma', N'Edit Languages', 4940)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_IdiomaLista_btnEliminarIdioma', N'Delete Languages', 5361)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_IdiomaLista_btnNuevoIdioma', N'Add Languages', 4739)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_Principal', N'Login Screens', 3070)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_UsuarioAsignarPermisos', N'Screen Assign Permissions to Users', 5600)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_UsuarioEdicion', N'User Edit Screen', 3800)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_UsuarioLista', N'User List Screen', 3632)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_UsuarioLista_btnAsignarPermisosUsuario', N'Assign Permissions to Users', 7501)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_UsuarioLista_btnEditarUsuario', N'Edit Users', 4849)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_UsuarioLista_btnEliminarUsuario', N'Delete Users', 5270)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Permiso_UsuarioLista_btnNuevoUsuario', N'Agregar Users', 5080)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'RequiredFieldValidatorErrorPassword', N'Password is required', 5674)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'RequiredFieldValidatorErrorUsuario', N'User is required', 5131)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'RequiredFieldValidatorLenguajeNombre', N'Name is required', 5257)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'RequiredFieldValidatorNuevaLeyenda', N'Required value', 4924)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloAsignarPermisosUsuario', N'Assign Permissions to Users', 5672)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloEditarGrupo', N'Edit Permission', 3336)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloEditarIdioma', N'Edit Language', 3145)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloEditarUsuario', N'Edit User', 2905)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloNuevoGrupo', N'Add Group', 2595)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloNuevoIdioma', N'Add Language', 2944)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloNuevoUsuario', N'Add User', 2704)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtContrase&#241;a', N'Insert Password', 3125)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtContraseña', N'Enter Password', 2964)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtGrupoNombre', N'Insert Group Name', 3141)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtLenguajeNombre', N'Insert language name', 3770)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtNuevoTextoLeyenda', N'Insert New text', 3609)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtUsuario', N'Insert USer', 2190)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtUsuarioID', N'User ID', 1875)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtUsuarioNombre', N'User Name', 2589)
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH]) VALUES (1, N'kS6FG3aa4JEjWYI4llCKGQ==', 1, N'21232F297A57A5A743894A0E4A801FC3', 0, 1, 2835)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH]) VALUES (2, N'Kaz8ncNkb3/4ED01oy0kgg==', 2, N'D432EB18017C004FD305969713A17AA8', 0, 1, 3024)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH]) VALUES (3, N'rzvaiyUnfYzlENk8GepKPw==', 1, N'AA47F8215C6F30A0DCDB2A36A9F4168E', 0, 1, 3013)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[UsuarioElemento] ([IDElemento], [IDUsuario], [DVH]) VALUES (187, 3, 0)
INSERT [dbo].[UsuarioElemento] ([IDElemento], [IDUsuario], [DVH]) VALUES (2168, 3, 0)
INSERT [dbo].[UsuarioElemento] ([IDElemento], [IDUsuario], [DVH]) VALUES (2491, 3, 0)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_Elemento_descripcion]    Script Date: 10/1/2017 12:09:38 AM ******/
ALTER TABLE [dbo].[Elemento] ADD  CONSTRAINT [UC_Elemento_descripcion] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_Habilitado]  DEFAULT ((0)) FOR [Habilitado]
GO
ALTER TABLE [dbo].[Categoria]  WITH CHECK ADD  CONSTRAINT [Cliente_Categoria_FK1] FOREIGN KEY([IDCliente])
REFERENCES [dbo].[Cliente] ([ID])
GO
ALTER TABLE [dbo].[Categoria] CHECK CONSTRAINT [Cliente_Categoria_FK1]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [Provincia_Cliente_FK1] FOREIGN KEY([IDProvincia])
REFERENCES [dbo].[Provincia] ([ID])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [Provincia_Cliente_FK1]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [Usuario_Cliente_FK1] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuario] ([ID])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [Usuario_Cliente_FK1]
GO
ALTER TABLE [dbo].[ConcursoDistribuidor]  WITH CHECK ADD  CONSTRAINT [Concurso_ConcursoDistribuidor_FK1] FOREIGN KEY([IDConcurso])
REFERENCES [dbo].[Concurso] ([ID])
GO
ALTER TABLE [dbo].[ConcursoDistribuidor] CHECK CONSTRAINT [Concurso_ConcursoDistribuidor_FK1]
GO
ALTER TABLE [dbo].[ConcursoDistribuidor]  WITH CHECK ADD  CONSTRAINT [Distribuidor_ConcursoDistribuidor_FK1] FOREIGN KEY([IDDistribuidor])
REFERENCES [dbo].[Distribuidor] ([ID])
GO
ALTER TABLE [dbo].[ConcursoDistribuidor] CHECK CONSTRAINT [Distribuidor_ConcursoDistribuidor_FK1]
GO
ALTER TABLE [dbo].[ConcursoProducto]  WITH CHECK ADD  CONSTRAINT [Concurso_ConcursoProducto_FK1] FOREIGN KEY([IDConcurso])
REFERENCES [dbo].[Concurso] ([ID])
GO
ALTER TABLE [dbo].[ConcursoProducto] CHECK CONSTRAINT [Concurso_ConcursoProducto_FK1]
GO
ALTER TABLE [dbo].[ConcursoProducto]  WITH CHECK ADD  CONSTRAINT [Producto_ConcursoProducto_FK1] FOREIGN KEY([IDProducto])
REFERENCES [dbo].[Producto] ([ID])
GO
ALTER TABLE [dbo].[ConcursoProducto] CHECK CONSTRAINT [Producto_ConcursoProducto_FK1]
GO
ALTER TABLE [dbo].[Distribuidor]  WITH CHECK ADD  CONSTRAINT [Cliente_Distribuidor_FK1] FOREIGN KEY([IDCliente])
REFERENCES [dbo].[Cliente] ([ID])
GO
ALTER TABLE [dbo].[Distribuidor] CHECK CONSTRAINT [Cliente_Distribuidor_FK1]
GO
ALTER TABLE [dbo].[Distribuidor]  WITH CHECK ADD  CONSTRAINT [Provincia_Distribuidor_FK1] FOREIGN KEY([IDProvincia])
REFERENCES [dbo].[Provincia] ([ID])
GO
ALTER TABLE [dbo].[Distribuidor] CHECK CONSTRAINT [Provincia_Distribuidor_FK1]
GO
ALTER TABLE [dbo].[Distribuidor]  WITH CHECK ADD  CONSTRAINT [Usuario_Distribuidor_FK1] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuario] ([ID])
GO
ALTER TABLE [dbo].[Distribuidor] CHECK CONSTRAINT [Usuario_Distribuidor_FK1]
GO
ALTER TABLE [dbo].[ElementoElemento]  WITH CHECK ADD  CONSTRAINT [es hijo] FOREIGN KEY([IDHijo])
REFERENCES [dbo].[Elemento] ([ID])
GO
ALTER TABLE [dbo].[ElementoElemento] CHECK CONSTRAINT [es hijo]
GO
ALTER TABLE [dbo].[ElementoElemento]  WITH CHECK ADD  CONSTRAINT [es padre] FOREIGN KEY([IDPadre])
REFERENCES [dbo].[Elemento] ([ID])
GO
ALTER TABLE [dbo].[ElementoElemento] CHECK CONSTRAINT [es padre]
GO
ALTER TABLE [dbo].[Error]  WITH CHECK ADD  CONSTRAINT [Secuencia_Error_FK1] FOREIGN KEY([IDSecuencia])
REFERENCES [dbo].[Secuencia] ([ID])
GO
ALTER TABLE [dbo].[Error] CHECK CONSTRAINT [Secuencia_Error_FK1]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [Distribuidor_Factura_FK1] FOREIGN KEY([IDDistribuidor])
REFERENCES [dbo].[Distribuidor] ([ID])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [Distribuidor_Factura_FK1]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [PuntoDeVenta_Factura_FK1] FOREIGN KEY([IDPuntoVenta])
REFERENCES [dbo].[PuntoDeVenta] ([ID])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [PuntoDeVenta_Factura_FK1]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [Secuencia_Factura_FK1] FOREIGN KEY([IDSecuencia])
REFERENCES [dbo].[Secuencia] ([ID])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [Secuencia_Factura_FK1]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [Vendedor_Factura_FK1] FOREIGN KEY([IDVendedor])
REFERENCES [dbo].[Vendedor] ([ID])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [Vendedor_Factura_FK1]
GO
ALTER TABLE [dbo].[FacturaDetalle]  WITH CHECK ADD  CONSTRAINT [Factura_FacturaDetalle_FK1] FOREIGN KEY([IDFactura])
REFERENCES [dbo].[Factura] ([ID])
GO
ALTER TABLE [dbo].[FacturaDetalle] CHECK CONSTRAINT [Factura_FacturaDetalle_FK1]
GO
ALTER TABLE [dbo].[FacturaDetalle]  WITH CHECK ADD  CONSTRAINT [Producto_FacturaDetalle_FK1] FOREIGN KEY([IDProducto])
REFERENCES [dbo].[Producto] ([ID])
GO
ALTER TABLE [dbo].[FacturaDetalle] CHECK CONSTRAINT [Producto_FacturaDetalle_FK1]
GO
ALTER TABLE [dbo].[IdiomaLeyenda]  WITH CHECK ADD  CONSTRAINT [Idioma_Idioma_Leyenda_FK1] FOREIGN KEY([IDIdioma])
REFERENCES [dbo].[Idioma] ([ID])
GO
ALTER TABLE [dbo].[IdiomaLeyenda] CHECK CONSTRAINT [Idioma_Idioma_Leyenda_FK1]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [Categoria_Producto_FK1] FOREIGN KEY([IDCategoria])
REFERENCES [dbo].[Categoria] ([ID])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [Categoria_Producto_FK1]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [Cliente_Producto_FK1] FOREIGN KEY([IDCliente])
REFERENCES [dbo].[Cliente] ([ID])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [Cliente_Producto_FK1]
GO
ALTER TABLE [dbo].[PuntoDeVenta]  WITH CHECK ADD  CONSTRAINT [Distribuidor_PuntoDeVenta_FK1] FOREIGN KEY([IDDistribuidor])
REFERENCES [dbo].[Distribuidor] ([ID])
GO
ALTER TABLE [dbo].[PuntoDeVenta] CHECK CONSTRAINT [Distribuidor_PuntoDeVenta_FK1]
GO
ALTER TABLE [dbo].[PuntoDeVenta]  WITH CHECK ADD  CONSTRAINT [Provincia_PuntoDeVenta_FK1] FOREIGN KEY([IDProvincia])
REFERENCES [dbo].[Provincia] ([ID])
GO
ALTER TABLE [dbo].[PuntoDeVenta] CHECK CONSTRAINT [Provincia_PuntoDeVenta_FK1]
GO
ALTER TABLE [dbo].[PuntoDeVenta]  WITH CHECK ADD  CONSTRAINT [Secuencia_PuntoDeVenta_FK1] FOREIGN KEY([IDSecuencia])
REFERENCES [dbo].[Secuencia] ([ID])
GO
ALTER TABLE [dbo].[PuntoDeVenta] CHECK CONSTRAINT [Secuencia_PuntoDeVenta_FK1]
GO
ALTER TABLE [dbo].[PuntoDeVenta]  WITH CHECK ADD  CONSTRAINT [Vendedor_PuntoDeVenta_FK1] FOREIGN KEY([IDVendedor])
REFERENCES [dbo].[Vendedor] ([ID])
GO
ALTER TABLE [dbo].[PuntoDeVenta] CHECK CONSTRAINT [Vendedor_PuntoDeVenta_FK1]
GO
ALTER TABLE [dbo].[Secuencia]  WITH CHECK ADD  CONSTRAINT [Distribuidor_Secuencia_FK1] FOREIGN KEY([IDDistribuidor])
REFERENCES [dbo].[Distribuidor] ([ID])
GO
ALTER TABLE [dbo].[Secuencia] CHECK CONSTRAINT [Distribuidor_Secuencia_FK1]
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD  CONSTRAINT [Distribuidor_Stock_FK1] FOREIGN KEY([IDDistribuidor])
REFERENCES [dbo].[Distribuidor] ([ID])
GO
ALTER TABLE [dbo].[Stock] CHECK CONSTRAINT [Distribuidor_Stock_FK1]
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD  CONSTRAINT [Producto_Stock_FK1] FOREIGN KEY([IDProducto])
REFERENCES [dbo].[Producto] ([ID])
GO
ALTER TABLE [dbo].[Stock] CHECK CONSTRAINT [Producto_Stock_FK1]
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD  CONSTRAINT [Secuencia_Stock_FK1] FOREIGN KEY([IDSecuencia])
REFERENCES [dbo].[Secuencia] ([ID])
GO
ALTER TABLE [dbo].[Stock] CHECK CONSTRAINT [Secuencia_Stock_FK1]
GO
ALTER TABLE [dbo].[UsuarioElemento]  WITH CHECK ADD  CONSTRAINT [tiene] FOREIGN KEY([IDElemento])
REFERENCES [dbo].[Elemento] ([ID])
GO
ALTER TABLE [dbo].[UsuarioElemento] CHECK CONSTRAINT [tiene]
GO
ALTER TABLE [dbo].[UsuarioElemento]  WITH CHECK ADD  CONSTRAINT [Usuario_Elemento_Usuario_FK1] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuario] ([ID])
GO
ALTER TABLE [dbo].[UsuarioElemento] CHECK CONSTRAINT [Usuario_Elemento_Usuario_FK1]
GO
ALTER TABLE [dbo].[Vendedor]  WITH CHECK ADD  CONSTRAINT [Distribuidor_Vendedor_FK1] FOREIGN KEY([IDDistribuidor])
REFERENCES [dbo].[Distribuidor] ([ID])
GO
ALTER TABLE [dbo].[Vendedor] CHECK CONSTRAINT [Distribuidor_Vendedor_FK1]
GO
ALTER TABLE [dbo].[Vendedor]  WITH CHECK ADD  CONSTRAINT [Secuencia_Vendedor_FK1] FOREIGN KEY([IDSecuencia])
REFERENCES [dbo].[Secuencia] ([ID])
GO
ALTER TABLE [dbo].[Vendedor] CHECK CONSTRAINT [Secuencia_Vendedor_FK1]
GO
USE [master]
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET  READ_WRITE 
GO
