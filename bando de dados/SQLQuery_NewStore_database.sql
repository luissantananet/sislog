# Criar Banco de Dados
create database store default character set utf8 default collate utf8_general_ci;
# Usar o Banco
use store;

create table login(
	idlogin int not null auto_increment,
    nome varchar(100),
    senha varchar(100),
    primary key(idlogin)
);
create table markup(
	idkup int not null auto_increment,
    df decimal(5,2),
    dv decimal(5,2),
    lp decimal(5,2),
	markup decimal(5,2),
    primary key(idkup)
);
create table produto(
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
create table estoque(
	idestoque int not null auto_increment,
    quantidade varchar(5),
    primary key(idestoque)
);
