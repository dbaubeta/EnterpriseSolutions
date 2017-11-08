USE [master]
GO
/****** Object:  Database [EnterpriseSolutionsBD]    Script Date: 11/8/2017 1:32:42 AM ******/
CREATE DATABASE [EnterpriseSolutionsBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EnterpriseSolutionBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EnterpriseSolutionBD.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EnterpriseSolutionBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EnterpriseSolutionBD_log.ldf' , SIZE = 22464KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [EnterpriseSolutionsBD] SET  DISABLE_BROKER 
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 11/8/2017 1:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDReal] [nvarchar](max) NOT NULL,
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[Concurso]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[ConcursoDistribuidor]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[ConcursoProducto]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[Config]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[Distribuidor]    Script Date: 11/8/2017 1:32:42 AM ******/
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
	[borrado] [bit] NOT NULL,
	[DVH] [bigint] NOT NULL,
	[DiasFactura] [nvarchar](7) NOT NULL,
	[AreaVentasCentroLat] [float] NOT NULL,
	[AreaVentasCentroLong] [float] NOT NULL,
	[AreaVentasRadio] [bigint] NOT NULL,
 CONSTRAINT [Distribuidor_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DVV]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[Elemento]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[ElementoElemento]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[EntradasBitacora]    Script Date: 11/8/2017 1:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntradasBitacora](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[FechaHora] [datetime] NOT NULL,
	[Modulo] [nvarchar](max) NOT NULL,
	[Mensaje] [nvarchar](max) NOT NULL,
	[Datos] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[IDUsuario] [bigint] NOT NULL,
 CONSTRAINT [EntradasBitacora_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Error]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[Factura]    Script Date: 11/8/2017 1:32:42 AM ******/
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
	[IDDistribuidor] [bigint] NOT NULL,
	[IDVendedor] [bigint] NOT NULL,
 CONSTRAINT [Factura_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FacturaDetalle]    Script Date: 11/8/2017 1:32:42 AM ******/
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
 CONSTRAINT [FacturaDetalle_PK] PRIMARY KEY CLUSTERED 
(
	[IDFactura] ASC,
	[Linea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 11/8/2017 1:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NULL,
	[borrado] [bit] NULL,
	[culture] [nvarchar](max) NULL,
 CONSTRAINT [Idioma_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IdiomaLeyenda]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[Justificacion]    Script Date: 11/8/2017 1:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Justificacion](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDDistribuidor] [bigint] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Motivo] [nvarchar](max) NOT NULL,
	[DVH] [bigint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producto]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[Provincia]    Script Date: 11/8/2017 1:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
 CONSTRAINT [Provincia_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PuntoDeVenta]    Script Date: 11/8/2017 1:32:42 AM ******/
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
	[IDVendedor] [bigint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Latitud] [float] NOT NULL,
	[Longitud] [float] NOT NULL,
 CONSTRAINT [PuntoDeVenta_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Secuencia]    Script Date: 11/8/2017 1:32:42 AM ******/
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
	[IDDistribuidor] [bigint] NOT NULL,
 CONSTRAINT [Secuencia_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 11/8/2017 1:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stock](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Tipo] [varchar](max) NOT NULL,
	[Cantidad] [bigint] NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[DVH] [bigint] NOT NULL,
	[Borrado] [bit] NOT NULL,
	[IDDistribuidor] [bigint] NOT NULL,
	[IDProducto] [bigint] NOT NULL,
 CONSTRAINT [Stock_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 11/8/2017 1:32:42 AM ******/
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
	[borrado] [bit] NOT NULL,
 CONSTRAINT [Usuario_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UsuarioElemento]    Script Date: 11/8/2017 1:32:42 AM ******/
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
/****** Object:  Table [dbo].[Vendedor]    Script Date: 11/8/2017 1:32:42 AM ******/
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
 CONSTRAINT [Vendedor_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([ID], [IDReal], [IDCliente], [Nombre], [DVH], [Borrado]) VALUES (1, N'100', 1, N'Galletitas Dulces', 2359, 0)
INSERT [dbo].[Categoria] ([ID], [IDReal], [IDCliente], [Nombre], [DVH], [Borrado]) VALUES (2, N'100', 1, N'Galletitas Dulces', 2284, 1)
INSERT [dbo].[Categoria] ([ID], [IDReal], [IDCliente], [Nombre], [DVH], [Borrado]) VALUES (3, N'200', 1, N'Golosinas', 1629, 0)
SET IDENTITY_INSERT [dbo].[Categoria] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([ID], [Nombre], [Mail], [DVH], [Borrado], [IDProvincia], [IDUsuario]) VALUES (1, N'Terrabusi', N'info@terrabusi.com', 3371, 0, 1, 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Mail], [DVH], [Borrado], [IDProvincia], [IDUsuario]) VALUES (2, N'Arcor', N'info@arcor.com', 2488, 0, 1, 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Mail], [DVH], [Borrado], [IDProvincia], [IDUsuario]) VALUES (6, N'gfdgdf', N'dfgdfgdf', 1942, 1, 5, 3)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Mail], [DVH], [Borrado], [IDProvincia], [IDUsuario]) VALUES (7, N'fsdfsd', N'fsdfsdfsd', 2100, 1, 1, 2)
SET IDENTITY_INSERT [dbo].[Cliente] OFF
SET IDENTITY_INSERT [dbo].[Distribuidor] ON 

INSERT [dbo].[Distribuidor] ([ID], [IDReal], [Nombre], [IDProvincia], [IDUsuario], [IDCliente], [Mail], [borrado], [DVH], [DiasFactura], [AreaVentasCentroLat], [AreaVentasCentroLong], [AreaVentasRadio]) VALUES (2, N'100', N'La Dolce', 1, 6, 1, N'dolce@gmail.com', 1, 2875, N'1111111', 0, 0, 0)
INSERT [dbo].[Distribuidor] ([ID], [IDReal], [Nombre], [IDProvincia], [IDUsuario], [IDCliente], [Mail], [borrado], [DVH], [DiasFactura], [AreaVentasCentroLat], [AreaVentasCentroLong], [AreaVentasRadio]) VALUES (3, N'100', N'La Dolce', 1, 6, 1, N'ladolce@gmail.com', 0, 5460, N'0111110', -34.6032587366877, -58.3950752019882, 3000)
INSERT [dbo].[Distribuidor] ([ID], [IDReal], [Nombre], [IDProvincia], [IDUsuario], [IDCliente], [Mail], [borrado], [DVH], [DiasFactura], [AreaVentasCentroLat], [AreaVentasCentroLong], [AreaVentasRadio]) VALUES (4, N'200', N'Potigian', 1, 7, 1, N'potigian@gmail.com', 0, 5736, N'1111111', -34.608062633788315, -58.47747266292572, 4000)
SET IDENTITY_INSERT [dbo].[Distribuidor] OFF
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Cliente', 9901)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Elemento', 68584)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'ElementoElemento', 16757)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'EntradasBitacora', 1451676)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Factura', 4586)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'FacturaDetalle', 797)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'idioma', 3277)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'IdiomaLeyenda', 2017906)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'justificacion', 34168)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'PuntoDeVenta', 35487)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Secuencia', 11026)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Stock', 0)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Usuario', 22362)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'UsuarioElemento', 839)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Vendedor', 4674)
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
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (2534, N'BackupLista', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (2535, N'BackupLista_btnNuevoBackup', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (2536, N'BackupLista_btnEliminarBackup', 0, 0)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (2791, N'BackupLista_btnRestore', 0, 2314)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (2988, N'BitacoraLista', 0, 1362)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3059, N'ClienteLista', 0, 1265)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3060, N'ClienteLista_btnNuevoCliente', 0, 2917)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3061, N'ClienteLista_btnEditarCliente', 0, 2993)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3062, N'ClienteLista_btnEliminarCliente', 0, 3209)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3065, N'ClienteEdicion', 0, 1455)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3329, N'DistribuidorLista', 0, 1825)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3330, N'DistribuidorLista_btnNuevoDistribuidor', 0, 4037)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3331, N'DistribuidorLista_btnEditarDistribuidor', 0, 4113)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3332, N'DistribuidorLista_btnEliminarDistribuidor', 0, 4329)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3338, N'DistribuidorEdicion', 0, 2015)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3426, N'CategoriaLista', 0, 1468)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3427, N'CategoriaLista_btnNuevoCategoria', 0, 3323)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3428, N'CategoriaLista_btnEditarCategoria', 0, 3399)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3429, N'CategoriaLista_btnEliminarCategoria', 0, 3615)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3430, N'CategoriaEdicion', 0, 1658)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3508, N'ProductoLista', 0, 1405)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3509, N'ProductoLista_btnNuevoProducto', 0, 3197)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3510, N'ProductoLista_btnEditarProducto', 0, 3273)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3511, N'ProductoLista_btnEliminarProducto', 0, 3489)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3512, N'ProductoEdicion', 0, 1595)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3532, N'CargaManual', 0, 1132)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3575, N'TransmisionesLista', 0, 1948)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (3685, N'InvasionZonas', 0, 1410)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (4056, N'PanelControl', 0, 1281)
INSERT [dbo].[Elemento] ([ID], [Nombre], [Tipo], [DVH]) VALUES (4158, N'StockLista', 0, 1073)
SET IDENTITY_INSERT [dbo].[Elemento] OFF
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1, 209)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 3, 211)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 4, 212)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 5, 213)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 6, 214)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 11, 258)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 348, 319)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 349, 320)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 350, 312)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 351, 313)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 509, 318)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1507, 365)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1508, 366)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1509, 367)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1510, 359)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 1519, 368)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 2168, 369)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 2491, 368)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 2534, 366)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 2535, 367)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 2536, 368)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 2791, 371)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 2988, 379)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 3059, 369)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 3060, 361)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 3061, 362)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 3062, 363)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (187, 3065, 366)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (188, 1, 210)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (188, 3532, 366)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 1, 203)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3329, 363)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3330, 355)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3331, 356)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3332, 357)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3338, 363)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3426, 361)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3427, 362)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3428, 363)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3429, 364)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3430, 356)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3508, 362)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3509, 363)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3510, 355)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3511, 356)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3512, 357)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3575, 366)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 3685, 368)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 4056, 361)
SET IDENTITY_INSERT [dbo].[EntradasBitacora] ON 

INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (15, CAST(0x0000A802002B4DA4 AS DateTime), N'Login', N'BIT_Login', N'', 2408, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (16, CAST(0x0000A802002C5A1E AS DateTime), N'Logout', N'BIT_Logout', N'', 2659, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (17, CAST(0x0000A802002CDDDC AS DateTime), N'Login', N'BIT_Login', N'', 2396, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (18, CAST(0x0000A802002EAA63 AS DateTime), N'Login', N'BIT_Login', N'', 2408, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (19, CAST(0x0000A8020031766B AS DateTime), N'Login', N'BIT_Login', N'', 2392, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (20, CAST(0x0000A80200E71C3E AS DateTime), N'Login', N'BIT_Login', N'', 2410, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (21, CAST(0x0000A80200E801D0 AS DateTime), N'Logout', N'BIT_Logout', N'', 2669, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (22, CAST(0x0000A80200FA36C8 AS DateTime), N'Login', N'BIT_Login', N'', 2404, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (23, CAST(0x0000A80200FB890D AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (24, CAST(0x0000A80200FBEF86 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (25, CAST(0x0000A8020100400A AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (26, CAST(0x0000A802010049DC AS DateTime), N'Logout', N'BIT_Logout', N'', 2673, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (27, CAST(0x0000A802011926F2 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (28, CAST(0x0000A8020119C3AD AS DateTime), N'Logout', N'BIT_Logout', N'', 2674, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (29, CAST(0x0000A80E014BE6E3 AS DateTime), N'Login', N'BIT_Login', N'', 2473, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (30, CAST(0x0000A80E014BFE2F AS DateTime), N'Login', N'BIT_Login', N'', 2474, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (31, CAST(0x0000A80E014C3C9E AS DateTime), N'Login', N'BIT_Login', N'', 2478, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (32, CAST(0x0000A80E014C8D0A AS DateTime), N'Login', N'BIT_Login', N'', 2469, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (33, CAST(0x0000A80E014D7E71 AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (34, CAST(0x0000A80E014E1E05 AS DateTime), N'Login', N'BIT_Login', N'', 2476, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (35, CAST(0x0000A80E014E44C1 AS DateTime), N'Login', N'BIT_Login', N'', 2468, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (36, CAST(0x0000A80E0155BE97 AS DateTime), N'Login', N'BIT_Login', N'', 2472, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (37, CAST(0x0000A80E0156022D AS DateTime), N'Logout', N'BIT_Logout', N'', 2728, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (38, CAST(0x0000A80E0156ACF0 AS DateTime), N'Login', N'BIT_Login', N'', 2480, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (39, CAST(0x0000A80E01575020 AS DateTime), N'Login', N'BIT_Login', N'', 2483, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (40, CAST(0x0000A80E0157F456 AS DateTime), N'Login', N'BIT_Login', N'', 2473, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (41, CAST(0x0000A80E01585074 AS DateTime), N'Login', N'BIT_Login', N'', 2475, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (42, CAST(0x0000A80E0158A4C4 AS DateTime), N'Login', N'BIT_Login', N'', 2479, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (43, CAST(0x0000A80E01598163 AS DateTime), N'Login', N'BIT_Login', N'', 2481, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (44, CAST(0x0000A80E017DA039 AS DateTime), N'Login', N'BIT_Login', N'', 2518, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (45, CAST(0x0000A80E0189A6C9 AS DateTime), N'Login', N'BIT_Login', N'', 2513, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (46, CAST(0x0000A80E018A320B AS DateTime), N'Login', N'BIT_Login', N'', 2514, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (47, CAST(0x0000A80F00006601 AS DateTime), N'Login', N'BIT_Login', N'', 2497, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (48, CAST(0x0000A80F00029924 AS DateTime), N'Login', N'BIT_Login', N'', 2505, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (49, CAST(0x0000A80F00037342 AS DateTime), N'Login', N'BIT_Login', N'', 2496, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (50, CAST(0x0000A80F0003FA07 AS DateTime), N'Login', N'BIT_Login', N'', 2502, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (51, CAST(0x0000A80F000424FB AS DateTime), N'Login', N'BIT_Login', N'', 2498, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (52, CAST(0x0000A80F00052024 AS DateTime), N'Login', N'BIT_Login', N'', 2508, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (53, CAST(0x0000A80F000575B9 AS DateTime), N'Login', N'BIT_Login', N'', 2504, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (54, CAST(0x0000A80F0005B211 AS DateTime), N'Login', N'BIT_Login', N'', 2497, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (55, CAST(0x0000A80F00063946 AS DateTime), N'Login', N'BIT_Login', N'', 2503, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (56, CAST(0x0000A80F0006C49E AS DateTime), N'Login', N'BIT_Login', N'', 2504, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (57, CAST(0x0000A80F0006F86D AS DateTime), N'Login', N'BIT_Login', N'', 2498, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (58, CAST(0x0000A80F00078787 AS DateTime), N'Login', N'BIT_Login', N'', 2502, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (59, CAST(0x0000A80F00081063 AS DateTime), N'Login', N'BIT_Login', N'', 2501, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (60, CAST(0x0000A80F0008BAF7 AS DateTime), N'Login', N'BIT_Login', N'', 2502, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (61, CAST(0x0000A80F0008CDF7 AS DateTime), N'Logout', N'BIT_Logout', N'', 2753, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (62, CAST(0x0000A80F0008DAC0 AS DateTime), N'Login', N'BIT_Login', N'', 2497, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (63, CAST(0x0000A80F000980AA AS DateTime), N'Cliente', N'BIT_ClienteAlta', N'1', 3343, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (64, CAST(0x0000A80F000A02F2 AS DateTime), N'Login', N'BIT_Login', N'', 2505, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (65, CAST(0x0000A80F000A3C4B AS DateTime), N'Login', N'BIT_Login', N'', 2503, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (66, CAST(0x0000A80F000A7C92 AS DateTime), N'Cliente', N'BIT_ClienteAlta', N'2', 3341, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (67, CAST(0x0000A80F000F561E AS DateTime), N'Login', N'BIT_Login', N'', 2502, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (68, CAST(0x0000A80F0011B57D AS DateTime), N'Login', N'BIT_Login', N'', 2451, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (69, CAST(0x0000A80F00125CF9 AS DateTime), N'Login', N'BIT_Login', N'', 2449, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (70, CAST(0x0000A80F00190C2E AS DateTime), N'Login', N'BIT_Login', N'', 2443, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (71, CAST(0x0000A80F00194A14 AS DateTime), N'Login', N'BIT_Login', N'', 2446, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (72, CAST(0x0000A80F001A71B7 AS DateTime), N'Login', N'BIT_Login', N'', 2453, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (73, CAST(0x0000A80F001D9924 AS DateTime), N'Login', N'BIT_Login', N'', 2457, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (74, CAST(0x0000A80F001FBDE2 AS DateTime), N'Login', N'BIT_Login', N'', 2454, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (75, CAST(0x0000A80F001FC698 AS DateTime), N'Cliente', N'BIT_ClienteModificacion', N'2', 4129, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (76, CAST(0x0000A80F001FCECA AS DateTime), N'Cliente', N'BIT_ClienteModificacion', N'2', 4136, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (77, CAST(0x0000A80F001FE766 AS DateTime), N'Usuario', N'BIT_UsuarioAlta', N'4', 3373, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (78, CAST(0x0000A80F001FF199 AS DateTime), N'Usuario', N'BIT_UsuarioAlta', N'5', 3374, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (79, CAST(0x0000A80F001FFEE2 AS DateTime), N'Cliente', N'BIT_ClienteModificacion', N'1', 4135, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (80, CAST(0x0000A80F00200B4D AS DateTime), N'Cliente', N'BIT_ClienteModificacion', N'2', 4129, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (81, CAST(0x0000A80F002157AE AS DateTime), N'Cliente', N'BIT_ClienteAlta', N'6', 3290, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (82, CAST(0x0000A80F00215FE3 AS DateTime), N'Cliente', N'BIT_ClienteModificacion', N'6', 4123, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (83, CAST(0x0000A80F0022A7B6 AS DateTime), N'Login', N'BIT_Login', N'', 2445, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (84, CAST(0x0000A80F0022BF91 AS DateTime), N'Cliente', N'BIT_ClienteEliminacion', N'6', 4035, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (85, CAST(0x0000A80F00233443 AS DateTime), N'Login', N'BIT_Login', N'', 2447, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (86, CAST(0x0000A80F00233D4A AS DateTime), N'Cliente', N'BIT_ClienteAlta', N'7', 3302, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (87, CAST(0x0000A80F002342EA AS DateTime), N'Cliente', N'BIT_ClienteEliminacion', N'7', 4039, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (88, CAST(0x0000A80F0023B25E AS DateTime), N'Login', N'BIT_Login', N'', 2460, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (89, CAST(0x0000A812014B418F AS DateTime), N'Login', N'BIT_Login', N'', 2462, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (90, CAST(0x0000A812014D83CF AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (91, CAST(0x0000A812014ED15A AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (92, CAST(0x0000A812014F9D67 AS DateTime), N'Login', N'BIT_Login', N'', 2467, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (93, CAST(0x0000A81300B0942C AS DateTime), N'Login', N'BIT_Login', N'', 2495, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (94, CAST(0x0000A81301515B32 AS DateTime), N'Login', N'BIT_Login', N'', 2471, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (95, CAST(0x0000A8130151B9D0 AS DateTime), N'Login', N'BIT_Login', N'', 2475, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (96, CAST(0x0000A81301560293 AS DateTime), N'Login', N'BIT_Login', N'', 2467, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (97, CAST(0x0000A813015C20F0 AS DateTime), N'Login', N'BIT_Login', N'', 2473, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (98, CAST(0x0000A813015FD04F AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (99, CAST(0x0000A813015FFA33 AS DateTime), N'Usuario', N'BIT_UsuarioAlta', N'6', 3379, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (100, CAST(0x0000A8130160514B AS DateTime), N'Logout', N'BIT_Logout', N'', 2725, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (101, CAST(0x0000A8130160646B AS DateTime), N'Login', N'BIT_Login', N'', 2461, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (102, CAST(0x0000A8130160BC6A AS DateTime), N'Login', N'BIT_Login', N'', 2468, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (103, CAST(0x0000A8130160D5E9 AS DateTime), N'Distribuidor', N'BIT_DistribuidorAlta', N'2', 4434, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (104, CAST(0x0000A81301611EB9 AS DateTime), N'Logout', N'BIT_Logout', N'', 2724, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (105, CAST(0x0000A81301623452 AS DateTime), N'Login', N'BIT_Login', N'', 2476, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (106, CAST(0x0000A81301654BB8 AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (107, CAST(0x0000A8130165AECF AS DateTime), N'Login', N'BIT_Login', N'', 2469, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (108, CAST(0x0000A8130165CA58 AS DateTime), N'Logout', N'BIT_Logout', N'', 2723, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (109, CAST(0x0000A81301664C2B AS DateTime), N'Login', N'BIT_Login', N'', 2467, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (110, CAST(0x0000A8130166563A AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'2', 5272, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (111, CAST(0x0000A81301665D53 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'2', 5269, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (112, CAST(0x0000A813016663B0 AS DateTime), N'Distribuidor', N'BIT_DistribuidorEliminacion', N'2', 5173, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (113, CAST(0x0000A813016671FD AS DateTime), N'Distribuidor', N'BIT_DistribuidorAlta', N'3', 4430, 1)
GO
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (114, CAST(0x0000A8130167A11F AS DateTime), N'Usuario', N'BIT_UsuarioAlta', N'7', 3391, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (115, CAST(0x0000A8130167AB1A AS DateTime), N'Distribuidor', N'BIT_DistribuidorAlta', N'4', 4435, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (116, CAST(0x0000A8130167AFFD AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'4', 5274, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (117, CAST(0x0000A813018AD789 AS DateTime), N'Login', N'BIT_Login', N'', 2515, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (118, CAST(0x0000A814000BFD31 AS DateTime), N'Login', N'BIT_Login', N'', 2502, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (119, CAST(0x0000A814001D34D9 AS DateTime), N'Login', N'BIT_Login', N'', 2445, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (120, CAST(0x0000A814001D89D4 AS DateTime), N'Logout', N'BIT_Logout', N'', 2707, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (121, CAST(0x0000A814001D92B6 AS DateTime), N'Login', N'BIT_Login', N'', 2448, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (122, CAST(0x0000A814001E0F03 AS DateTime), N'Categoria', N'BIT_CategoriaAlta', N'1', 3701, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (123, CAST(0x0000A814001F5C51 AS DateTime), N'Categoria', N'BIT_CategoriaAlta', N'2', 3691, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (124, CAST(0x0000A8140020AE34 AS DateTime), N'Login', N'BIT_Login', N'', 2460, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (125, CAST(0x0000A8140020D141 AS DateTime), N'Categoria', N'BIT_CategoriaEliminacion', N'2', 4448, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (126, CAST(0x0000A8140020E853 AS DateTime), N'Categoria', N'BIT_CategoriaModificacion', N'1', 4541, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (127, CAST(0x0000A8140020EF42 AS DateTime), N'Categoria', N'BIT_CategoriaModificacion', N'1', 4538, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (128, CAST(0x0000A814003703E2 AS DateTime), N'Login', N'BIT_Login', N'', 2446, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (129, CAST(0x0000A8140037F37C AS DateTime), N'Login', N'BIT_Login', N'', 2446, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (130, CAST(0x0000A81400381120 AS DateTime), N'Logout', N'BIT_Logout', N'', 2706, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (131, CAST(0x0000A81400392F1B AS DateTime), N'Login', N'BIT_Login', N'', 2448, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (132, CAST(0x0000A8150134FB73 AS DateTime), N'Login', N'BIT_Login', N'', 2475, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (133, CAST(0x0000A8150139967B AS DateTime), N'Login', N'BIT_Login', N'', 2464, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (134, CAST(0x0000A8150139F9A9 AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (135, CAST(0x0000A815013A07A5 AS DateTime), N'Producto', N'BIT_ProductoAlta', N'2', 3582, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (136, CAST(0x0000A815013A2E3B AS DateTime), N'Producto', N'BIT_ProductoModificacion', N'2', 4423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (137, CAST(0x0000A815013A3210 AS DateTime), N'Producto', N'BIT_ProductoModificacion', N'2', 4427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (138, CAST(0x0000A81A015CA474 AS DateTime), N'Login', N'BIT_Login', N'', 2475, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (139, CAST(0x0000A81A015CDEC4 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (140, CAST(0x0000A81A01637E60 AS DateTime), N'Login', N'BIT_Login', N'', 2478, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (141, CAST(0x0000A81A0166551C AS DateTime), N'Login', N'BIT_Login', N'', 2481, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (142, CAST(0x0000A81A0167F394 AS DateTime), N'Login', N'BIT_Login', N'', 2472, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (143, CAST(0x0000A81A0182193D AS DateTime), N'Login', N'BIT_Login', N'', 2518, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (144, CAST(0x0000A81A0182AFFC AS DateTime), N'Login', N'BIT_Login', N'', 2520, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (145, CAST(0x0000A81A01837975 AS DateTime), N'Login', N'BIT_Login', N'', 2515, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (146, CAST(0x0000A81A0185A21A AS DateTime), N'Login', N'BIT_Login', N'', 2523, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (147, CAST(0x0000A81A0186325D AS DateTime), N'Login', N'BIT_Login', N'', 2519, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (148, CAST(0x0000A81B00070220 AS DateTime), N'Login', N'BIT_Login', N'', 2500, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (149, CAST(0x0000A81B00076DE7 AS DateTime), N'Login', N'BIT_Login', N'', 2501, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (150, CAST(0x0000A81B0007F1A5 AS DateTime), N'Login', N'BIT_Login', N'', 2510, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (151, CAST(0x0000A81B0008AC9F AS DateTime), N'Login', N'BIT_Login', N'', 2501, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (152, CAST(0x0000A81B0008DE04 AS DateTime), N'Login', N'BIT_Login', N'', 2503, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (153, CAST(0x0000A81B00098384 AS DateTime), N'Login', N'BIT_Login', N'', 2508, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (154, CAST(0x0000A81B0009A967 AS DateTime), N'Login', N'BIT_Login', N'', 2499, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (155, CAST(0x0000A81B000B91C7 AS DateTime), N'Login', N'BIT_Login', N'', 2503, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (156, CAST(0x0000A81B00F14012 AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (157, CAST(0x0000A81B00F182D4 AS DateTime), N'Login', N'BIT_Login', N'', 2477, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (158, CAST(0x0000A81B00F2E482 AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (159, CAST(0x0000A81B00F66176 AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (160, CAST(0x0000A81B00F6C85E AS DateTime), N'Login', N'BIT_Login', N'', 2472, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (161, CAST(0x0000A81B00F73894 AS DateTime), N'Login', N'BIT_Login', N'', 2463, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (162, CAST(0x0000A81B00F75C8F AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (163, CAST(0x0000A81B00F775EF AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (164, CAST(0x0000A81B0108F19B AS DateTime), N'Login', N'BIT_Login', N'', 2472, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (165, CAST(0x0000A81B010971DE AS DateTime), N'Login', N'BIT_Login', N'', 2473, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (166, CAST(0x0000A81B0109F821 AS DateTime), N'Login', N'BIT_Login', N'', 2469, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (167, CAST(0x0000A81B010A3A54 AS DateTime), N'Login', N'BIT_Login', N'', 2476, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (168, CAST(0x0000A81B010A8794 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (169, CAST(0x0000A81B010BF24E AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (170, CAST(0x0000A81B010C1C0E AS DateTime), N'Login', N'BIT_Login', N'', 2474, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (171, CAST(0x0000A81B010C917E AS DateTime), N'Login', N'BIT_Login', N'', 2479, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (172, CAST(0x0000A81B010CD719 AS DateTime), N'Login', N'BIT_Login', N'', 2480, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (173, CAST(0x0000A81B010D7ABA AS DateTime), N'Login', N'BIT_Login', N'', 2469, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (174, CAST(0x0000A81B010DE46E AS DateTime), N'Login', N'BIT_Login', N'', 2473, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (175, CAST(0x0000A81B010E2CD3 AS DateTime), N'Login', N'BIT_Login', N'', 2467, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (176, CAST(0x0000A81B010EB239 AS DateTime), N'Login', N'BIT_Login', N'', 2472, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (177, CAST(0x0000A81B010FA5B8 AS DateTime), N'Login', N'BIT_Login', N'', 2471, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (178, CAST(0x0000A81B01104882 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (179, CAST(0x0000A81B0110882C AS DateTime), N'Login', N'BIT_Login', N'', 2469, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (180, CAST(0x0000A81B0110D51C AS DateTime), N'Login', N'BIT_Login', N'', 2467, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (181, CAST(0x0000A81B015326A3 AS DateTime), N'Login', N'BIT_Login', N'', 2481, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (182, CAST(0x0000A81B01541059 AS DateTime), N'Login', N'BIT_Login', N'', 2481, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (183, CAST(0x0000A81B0154ECF7 AS DateTime), N'Login', N'BIT_Login', N'', 2474, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (184, CAST(0x0000A81B01557615 AS DateTime), N'Login', N'BIT_Login', N'', 2473, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (185, CAST(0x0000A81B0156E452 AS DateTime), N'Login', N'BIT_Login', N'', 2481, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (186, CAST(0x0000A81B01570778 AS DateTime), N'Login', N'BIT_Login', N'', 2484, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (187, CAST(0x0000A81B015ABC03 AS DateTime), N'Login', N'BIT_Login', N'', 2472, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (188, CAST(0x0000A81B015B9E36 AS DateTime), N'Logout', N'BIT_Logout', N'', 2737, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (189, CAST(0x0000A81B015BA311 AS DateTime), N'Login', N'BIT_Login', N'', 2474, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (190, CAST(0x0000A81B015C7F3D AS DateTime), N'Login', N'BIT_Login', N'', 2476, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (191, CAST(0x0000A81B015CE7D0 AS DateTime), N'Login', N'BIT_Login', N'', 2474, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (192, CAST(0x0000A81B015D34B6 AS DateTime), N'Login', N'BIT_Login', N'', 2472, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (193, CAST(0x0000A81B015E174F AS DateTime), N'Login', N'BIT_Login', N'', 2479, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (194, CAST(0x0000A81B015EE7DB AS DateTime), N'Login', N'BIT_Login', N'', 2480, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (195, CAST(0x0000A81B015FC89E AS DateTime), N'Login', N'BIT_Login', N'', 2477, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (196, CAST(0x0000A81B01600D45 AS DateTime), N'Login', N'BIT_Login', N'', 2476, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (197, CAST(0x0000A81B0160A2AE AS DateTime), N'Login', N'BIT_Login', N'', 2477, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (198, CAST(0x0000A81B0160BB0D AS DateTime), N'Logout', N'BIT_Logout', N'', 2733, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (199, CAST(0x0000A81B016D9465 AS DateTime), N'Login', N'BIT_Login', N'', 2507, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (200, CAST(0x0000A81B016DAF2D AS DateTime), N'Logout', N'BIT_Logout', N'', 2769, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (201, CAST(0x0000A81B01700FF5 AS DateTime), N'Login', N'BIT_Login', N'', 2509, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (202, CAST(0x0000A81B01705FEC AS DateTime), N'Logout', N'BIT_Logout', N'', 2767, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (203, CAST(0x0000A81B0176B866 AS DateTime), N'Login', N'BIT_Login', N'', 2520, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (204, CAST(0x0000A81B01770B09 AS DateTime), N'Login', N'BIT_Login', N'', 2523, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (205, CAST(0x0000A81B0177B1A5 AS DateTime), N'Login', N'BIT_Login', N'', 2520, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (206, CAST(0x0000A81B017991B2 AS DateTime), N'Login', N'BIT_Login', N'', 2517, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (207, CAST(0x0000A81B017AF76A AS DateTime), N'Login', N'BIT_Login', N'', 2527, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (208, CAST(0x0000A81B017B6E1B AS DateTime), N'Login', N'BIT_Login', N'', 2514, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (209, CAST(0x0000A81C0152C838 AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (210, CAST(0x0000A81C015303FB AS DateTime), N'Login', N'BIT_Login', N'', 2471, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (211, CAST(0x0000A81C015892C0 AS DateTime), N'Login', N'BIT_Login', N'', 2469, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (212, CAST(0x0000A81C01663486 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (213, CAST(0x0000A81C017F28E5 AS DateTime), N'Login', N'BIT_Login', N'', 2504, 1)
GO
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (214, CAST(0x0000A81D00D6C17E AS DateTime), N'Login', N'BIT_Login', N'', 2458, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (215, CAST(0x0000A81D00D79976 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (216, CAST(0x0000A81D00D8B8FF AS DateTime), N'Login', N'BIT_Login', N'', 2460, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (217, CAST(0x0000A81D011EC2E8 AS DateTime), N'Login', N'BIT_Login', N'', 2461, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (218, CAST(0x0000A81D01206106 AS DateTime), N'Login', N'BIT_Login', N'', 2475, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (219, CAST(0x0000A81D01612ECF AS DateTime), N'Login', N'BIT_Login', N'', 2471, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (220, CAST(0x0000A81D01614AF5 AS DateTime), N'Login', N'BIT_Login', N'', 2472, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (221, CAST(0x0000A81D0161680C AS DateTime), N'Producto', N'BIT_ProductoAlta', N'3', 3593, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (222, CAST(0x0000A81D01617A09 AS DateTime), N'Categoria', N'BIT_CategoriaAlta', N'3', 3726, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (223, CAST(0x0000A81D01618CB3 AS DateTime), N'Categoria', N'BIT_CategoriaModificacion', N'3', 4554, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (224, CAST(0x0000A81D01619FEF AS DateTime), N'Producto', N'BIT_ProductoModificacion', N'3', 4426, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (225, CAST(0x0000A81D0161B30A AS DateTime), N'Producto', N'BIT_ProductoAlta', N'4', 3599, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (226, CAST(0x0000A81D01625BA0 AS DateTime), N'Login', N'BIT_Login', N'', 2460, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (227, CAST(0x0000A81D01630552 AS DateTime), N'Login', N'BIT_Login', N'', 2469, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (228, CAST(0x0000A81D01639162 AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (229, CAST(0x0000A81D01689FDC AS DateTime), N'Login', N'BIT_Login', N'', 2477, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (230, CAST(0x0000A81D016A17BE AS DateTime), N'Login', N'BIT_Login', N'', 2471, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (231, CAST(0x0000A81D016A8161 AS DateTime), N'Login', N'BIT_Login', N'', 2475, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (232, CAST(0x0000A81D016B9C2E AS DateTime), N'Login', N'BIT_Login', N'', 2505, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (233, CAST(0x0000A81D016D2BC6 AS DateTime), N'Login', N'BIT_Login', N'', 2510, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (234, CAST(0x0000A81D016F61A1 AS DateTime), N'Login', N'BIT_Login', N'', 2512, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (235, CAST(0x0000A81E00CF5FA4 AS DateTime), N'Login', N'BIT_Login', N'', 2457, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (236, CAST(0x0000A81E00D0C94F AS DateTime), N'Login', N'BIT_Login', N'', 2453, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (237, CAST(0x0000A81E00D11D48 AS DateTime), N'Login', N'BIT_Login', N'', 2456, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (238, CAST(0x0000A81E00D18297 AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (239, CAST(0x0000A81E00D1B464 AS DateTime), N'Login', N'BIT_Login', N'', 2458, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (240, CAST(0x0000A81E00D1F304 AS DateTime), N'Login', N'BIT_Login', N'', 2462, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (241, CAST(0x0000A81E00D1FEB5 AS DateTime), N'CargaSecuenciasManual', N'BIT_SecuanciaAlta', N'1', 4907, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (242, CAST(0x0000A81E011DAE95 AS DateTime), N'Login', N'BIT_Login', N'', 2412, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (243, CAST(0x0000A81E011EBC1E AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (244, CAST(0x0000A81E011FE09F AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (245, CAST(0x0000A81E01203693 AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (246, CAST(0x0000A81E01212FAC AS DateTime), N'Login', N'BIT_Login', N'', 2415, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (247, CAST(0x0000A81E012191C5 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (248, CAST(0x0000A81E01221957 AS DateTime), N'Login', N'BIT_Login', N'', 2415, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (249, CAST(0x0000A81E01225E14 AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (250, CAST(0x0000A81E0122EBF7 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (251, CAST(0x0000A81E012330F9 AS DateTime), N'Login', N'BIT_Login', N'', 2408, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (252, CAST(0x0000A81E01238D78 AS DateTime), N'Login', N'BIT_Login', N'', 2410, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (253, CAST(0x0000A81E012472D2 AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (254, CAST(0x0000A81E0124B162 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (255, CAST(0x0000A81E0125203A AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (256, CAST(0x0000A81E01271FE1 AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (257, CAST(0x0000A81E012805C5 AS DateTime), N'CargaSecuenciasManual', N'BIT_SecuanciaAlta', N'1', 4869, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (258, CAST(0x0000A81E01282F2F AS DateTime), N'Logout', N'BIT_Logout', N'', 2677, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (259, CAST(0x0000A81E0138C8A4 AS DateTime), N'Login', N'BIT_Login', N'', 2428, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (260, CAST(0x0000A81E0139280E AS DateTime), N'Login', N'BIT_Login', N'', 2405, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (261, CAST(0x0000A81E013986AF AS DateTime), N'Login', N'BIT_Login', N'', 2408, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (262, CAST(0x0000A81E0139CDE1 AS DateTime), N'Login', N'BIT_Login', N'', 2410, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (263, CAST(0x0000A81E013AB05E AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (264, CAST(0x0000A81E013CA7EB AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (265, CAST(0x0000A81E013E981A AS DateTime), N'Login', N'BIT_Login', N'', 2426, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (266, CAST(0x0000A81E0142FBB5 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (267, CAST(0x0000A81E0143D517 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (268, CAST(0x0000A81E01442CA0 AS DateTime), N'Login', N'BIT_Login', N'', 2415, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (269, CAST(0x0000A81E0144B9F2 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (270, CAST(0x0000A81E01450FA4 AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (271, CAST(0x0000A81E0145B0B4 AS DateTime), N'Login', N'BIT_Login', N'', 2425, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (272, CAST(0x0000A81E01463C9E AS DateTime), N'Login', N'BIT_Login', N'', 2426, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (273, CAST(0x0000A81E014B7893 AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (274, CAST(0x0000A81E014B86CA AS DateTime), N'Logout', N'BIT_Logout', N'', 2673, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (275, CAST(0x0000A81E014C1854 AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (276, CAST(0x0000A81E014C9886 AS DateTime), N'Logout', N'BIT_Logout', N'', 2675, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (277, CAST(0x0000A81E014E6F75 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (278, CAST(0x0000A81E014F0D84 AS DateTime), N'CargaSecuenciasManual', N'BIT_SecuanciaAlta', N'1', 4867, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (279, CAST(0x0000A81E01513B40 AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (280, CAST(0x0000A81F0126708A AS DateTime), N'Login', N'BIT_Login', N'', 2411, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (281, CAST(0x0000A81F01290787 AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (282, CAST(0x0000A81F012B0902 AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (283, CAST(0x0000A81F012C73AA AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (284, CAST(0x0000A81F012CFFE0 AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (285, CAST(0x0000A81F012D69D3 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (286, CAST(0x0000A81F012DA82F AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (287, CAST(0x0000A82000C44D0E AS DateTime), N'Login', N'BIT_Login', N'', 2449, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (288, CAST(0x0000A82000C6399B AS DateTime), N'Login', N'BIT_Login', N'', 2457, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (289, CAST(0x0000A82000D2CE9C AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (290, CAST(0x0000A82000D776E6 AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (291, CAST(0x0000A82000D7DC60 AS DateTime), N'Login', N'BIT_Login', N'', 2415, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (292, CAST(0x0000A82000D88660 AS DateTime), N'Login', N'BIT_Login', N'', 2410, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (293, CAST(0x0000A82000D93495 AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (294, CAST(0x0000A82000DC8423 AS DateTime), N'Login', N'BIT_Login', N'', 2411, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (295, CAST(0x0000A82000DDA3EC AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (296, CAST(0x0000A82000DDE874 AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (297, CAST(0x0000A82000DE50CE AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (298, CAST(0x0000A82000DE8488 AS DateTime), N'Login', N'BIT_Login', N'', 2412, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (299, CAST(0x0000A82000DEE14D AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (300, CAST(0x0000A82000DF183D AS DateTime), N'Login', N'BIT_Login', N'', 2411, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (301, CAST(0x0000A82000DF5C21 AS DateTime), N'Login', N'BIT_Login', N'', 2410, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (302, CAST(0x0000A82000DF8852 AS DateTime), N'Login', N'BIT_Login', N'', 2412, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (303, CAST(0x0000A82000EA9431 AS DateTime), N'Login', N'BIT_Login', N'', 2410, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (304, CAST(0x0000A82000EBFD7C AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (305, CAST(0x0000A82000EC2BB5 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (306, CAST(0x0000A82000ED7124 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (307, CAST(0x0000A82000EE3C03 AS DateTime), N'Login', N'BIT_Login', N'', 2415, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (308, CAST(0x0000A82000EE9988 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (309, CAST(0x0000A82001093691 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (310, CAST(0x0000A8200109ACF3 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (311, CAST(0x0000A820010A4A10 AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (312, CAST(0x0000A8200117B4A3 AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (313, CAST(0x0000A82001180C87 AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
GO
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (314, CAST(0x0000A8200122DBFC AS DateTime), N'Login', N'BIT_Login', N'', 2429, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (315, CAST(0x0000A820012711CA AS DateTime), N'Login', N'BIT_Login', N'', 2422, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (316, CAST(0x0000A820012AD1D8 AS DateTime), N'Login', N'BIT_Login', N'', 2425, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (317, CAST(0x0000A820012BD2F6 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (318, CAST(0x0000A82001504BC8 AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (319, CAST(0x0000A8200153394C AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (320, CAST(0x0000A8200153D426 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (321, CAST(0x0000A82001540D3C AS DateTime), N'Logout', N'BIT_Logout', N'', 2681, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (322, CAST(0x0000A820015516DD AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (323, CAST(0x0000A82001555FB9 AS DateTime), N'Logout', N'BIT_Logout', N'', 2680, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (324, CAST(0x0000A820015561C1 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (325, CAST(0x0000A8200155FF48 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (326, CAST(0x0000A82001565CD7 AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (327, CAST(0x0000A8200156B556 AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (328, CAST(0x0000A82001570CF8 AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (329, CAST(0x0000A82001573289 AS DateTime), N'Login', N'BIT_Login', N'', 2425, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (330, CAST(0x0000A820015C2B68 AS DateTime), N'Login', N'BIT_Login', N'', 2426, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (331, CAST(0x0000A820015CB706 AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (332, CAST(0x0000A820015CF564 AS DateTime), N'Login', N'BIT_Login', N'', 2413, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (333, CAST(0x0000A82100CC645A AS DateTime), N'Login', N'BIT_Login', N'', 2458, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (334, CAST(0x0000A82100CEBB6C AS DateTime), N'Login', N'BIT_Login', N'', 2461, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (335, CAST(0x0000A8210149F55C AS DateTime), N'Login', N'BIT_Login', N'', 2411, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (336, CAST(0x0000A8210149F6FE AS DateTime), N'Login', N'BIT_Login', N'', 2412, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (337, CAST(0x0000A821014A5465 AS DateTime), N'Login', N'BIT_Login', N'', 2415, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (338, CAST(0x0000A821014BC657 AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (339, CAST(0x0000A821014C3290 AS DateTime), N'Login', N'BIT_Login', N'', 2428, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (340, CAST(0x0000A821014DD13D AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (341, CAST(0x0000A821014E7720 AS DateTime), N'Login', N'BIT_Login', N'', 2425, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (342, CAST(0x0000A821014EFF56 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (343, CAST(0x0000A821014F6D29 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (344, CAST(0x0000A82101525CC6 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (345, CAST(0x0000A8210152DFBA AS DateTime), N'Login', N'BIT_Login', N'', 2426, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (346, CAST(0x0000A8210152FF63 AS DateTime), N'Logout', N'BIT_Logout', N'', 2679, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (347, CAST(0x0000A8210154905C AS DateTime), N'Login', N'BIT_Login', N'', 2432, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (348, CAST(0x0000A8210154C67D AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (349, CAST(0x0000A8210155357F AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (350, CAST(0x0000A821015D5E17 AS DateTime), N'Login', N'BIT_Login', N'', 2412, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (351, CAST(0x0000A821015DC8F3 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (352, CAST(0x0000A821015E1E65 AS DateTime), N'Login', N'BIT_Login', N'', 2422, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (353, CAST(0x0000A821015E5886 AS DateTime), N'Login', N'BIT_Login', N'', 2422, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (354, CAST(0x0000A821015F73FE AS DateTime), N'Login', N'BIT_Login', N'', 2428, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (355, CAST(0x0000A8210162D646 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (356, CAST(0x0000A82101632E2B AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (357, CAST(0x0000A82101647F4A AS DateTime), N'Logout', N'BIT_Logout', N'', 2690, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (358, CAST(0x0000A82101648304 AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (359, CAST(0x0000A82101652D6D AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (360, CAST(0x0000A821016666D9 AS DateTime), N'Login', N'BIT_Login', N'', 2426, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (361, CAST(0x0000A8210166E976 AS DateTime), N'Login', N'BIT_Login', N'', 2428, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (362, CAST(0x0000A82101671C8D AS DateTime), N'Logout', N'BIT_Logout', N'', 2689, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (363, CAST(0x0000A821016A1290 AS DateTime), N'Login', N'BIT_Login', N'', 2428, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (364, CAST(0x0000A821016B085E AS DateTime), N'Login', N'BIT_Login', N'', 2459, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (365, CAST(0x0000A821016DA7B2 AS DateTime), N'Login', N'BIT_Login', N'', 2460, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (366, CAST(0x0000A821017038F6 AS DateTime), N'Login', N'BIT_Login', N'', 2463, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (367, CAST(0x0000A8210170DDF2 AS DateTime), N'Login', N'BIT_Login', N'', 2454, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (368, CAST(0x0000A82101736464 AS DateTime), N'Login', N'BIT_Login', N'', 2456, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (369, CAST(0x0000A8210174C53E AS DateTime), N'Login', N'BIT_Login', N'', 2462, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (370, CAST(0x0000A82101760745 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (371, CAST(0x0000A82101768907 AS DateTime), N'Login', N'BIT_Login', N'', 2467, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (372, CAST(0x0000A82101775E3B AS DateTime), N'Logout', N'BIT_Logout', N'', 2721, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (373, CAST(0x0000A8220006A0E3 AS DateTime), N'Login', N'BIT_Login', N'', 2451, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (374, CAST(0x0000A82200CAFCC0 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (375, CAST(0x0000A82200CC1A08 AS DateTime), N'Login', N'BIT_Login', N'', 2463, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (376, CAST(0x0000A82300B4B086 AS DateTime), N'Login', N'BIT_Login', N'', 2455, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (377, CAST(0x0000A82300B526C8 AS DateTime), N'Login', N'BIT_Login', N'', 2456, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (378, CAST(0x0000A82300B58A68 AS DateTime), N'Login', N'BIT_Login', N'', 2450, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (379, CAST(0x0000A82300B5BBC3 AS DateTime), N'Login', N'BIT_Login', N'', 2442, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (380, CAST(0x0000A82300B8AE77 AS DateTime), N'Login', N'BIT_Login', N'', 2446, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (381, CAST(0x0000A82300B99D9A AS DateTime), N'Login', N'BIT_Login', N'', 2455, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (382, CAST(0x0000A82300B9D3AA AS DateTime), N'Login', N'BIT_Login', N'', 2451, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (383, CAST(0x0000A82300BA26FD AS DateTime), N'Login', N'BIT_Login', N'', 2454, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (384, CAST(0x0000A82300BA5AB7 AS DateTime), N'Login', N'BIT_Login', N'', 2457, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (385, CAST(0x0000A82300BB35EC AS DateTime), N'Login', N'BIT_Login', N'', 2449, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (386, CAST(0x0000A82300BB5DFD AS DateTime), N'Login', N'BIT_Login', N'', 2442, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (387, CAST(0x0000A82300BBC27D AS DateTime), N'Login', N'BIT_Login', N'', 2451, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (388, CAST(0x0000A82300BCBE07 AS DateTime), N'Login', N'BIT_Login', N'', 2448, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (389, CAST(0x0000A82300BD32A3 AS DateTime), N'Login', N'BIT_Login', N'', 2452, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (390, CAST(0x0000A82300CBD9CA AS DateTime), N'Login', N'BIT_Login', N'', 2459, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (391, CAST(0x0000A82300CCC63D AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (392, CAST(0x0000A82300CD3A2B AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (393, CAST(0x0000A82300CDDFB1 AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (394, CAST(0x0000A82300CE5CAC AS DateTime), N'Login', N'BIT_Login', N'', 2459, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (395, CAST(0x0000A82300CEAF57 AS DateTime), N'Login', N'BIT_Login', N'', 2462, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (396, CAST(0x0000A82300CEE6FE AS DateTime), N'Login', N'BIT_Login', N'', 2468, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (397, CAST(0x0000A82300D0E3C1 AS DateTime), N'Login', N'BIT_Login', N'', 2462, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (398, CAST(0x0000A82300D17B35 AS DateTime), N'Login', N'BIT_Login', N'', 2464, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (399, CAST(0x0000A82300DBDF3E AS DateTime), N'Login', N'BIT_Login', N'', 2409, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (400, CAST(0x0000A82300EACF70 AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (401, CAST(0x0000A82300EE77DF AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (402, CAST(0x0000A82300EF6B31 AS DateTime), N'Login', N'BIT_Login', N'', 2413, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (403, CAST(0x0000A82300F0711D AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (404, CAST(0x0000A82300F0DA36 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (405, CAST(0x0000A82300F11C33 AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (406, CAST(0x0000A82300F1D193 AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (407, CAST(0x0000A82300F216C6 AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (408, CAST(0x0000A82300F55196 AS DateTime), N'Login', N'BIT_Login', N'', 2413, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (409, CAST(0x0000A82300F7DB18 AS DateTime), N'Login', N'BIT_Login', N'', 2413, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (410, CAST(0x0000A82300F81474 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5210, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (411, CAST(0x0000A82300F875A2 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (412, CAST(0x0000A82300F88095 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5217, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (413, CAST(0x0000A82300F89512 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5211, 1)
GO
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (414, CAST(0x0000A82301058616 AS DateTime), N'Login', N'BIT_Login', N'', 2413, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (415, CAST(0x0000A82301067634 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (416, CAST(0x0000A8230106D161 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (417, CAST(0x0000A8230115A6A4 AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (418, CAST(0x0000A8230115E8F9 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (419, CAST(0x0000A8230115E8F9 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (420, CAST(0x0000A8230116A414 AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (421, CAST(0x0000A8230116D622 AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (422, CAST(0x0000A82301172565 AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (423, CAST(0x0000A8230118C54C AS DateTime), N'Login', N'BIT_Login', N'', 2415, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (424, CAST(0x0000A82301199BD8 AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (425, CAST(0x0000A8230119B294 AS DateTime), N'CargaSecuenciasManual', N'BIT_SecuanciaAlta', N'1', 4866, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (426, CAST(0x0000A823011D52A0 AS DateTime), N'Login', N'BIT_Login', N'', 2429, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (427, CAST(0x0000A823011D8A90 AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (428, CAST(0x0000A823011DE415 AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (429, CAST(0x0000A823011E1F8D AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (430, CAST(0x0000A823011E6862 AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (431, CAST(0x0000A823012A1011 AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (432, CAST(0x0000A823012A73E3 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (433, CAST(0x0000A823012ABF9D AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (434, CAST(0x0000A823012B06DB AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (435, CAST(0x0000A823012B9109 AS DateTime), N'Login', N'BIT_Login', N'', 2414, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (436, CAST(0x0000A823012BD187 AS DateTime), N'CargaSecuenciasManual', N'BIT_SecuanciaAlta', N'1', 4863, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (437, CAST(0x0000A82301356731 AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (438, CAST(0x0000A82301368C7B AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (439, CAST(0x0000A82301375543 AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (440, CAST(0x0000A8230138D0BE AS DateTime), N'Login', N'BIT_Login', N'', 2431, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (441, CAST(0x0000A823014C2C66 AS DateTime), N'Login', N'BIT_Login', N'', 2425, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (442, CAST(0x0000A823014CAEFC AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (443, CAST(0x0000A823014F1641 AS DateTime), N'Login', N'BIT_Login', N'', 2412, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (444, CAST(0x0000A823014F1641 AS DateTime), N'Login', N'BIT_Login', N'', 2412, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (445, CAST(0x0000A823014F57BC AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (446, CAST(0x0000A82301557A85 AS DateTime), N'Login', N'BIT_Login', N'', 2425, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (447, CAST(0x0000A82301591C67 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (448, CAST(0x0000A82301596BC4 AS DateTime), N'Login', N'BIT_Login', N'', 2433, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (449, CAST(0x0000A823015C9E2F AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (450, CAST(0x0000A823015EFB8B AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (451, CAST(0x0000A8230160586A AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (452, CAST(0x0000A8230160E6A6 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (453, CAST(0x0000A8230162CA07 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (454, CAST(0x0000A82301663EC9 AS DateTime), N'Login', N'BIT_Login', N'', 2429, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (455, CAST(0x0000A823016CDE68 AS DateTime), N'Login', N'BIT_Login', N'', 2467, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (456, CAST(0x0000A823016E6B17 AS DateTime), N'Login', N'BIT_Login', N'', 2461, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (457, CAST(0x0000A82301767B0A AS DateTime), N'Login', N'BIT_Login', N'', 2466, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (458, CAST(0x0000A8230177E389 AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (459, CAST(0x0000A8230178DB4A AS DateTime), N'Login', N'BIT_Login', N'', 2463, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (460, CAST(0x0000A823017985F3 AS DateTime), N'Login', N'BIT_Login', N'', 2464, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (461, CAST(0x0000A8230179B76C AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (462, CAST(0x0000A823017B1FD7 AS DateTime), N'Login', N'BIT_Login', N'', 2454, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (463, CAST(0x0000A823017B75CA AS DateTime), N'Login', N'BIT_Login', N'', 2460, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (464, CAST(0x0000A823017C1034 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (465, CAST(0x0000A823017C4097 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5263, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (466, CAST(0x0000A8230189421B AS DateTime), N'Login', N'BIT_Login', N'', 2472, 3)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (467, CAST(0x0000A82301895B18 AS DateTime), N'Login', N'BIT_Login', N'', 2468, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (468, CAST(0x0000A82301897774 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5264, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (469, CAST(0x0000A8230189930A AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'4', 5270, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (470, CAST(0x0000A8230189CCA7 AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (471, CAST(0x0000A823018A7B62 AS DateTime), N'Login', N'BIT_Login', N'', 2469, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (472, CAST(0x0000A823018AD41C AS DateTime), N'Login', N'BIT_Login', N'', 2468, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (473, CAST(0x0000A8240002F223 AS DateTime), N'Login', N'BIT_Login', N'', 2447, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (474, CAST(0x0000A8240003B651 AS DateTime), N'Login', N'BIT_Login', N'', 2446, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (475, CAST(0x0000A824000410F8 AS DateTime), N'Login', N'BIT_Login', N'', 2456, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (476, CAST(0x0000A82400053FCC AS DateTime), N'Login', N'BIT_Login', N'', 2455, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (477, CAST(0x0000A8240005AB55 AS DateTime), N'Login', N'BIT_Login', N'', 2452, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (478, CAST(0x0000A8240005C54C AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5240, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (479, CAST(0x0000A8240006145D AS DateTime), N'Logout', N'BIT_Logout', N'', 2709, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (480, CAST(0x0000A824000628F0 AS DateTime), N'Login', N'BIT_Login', N'', 2450, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (481, CAST(0x0000A824000676A4 AS DateTime), N'Login', N'BIT_Login', N'', 2448, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (482, CAST(0x0000A824000683C6 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5249, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (483, CAST(0x0000A82400069A6F AS DateTime), N'Login', N'BIT_Login', N'', 2447, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (484, CAST(0x0000A8240006AEBC AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5253, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (485, CAST(0x0000A82400080EBD AS DateTime), N'Login', N'BIT_Login', N'', 2452, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (486, CAST(0x0000A824011ADCD3 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (487, CAST(0x0000A824011B8AB2 AS DateTime), N'Login', N'BIT_Login', N'', 2413, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (488, CAST(0x0000A824011BBD8D AS DateTime), N'Login', N'BIT_Login', N'', 2416, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (489, CAST(0x0000A824011DBAF9 AS DateTime), N'Login', N'BIT_Login', N'', 2419, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (490, CAST(0x0000A824011DF4CD AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5217, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (491, CAST(0x0000A824011E38CE AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5216, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (492, CAST(0x0000A824011E5CF8 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'3', 5219, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (493, CAST(0x0000A824011E7AC7 AS DateTime), N'Distribuidor', N'BIT_DistribuidorModificacion', N'4', 5214, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (494, CAST(0x0000A824012CE01A AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (495, CAST(0x0000A824012DB581 AS DateTime), N'Login', N'BIT_Login', N'', 2429, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (496, CAST(0x0000A824012DE0D2 AS DateTime), N'Login', N'BIT_Login', N'', 2425, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (497, CAST(0x0000A824012EB4BF AS DateTime), N'Login', N'BIT_Login', N'', 2420, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (498, CAST(0x0000A8240130E5CA AS DateTime), N'Login', N'BIT_Login', N'', 2417, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (499, CAST(0x0000A8240132544B AS DateTime), N'Login', N'BIT_Login', N'', 2426, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (500, CAST(0x0000A824015D22E6 AS DateTime), N'Login', N'BIT_Login', N'', 2423, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (501, CAST(0x0000A824015E67DE AS DateTime), N'Login', N'BIT_Login', N'', 2429, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (502, CAST(0x0000A824015EE78E AS DateTime), N'Login', N'BIT_Login', N'', 2429, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (503, CAST(0x0000A824015FB4BA AS DateTime), N'Login', N'BIT_Login', N'', 2418, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (504, CAST(0x0000A824016022B5 AS DateTime), N'Login', N'BIT_Login', N'', 2421, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (505, CAST(0x0000A82401615365 AS DateTime), N'Login', N'BIT_Login', N'', 2427, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (506, CAST(0x0000A82401619A05 AS DateTime), N'Login', N'BIT_Login', N'', 2428, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (507, CAST(0x0000A82401631BBB AS DateTime), N'Logout', N'BIT_Logout', N'', 2684, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (508, CAST(0x0000A82401632921 AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (509, CAST(0x0000A82401633A4C AS DateTime), N'Usuario', N'BIT_UsuarioModificacion', N'4', 4171, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (510, CAST(0x0000A82401635127 AS DateTime), N'Usuario', N'BIT_UsuarioModificacion', N'5', 4174, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (511, CAST(0x0000A824016358BB AS DateTime), N'Logout', N'BIT_Logout', N'', 2686, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (512, CAST(0x0000A82401635D5B AS DateTime), N'Login', N'BIT_Login', N'', 2426, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (513, CAST(0x0000A8240163BC47 AS DateTime), N'Login', N'BIT_Login', N'', 2425, 4)
GO
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (514, CAST(0x0000A8240163CCF8 AS DateTime), N'Logout', N'BIT_Logout', N'', 2688, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (515, CAST(0x0000A8240163D906 AS DateTime), N'Login', N'BIT_Login', N'', 2429, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (516, CAST(0x0000A8240163DFCC AS DateTime), N'Logout', N'BIT_Logout', N'', 2683, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (517, CAST(0x0000A8240163E4DD AS DateTime), N'Login', N'BIT_Login', N'', 2433, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (518, CAST(0x0000A8240163E7E6 AS DateTime), N'Logout', N'BIT_Logout', N'', 2693, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (519, CAST(0x0000A8240163EB38 AS DateTime), N'Login', N'BIT_Login', N'', 2426, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (520, CAST(0x0000A82401640EE1 AS DateTime), N'Logout', N'BIT_Logout', N'', 2683, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (521, CAST(0x0000A824016416E1 AS DateTime), N'Login', N'BIT_Login', N'', 2434, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (522, CAST(0x0000A8240164B2B3 AS DateTime), N'Login', N'BIT_Login', N'', 2431, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (523, CAST(0x0000A82401652D3A AS DateTime), N'Login', N'BIT_Login', N'', 2424, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (524, CAST(0x0000A82401654726 AS DateTime), N'Login', N'BIT_Login', N'', 2431, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (525, CAST(0x0000A8240166345E AS DateTime), N'Login', N'BIT_Login', N'', 2424, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (526, CAST(0x0000A824016737A3 AS DateTime), N'Login', N'BIT_Login', N'', 2433, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (527, CAST(0x0000A824016787F0 AS DateTime), N'Login', N'BIT_Login', N'', 2428, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (528, CAST(0x0000A8240168C8DE AS DateTime), N'Login', N'BIT_Login', N'', 2430, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (529, CAST(0x0000A82401690EC6 AS DateTime), N'Login', N'BIT_Login', N'', 2431, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (530, CAST(0x0000A8240169FF8A AS DateTime), N'Login', N'BIT_Login', N'', 2441, 4)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (531, CAST(0x0000A824016CE096 AS DateTime), N'Login', N'BIT_Login', N'', 2470, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (532, CAST(0x0000A824018AFF66 AS DateTime), N'Login', N'BIT_Login', N'', 2474, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (533, CAST(0x0000A824018B16B6 AS DateTime), N'Logout', N'BIT_Logout', N'', 2734, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (534, CAST(0x0000A825000012E0 AS DateTime), N'Login', N'BIT_Login', N'', 2447, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (535, CAST(0x0000A82500001CA2 AS DateTime), N'Logout', N'BIT_Logout', N'', 2704, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (536, CAST(0x0000A8250004B3EB AS DateTime), N'Login', N'BIT_Login', N'', 2455, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (537, CAST(0x0000A82500056D1C AS DateTime), N'Login', N'BIT_Login', N'', 2459, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (538, CAST(0x0000A82500059DFF AS DateTime), N'Login', N'BIT_Login', N'', 2451, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (539, CAST(0x0000A8250007FE54 AS DateTime), N'Login', N'BIT_Login', N'', 2457, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (540, CAST(0x0000A82500088A45 AS DateTime), N'Login', N'BIT_Login', N'', 2449, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (541, CAST(0x0000A825000C65A5 AS DateTime), N'Login', N'BIT_Login', N'', 2457, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (542, CAST(0x0000A825000D55E4 AS DateTime), N'Login', N'BIT_Login', N'', 2458, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (543, CAST(0x0000A825000DB934 AS DateTime), N'Login', N'BIT_Login', N'', 2465, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (544, CAST(0x0000A825000E4E57 AS DateTime), N'Login', N'BIT_Login', N'', 2452, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (545, CAST(0x0000A825000F2ECD AS DateTime), N'Login', N'BIT_Login', N'', 2457, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (546, CAST(0x0000A825000F8ABF AS DateTime), N'Login', N'BIT_Login', N'', 2459, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (547, CAST(0x0000A825000FA4A9 AS DateTime), N'Login', N'BIT_Login', N'', 2463, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (548, CAST(0x0000A825000FBF2D AS DateTime), N'Login', N'BIT_Login', N'', 2462, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (549, CAST(0x0000A82500103BA9 AS DateTime), N'Login', N'BIT_Login', N'', 2460, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (550, CAST(0x0000A8250011AF16 AS DateTime), N'Login', N'BIT_Login', N'', 2399, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (551, CAST(0x0000A82500123528 AS DateTime), N'Login', N'BIT_Login', N'', 2404, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (552, CAST(0x0000A825001415E7 AS DateTime), N'Login', N'BIT_Login', N'', 2401, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (553, CAST(0x0000A82500147FD5 AS DateTime), N'Login', N'BIT_Login', N'', 2406, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (554, CAST(0x0000A8250014BD03 AS DateTime), N'Login', N'BIT_Login', N'', 2399, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (555, CAST(0x0000A825001657F8 AS DateTime), N'Login', N'BIT_Login', N'', 2396, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (556, CAST(0x0000A82500168084 AS DateTime), N'Login', N'BIT_Login', N'', 2403, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (557, CAST(0x0000A8250016BCB4 AS DateTime), N'Login', N'BIT_Login', N'', 2404, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (558, CAST(0x0000A8250016F999 AS DateTime), N'Login', N'BIT_Login', N'', 2406, 1)
INSERT [dbo].[EntradasBitacora] ([id], [FechaHora], [Modulo], [Mensaje], [Datos], [DVH], [IDUsuario]) VALUES (559, CAST(0x0000A82500171A5F AS DateTime), N'Login', N'BIT_Login', N'', 2402, 1)
SET IDENTITY_INSERT [dbo].[EntradasBitacora] OFF
SET IDENTITY_INSERT [dbo].[Factura] ON 

INSERT [dbo].[Factura] ([ID], [NroFactura], [Fecha], [DVH], [Borrado], [IDPuntoVenta], [IDDistribuidor], [IDVendedor]) VALUES (1, N'0001A00000001', CAST(0x0000A6EE00000000 AS DateTime), 2291, 0, 1, 3, 2)
INSERT [dbo].[Factura] ([ID], [NroFactura], [Fecha], [DVH], [Borrado], [IDPuntoVenta], [IDDistribuidor], [IDVendedor]) VALUES (2, N'0001A00000002', CAST(0x0000A6F000000000 AS DateTime), 2295, 0, 2, 3, 2)
SET IDENTITY_INSERT [dbo].[Factura] OFF
INSERT [dbo].[FacturaDetalle] ([IDFactura], [Linea], [IDProducto], [Cantidad], [Precio], [DVH]) VALUES (1, 3, 4, 50, CAST(50.00 AS Decimal(10, 2)), 354)
INSERT [dbo].[FacturaDetalle] ([IDFactura], [Linea], [IDProducto], [Cantidad], [Precio], [DVH]) VALUES (2, 3, 4, 100, CAST(100.00 AS Decimal(10, 2)), 443)
SET IDENTITY_INSERT [dbo].[Idioma] ON 

INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH], [borrado], [culture]) VALUES (1, N'Español', 1752, 0, N'es-AR')
INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH], [borrado], [culture]) VALUES (2, N'Ingles', 1525, 0, N'en-US')
SET IDENTITY_INSERT [dbo].[Idioma] OFF
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'abril', N'Abril', 1061)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'agosto', N'Agosto', 1323)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'backupcompleto', N'Backup completo.', 3089)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'bit_login', N'El usuario ha ingresado al sistema.', 4279)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'bit_logout', N'El usuario ha cerrado la sesión.', 4219)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnaceptar', N'Aceptar', 1813)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnasignarpermisosusuario', N'Asignar Permisos', 4363)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btncancelar', N'Cancelar', 1991)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btndibujarmapa', N'Dibujar', 2230)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditarcategoria', N'Modificar', 2859)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditarcliente', N'Modificar Cliente', 3396)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditardistribuidor', N'Modificar', 3216)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditargrupo', N'Modificar Grupo', 3030)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditaridioma', N'Modificar Idioma', 3170)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditarproducto', N'Modificar', 2796)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditarusuario', N'Modificar', 2692)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminarbackup', N'Eliminar Backup', 3299)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminarcategoria', N'Eliminar', 2982)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminarcliente', N'Eliminar Cliente', 3519)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminardistribuidor', N'Eliminar', 3339)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminargrupo', N'Eliminar Grupo', 3153)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminaridioma', N'Eliminar Idioma', 3293)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminarproducto', N'Eliminar', 2919)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminarusuario', N'Eliminar', 2815)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnlogin', N'Ingresar', 1737)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalaceptar', N'Aceptar', 2338)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalaceptar2', N'Aceptar', 2388)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalcancelar', N'Cancelar', 2516)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalcancelar2', N'Cancelar', 2566)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalno', N'No', 1308)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalok', N'Aceptar', 1820)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalsi', N'Si', 1306)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevobackup', N'Nuevo Backup', 2715)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevocategoria', N'Nueva', 2384)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevocliente', N'Agregar Cliente', 3107)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevodistribuidor', N'Nuevo', 2755)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevogrupo', N'Nuevo Grupo', 2569)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevoidioma', N'Nuevo Idioma', 2709)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevoproducto', N'Nuevo', 2335)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevousuario', N'Nuevo Usuario', 3007)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnrestore', N'Restaurar backup', 2760)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnupload', N'Procesar Secuencia', 2793)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'cargaseqlistabienformado', N'1. Validacion de XML bien formado......', 5736)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'cargaseqlistadatos', N'3. Validacion de datos...', 4057)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'cargaseqlistavalido', N'2. Validacion de XML valido contra XSD......', 5617)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'clickparaeliminarjustificacion', N'(Click en icono para eliminar justificacion)', 7353)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'correcto', N'CORRECTO', 1523)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'culturainvalida', N'La cultura ingresada es invalida', 4724)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'detallefacturanoexisteproducto', N'La linea %0 de la factura %1 tiene un codigo de producto %2 inexistente.', 9513)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'detallesdesecuencia', N'Detalles de la secuencia', 4300)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'diciembre', N'Diciembre', 1881)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'domingocorto', N'DO', 1496)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'enero', N'Enero', 1091)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estaseguroborrarbackupseleccionado', N'Esta seguro que quiere eliminar el backup seleccionado?', 8946)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estaseguroborrarelementoseleccionado', N'Esta seguro que desea eliminar el item seleccionado?', 8837)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estaseguroborraridiomaseleccionado', N'Esta seguro que desea eliminar el idioma seleccionado?', 8803)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estasegurocrearnuevobackup', N'Esta seguro que desea crear un nuevo Backup?', 6948)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estasegurorestaurarbackupseleccionado', N'Esta seguro que quiere restaurar el backup seleccionado?', 9419)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estasegurosalir', N'Esta seguro que desea salir y perder los cambios?', 6270)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'facturascargados', N'Total de facturas cargadas', 4234)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'fallo', N'FALLO', 941)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'febrero', N'Febrero', 1499)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbackups_columna0', N'Fecha de Backup', 3339)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbackups_columna1', N'Path del archivo', 3524)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbitacora_columna0', N'Fecha/Hora', 3009)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbitacora_columna1', N'Usuario', 2842)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbitacora_columna2', N'Modulo', 2723)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbitacora_columna3', N'Mensaje', 2807)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdcategorias_columna0', N'ID Categoria', 3402)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdcategorias_columna1', N'Nombre', 2930)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdclientes_columna0', N'ID Cliente', 2996)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdclientes_columna1', N'Nombre', 2727)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdclientes_columna2', N'Provincia', 3056)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grddistribuidors_columna0', N'ID Distribuidor', 4116)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grddistribuidors_columna1', N'Nombre', 3287)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grddistribuidors_columna2', N'Provincia', 3616)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdelementosseleccionados_columna0', N'ID', 3745)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdelementosseleccionados_columna1', N'Elementos seleccionados', 5949)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdelementosseleccionados_columna2', N'Seleccionar', 4734)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdgrupodisponibles_columna2', N'Seleccionar', 4127)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdgrupos_columna0', N'ID Grupo', 2630)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdgrupos_columna1', N'Nombre', 2544)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdgruposdisponibles_columna0', N'ID', 3253)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdgruposdisponibles_columna1', N'Grupo', 3638)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdgruposdisponibles_columna2', N'Seleccionar', 4242)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdidiomas_columna0', N'ID', 2143)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdidiomas_columna1', N'Nombre', 2614)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdleyendas_columna0', N'ID Leyenda', 2992)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdleyendas_columna1', N'Texto leyenda referencia', 4492)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdleyendas_columna2', N'Nuevo texto de leyenda', 4239)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdpermisosdisponibles_columna0', N'Permiso', 4057)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdpermisosdisponibles_columna1', N'Permiso', 4058)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdpermisosdisponibles_columna2', N'Seleccionar', 4452)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdproductos_columna0', N'ID Producto', 3276)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdproductos_columna1', N'Nombre', 2867)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdproductos_columna2', N'Categoria', 3168)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdpuntodeventas_columna0', N'ID', 2825)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdpuntodeventas_columna1', N'Punto de Venta', 3994)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna0', N'ID', 2939)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna1', N'Distribuidor', 4067)
GO
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna10', N'09', 2952)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna11', N'10', 2945)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna12', N'11', 2947)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna13', N'12', 2949)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna14', N'13', 2951)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna15', N'14', 2953)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna16', N'15', 2955)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna17', N'16', 2957)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna18', N'17', 2959)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna19', N'18', 2961)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna2', N'01', 2897)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna20', N'19', 2954)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna21', N'20', 2947)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna22', N'21', 2949)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna23', N'22', 2951)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna24', N'23', 2953)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna25', N'24', 2955)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna26', N'25', 2957)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna27', N'26', 2959)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna28', N'27', 2961)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna29', N'28', 2963)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna3', N'02', 2899)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna30', N'29', 2956)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna31', N'30', 2949)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna32', N'31', 2951)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna4', N'03', 2901)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna5', N'04', 2903)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna6', N'05', 2905)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna7', N'06', 2907)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna8', N'07', 2909)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdtransmisioness_columna9', N'08', 2911)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdusuarios_columna0', N'ID', 2292)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdusuarios_columna1', N'Nombre usuario', 3571)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdusuarios_columna2', N'Idioma', 2748)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdusuarios_columna3', N'Habilitado', 3163)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'hayleyendasfaltantes', N'Hay leyendas faltantes para el idioma. Todas las leyendas deben completarse.', 9332)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'idrealdistribuidorrequerido', N'El ID Real del distribuidor es un dato requerido.', 7410)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'ingresearchivorequerido', N'Seleccione un archivo para procesar, haciendo clic en "Seleccionar Archivo".', 9537)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'juevescorto', N'JU', 1417)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'julio', N'Julio', 1111)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'junio', N'Junio', 1115)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'justificado:', N'Justificado:', 2479)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'label11', N'....', 843)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblareaventas', N'Area de ventas', 2728)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblareaventaslat', N'Latitud', 2477)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblareaventaslong', N'Longitud', 2699)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblareaventasradio', N'Radio (metros)', 3230)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblbackuplistatitulo', N'Administración de Backups', 4778)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblborradojustificaciontitulo', N'Eliminar justificacion', 5404)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblcargamanualseq', N'Carga manual de secuencias', 4312)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblcategoriaid', N'ID Categoria', 2595)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblcategorialistatitulo', N'Administración de Categorías', 5536)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblcategorianombre', N'Nombre', 2560)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblcliente', N'Cliente', 1811)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblclienteid', N'ID Cliente', 2189)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblclientelistatitulo', N'Administración de Clientes', 4998)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblclientenombre', N'Nombre', 2357)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblclienteprovincia', N'Provincia', 3013)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblclienteusuario', N'Usuario Asignado', 3461)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblcontrasena', N'Contraseña', 2602)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldescripcionsistema', N'Una herramienta indispensable para administrar su red de distribución, comprender y satisfacer las necesidades de stock de sus clientes y asegurarse las mas amplia cobertura de sus productos en el mercado.', 21950)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldiasfacturacion', N'Dias de facturación', 3896)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldistribuidor', N'Distribuidor', 2931)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldistribuidorid', N'ID Distribuidor', 3309)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldistribuidorlistatitulo', N'Administracion de Distribuidores', 6087)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldistribuidornombre', N'Nombre', 2917)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldistribuidorprovincia', N'Provincia', 3573)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldistribuidorusuario', N'Usuario Asignado', 4021)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblenterprisetracking', N'Enterprise Tracking', 4211)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblgrupoid', N'ID del Grupo', 2164)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblgrupolistatitulo', N'Administración de Grupos', 4632)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblgruponombre', N'Noombre del Grupo', 3183)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblidiomalistatitulo', N'Administración de Idiomas', 4772)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblidreal', N'ID Real', 1549)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblingresesusdatos', N'Credenciales', 3216)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbljustificaciontitulo', N'Justificar fecha sin facturación', 5695)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbllenguajecultura', N'Cultura', 2710)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbllenguajenombre', N'Nombre de Lenguaje', 3536)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbllenguajereferencia', N'Lenguaje de Referencia', 4338)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblmail', N'Mail', 1169)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblpassword', N'Contraseña', 2415)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblprecio', N'Precio', 1615)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblproductocategoria', N'Categoria', 3097)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblproductoid', N'ID Producto', 2469)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblproductolistatitulo', N'Id Producto', 3510)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblproductonombre', N'Nombre', 2497)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblrememberme', N'Recordarme ?', 2543)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblstocklistatitulo', N'Informe de Stock', 3530)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbltransmisioneslistatitulo', N'Administración de Transmisiones', 6249)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuario', N'Usuario', 1883)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuarioabilitado', N'Habilitado?', 3148)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuarioid', N'ID Usuario', 2261)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuarioidioma', N'Idioma', 2361)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuariolistatitulo', N'Administración de Usuarios', 5070)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuarionombre', N'Nombre', 2393)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'listaerrores', N'<b>Lista de Errores</b>', 3359)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'listasecuencias', N'.', 1695)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'listatablas', N'.', 1267)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lunescorto', N'LU', 1312)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mailclienterequerido', N'El mail del cliente es un dato requerido.', 5942)
GO
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'maildistribuidorrequerido', N'El mail del distribuidor es un dato requerido.', 7062)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'martescorto', N'MA', 1394)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'marzo', N'Marzo', 1123)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mayo', N'Mayo', 893)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'miercolescorto', N'MI', 1713)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonconcursos', N'Concursos', 3003)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonconcursos_concurso', N'Adm. de Concursos', 4559)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonidioma', N'Idiomas', 2390)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonidioma_idioma', N'Adm. de Idiomas', 3697)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonlogout', N'Cerrar sesión', 3147)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes', N'Reportes', 2789)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_invasionzonas', N'Invasión de Zonas', 5217)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_proyeccionvtas', N'Proyeccion de ventas', 5534)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_rankingdistvend', N'Ranking de Distribuidores/Vendedores', 7192)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_stock', N'Informe de Stock', 4081)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_valstockfifo', N'Valorización de Stock (FIFO)', 5906)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_valstocklifo', N'Valorización de Stock (LIFO)', 5918)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_valstockppp', N'Valorización de Stock (PPP)', 5770)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_vtasxcatprod', N'Ventas por Categoria y Producto', 6317)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonreportes_vtasxdistvend', N'Ventas por Distribuidor/Vendedor', 6627)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonsecuencias', N'Secuencias', 3139)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonsecuencias_cargamanual', N'Carga manual de secuencia', 5712)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonsecuencias_panelcontrol', N'Panel de Control', 5002)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonsecuencias_transmisiones', N'Adm. de Transmisiones', 5606)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonseguridad', N'Seguridad', 2925)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonseguridad_backup', N'Adm. de Backups', 4028)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonseguridad_bitacora', N'Adm. de Bitacora', 4327)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonseguridad_grupo', N'Adm. de Grupos de permisos', 5029)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttonseguridad_usuario', N'Adm. de Usuarios', 4320)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttontablas', N'Tablas del sistema', 3414)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttontablas_categoria', N'Adm. de Categorias', 4333)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttontablas_cliente', N'Adm. de clientes', 3959)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttontablas_distribuidor', N'Adm. de Distribuidores', 5148)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'mnubuttontablas_producto', N'Adm. de productos', 4239)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'msjerrorcontrasenaincorrecta', N'Contraseña incorrecta', 5336)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'msjerrorusuarioincorrecto', N'El usuario ingresado no existe.', 5751)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'nombreclienterequerido', N'El nombre del cliente es un dato requerido.', 6390)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'nombredistribuidorrequerido', N'El nombre del distribuidor es un dato requerido.', 7510)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'notranslatefactfaltante', N'Facturación Faltante', 4619)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'notranslatefactpresente', N'Facturación Presente', 4665)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'notranslatejustificado', N'Dia No Facturado c/Justificación', 5526)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'noviembre', N'Noviembre', 1951)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'octubre', N'Octubre', 1529)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_backuplista', N'Pantalla Lista de Backups', 4414)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_backuplista_btneliminarbackup', N'Eliminar Backups', 5542)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_backuplista_btnnuevobackup', N'Agregar Backups', 5130)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_backuplista_btnrestore', N'Restaurar desde Backups', 5520)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_bitacoralista', N'Pantalla Lista Bitacora', 4480)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_cargamanual', N'Carga manual de secuencias', 4531)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_categoriaedicion', N'Pantalla Edicion de Categorias', 5420)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_categorialista', N'Pantalla Lista de Categorias', 5040)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_categorialista_btneditarcategoria', N'Modificar Categorias', 6358)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_categorialista_btneliminarcategoria', N'Eliminar Categorias', 6481)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_categorialista_btnnuevocategoria', N'Agregar Categorias', 6069)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_clienteedicion', N'Pantalla Modificar Clientes', 4992)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_clientelista', N'Pantalla Lista de clientes', 4666)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_clientelista_btneditarcliente', N'Modificar Clientes', 5749)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_clientelista_btneliminarcliente', N'Eliminar Clientes', 5872)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_clientelista_btnnuevocliente', N'Agregar Clientes', 5460)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_distribuidoredicion', N'Pantalla Edición de distribuidores', 6399)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_distribuidorlista', N'Pantalla Lista de distribuidores', 5887)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_distribuidorlista_btneditardistribuidor', N'Modificar distribuidores', 7562)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_distribuidorlista_btneliminardistribuidor', N'Eliminar distribuidores', 7685)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_distribuidorlista_btnnuevodistribuidor', N'Agregar distribuidores', 7273)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_grupoedicion', N'Pantalla Modificacion de Grupo', 5055)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_grupolista', N'Pantalla Lista de Grupos', 4268)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_grupolista_btneditargrupo', N'Modificar Grupo', 5085)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_grupolista_btneliminargrupo', N'Eliminar Grupo', 5208)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_grupolista_btnnuevogrupo', N'Agregar Grupo', 4796)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_idiomaedicion', N'Pantalla modificacion de Idioma', 5227)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_idiomalista', N'Pantalla Lista de Idiomas', 4408)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_idiomalista_btneditaridioma', N'Modificar Idiomas', 5410)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_idiomalista_btneliminaridioma', N'Eliminar Idiomas', 5533)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_idiomalista_btnnuevoidioma', N'Agregar Idiomas', 5121)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_invasionzonas', N'Pantalla Invasion de Zonas', 4809)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_panelcontrol', N'Pantalla Panel de Control', 4551)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_panelcontrollista', N'Pantalla Panel de control', 5124)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_principal', N'Pantalla Ingreso al sistema', 4472)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_productoedicion', N'Pantalla Edicion de Productos', 5294)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_productolista', N'Pantalla Lista de Productos', 4914)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_productolista_btneditarproducto', N'Modificar Productos', 6169)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_productolista_btneliminarproducto', N'Eliminar Productos', 6292)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_productolista_btnnuevoproducto', N'Agregar Productos', 5880)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_transmisioneslista', N'Pantalla Lista de Transmisiones', 5885)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuarioasignarpermisos', N'Pantalla Asignar Permisos a Usuarios', 6766)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuarioedicion', N'Pantalla Modificacion de Grupo', 5274)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista', N'Pantalla Lista de Usuarios', 4706)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista_btnasignarpermisosusuario', N'Asignar Permisos a Usuarios', 7657)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista_btneditarusuario', N'Modificar Usuario', 5742)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista_btneliminarusuario', N'Eliminar Usuario', 5865)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista_btnnuevousuario', N'Agregar Usuario', 5453)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'puntosventacargados', N'Total de puntos de venta cargados', 5245)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'requiredfieldvalidatorerrorpassword', N'Contraseña requerida', 5996)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'requiredfieldvalidatorerrorusuario', N'Usuario requerido', 5478)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'requiredfieldvalidatorlenguajenombre', N'Nombre es requerido', 5749)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'requiredfieldvalidatornuevaleyenda', N'Dato requerido', 5077)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'restorecompleto', N'Restauración completa.', 4015)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'sabadocorto', N'SA', 1366)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'seguroborrarjustificacion', N'Esta seguro que desea eliminar la justificacion para la fecha?: ', 8658)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'septiembre', N'Septiembre', 2161)
GO
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'stockcargados', N'Total de entradas de stock cargadas', 4731)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'stocknoexisteproducto', N'Una entrada de stock para la fecha %0 tiene un codigo de producto %1 inexistente.', 9595)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloasignarpermisosusuario', N'Asignar Permisos', 4712)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditarcategoria', N'Modificar Categoria', 4151)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditarcliente', N'Modificar Cliente', 3745)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditardistribuidor', N'Modificar Distribuidor', 4865)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditargrupo', N'Modificar Grupo de permisos', 4526)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditaridioma', N'Modificar Idioma', 3519)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditarproducto', N'Modificar Producto', 4025)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditarusuario', N'Modificar Usuario', 3817)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevocategoria', N'Nueva Categoria', 3676)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevocliente', N'Nuevo Cliente', 3284)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevodistribuidor', N'Nuevo Distribuidor', 4404)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevogrupo', N'Nuevo Grupo', 2918)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevoidioma', N'Nuevo Idioma', 3058)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevoproducto', N'Nuevo Producto', 3564)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevousuario', N'Nuevo Usuario', 3356)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloresultadocargasecuencia', N'Resultado de carga de secuencia', 6086)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtareaventaslat', N'Ingrese Latitud del centro del area de ventas permitida', 6983)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtareaventaslong', N'Ingrese la longitud del centro del Area de ventas permitida', 7442)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtareaventasradio', N'Ingrese el valor en metros para el radio del area de ventas permitida', 8420)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtcategorianombre', N'Ingrese Nombre', 3347)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtclientenombre', N'Ingrese el nombre del cliente', 4530)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtcontrasena', N'Ingrese la contraseña', 3658)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtcoordinate', N'sasdasdas', 2416)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtdesde', N'xxx', 1278)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtdistribuidornombre', N'Ingrese el nombre del distribuidor', 5650)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtgruponombre', N'Ingrese un nombre para el grupo', 4534)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txthasta', N'xxx', 1290)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtidreal', N'Ingrese el ID real del distribuidor', 4282)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtidrealcategoria', N'ID Real', 2530)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtidrealdistribuidor', N'Ingrese el ID real del Distribuidor', 5550)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtidrealproducto', N'Ingrese ID real del producto', 4501)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtjustificacion', N'Ingrese Justificacion', 3892)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtlenguajecultura', N'Ingrese cultura', 3529)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtlenguajenombre', N'Ingrese nombre del lenguaje', 4495)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtmail', N'Ingrese la direccion de mail', 3434)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtnuevotextoleyenda', N'Ingrese nuevo texto', 4162)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtprecio', N'Ingrese precio', 2434)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtproductonombre', N'Ingrese el nombre del producto', 4810)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtusuario', N'Ingrese usuario', 2702)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtusuarioid', N'ID del usuario', 2672)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtusuarionombre', N'Nombre de usuario', 3472)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'uploadbutton', N'x', 1482)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'usuarioclienterequerido', N'El Usuario asignado al cliente es un dato requerido.', 7390)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'vendedorescargados', N'Total de vendedores cargados', 4676)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'viernescorto', N'VI', 1523)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'backupcompleto', N'Backup complete.', 3080)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'bit_login', N'User has logged in.', 2715)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'bit_logout', N'User has logged out.', 2973)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnaceptar', N'Ok', 1296)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnasignarpermisosusuario', N'Assign Permissions', 4598)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btncancelar', N'Cancel', 1781)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btneditargrupo', N'Edit Group', 2511)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btneditaridioma', N'Edit Language', 2860)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btneditarusuario', N'Edit User', 2620)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btneliminarbackup', N'Delete Backup', 3078)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btneliminargrupo', N'Delete Group', 2932)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btneliminaridioma', N'Delete Language', 3281)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btneliminarusuario', N'Delete User', 3041)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnlogin', N'Login', 1416)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnmodalno', N'No', 1309)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnmodalok', N'OK', 1271)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnmodalsi', N'Yes', 1424)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnnuevobackup', N'Create Backup', 2787)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnnuevogrupo', N'Add Group', 2310)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnnuevoidioma', N'Add Language', 2659)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnnuevousuario', N'Add User', 2419)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnrestore', N'Restore from backup', 3016)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'btnupload', N'Upload', 1632)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'cargaseqlistabienformado', N'1. Well formed XML ......', 4209)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'cargaseqlistadatos', N'3. Validation of data values......', 4656)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'cargaseqlistavalido', N'2. XML valid against XSD ......', 4224)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'correcto', N'SUCCESS', 1420)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'culturainvalida', N'Invalid Culture', 3141)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'detallefacturanoexisteproducto', N'Line %0 of invoice %1 has a non existent product code  %2.', 7972)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estaseguroborrarbackupseleccionado', N'Are you sure you want to delete the selected backup?', 8539)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estaseguroborrarelementoseleccionado', N'Are you sure to delete the selected item?', 7712)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estaseguroborraridiomaseleccionado', N'Are you sure to delete the selected Language?', 7855)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estasegurocrearnuevobackup', N'Are you sure you want to create a new backup?', 6982)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estasegurorestaurarbackupseleccionado', N'Are you sure you want to restore the DB from the selected backup?', 10008)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estasegurosalir', N'Are you sure you want to leave and lose your changes?', 6615)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'fallo', N'FAIL', 828)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdbackups_columna0', N'Backup Date', 3018)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdbackups_columna1', N'File Path', 2820)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdbitacora_columna0', N'Date/Time', 2926)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdbitacora_columna1', N'User', 2514)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdbitacora_columna2', N'Module', 2714)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdbitacora_columna3', N'Message', 2810)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdelementosseleccionados_columna0', N'ID', 3746)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdelementosseleccionados_columna1', N'Selected Elements', 5276)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdelementosseleccionados_columna2', N'Select', 4215)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdgrupodisponibles_columna2', N'Select', 3608)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdgrupos_columna0', N'Group ID', 2631)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdgrupos_columna1', N'Name', 2319)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdgruposdisponibles_columna0', N'ID', 3254)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdgruposdisponibles_columna1', N'Group', 3639)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdgruposdisponibles_columna2', N'Select', 3723)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdidiomas_columna0', N'ID', 2144)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdidiomas_columna1', N'Name', 2389)
GO
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdleyendas_columna0', N'ID Legend', 2878)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdleyendas_columna1', N'Reference Legend', 3649)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdleyendas_columna2', N'New Legend', 3037)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdpermisosdisponibles_columna0', N'ID', 3464)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdpermisosdisponibles_columna1', N'Permission', 4389)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdpermisosdisponibles_columna2', N'Select', 3933)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdusuarios_columna0', N'ID', 2293)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdusuarios_columna1', N'User Name', 2985)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdusuarios_columna2', N'Language', 2958)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdusuarios_columna3', N'Enabled', 2838)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'hayleyendasfaltantes', N'All legends are required.', 4525)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblbackuplistatitulo', N'Backup Management', 3859)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblcargamanualseq', N'Manual Load of Sequences', 4080)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblcontrasena', N'Password', 2285)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lbldescripcionsistema', N'A must-have tool to manage your distribution network, understand and satisfy the stock needs of your customers, and ensure a wider product coverage in the market.', 17678)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblenterprisetracking', N'Enterprise Tracking', 4212)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblgrupoid', N'Group ID', 1824)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblgrupolistatitulo', N'Groups Management', 3828)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblgruponombre', N'Group Name', 2506)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblidiomalistatitulo', N'Languages Management', 4177)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblingresesusdatos', N'Credentials', 3133)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lbllenguajecultura', N'Culture', 2715)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lbllenguajenombre', N'Language name', 3103)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lbllenguajereferencia', N'Reference Language', 3998)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblpassword', N'Password', 2098)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblrememberme', N'Remember me?', 2541)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblusuario', N'User', 1555)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblusuarioabilitado', N'Enabled?', 2823)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblusuarioid', N'User ID', 1933)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblusuarioidioma', N'Language', 2571)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblusuariolistatitulo', N'Users Management', 3937)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'lblusuarionombre', N'Name', 2168)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'listaerrores', N'<b>Error list</b>', 2263)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'listasecuencias', N'.', 1696)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'listatablas', N'.', 1268)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonconcursos', N'Contests', 2896)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonconcursos_concurso', N'Contests Management', 4920)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonidioma', N'Languages', 2600)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonidioma_idioma', N'Languages Management', 4375)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonlogout', N'Logout', 2354)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes', N'Reports', 2689)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_invasionzonas', N'Zone Invation', 4743)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_proyeccionvtas', N'Sales Proyection', 5166)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_rankingdistvend', N'Distributors/Salesmen Ranking', 6555)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_stock', N'Stock Report', 3765)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_valstockfifo', N'Stock Valorization(FIFO)', 5527)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_valstocklifo', N'Stock Valorization(LIFO)', 5539)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_valstockppp', N'Stock Valorization(PPP)', 5391)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_vtasxcatprod', N'Product/Category Sales', 5498)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonreportes_vtasxdistvend', N'Distributors/Salesmen Sales', 6165)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonsecuencias', N'Sequences', 3053)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonsecuencias_cargamanual', N'Manual sequence Load', 5267)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonsecuencias_panelcontrol', N'Control Panel', 4770)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonsecuencias_transmisiones', N'Transmissions Management', 6089)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonseguridad', N'Security', 2862)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonseguridad_backup', N'Backups Management', 4497)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonseguridad_bitacora', N'Log Management', 4281)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonseguridad_grupo', N'Permission Groups management', 5480)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttonseguridad_usuario', N'Users Management', 4460)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttontablas', N'System Tables', 2965)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttontablas_categoria', N'Categories Management', 4806)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttontablas_cliente', N'Customers Management', 4538)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttontablas_distribuidor', N'Distributors Management', 5427)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'mnubuttontablas_producto', N'Products Management', 4565)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'msjerrorcontrasenaincorrecta', N'Wrong password', 4510)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'msjerrorusuarioincorrecto', N'User does not exist.', 4668)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_backuplista', N'Backup List Screen', 3765)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_backuplista_btneliminarbackup', N'Delete Backups', 5321)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_backuplista_btnnuevobackup', N'Create Backups', 5030)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_backuplista_btnrestore', N'Restore from Backups', 5227)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_grupoedicion', N'Group Edit Screen', 3787)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_grupolista', N'Group List Screen', 3619)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_grupolista_btneditargrupo', N'Edit Groups', 4681)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_grupolista_btneliminargrupo', N'Delete Groups', 5102)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_grupolista_btnnuevogrupo', N'Add Groups', 4480)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_idiomaedicion', N'Language Edit Screen', 4136)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_idiomalista', N'Language List Screen', 3968)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_idiomalista_btneditaridioma', N'Edit Languages', 5100)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_idiomalista_btneliminaridioma', N'Delete Languages', 5521)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_idiomalista_btnnuevoidioma', N'Add Languages', 4899)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_principal', N'Login Screens', 3134)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_usuarioasignarpermisos', N'Screen Assign Permissions to Users', 6597)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_usuarioedicion', N'User Edit Screen', 3896)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_usuariolista', N'User List Screen', 3728)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_usuariolista_btnasignarpermisosusuario', N'Assign Permissions to Users', 7693)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_usuariolista_btneditarusuario', N'Edit Users', 5009)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_usuariolista_btneliminarusuario', N'Delete Users', 5430)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'permiso_usuariolista_btnnuevousuario', N'Agregar Users', 5240)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'requiredfieldvalidatorerrorpassword', N'Password is required', 5834)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'requiredfieldvalidatorerrorusuario', N'User is required', 5291)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'requiredfieldvalidatorlenguajenombre', N'Name is required', 5417)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'requiredfieldvalidatornuevaleyenda', N'Required value', 5084)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'restorecompleto', N'Restore complete.', 3364)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'stocknoexisteproducto', N'Stock entry for date %0 has a non existent product code %1.', 7425)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloasignarpermisosusuario', N'Assign Permissions to Users', 5768)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloeditargrupo', N'Edit Permission', 3400)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloeditaridioma', N'Edit Language', 3209)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloeditarusuario', N'Edit User', 2969)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'titulonuevogrupo', N'Add Group', 2659)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'titulonuevoidioma', N'Add Language', 3008)
GO
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'titulonuevousuario', N'Add User', 2768)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloresultadocargasecuencia', N'Sequence Load Result', 4940)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtcontrasena', N'Enter Password', 2865)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtgruponombre', N'Insert Group Name', 3205)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtlenguajecultura', N'Enter Culture', 3295)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtlenguajenombre', N'Insert language name', 3834)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtnuevotextoleyenda', N'Insert New text', 3705)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtusuario', N'Insert USer', 2222)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtusuarioid', N'User ID', 1971)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtusuarionombre', N'User Name', 2653)
SET IDENTITY_INSERT [dbo].[Justificacion] ON 

INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (1, 4, CAST(0x823D0B00 AS Date), N'Cerrado por duelo', 2798)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (2, 3, CAST(0x7E3D0B00 AS Date), N'Prueba de justificacion', 3371)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (9, 3, CAST(0x4A3C0B00 AS Date), N'pipipi', 1710)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (6, 3, CAST(0x4E3C0B00 AS Date), N'No se facturo', 2288)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (7, 3, CAST(0x4D3C0B00 AS Date), N'No se facturo', 2287)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (8, 3, CAST(0x7D3D0B00 AS Date), N'Le chingue al boton', 2874)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (10, 3, CAST(0x7C3D0B00 AS Date), N'esta es una prueba de justificacion muuuuuuuuuuy larga para ver si hay kilombos cuando se sobrepasa el tooltip', 11726)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (11, 4, CAST(0x7B3D0B00 AS Date), N'Prueba', 1717)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (12, 3, CAST(0x7F3D0B00 AS Date), N'd', 1213)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (14, 3, CAST(0x7A3D0B00 AS Date), N'sd', 1323)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (15, 3, CAST(0x793D0B00 AS Date), N'dsds', 1537)
INSERT [dbo].[Justificacion] ([ID], [IDDistribuidor], [Fecha], [Motivo], [DVH]) VALUES (13, 3, CAST(0x7B3D0B00 AS Date), N'ds', 1324)
SET IDENTITY_INSERT [dbo].[Justificacion] OFF
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([ID], [IDReal], [Nombre], [Precio], [DVH], [Borrado], [IDCliente], [IDCategoria]) VALUES (2, N'150', N'Oreo', CAST(15.60 AS Numeric(10, 2)), 1346, 0, 1, 1)
INSERT [dbo].[Producto] ([ID], [IDReal], [Nombre], [Precio], [DVH], [Borrado], [IDCliente], [IDCategoria]) VALUES (3, N'100', N'Tita', CAST(7.00 AS Numeric(10, 2)), 1193, 0, 1, 3)
INSERT [dbo].[Producto] ([ID], [IDReal], [Nombre], [Precio], [DVH], [Borrado], [IDCliente], [IDCategoria]) VALUES (4, N'200', N'Rhodesia', CAST(8.00 AS Numeric(10, 2)), 1608, 0, 1, 3)
SET IDENTITY_INSERT [dbo].[Producto] OFF
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (1, N'C.A.B.A.')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (2, N'Buenos Aires')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (3, N'Catamarca')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (4, N'Chaco')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (5, N'Chubut')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (6, N'Córdoba')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (7, N'Corrientes')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (8, N'Entre Ríos')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (9, N'Formosa')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (10, N'Jujuy')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (11, N'La Pampa')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (12, N'La Rioja')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (13, N'Mendoza')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (14, N'Misiones')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (15, N'Neuquén')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (16, N'Río Negro')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (17, N'Salta')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (18, N'San Juan')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (19, N'San Luis')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (20, N'Santa Cruz')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (21, N'Santa Fe')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (22, N'Santiago del Estero')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (23, N'Tierra del Fuego')
INSERT [dbo].[Provincia] ([ID], [Nombre]) VALUES (24, N'Tucumán')
SET IDENTITY_INSERT [dbo].[Provincia] OFF
SET IDENTITY_INSERT [dbo].[PuntoDeVenta] ON 

INSERT [dbo].[PuntoDeVenta] ([ID], [IDReal], [Nombre], [CUIT], [Calle], [Depto], [CodigoPostal], [DVH], [Borrado], [IDProvincia], [IDDistribuidor], [IDVendedor], [Numero], [Latitud], [Longitud]) VALUES (1, 1, N'El Kioskito Loco', N'12345678901', N'Av. Pres. Manuel Quintana', N'', N'C1129ABA', 6722, 0, 1, 3, 2, 401, -34.5888172, -58.3890324)
INSERT [dbo].[PuntoDeVenta] ([ID], [IDReal], [Nombre], [CUIT], [Calle], [Depto], [CodigoPostal], [DVH], [Borrado], [IDProvincia], [IDDistribuidor], [IDVendedor], [Numero], [Latitud], [Longitud]) VALUES (2, 2, N'Super el Chino', N'54316565163', N'Av. Callao', N'', N'C1024AAP', 5217, 0, 1, 3, 2, 1650, -34.5905287, -58.3905413)
INSERT [dbo].[PuntoDeVenta] ([ID], [IDReal], [Nombre], [CUIT], [Calle], [Depto], [CodigoPostal], [DVH], [Borrado], [IDProvincia], [IDDistribuidor], [IDVendedor], [Numero], [Latitud], [Longitud]) VALUES (3, 3, N'Mayorista El zarpado', N'65468791654', N'Av. Gral. Las Heras', N'', N'C1127AAP', 6598, 0, 1, 3, 3, 2075, -34.5893405, -58.3945266)
INSERT [dbo].[PuntoDeVenta] ([ID], [IDReal], [Nombre], [CUIT], [Calle], [Depto], [CodigoPostal], [DVH], [Borrado], [IDProvincia], [IDDistribuidor], [IDVendedor], [Numero], [Latitud], [Longitud]) VALUES (4, 4, N'Despensa la Kriss', N'21654987652', N'Ayacucho', N'', N'C1112AAH', 5407, 0, 1, 3, 5, 1870, -34.588577, -58.390421)
INSERT [dbo].[PuntoDeVenta] ([ID], [IDReal], [Nombre], [CUIT], [Calle], [Depto], [CodigoPostal], [DVH], [Borrado], [IDProvincia], [IDDistribuidor], [IDVendedor], [Numero], [Latitud], [Longitud]) VALUES (5, 5, N'Super El Morlaco', N'56546545888', N'Posadas', N'', N'C1112ADB', 5232, 0, 1, 3, 4, 1530, -34.5874124, -58.387562)
INSERT [dbo].[PuntoDeVenta] ([ID], [IDReal], [Nombre], [CUIT], [Calle], [Depto], [CodigoPostal], [DVH], [Borrado], [IDProvincia], [IDDistribuidor], [IDVendedor], [Numero], [Latitud], [Longitud]) VALUES (6, 6, N'Despensa El Patovica Alegre', N'65465499879', N'Serrano', N'', N'C1414DEQ', 6311, 0, 1, 3, 4, 850, -34.5936519, -58.4383641)
SET IDENTITY_INSERT [dbo].[PuntoDeVenta] OFF
SET IDENTITY_INSERT [dbo].[Secuencia] ON 

INSERT [dbo].[Secuencia] ([ID], [IDReal], [Fecha], [Estado], [DVH], [IDDistribuidor]) VALUES (1, 1, CAST(0x0000A81D01639A44 AS DateTime), N'OK', 1394, 3)
INSERT [dbo].[Secuencia] ([ID], [IDReal], [Fecha], [Estado], [DVH], [IDDistribuidor]) VALUES (2, 1, CAST(0x0000A81D016BA3B2 AS DateTime), N'OK', 1437, 3)
INSERT [dbo].[Secuencia] ([ID], [IDReal], [Fecha], [Estado], [DVH], [IDDistribuidor]) VALUES (3, 1, CAST(0x0000A81D016F6AA2 AS DateTime), N'OK', 1436, 3)
INSERT [dbo].[Secuencia] ([ID], [IDReal], [Fecha], [Estado], [DVH], [IDDistribuidor]) VALUES (4, 1, CAST(0x0000A81E00D1FB58 AS DateTime), N'OK', 1385, 3)
INSERT [dbo].[Secuencia] ([ID], [IDReal], [Fecha], [Estado], [DVH], [IDDistribuidor]) VALUES (5, 1, CAST(0x0000A81E0127A716 AS DateTime), N'OK', 1346, 3)
INSERT [dbo].[Secuencia] ([ID], [IDReal], [Fecha], [Estado], [DVH], [IDDistribuidor]) VALUES (6, 1, CAST(0x0000A81E014F0D18 AS DateTime), N'OK', 1348, 3)
INSERT [dbo].[Secuencia] ([ID], [IDReal], [Fecha], [Estado], [DVH], [IDDistribuidor]) VALUES (7, 1, CAST(0x0000A8230119A9D3 AS DateTime), N'OK', 1340, 3)
INSERT [dbo].[Secuencia] ([ID], [IDReal], [Fecha], [Estado], [DVH], [IDDistribuidor]) VALUES (8, 1, CAST(0x0000A823012BCC77 AS DateTime), N'OK', 1340, 3)
SET IDENTITY_INSERT [dbo].[Secuencia] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (1, N'kS6FG3aa4JEjWYI4llCKGQ==', 1, N'21232F297A57A5A743894A0E4A801FC3', 0, 1, 2835, 0)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (2, N'Kaz8ncNkb3/4ED01oy0kgg==', 2, N'D432EB18017C004FD305969713A17AA8', 0, 1, 3024, 0)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (3, N'rzvaiyUnfYzlENk8GepKPw==', 1, N'AA47F8215C6F30A0DCDB2A36A9F4168E', 0, 1, 3013, 0)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (4, N'5FyJJDQdXE3oOh3fA0Oe6w==', 1, N'76CEBB2C444D72118969791FC106CDE2', 0, 1, 3394, 0)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (5, N'tlTFkjYoBmk7a/wGVM9f7g==', 1, N'22C889209F152C93AB7BBAF88442B09E', 0, 1, 3386, 0)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (6, N'5/tnjXnDM/pNjpij3dSXFA==', 1, N'128C85534E12FCB8A553F44C436CE4E1', 0, 1, 3363, 0)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (7, N'wSb/xPzGU2dDSR2Uyp4VYQ==', 1, N'C1C3BF5EC4130D355DFC822AACA135EF', 0, 1, 3347, 0)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[UsuarioElemento] ([IDElemento], [IDUsuario], [DVH]) VALUES (187, 3, 211)
INSERT [dbo].[UsuarioElemento] ([IDElemento], [IDUsuario], [DVH]) VALUES (188, 6, 215)
INSERT [dbo].[UsuarioElemento] ([IDElemento], [IDUsuario], [DVH]) VALUES (190, 4, 206)
INSERT [dbo].[UsuarioElemento] ([IDElemento], [IDUsuario], [DVH]) VALUES (190, 5, 207)
SET IDENTITY_INSERT [dbo].[Vendedor] ON 

INSERT [dbo].[Vendedor] ([ID], [IDReal], [Nombre], [DVH], [Borrado], [IDDistribuidor]) VALUES (2, N'1', N'Pedro', 1094, 0, 3)
INSERT [dbo].[Vendedor] ([ID], [IDReal], [Nombre], [DVH], [Borrado], [IDDistribuidor]) VALUES (3, N'2', N'Andres', 1197, 0, 3)
INSERT [dbo].[Vendedor] ([ID], [IDReal], [Nombre], [DVH], [Borrado], [IDDistribuidor]) VALUES (4, N'3', N'Matias', 1200, 0, 3)
INSERT [dbo].[Vendedor] ([ID], [IDReal], [Nombre], [DVH], [Borrado], [IDDistribuidor]) VALUES (5, N'4', N'Daniel', 1183, 0, 3)
SET IDENTITY_INSERT [dbo].[Vendedor] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_Elemento_descripcion]    Script Date: 11/8/2017 1:32:42 AM ******/
ALTER TABLE [dbo].[Elemento] ADD  CONSTRAINT [UC_Elemento_descripcion] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Distribuidor] ADD  CONSTRAINT [DF_Distribuidor_borrado]  DEFAULT ((0)) FOR [borrado]
GO
ALTER TABLE [dbo].[Distribuidor] ADD  CONSTRAINT [DF_Distribuidor_DVH]  DEFAULT ((0)) FOR [DVH]
GO
ALTER TABLE [dbo].[Distribuidor] ADD  CONSTRAINT [DF_Distribuidor_DiasFactura]  DEFAULT ((1111111)) FOR [DiasFactura]
GO
ALTER TABLE [dbo].[Distribuidor] ADD  CONSTRAINT [DF_Distribuidor_AreaCentroLat]  DEFAULT ((0)) FOR [AreaVentasCentroLat]
GO
ALTER TABLE [dbo].[Distribuidor] ADD  CONSTRAINT [DF_Distribuidor_AreaCentroLong]  DEFAULT ((0)) FOR [AreaVentasCentroLong]
GO
ALTER TABLE [dbo].[Distribuidor] ADD  CONSTRAINT [DF_Distribuidor_AreaRadio]  DEFAULT ((0)) FOR [AreaVentasRadio]
GO
ALTER TABLE [dbo].[PuntoDeVenta] ADD  CONSTRAINT [DF_PuntoDeVenta_Latitud]  DEFAULT ((0)) FOR [Latitud]
GO
ALTER TABLE [dbo].[PuntoDeVenta] ADD  CONSTRAINT [DF_PuntoDeVenta_Longitud]  DEFAULT ((0)) FOR [Longitud]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_Habilitado]  DEFAULT ((0)) FOR [Habilitado]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_borrado]  DEFAULT ((0)) FOR [borrado]
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
ALTER TABLE [dbo].[EntradasBitacora]  WITH CHECK ADD  CONSTRAINT [EntradasBitacora_Usuario_FK1] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuario] ([ID])
GO
ALTER TABLE [dbo].[EntradasBitacora] CHECK CONSTRAINT [EntradasBitacora_Usuario_FK1]
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
USE [master]
GO
ALTER DATABASE [EnterpriseSolutionsBD] SET  READ_WRITE 
GO
