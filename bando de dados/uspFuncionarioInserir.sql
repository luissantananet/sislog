DELIMITER //

create procedure uspFuncionarioInserir(
	idfilial int, nome_func varchar(100),login_func varchar(50),senha_func varchar(50)
    
)
begin
	start transaction;
		select last_insert_id() into @idpessoafilial;
		insert into tblfuncionario(idpessoafilial,nomecompleto,login,senha)
        values(idfilial,nome_func,login_func,senha_func);
	commit;
end //
Delimiter ;