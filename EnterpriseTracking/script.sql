USE [master]
GO
/****** Object:  Database [EnterpriseSolutionsBD]    Script Date: 06/09/2017 10:42:31 p.m. ******/
CREATE DATABASE [EnterpriseSolutionsBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EnterpriseSolutionBD', FILENAME = N'D:\EnterpriseSolutionBD.mdf' , SIZE = 5056KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EnterpriseSolutionBD_log', FILENAME = N'D:\EnterpriseSolutionBD_log.ldf' , SIZE = 5056KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[BROperation]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Concurso]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[ConcursoDistribuidor]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[ConcursoProducto]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Config]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Distribuidor]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[DVV]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Elemento]    Script Date: 06/09/2017 10:42:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elemento](
	[ID] [bigint] NOT NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Borrado] [bit] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Elemento_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Elemento_Elemento]    Script Date: 06/09/2017 10:42:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elemento_Elemento](
	[IDPadre] [bigint] NOT NULL,
	[IDHijo] [bigint] NOT NULL,
	[Substrae] [bit] NULL,
	[Borrado] [bit] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Elemento_Elemento_PK] PRIMARY KEY CLUSTERED 
(
	[IDPadre] ASC,
	[IDHijo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Elemento_Usuario]    Script Date: 06/09/2017 10:42:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elemento_Usuario](
	[IDElemento] [bigint] NOT NULL,
	[IDUsuario] [bigint] NOT NULL,
	[Substrae] [bit] NULL,
	[Borrado] [bit] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Elemento_Usuario_PK] PRIMARY KEY CLUSTERED 
(
	[IDElemento] ASC,
	[IDUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EntradasBitacora]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Error]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Factura]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[FacturaDetalle]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Idioma]    Script Date: 06/09/2017 10:42:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [Idioma_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Idioma_Leyenda]    Script Date: 06/09/2017 10:42:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma_Leyenda](
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
/****** Object:  Table [dbo].[Producto]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Provincia]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[PuntoDeVenta]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Secuencia]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Stock]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 06/09/2017 10:42:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID] [bigint] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[IDIdioma] [bigint] NOT NULL,
	[password] [nvarchar](max) NULL,
	[IntentosFallidos] [smallint] NULL,
	[borrado] [bit] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Usuario_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vendedor]    Script Date: 06/09/2017 10:42:31 p.m. ******/
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
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'idioma', 3649)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Idioma_Leyenda', 56425)
SET IDENTITY_INSERT [dbo].[Idioma] ON 

INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH]) VALUES (1, N'Español', 853)
INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH]) VALUES (2, N'Ingles', 610)
SET IDENTITY_INSERT [dbo].[Idioma] OFF
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnAceptar', N'Aceptar', 1781)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnLogin', N'Ingresar', 1705)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'ErrorPassword', N'Contraseña requerida', 3585)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'ErrorUsuario', N'Usuario requerido', 3067)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna0', N'ID Leyenda', 2960)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna1', N'Texto Leyenda', 3352)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna2', N'Leyenda nuevo idioma', 4037)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblLenguajeNombre', N'Nombre Lenguaje', 3239)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblLenguajeReferencia', N'Lenguaje base', 3440)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblPassword', N'Contraseña', 2383)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblRememberme', N'Recordarme?', 2479)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblUsuario', N'Usuario', 1851)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'page1', N'Pagina1', 1152)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'RequiredFieldValidatorLenguajeNombre', N'Nombre requerido', 5341)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'RequiredFieldValidatorNuevaLeyenda', N'Campo requerido', 5021)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtLenguajeNombre', N'Nombre Lenguaje', 3277)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtNuevoTextoLeyenda', N'Nueva leyenda', 3445)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtPassword', N'Contraseña', 2421)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtUsuario', N'Usuario', 1889)
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
ALTER TABLE [dbo].[Elemento_Elemento]  WITH CHECK ADD  CONSTRAINT [es hijo] FOREIGN KEY([IDHijo])
REFERENCES [dbo].[Elemento] ([ID])
GO
ALTER TABLE [dbo].[Elemento_Elemento] CHECK CONSTRAINT [es hijo]
GO
ALTER TABLE [dbo].[Elemento_Elemento]  WITH CHECK ADD  CONSTRAINT [es padre] FOREIGN KEY([IDPadre])
REFERENCES [dbo].[Elemento] ([ID])
GO
ALTER TABLE [dbo].[Elemento_Elemento] CHECK CONSTRAINT [es padre]
GO
ALTER TABLE [dbo].[Elemento_Usuario]  WITH CHECK ADD  CONSTRAINT [tiene] FOREIGN KEY([IDElemento])
REFERENCES [dbo].[Elemento] ([ID])
GO
ALTER TABLE [dbo].[Elemento_Usuario] CHECK CONSTRAINT [tiene]
GO
ALTER TABLE [dbo].[Elemento_Usuario]  WITH CHECK ADD  CONSTRAINT [Usuario_Elemento_Usuario_FK1] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuario] ([ID])
GO
ALTER TABLE [dbo].[Elemento_Usuario] CHECK CONSTRAINT [Usuario_Elemento_Usuario_FK1]
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
ALTER TABLE [dbo].[Idioma_Leyenda]  WITH CHECK ADD  CONSTRAINT [Idioma_Idioma_Leyenda_FK1] FOREIGN KEY([IDIdioma])
REFERENCES [dbo].[Idioma] ([ID])
GO
ALTER TABLE [dbo].[Idioma_Leyenda] CHECK CONSTRAINT [Idioma_Idioma_Leyenda_FK1]
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
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [Idioma_Usuario_FK1] FOREIGN KEY([IDIdioma])
REFERENCES [dbo].[Idioma] ([ID])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [Idioma_Usuario_FK1]
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
