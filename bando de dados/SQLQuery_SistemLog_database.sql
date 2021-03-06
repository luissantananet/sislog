USE [master]
GO
/****** Object:  Database [Sistemlog]    Script Date: 14/02/2016 20:01:05 ******/
CREATE DATABASE [Sistemlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sistemlog', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Sistemlog.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Sistemlog_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Sistemlog_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Sistemlog] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sistemlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sistemlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sistemlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sistemlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sistemlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sistemlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sistemlog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Sistemlog] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Sistemlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sistemlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sistemlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sistemlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sistemlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sistemlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sistemlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sistemlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sistemlog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sistemlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sistemlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sistemlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sistemlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sistemlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sistemlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sistemlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sistemlog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Sistemlog] SET  MULTI_USER 
GO
ALTER DATABASE [Sistemlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sistemlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sistemlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sistemlog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Sistemlog]
GO
/****** Object:  Table [dbo].[tblCliente]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCliente](
	[IDPessoaCliente] [int] NOT NULL,
 CONSTRAINT [PK_tblCliente] PRIMARY KEY CLUSTERED 
(
	[IDPessoaCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblEmail]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEmail](
	[IDPessoaEmail] [int] NOT NULL,
	[Email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblEmail] PRIMARY KEY CLUSTERED 
(
	[IDPessoaEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblEndereco]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEndereco](
	[IDPessoa] [int] NOT NULL,
	[Endereco] [varchar](50) NOT NULL,
	[Bairro] [varchar](50) NOT NULL,
	[CEP] [varchar](8) NOT NULL,
	[Cidade] [varchar](50) NOT NULL,
	[UF] [varchar](2) NOT NULL,
 CONSTRAINT [PK_tblEndereco] PRIMARY KEY CLUSTERED 
(
	[IDPessoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblEstoque]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEstoque](
	[IDPessoaFilial] [int] NOT NULL,
	[IDProduto] [int] NOT NULL,
	[Quantidade] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_tblEstoque] PRIMARY KEY CLUSTERED 
(
	[IDPessoaFilial] ASC,
	[IDProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblEstoqueMovimentado]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEstoqueMovimentado](
	[IDEstoqueMovimentado] [int] IDENTITY(1,1) NOT NULL,
	[IDPessoaFilial] [int] NOT NULL,
	[IDProduto] [int] NOT NULL,
	[Quantidade] [numeric](18, 2) NOT NULL,
	[DataHora] [datetime] NOT NULL,
	[EntrouSaiu] [char](1) NOT NULL,
 CONSTRAINT [PK_tblEstoqueMovimentado] PRIMARY KEY CLUSTERED 
(
	[IDEstoqueMovimentado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblEstoqueReservado]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEstoqueReservado](
	[IDPessoaFilial] [int] NOT NULL,
	[IDProduto] [int] NOT NULL,
	[Quantidade] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_tblEstoqueReservado] PRIMARY KEY CLUSTERED 
(
	[IDPessoaFilial] ASC,
	[IDProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblFilial]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFilial](
	[IDPessoaFilial] [int] NOT NULL,
	[DataFuzao] [date] NOT NULL,
 CONSTRAINT [PK_tblFilial] PRIMARY KEY CLUSTERED 
(
	[IDPessoaFilial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblFornecedor]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFornecedor](
	[IDPessoaFornecedor] [int] NOT NULL,
 CONSTRAINT [PK_tblFornecedor] PRIMARY KEY CLUSTERED 
(
	[IDPessoaFornecedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblOperacao]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOperacao](
	[IDOperacao] [int] NOT NULL,
	[Descricao] [varchar](20) NOT NULL,
 CONSTRAINT [PK_tblOperacao] PRIMARY KEY CLUSTERED 
(
	[IDOperacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPedido]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPedido](
	[IDPedido] [int] IDENTITY(1,1) NOT NULL,
	[DataHora] [datetime] NOT NULL,
	[IDOperacao] [int] NOT NULL,
	[IDSituacao] [int] NOT NULL,
	[IDPessoaEmitente] [int] NOT NULL,
	[IDPEssoaDestinatario] [int] NOT NULL,
 CONSTRAINT [PK_tblPedido] PRIMARY KEY CLUSTERED 
(
	[IDPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPedidoItem]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPedidoItem](
	[IDPedido] [int] NOT NULL,
	[IDProduto] [int] NOT NULL,
	[Quantidade] [decimal](18, 2) NOT NULL,
	[ValorUnitario] [decimal](18, 2) NOT NULL,
	[PercentualDesconto] [decimal](5, 2) NOT NULL,
	[ValorDesconto] [decimal](18, 2) NOT NULL,
	[ValorTotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_tblPedidoItem] PRIMARY KEY CLUSTERED 
(
	[IDPedido] ASC,
	[IDProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPessoa]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPessoa](
	[IDPessoa] [int] IDENTITY(1,1) NOT NULL,
	[IDPessoaTipo] [int] NOT NULL,
 CONSTRAINT [PK_tblPessoa] PRIMARY KEY CLUSTERED 
(
	[IDPessoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPessoaFisica]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPessoaFisica](
	[IDPessoaFisica] [int] NOT NULL,
	[CPF] [varchar](11) NOT NULL,
	[RG] [varchar](20) NULL,
	[NomeCompleto] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblPessoaFisica] PRIMARY KEY CLUSTERED 
(
	[IDPessoaFisica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPessoaJuridica]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPessoaJuridica](
	[IDPessoaJuridica] [int] NOT NULL,
	[CNPJ] [varchar](14) NOT NULL,
	[InscricaoEstadual] [varchar](20) NULL,
	[RazaoSocial] [varchar](50) NOT NULL,
	[NomeFantasia] [varchar](50) NULL,
 CONSTRAINT [PK_tblPessoaJuridica] PRIMARY KEY CLUSTERED 
(
	[IDPessoaJuridica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPessoaTipo]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPessoaTipo](
	[IDPessoaTipo] [int] NOT NULL,
	[Descricao] [varchar](20) NOT NULL,
 CONSTRAINT [PK_tblPessoaTipo_1] PRIMARY KEY CLUSTERED 
(
	[IDPessoaTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPreco]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPreco](
	[IDProduto] [int] NOT NULL,
	[PrecoCusto] [numeric](5, 2) NOT NULL,
	[PrecoVenda] [numeric](5, 2) NOT NULL,
 CONSTRAINT [PK_tblPreco] PRIMARY KEY CLUSTERED 
(
	[IDProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProduto]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProduto](
	[IDProduto] [int] IDENTITY(1,1) NOT NULL,
	[Ean] [varchar](14) NOT NULL,
	[Descricao] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tblProduto] PRIMARY KEY CLUSTERED 
(
	[IDProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSituacao]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSituacao](
	[IDSituacao] [int] NOT NULL,
	[Descricao] [varchar](20) NOT NULL,
	[IDOperacao] [int] NOT NULL,
 CONSTRAINT [PK_tblSituacao] PRIMARY KEY CLUSTERED 
(
	[IDSituacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTelefone]    Script Date: 14/02/2016 20:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTelefone](
	[IDPessoa] [int] NOT NULL,
	[Telefone] [varchar](10) NOT NULL,
	[Fax] [varchar](10) NULL,
	[Celular] [varchar](11) NULL,
 CONSTRAINT [PK_tblTelefone] PRIMARY KEY CLUSTERED 
(
	[IDPessoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tblPessoaFisica_CPF]    Script Date: 14/02/2016 20:01:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblPessoaFisica_CPF] ON [dbo].[tblPessoaFisica]
(
	[CPF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tblPessoaJuridica_CNPJ]    Script Date: 14/02/2016 20:01:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblPessoaJuridica_CNPJ] ON [dbo].[tblPessoaJuridica]
(
	[CNPJ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tblProduto]    Script Date: 14/02/2016 20:01:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblProduto] ON [dbo].[tblProduto]
(
	[Ean] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPedido] ADD  CONSTRAINT [DF_tblPedido_DataHora]  DEFAULT (getdate()) FOR [DataHora]
GO
ALTER TABLE [dbo].[tblCliente]  WITH CHECK ADD  CONSTRAINT [FK_tblCliente_tblPessoa] FOREIGN KEY([IDPessoaCliente])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblCliente] CHECK CONSTRAINT [FK_tblCliente_tblPessoa]
GO
ALTER TABLE [dbo].[tblEmail]  WITH CHECK ADD  CONSTRAINT [FK_tblEmail_tblPessoa] FOREIGN KEY([IDPessoaEmail])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblEmail] CHECK CONSTRAINT [FK_tblEmail_tblPessoa]
GO
ALTER TABLE [dbo].[tblEndereco]  WITH CHECK ADD  CONSTRAINT [FK_tblEndereco_tblPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblEndereco] CHECK CONSTRAINT [FK_tblEndereco_tblPessoa]
GO
ALTER TABLE [dbo].[tblEstoque]  WITH CHECK ADD  CONSTRAINT [FK_tblEstoque_tblFilial] FOREIGN KEY([IDPessoaFilial])
REFERENCES [dbo].[tblFilial] ([IDPessoaFilial])
GO
ALTER TABLE [dbo].[tblEstoque] CHECK CONSTRAINT [FK_tblEstoque_tblFilial]
GO
ALTER TABLE [dbo].[tblEstoque]  WITH CHECK ADD  CONSTRAINT [FK_tblEstoque_tblProduto] FOREIGN KEY([IDProduto])
REFERENCES [dbo].[tblProduto] ([IDProduto])
GO
ALTER TABLE [dbo].[tblEstoque] CHECK CONSTRAINT [FK_tblEstoque_tblProduto]
GO
ALTER TABLE [dbo].[tblEstoqueMovimentado]  WITH CHECK ADD  CONSTRAINT [FK_tblEstoqueMovimentado_tblFilial] FOREIGN KEY([IDPessoaFilial])
REFERENCES [dbo].[tblFilial] ([IDPessoaFilial])
GO
ALTER TABLE [dbo].[tblEstoqueMovimentado] CHECK CONSTRAINT [FK_tblEstoqueMovimentado_tblFilial]
GO
ALTER TABLE [dbo].[tblEstoqueMovimentado]  WITH CHECK ADD  CONSTRAINT [FK_tblEstoqueMovimentado_tblProduto] FOREIGN KEY([IDProduto])
REFERENCES [dbo].[tblProduto] ([IDProduto])
GO
ALTER TABLE [dbo].[tblEstoqueMovimentado] CHECK CONSTRAINT [FK_tblEstoqueMovimentado_tblProduto]
GO
ALTER TABLE [dbo].[tblEstoqueReservado]  WITH CHECK ADD  CONSTRAINT [FK_tblEstoqueReservado_tblEstoque] FOREIGN KEY([IDPessoaFilial], [IDProduto])
REFERENCES [dbo].[tblEstoque] ([IDPessoaFilial], [IDProduto])
GO
ALTER TABLE [dbo].[tblEstoqueReservado] CHECK CONSTRAINT [FK_tblEstoqueReservado_tblEstoque]
GO
ALTER TABLE [dbo].[tblFilial]  WITH CHECK ADD  CONSTRAINT [FK_tblFilial_tblPessoa] FOREIGN KEY([IDPessoaFilial])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblFilial] CHECK CONSTRAINT [FK_tblFilial_tblPessoa]
GO
ALTER TABLE [dbo].[tblFornecedor]  WITH CHECK ADD  CONSTRAINT [FK_tblFornecedor_tblPessoa] FOREIGN KEY([IDPessoaFornecedor])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblFornecedor] CHECK CONSTRAINT [FK_tblFornecedor_tblPessoa]
GO
ALTER TABLE [dbo].[tblPedido]  WITH CHECK ADD  CONSTRAINT [FK_tblPedido_tblOperacao] FOREIGN KEY([IDOperacao])
REFERENCES [dbo].[tblOperacao] ([IDOperacao])
GO
ALTER TABLE [dbo].[tblPedido] CHECK CONSTRAINT [FK_tblPedido_tblOperacao]
GO
ALTER TABLE [dbo].[tblPedido]  WITH CHECK ADD  CONSTRAINT [FK_tblPedido_tblPessoa_Destinatario] FOREIGN KEY([IDPEssoaDestinatario])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblPedido] CHECK CONSTRAINT [FK_tblPedido_tblPessoa_Destinatario]
GO
ALTER TABLE [dbo].[tblPedido]  WITH CHECK ADD  CONSTRAINT [FK_tblPedido_tblPessoa_Emitente] FOREIGN KEY([IDPessoaEmitente])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblPedido] CHECK CONSTRAINT [FK_tblPedido_tblPessoa_Emitente]
GO
ALTER TABLE [dbo].[tblPedido]  WITH CHECK ADD  CONSTRAINT [FK_tblPedido_tblSituacao] FOREIGN KEY([IDSituacao])
REFERENCES [dbo].[tblSituacao] ([IDSituacao])
GO
ALTER TABLE [dbo].[tblPedido] CHECK CONSTRAINT [FK_tblPedido_tblSituacao]
GO
ALTER TABLE [dbo].[tblPedidoItem]  WITH CHECK ADD  CONSTRAINT [FK_tblPedidoItem_tblPedido] FOREIGN KEY([IDPedido])
REFERENCES [dbo].[tblPedido] ([IDPedido])
GO
ALTER TABLE [dbo].[tblPedidoItem] CHECK CONSTRAINT [FK_tblPedidoItem_tblPedido]
GO
ALTER TABLE [dbo].[tblPedidoItem]  WITH CHECK ADD  CONSTRAINT [FK_tblPedidoItem_tblProduto] FOREIGN KEY([IDProduto])
REFERENCES [dbo].[tblProduto] ([IDProduto])
GO
ALTER TABLE [dbo].[tblPedidoItem] CHECK CONSTRAINT [FK_tblPedidoItem_tblProduto]
GO
ALTER TABLE [dbo].[tblPessoa]  WITH CHECK ADD  CONSTRAINT [FK_tblPessoa_tblPessoaTipo] FOREIGN KEY([IDPessoaTipo])
REFERENCES [dbo].[tblPessoaTipo] ([IDPessoaTipo])
GO
ALTER TABLE [dbo].[tblPessoa] CHECK CONSTRAINT [FK_tblPessoa_tblPessoaTipo]
GO
ALTER TABLE [dbo].[tblPessoaFisica]  WITH CHECK ADD  CONSTRAINT [FK_tblPessoaFisica_tblPessoa] FOREIGN KEY([IDPessoaFisica])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblPessoaFisica] CHECK CONSTRAINT [FK_tblPessoaFisica_tblPessoa]
GO
ALTER TABLE [dbo].[tblPessoaJuridica]  WITH CHECK ADD  CONSTRAINT [FK_tblPessoaJuridica_tblPessoa] FOREIGN KEY([IDPessoaJuridica])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblPessoaJuridica] CHECK CONSTRAINT [FK_tblPessoaJuridica_tblPessoa]
GO
ALTER TABLE [dbo].[tblPreco]  WITH CHECK ADD  CONSTRAINT [FK_tblPreco_tblProduto] FOREIGN KEY([IDProduto])
REFERENCES [dbo].[tblProduto] ([IDProduto])
GO
ALTER TABLE [dbo].[tblPreco] CHECK CONSTRAINT [FK_tblPreco_tblProduto]
GO
ALTER TABLE [dbo].[tblSituacao]  WITH CHECK ADD  CONSTRAINT [FK_tblSituacao_tblOperacao] FOREIGN KEY([IDOperacao])
REFERENCES [dbo].[tblOperacao] ([IDOperacao])
GO
ALTER TABLE [dbo].[tblSituacao] CHECK CONSTRAINT [FK_tblSituacao_tblOperacao]
GO
ALTER TABLE [dbo].[tblTelefone]  WITH CHECK ADD  CONSTRAINT [FK_tblTelefone_tblPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[tblPessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[tblTelefone] CHECK CONSTRAINT [FK_tblTelefone_tblPessoa]
GO
USE [master]
GO
ALTER DATABASE [Sistemlog] SET  READ_WRITE 
GO
