#criar banco
#ENGINE = InnoDBInnoDB;
create database dbvendas default character set utf8 default collate utf8_general_ci;
USE dbvendas;

-- --------------------------------------------------------
--  Criando cadastro de Pessoa
-- --------------------------------------------------------
CREATE TABLE tblpessoa (
    idpessoa INT not null AUTO_INCREMENT,
    idpessoatipo INT NOT NULL,
    cep VARCHAR(8) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    telefone VARCHAR(10),
    celular VARCHAR(11),
    email VARCHAR(50),
    PRIMARY KEY (idpessoa, idpessoatipo)
);#default charset = utf8;

CREATE TABLE tblpessoatipo (
    idpessoatipo INT not null AUTO_INCREMENT,
    descricao VARCHAR(20),
	PRIMARY KEY(idpessoatipo)
);#default charset = utf8;

CREATE TABLE tblpessoafisica (
    idpessoafisica INT not null AUTO_INCREMENT,
    cpf VARCHAR(11),
    rg VARCHAR(20),
    nomecompleto VARCHAR(100),
    PRIMARY KEY (idpessoafisica)
);#default charset = utf8;

CREATE TABLE tblpessoajuridica (
    idpessoajuridica INT not null AUTO_INCREMENT,
    cnpj VARCHAR(14),
    incricaoestadual VARCHAR(20),
    razaosocial VARCHAR(100),
    nomefantasia VARCHAR(50),
    PRIMARY KEY(idpessoajuridica)
);#default charset = utf8;

CREATE TABLE tblfilial (
    idpessoafilial INT not null PRIMARY KEY
);#default charset = utf8;

CREATE TABLE tblfornecedor (
    idpessoafornecedor INT not null PRIMARY KEY
);#default charset = utf8;

CREATE TABLE tblcliente (
    idpessoacliente INT not null PRIMARY KEY
);#default charset = utf8;
 
ALTER TABLE tblpessoa ADD CONSTRAINT FK_tblpessoa_ptipo
    FOREIGN KEY (idpessoatipo) REFERENCES tblpessoatipo (idpessoatipo);
ALTER TABLE tblpessoafisica ADD CONSTRAINT FK_tblfisic_pessoa
    FOREIGN KEY (idpessoafisica) REFERENCES tblpessoa (idpessoa);
ALTER TABLE tblpessoajuridica ADD CONSTRAINT FK_tbljurid_pessoa
    FOREIGN KEY (idpessoajuridica) REFERENCES tblpessoa (idpessoa);
ALTER TABLE tblfilial ADD CONSTRAINT FK_tblfilial_pessoa
    FOREIGN KEY (idpessoafilial) REFERENCES tblpessoa (idpessoa);
ALTER TABLE tblfornecedor ADD CONSTRAINT FK_tblfornec_pessoa
    FOREIGN KEY (idpessoafornecedor) REFERENCES tblpessoa (idpessoa);
ALTER TABLE tblcliente ADD CONSTRAINT FK_tblpessoa_cliente
    FOREIGN KEY (idpessoacliente) REFERENCES tblpessoa (idpessoa);
    
-- --------------------------------------------------------
--  Criando cadastro de produto
-- --------------------------------------------------------
create table tblproduto(
	idproduto int not null AUTO_INCREMENT,
    descricao varchar(100) not null,
    idcategoria int not null,
    primary key(idproduto, idcategoria)
);#default charset = uft8;

create TABLE tblcategoria(
	idcategoria int not null AUTO_INCREMENT,
    descricao varchar(50) not null,
    PRIMARY key (idcategoria)
);#default charset = utf8;

create table tblprecoproduto(
	idproduto int not null primary key,
    precocompra decimal(5,2) not null,
    precovenda decimal(5,2) not null
);#default charset = uft8;

ALTER TABLE tblprecoproduto ADD CONSTRAINT FK_tblpreco_prod
    FOREIGN KEY (idproduto) REFERENCES tblproduto (idproduto);
ALTER TABLE tblproduto ADD CONSTRAINT fk_tblproduto_categ
	FOREIGN KEY (idcategoria) REFERENCES tblcategoria(idcategoria);
    
-- --------------------------------------------------------
--  Criando estrutura do estoque
-- --------------------------------------------------------
CREATE TABLE tblestoque(
	idpessoafilial int not null,
    idproduto int not null,
    quantidade int not null,
	PRIMARY KEY (idpessoafilial, idproduto)
);#default charset = uft8;

CREATE TABLE tblestoquereservado(
	idpessoafilial int not null,
    idproduto int not null,
    quantidade int not null,
	PRIMARY KEY (idpessoafilial, idproduto)
);#default charset = uft8;

CREATE TABLE tblestoquemovimentado(
	idpessoafilial int not null,
    idproduto int not null,
    quantidade int not null,
    datahora DATETIME NOT NULL,
    estrousaiu char(1),
	PRIMARY KEY (idpessoafilial, idproduto)
);#default charset = uft8;


