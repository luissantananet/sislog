DELIMITER //
create procedure uspPessoaJuridicaInserir(
		#dados da tblpessoafisica
		cnpjj varchar(14), inscest varchar(20), razaosaocialj varchar(100), nomefaj varchar(50),
        #dados da tblpessoa
        ceppes varchar(8), endpes varchar(100), bairropes varchar(50), cidadespes varchar(50), ufpes varchar(2), telefone varchar(10), celular varchar(11),email varchar(50)
)
begin
	start transaction;
		# inserir na tabela tblpessoa
		insert into tblpessoa(idpessoatipo,cep, endereco, bairro, cidade, uf, telefone, celular,email)
		values(2,ceppes, endpes, bairropes, cidadespes, ufpes, telefone, celular,email);
        #inserir na tebela tblpessoafisica
		insert into tblpessoafisica(cnpj, incricaoestadual, razaosaocial, nomefantasia)
		values(cnpjj, inscest, razaosaocialj, nomefaj);
	commit;
end //
Delimiter ;