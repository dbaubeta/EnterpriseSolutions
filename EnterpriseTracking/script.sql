USE [master]
GO
/****** Object:  Database [EnterpriseSolutionsBD]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[BROperation]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Concurso]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[ConcursoDistribuidor]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[ConcursoProducto]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Config]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Distribuidor]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[DVV]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Elemento]    Script Date: 9/13/2017 9:45:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elemento](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](400) NULL,
	[Tipo] [int] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Elemento_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Elemento_Elemento]    Script Date: 9/13/2017 9:45:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elemento_Elemento](
	[IDPadre] [bigint] NOT NULL,
	[IDHijo] [bigint] NOT NULL,
	[Borrado] [bit] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Elemento_Elemento_PK] PRIMARY KEY CLUSTERED 
(
	[IDPadre] ASC,
	[IDHijo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Elemento_Usuario]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[EntradasBitacora]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Error]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Factura]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[FacturaDetalle]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Idioma]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Idioma_Leyenda]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Provincia]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[PuntoDeVenta]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Secuencia]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Stock]    Script Date: 9/13/2017 9:45:41 AM ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 9/13/2017 9:45:41 AM ******/
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
	[borrado] [bit] NULL,
	[DVH] [bigint] NOT NULL,
 CONSTRAINT [Usuario_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vendedor]    Script Date: 9/13/2017 9:45:41 AM ******/
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
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Idioma_Leyenda', 455452)
SET IDENTITY_INSERT [dbo].[Elemento] ON 

INSERT [dbo].[Elemento] ([ID], [Descripcion], [Tipo], [DVH]) VALUES (1, N'mnuButtonIdioma', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Descripcion], [Tipo], [DVH]) VALUES (2, N'Login_btnLogin', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Descripcion], [Tipo], [DVH]) VALUES (6, N'EditarLenguaje_btnAceptar', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Descripcion], [Tipo], [DVH]) VALUES (7, N'Login', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Descripcion], [Tipo], [DVH]) VALUES (13, N'EditarLenguaje', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Descripcion], [Tipo], [DVH]) VALUES (16, N'Administrador', 1, 0)
INSERT [dbo].[Elemento] ([ID], [Descripcion], [Tipo], [DVH]) VALUES (17, N'Usuario', 1, 0)
SET IDENTITY_INSERT [dbo].[Elemento] OFF
INSERT [dbo].[Elemento_Elemento] ([IDPadre], [IDHijo], [Borrado], [DVH]) VALUES (16, 1, NULL, 0)
INSERT [dbo].[Elemento_Elemento] ([IDPadre], [IDHijo], [Borrado], [DVH]) VALUES (16, 6, NULL, 0)
INSERT [dbo].[Elemento_Elemento] ([IDPadre], [IDHijo], [Borrado], [DVH]) VALUES (16, 13, NULL, 0)
INSERT [dbo].[Elemento_Elemento] ([IDPadre], [IDHijo], [Borrado], [DVH]) VALUES (16, 17, NULL, 0)
INSERT [dbo].[Elemento_Elemento] ([IDPadre], [IDHijo], [Borrado], [DVH]) VALUES (17, 2, NULL, 0)
INSERT [dbo].[Elemento_Elemento] ([IDPadre], [IDHijo], [Borrado], [DVH]) VALUES (17, 7, NULL, 0)
INSERT [dbo].[Elemento_Usuario] ([IDElemento], [IDUsuario], [Substrae], [Borrado], [DVH]) VALUES (16, 1, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Idioma] ON 

INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH]) VALUES (1, N'Español', 853)
INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH]) VALUES (2, N'Ingles', 610)
INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH]) VALUES (14, N'cualquiera', 1068)
INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH]) VALUES (15, N'Cualquiera 2', 1118)
SET IDENTITY_INSERT [dbo].[Idioma] OFF
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnAceptar', N'Aceptar', 1781)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnLogin', N'Ingresar', 1705)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje.aspx_dlIdiomas', N'Idiomas', 3674)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje.aspx_head', N'Head', 2818)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje.aspx_page1', N'Pagina 1', 3181)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_btnAceptar', N'Aceptar', 3288)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_btnCancelar', N'Cancelar', 3466)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_dlIdiomas', N'Lista de Idiomas', 3958)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_grdLeyendas', N'Leyendas', 3515)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_head', N'Head', 2328)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_lblLenguajeNombre', N'Nombre del Lenguaje', 5087)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_MainContent', N'None', 3076)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_page1', N'Pagina 1', 2691)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_RequiredFieldValidatorLenguajeNombre', N'Nombre del lenguaje requerido', 8064)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_RequiredFieldValidatorNuevaLeyenda', N'* Campo requerido', 6602)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_ShortDescription', N'cbcbcvcv', 4068)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_Text1', N'gfgdfg', 2639)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_TextBox2', N'llll', 2756)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_TextBoxxxxx', N'fdsfd', 3273)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_txtLenguajeNombre', N'Nombre del Lenguaje', 5125)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'EditarLenguaje_txtNuevoTextoLeyenda', N'a', 3768)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'errmessage', N'El usuario no existe', 3047)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'ErrorPassword', N'Contraseña requerida', 3585)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'ErrorUsuario', N'Usuario requerido', 3067)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna0', N'ID Leyenda', 2960)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna1', N'Texto leyenda referencia', 4460)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdLeyendas_columna2', N'Nuevo texto de leyenda', 4207)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblLenguajeNombre', N'Nombre de Lenguaje', 3472)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblLenguajeReferencia', N'Lenguaje de Referencia', 4274)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblMessage', N'El usuario no existe', 3000)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblPassword', N'Contraseña', 2383)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblRememberme', N'Recordarme ?', 2511)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblUsuario', N'Usuario', 1851)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_dlIdiomas', N'Idiomas', 2277)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_Email', N'Email', 1625)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_ErrorMessage', N'Error en el ingreso de los valores.', 5118)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_ErrorPassword', N'La contraseña es requerida.', 4716)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_ErrorUsuario', N'El usuario es requerido', 4156)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_FailureText', N'Datos invalidos', 3290)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_head', N'Head', 1421)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_lblPassword', N'Contraseña', 2983)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_lblRememberme', N'Recordarme?', 3079)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_lblUsuario', N'Usuario', 2451)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_MainContent', N'Nada', 2141)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_page1', N'Pagina1', 1752)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_Password', N'Contraseña', 2669)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_RegisterHyperLink', N'Registrar nuevo usuario', 4748)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_RememberMe', N'Recordarme', 2670)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_Text1', N'sdfsdfsd', 1968)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_TextBoxxxxx', N'xcvxcvxc', 2740)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'Login_Usuario', N'Usuario', 2137)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnuButtonIdioma', N'Idiomas', 2326)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'msjErrorContraseñaIncorrecta', N'La contraseña ingresada es incorrecta', 6830)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'msjErrorUsuarioIncorrecto', N'El usuario ingresado no existe.', 5655)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'page1', N'Pagina1', 1152)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'RequiredFieldValidatorLenguajeNombre', N'Nombre es requerido', 5589)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'RequiredFieldValidatorNuevaLeyenda', N'Dato requerido', 4917)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtLenguajeNombre', N'Ingrese nombre del lenguaje', 4431)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtNuevoTextoLeyenda', N'Ingrese nuevo texto', 4066)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtPassword', N'Ingrese contraseña', 3202)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtUsuario', N'Ingrese usuario', 2670)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_dlIdiomas', N'Lista de Idiomas', 3286)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_MainContent', N'Nada', 2376)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_miboton', N'Aceptar', 2348)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_miboton2', N'Aceptar', 2398)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_milabel', N'Hola como estas', 3036)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_page1', N'Pagina1', 1987)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_page11', N'Pagina11', 2085)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_page12', N'Pagina12', 2087)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_page13', N'Pagina13', 2089)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'WebForm2_page2', N'Pagina2', 1989)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_btnAceptar', N'Ok', 2771)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_btnCancelar', N'Cancel', 3256)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_dlIdiomas', N'None', 2875)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_grdLeyendas', N'Legends', 3401)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_head', N'Head', 2329)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_lblLenguajeNombre', N'Language name', 4546)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_MainContent', N'None', 3077)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_page1', N'Page 1', 2481)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_RequiredFieldValidatorLenguajeNombre', N'Language name is required.', 7678)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_RequiredFieldValidatorNuevaLeyenda', N'Field required', 6406)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_txtLenguajeNombre', N'Language name', 4584)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'EditarLenguaje_txtNuevoTextoLeyenda', N'None', 4072)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_dlIdiomas', N'Languages', 2487)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_Email', N'Email', 1626)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_ErrorMessage', N'Error on login', 3225)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_ErrorPassword', N'Password required', 3771)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_ErrorUsuario', N'User required.', 3274)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_FailureText', N'Login Failure', 3032)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_lblPassword', N'Password', 2666)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_lblRememberme', N'Remember me?', 3109)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_lblUsuario', N'User', 2123)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_MainContent', N'None', 2170)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_page1', N'Page1', 1542)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_Password', N'Password', 2352)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_RegisterHyperLink', N'Register as a new user', 4456)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_RememberMe', N'Remember me', 2700)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'Login_Usuario', N'User', 1809)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_dlIdiomas', N'Oki', 2094)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_MainContent', N'Oki', 2296)
GO
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_miboton', N'OK', 1799)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_miboton2', N'Oki', 1986)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_milabel', N'Hello how are you', 3202)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_page1', N'Page1', 1777)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_page11', N'Page11', 1875)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_page12', N'Page12', 1877)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_page13', N'Page13', 1879)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'WebForm2_page2', N'Page2', 1779)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje.aspx_dlIdiomas', N'j', 3119)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje.aspx_head', N'jh', 2707)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje.aspx_page1', N'kjkj', 2983)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_btnAceptar', N'k', 2740)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_btnCancelar', N'm', 2831)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_dlIdiomas', N'b', 2621)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_grdLeyendas', N',mn', 3006)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_head', N'h', 2111)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_lblLenguajeNombre', N'gkj', 3657)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_MainContent', N'h', 2829)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_page1', N'nb v', 2425)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_RequiredFieldValidatorLenguajeNombre', N'gj', 5487)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_RequiredFieldValidatorNuevaLeyenda', N'fmnb', 5492)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_ShortDescription', N'ugh', 3613)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_Text1', N'j', 2181)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_TextBox2', N'lkh', 2692)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_TextBoxxxxx', N'lg', 3014)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_txtLenguajeNombre', N'klh', 3698)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'EditarLenguaje_txtNuevoTextoLeyenda', N'g', 3823)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_dlIdiomas', N'hg', 1823)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_Email', N'hg', 1393)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_ErrorMessage', N'hg', 2136)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_ErrorPassword', N'jh', 2281)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_ErrorUsuario', N'gkj', 2280)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_FailureText', N'hg', 2038)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_head', N'jkhg', 1520)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_lblPassword', N'jh', 2073)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_lblRememberme', N'g', 2140)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_lblUsuario', N'lgj', 2073)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_MainContent', N'k', 1925)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_page1', N'dfsdf', 1679)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_Password', N'lhg', 1864)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_RegisterHyperLink', N'n', 2563)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_RememberMe', N'bvlhk', 2226)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_Text1', N'g', 1271)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_TextBoxxxxx', N'hg', 2103)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'Login_Usuario', N'lkhg', 1864)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_dlIdiomas', N'k', 1958)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_MainContent', N'hjgkl', 2581)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_miboton', N'gh', 1900)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_miboton2', N'kg', 1953)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_milabel', N'klhg', 2081)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_page1', N'k', 1502)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_page11', N'hg', 1651)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_page12', N'jlhg', 1866)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_page13', N'h', 1550)
INSERT [dbo].[Idioma_Leyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (15, N'WebForm2_page2', N'gl', 1607)
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [borrado], [DVH]) VALUES (1, N'daniel', 1, N'AA47F8215C6F30A0DCDB2A36A9F4168E', 0, NULL, 0)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_Elemento_descripcion]    Script Date: 9/13/2017 9:45:41 AM ******/
ALTER TABLE [dbo].[Elemento] ADD  CONSTRAINT [UC_Elemento_descripcion] UNIQUE NONCLUSTERED 
(
	[Descripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
