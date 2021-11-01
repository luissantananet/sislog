DELIMITER //
create procedure uspPessoaFisicaInserir(
		#dados da tblpessoafisica
		cpffis varchar(11), rgfis varchar(20), nomecompletofis varchar(100),
        #dados da tblpessoa
        ceppes varchar(8), endpes varchar(100), bairropes varchar(50), cidadespes varchar(50), ufpes varchar(2), telefone varchar(10), celular varchar(11),email varchar(50)
)
begin
	start transaction;
		# inserir na tabela tblpessoa
        insert into tblpessoa(idpessoatipo,cep, endereco, bairro, cidade, uf, telefone, celular,email)
        values(1,ceppes, endpes, bairropes, cidadespes, ufpes, telefone, celular,email);
        #inserir na tebela tblpessoafisica
        insert into tblpessoafisica(cpf,rg,nomecompleto)
        values(cpffis, rgfis, nomecompletofis);
	commit;
end //
Delimiter ;