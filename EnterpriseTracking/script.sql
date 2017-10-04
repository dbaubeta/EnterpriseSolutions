USE [master]
GO
/****** Object:  Database [EnterpriseSolutionsBD]    Script Date: 10/4/2017 5:07:35 PM ******/
CREATE DATABASE [EnterpriseSolutionsBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EnterpriseSolutionBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EnterpriseSolutionBD.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EnterpriseSolutionBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EnterpriseSolutionBD_log.ldf' , SIZE = 4736KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Concurso]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[ConcursoDistribuidor]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[ConcursoProducto]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Config]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Distribuidor]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[DVV]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Elemento]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[ElementoElemento]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[EntradasBitacora]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Error]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Factura]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[FacturaDetalle]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Idioma]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[IdiomaLeyenda]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Provincia]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[PuntoDeVenta]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Secuencia]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Stock]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[UsuarioElemento]    Script Date: 10/4/2017 5:07:35 PM ******/
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
/****** Object:  Table [dbo].[Vendedor]    Script Date: 10/4/2017 5:07:35 PM ******/
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
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Elemento', 7160)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'ElementoElemento', 7558)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'EntradasBitacora', 34768)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'idioma', 3277)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'IdiomaLeyenda', 1239120)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'Usuario', 8872)
INSERT [dbo].[DVV] ([NombreTabla], [Valor]) VALUES (N'UsuarioElemento', 211)
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
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (188, 1, 210)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (188, 3, 212)
INSERT [dbo].[ElementoElemento] ([IDPadre], [IDHijo], [DVH]) VALUES (190, 1, 203)
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
SET IDENTITY_INSERT [dbo].[EntradasBitacora] OFF
SET IDENTITY_INSERT [dbo].[Idioma] ON 

INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH], [borrado], [culture]) VALUES (1, N'Español', 1752, 0, N'es-AR')
INSERT [dbo].[Idioma] ([ID], [Nombre], [DVH], [borrado], [culture]) VALUES (2, N'Ingles', 1525, 0, N'en-US')
SET IDENTITY_INSERT [dbo].[Idioma] OFF
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'backupcompleto', N'Backup completo.', 3089)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'bit_login', N'El usuario ha ingresado al sistema.', 4279)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'bit_logout', N'El usuario ha cerrado la sesión.', 4219)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnaceptar', N'Aceptar', 1813)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnasignarpermisosusuario', N'Asignar Permisos', 4363)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btncancelar', N'Cancelar', 1991)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditargrupo', N'Modificar Grupo', 3030)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditaridioma', N'Modificar Idioma', 3170)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneditarusuario', N'Modificar', 2692)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminarbackup', N'Eliminar Backup', 3299)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminargrupo', N'Eliminar Grupo', 3153)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminaridioma', N'Eliminar Idioma', 3293)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btneliminarusuario', N'Eliminar', 2815)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnlogin', N'Ingresar', 1737)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalno', N'No', 1308)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalok', N'Aceptar', 1820)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnmodalsi', N'Si', 1306)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevobackup', N'Nuevo Backup', 2715)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevogrupo', N'Nuevo Grupo', 2569)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevoidioma', N'Nuevo Idioma', 2709)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnnuevousuario', N'Nuevo Usuario', 3007)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'btnrestore', N'Restaurar backup', 2760)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'culturainvalida', N'La cultura ingresada es invalida', 4724)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estaseguroborrarbackupseleccionado', N'Esta seguro que quiere eliminar el backup seleccionado?', 8946)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estaseguroborrarelementoseleccionado', N'Esta seguro que desea eliminar el item seleccionado?', 8837)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estaseguroborraridiomaseleccionado', N'Esta seguro que desea eliminar el idioma seleccionado?', 8803)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estasegurocrearnuevobackup', N'Esta seguro que desea crear un nuevo Backup?', 6948)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estasegurorestaurarbackupseleccionado', N'Esta seguro que quiere restaurar el backup seleccionado?', 9419)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'estasegurosalir', N'Esta seguro que desea salir y perder los cambios?', 6270)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbackups_columna0', N'Fecha de Backup', 3339)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbackups_columna1', N'Path del archivo', 3524)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbitacora_columna0', N'Fecha/Hora', 3009)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbitacora_columna1', N'Usuario', 2842)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbitacora_columna2', N'Modulo', 2723)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdbitacora_columna3', N'Mensaje', 2807)
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
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdusuarios_columna0', N'ID', 2292)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdusuarios_columna1', N'Nombre usuario', 3571)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdusuarios_columna2', N'Idioma', 2748)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'grdusuarios_columna3', N'Habilitado', 3163)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'hayleyendasfaltantes', N'Hay leyendas faltantes para el idioma. Todas las leyendas deben completarse.', 9332)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblbackuplistatitulo', N'Administración de Backups', 4778)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblcontrasena', N'Contraseña', 2602)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbldescripcionsistema', N'Una herramienta indispensable para administrar su red de distribución, comprender y satisfacer las necesidades de stock de sus clientes y asegurarse las mas amplia cobertura de sus productos en el mercado.', 21950)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblenterprisetracking', N'Enterprise Tracking', 4211)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblgrupoid', N'ID del Grupo', 2164)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblgrupolistatitulo', N'Administración de Grupos', 4632)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblgruponombre', N'Noombre del Grupo', 3183)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblidiomalistatitulo', N'Administración de Idiomas', 4772)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblingresesusdatos', N'Credenciales', 3216)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbllenguajecultura', N'Cultura', 2710)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbllenguajenombre', N'Nombre de Lenguaje', 3536)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lbllenguajereferencia', N'Lenguaje de Referencia', 4338)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblpassword', N'Contraseña', 2415)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblrememberme', N'Recordarme ?', 2543)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuario', N'Usuario', 1883)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuarioabilitado', N'Habilitado?', 3148)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuarioid', N'ID Usuario', 2261)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuarioidioma', N'Idioma', 2361)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuariolistatitulo', N'Administración de Usuarios', 5070)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'lblusuarionombre', N'Nombre', 2393)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'listasecuencias', N'.', 1695)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'listatablas', N'.', 1267)
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
GO
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
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_backuplista', N'Pantalla Lista de Backups', 4414)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_backuplista_btneliminarbackup', N'Eliminar Backups', 5542)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_backuplista_btnnuevobackup', N'Agregar Backups', 5130)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_backuplista_btnrestore', N'Restaurar desde Backups', 5520)
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
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_principal', N'Pantalla Ingreso al sistema', 4472)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuarioasignarpermisos', N'Pantalla Asignar Permisos a Usuarios', 6766)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuarioedicion', N'Pantalla Modificacion de Grupo', 5274)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista', N'Pantalla Lista de Usuarios', 4706)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista_btnasignarpermisosusuario', N'Asignar Permisos a Usuarios', 7657)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista_btneditarusuario', N'Modificar Usuario', 5742)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista_btneliminarusuario', N'Eliminar Usuario', 5865)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'permiso_usuariolista_btnnuevousuario', N'Agregar Usuario', 5453)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'requiredfieldvalidatorerrorpassword', N'Contraseña requerida', 5996)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'requiredfieldvalidatorerrorusuario', N'Usuario requerido', 5478)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'requiredfieldvalidatorlenguajenombre', N'Nombre es requerido', 5749)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'requiredfieldvalidatornuevaleyenda', N'Dato requerido', 5077)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'restorecompleto', N'Restauración completa.', 4015)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloasignarpermisosusuario', N'Asignar Permisos', 4712)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditargrupo', N'Modificar Grupo de permisos', 4526)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditaridioma', N'Modificar Idioma', 3519)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'tituloeditarusuario', N'Modificar Usuario', 3817)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevogrupo', N'Nuevo Grupo', 2918)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevoidioma', N'Nuevo Idioma', 3058)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'titulonuevousuario', N'Nuevo Usuario', 3356)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtcontrasena', N'Ingrese la contraseña', 3658)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtgruponombre', N'Ingrese un nombre para el grupo', 4534)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtlenguajecultura', N'Ingrese cultura', 3529)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtlenguajenombre', N'Ingrese nombre del lenguaje', 4495)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtnuevotextoleyenda', N'Ingrese nuevo texto', 4162)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtusuario', N'Ingrese usuario', 2702)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtusuarioid', N'ID del usuario', 2672)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (1, N'txtusuarionombre', N'Nombre de usuario', 3472)
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
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'culturainvalida', N'Invalid Culture', 3141)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estaseguroborrarbackupseleccionado', N'Are you sure you want to delete the selected backup?', 8539)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estaseguroborrarelementoseleccionado', N'Are you sure to delete the selected item?', 7712)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estaseguroborraridiomaseleccionado', N'Are you sure to delete the selected Language?', 7855)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estasegurocrearnuevobackup', N'Are you sure you want to create a new backup?', 6982)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estasegurorestaurarbackupseleccionado', N'Are you sure you want to restore the DB from the selected backup?', 10008)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'estasegurosalir', N'Are you sure you want to leave and lose your changes?', 6615)
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
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdleyendas_columna0', N'ID Legend', 2878)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'grdleyendas_columna1', N'Reference Legend', 3649)
GO
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
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloasignarpermisosusuario', N'Assign Permissions to Users', 5768)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloeditargrupo', N'Edit Permission', 3400)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloeditaridioma', N'Edit Language', 3209)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'tituloeditarusuario', N'Edit User', 2969)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'titulonuevogrupo', N'Add Group', 2659)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'titulonuevoidioma', N'Add Language', 3008)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'titulonuevousuario', N'Add User', 2768)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtcontrasena', N'Enter Password', 2865)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtgruponombre', N'Insert Group Name', 3205)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtlenguajecultura', N'Enter Culture', 3295)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtlenguajenombre', N'Insert language name', 3834)
GO
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtnuevotextoleyenda', N'Insert New text', 3705)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtusuario', N'Insert USer', 2222)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtusuarioid', N'User ID', 1971)
INSERT [dbo].[IdiomaLeyenda] ([IDIdioma], [IDLeyenda], [Texto], [DVH]) VALUES (2, N'txtusuarionombre', N'User Name', 2653)
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (1, N'kS6FG3aa4JEjWYI4llCKGQ==', 1, N'21232F297A57A5A743894A0E4A801FC3', 0, 1, 2835, 0)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (2, N'Kaz8ncNkb3/4ED01oy0kgg==', 2, N'D432EB18017C004FD305969713A17AA8', 0, 1, 3024, 0)
INSERT [dbo].[Usuario] ([ID], [nombre], [IDIdioma], [password], [IntentosFallidos], [Habilitado], [DVH], [borrado]) VALUES (3, N'rzvaiyUnfYzlENk8GepKPw==', 1, N'AA47F8215C6F30A0DCDB2A36A9F4168E', 0, 1, 3013, 0)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[UsuarioElemento] ([IDElemento], [IDUsuario], [DVH]) VALUES (187, 3, 211)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_Elemento_descripcion]    Script Date: 10/4/2017 5:07:35 PM ******/
ALTER TABLE [dbo].[Elemento] ADD  CONSTRAINT [UC_Elemento_descripcion] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
