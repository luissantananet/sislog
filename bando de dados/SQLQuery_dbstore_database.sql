# Criar Banco de Dados
create database dbstore;
# Usar o Banco
use dbstore;

create table tbllogin(
	idlogin int not null auto_increment,
    nome VARCHAR(100) not null,
    login VARCHAR(50) not null,
    senha VARCHAR(50) not null,
    primary key(idlogin)
);
create table tblmarkup(
	idkup int not null auto_increment,
    df decimal(5,2),
    dv decimal(5,2),
    lp decimal(5,2),
	markup decimal(5,2),
    primary key(idkup)
);
create table tblproduto(
	idproduto int not null auto_increment,
    ean varchar(13),
    descricao varchar(100),
    categoria varchar(100),
    fabricante varchar(100),
    unidade varchar(6),
    precocusto decimal(6,2),
    markup decimal(5,2),
    precovenda decimal(6,2),
    primary key(idproduto)
);
create table tblestoque(
	idestoque int not null auto_increment,
    quantidade varchar(5),
    primary key(idestoque)
);
ALTER TABLE tblestoque ADD CONSTRAINT FK_tblprod_estoq
	FOREIGN KEY(idestoque) REFERENCES tblproduto(idproduto);

CREATE TABLE tblcliente(
    idcliente INT not null AUTO_INCREMENT,
    cnpjcpf varchar(14) not null,
    descricao varchar(200) not null,
    cep VARCHAR(8) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    telefone VARCHAR(10),
    celular VARCHAR(11),
    email VARCHAR(50),
    PRIMARY KEY (idcliente)
);
-- --------------------------------------------------------
--  Criando estrutura de Pedido
-- --------------------------------------------------------
CREATE TABLE tblpedido(
	idpedido int not null AUTO_INCREMENT,
    datahora DATETIME not null,
    idcliente int not null,
    PRIMARY KEY(idpedido, idcliente)
); #default charset = uft8;

CREATE TABLE tblpedidoitem(
	idpedido int not null,
    idproduto int not null,
    quantidade INT not null,
    valorunitario decimal(7,2) not null,
    percentualdesconto DECIMAL(7,2) not null,
    valordesconto DECIMAL(5,2) not null,
    valortotal DECIMAL(7,2) not null,
    PRIMARY KEY(idproduto)
);
#ligação entre a tblpedido e tblcliente
ALTER TABLE tblpedido ADD CONSTRAINT FK_tblped_client
	FOREIGN KEY(idcliente) REFERENCES tblcliente(idcliente);
#ligação entre a tblpedido e tblpedidoitem
ALTER TABLE tblpedidoitem ADD CONSTRAINT FK_tblpeditem_ped
	FOREIGN KEY(idpedido) REFERENCES tblpedido(idpedido);
ALTER TABLE tblpedidoitem ADD CONSTRAINT FK_tblpeditem_prod
	FOREIGN KEY(idproduto) references tblproduto(idproduto);

-- --------------------------------------------------------
--  Inserido dados na tabelas
-- --------------------------------------------------------

insert into tbllogin(nome, login, senha) values('Administrador','adm','adm');
insert into tblcliente(cnpjcpf,descricao,cep,endereco,bairro,cidade,uf,telefone,celular,email) values('12378123000182','Consumidor','90200500','rua do consumidor','São Luiz','Gravataí','RS','8133048810','81988101037','teste@testes.com.br');