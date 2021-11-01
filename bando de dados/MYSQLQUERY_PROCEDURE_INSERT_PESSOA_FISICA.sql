CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_up_ins_pessoafisica`(
    cpf VARCHAR(11), 
    rg VARCHAR(20),
    nomecompleto VARCHAR(100),
    idpessoatipo INT,
    cep VARCHAR(8),
    endereco VARCHAR(100),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    uf VARCHAR(2),
    telefone VARCHAR(10),
    celular VARCHAR(11),
    email VARCHAR(50) )
if(exists(select idpessoafisica from tblpessoafisica where tblpessoafisica.cpf =  tblpessoafisica.cpf)) then
			
BEGIN
	UPDATE tblpessoafisica SET nomecompleto = nomecompleto;
    update tblpessoa set idpessoatipo = idpessoatipo, cep = cep, endereco = endereco, bairro = bairro, cidade = cidade, uf = uf, telefone = telefone, celular = celular, email = email; 
end;
else
BEGIN
	# inserindo no cadastro 
	# inserir na tabela tblpessoa
	#INSERT INTO tblpessoa(idpessoatipo) VALUES(2);
    INSERT INTO tblpessoa (idpessoatipo, cep, endereco , bairro, cidade, uf, telefone, celular, email) 
		VALUES (idpessoatipo, cep, endereco , bairro, cidade, uf, telefone, celular, email);
    #inserindo na tabela tblpessoaficica
	INSERT INTO tblpessoafisica(cpf, rg , nomecompleto)
		VALUES(cpf, rg , nomecompleto);
	
end;
END IF