ALTER TABLE tblestoque ADD CONSTRAINT FK_tblestoque_filal
	FOREIGN KEY(idpessoafilial) references tblfilial(idpessoafilial);
ALTER TABLE tblestoque ADD CONSTRAINT FK_tblestoque_prodt
	FOREIGN KEY(idproduto) references tblproduto(idproduto);
ALTER TABLE tblestoquereservado ADD CONSTRAINT FK_tblreservado_estoque
	FOREIGN KEY(idpessoafilial) REFERENCES tblestoque(idpessoafilial);
ALTER TABLE tblestoquereservado ADD CONSTRAINT FK_tblreservado_estprod
	FOREIGN KEY(idproduto) REFERENCES tblestoque(idproduto);
ALTER TABLE tblestoquemovimentado ADD CONSTRAINT FK_tblmov_filial
	FOREIGN KEY(idpessoafilial) references tblfilial(idpessoafilial);
ALTER TABLE tblestoquemovimentado ADD CONSTRAINT FK_tblmov_prodt
	FOREIGN KEY(idproduto) references tblproduto(idproduto);

-- --------------------------------------------------------
--  Criando estrutura de Pedido
-- --------------------------------------------------------
CREATE TABLE tblpedido(
	idpedido int not null AUTO_INCREMENT,
    datahora DATETIME not null,
    idoperacao INT not null,
    idsituacao INT not null,
    idpessoaemitente int not null,
    idpessoadestinatario int not null,
    PRIMARY KEY(idpedido, idoperacao, idsituacao, idpessoaemitente, idpessoadestinatario)
); #default charset = uft8;

CREATE TABLE tblpedidoitem(
	idpedido int not null,
    idproduto int not null,
    quantidade INT not null,
    percentualdesconto DECIMAL(7,2) not null,
    valordesconto DECIMAL(5,2) not null,
    valortotal DECIMAL(7,2) not null,
    PRIMARY KEY(idpedido, idproduto)
);# default charset = uft8;

create table tbloperacao(
	idoperacao int AUTO_INCREMENT,
	descricao varchar(20) not null,
    primary key(idoperacao)
);#default charset = uft8;

create table tblsituacao(
	idsituacao int AUTO_INCREMENT,
	descricao varchar(20) not null,
    PRIMARY KEY(idsituacao)
);#default charset = uft8; 
 
ALTER TABLE tblpedido ADD CONSTRAINT FK_tblped_oper
	FOREIGN KEY(idoperacao) references tbloperacao(idoperacao);
ALTER TABLE tblpedido ADD CONSTRAINT FK_tblped_situa
	FOREIGN KEY(idsituacao) REFERENCES tblsituacao(idsituacao);
ALTER TABLE tblpedido ADD CONSTRAINT FK_tblped_emitente
	FOREIGN KEY(idpessoaemitente) REFERENCES tblpessoa(idpessoa);
ALTER TABLE tblpedido ADD CONSTRAINT FK_tblped_destina
	FOREIGN KEY(idpessoadestinatario) REFERENCES tblpessoa(idpessoa);

ALTER TABLE tblpedidoitem ADD CONSTRAINT FK_tblpeditem_ped
	FOREIGN KEY(idpedido) REFERENCES tblpedido(idpedido);
ALTER TABLE tblpedidoitem ADD CONSTRAINT FK_tblpeditem_prod
	FOREIGN KEY(idproduto) references tblproduto(idproduto);
  
-- --------------------------------------------------------
--  Criando estrutura de Funcionario
-- --------------------------------------------------------

create table tblfuncionario(
	idfunc int not null AUTO_INCREMENT,
    idpessoafilial int not null DEFAULT 1,
    nomecompleto VARCHAR(100) not null DEFAULT 'funcionario',
    login VARCHAR(50) not null DEFAULT 'funcionario',
    senha VARCHAR(50) not null DEFAULT '123456',
    PRIMARY KEY(idfunc, idpessoafilial)
);#default charset = uft8;

ALTER TABLE tblfuncionario ADD CONSTRAINT FK_tblfun_fili
	FOREIGN KEY(idpessoafilial) REFERENCES tblfilial(idpessoafilial);

-- --------------------------------------------------------
--  Inserido dados na tabelas
-- --------------------------------------------------------
insert into tblpessoatipo(descricao) values('Fisico');
insert into tblpessoatipo(descricao) values('Juridico');
INSERT INTO tbloperacao(descricao) VALUES('Compra');
INSERT INTO tbloperacao(descricao) VALUES('Venda');
INSERT INTO tblsituacao(descricao) VALUES('Aberto');
INSERT INTO tblsituacao(descricao) VALUES('Fechado');
#INSERT dados na tabela pessoafisica
#call uspPessoaFisicaInserir('07261662448','7755065','Luis Santana','55500050','vasco da gama, 334','vasco da gama','recife','PE','8132326060','81985323260','luissantananet@gmail.com');
#call uspFuncionarioInserir(1,'ADMINISTRADOR','adm','adm2020');