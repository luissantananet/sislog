DELIMITER //

create procedure uspPedidoInserir(
	datahoras DATETIME,
    idclientes int,
    #idpedidos int,
    idprodutos int,
    quantidades INT,
    valorunitarios decimal(7,2),
    percentualdescontos DECIMAL(7,2),
    valordescontos DECIMAL(5,2),
    valortotals DECIMAL(7,2)
)
begin
	start transaction;
		insert into tblpedido(datahora,idcliente) 
			values(datahoras,idclientes);
        select last_insert_id() into @ippedido;
        insert into tblpedidoitem(idpedido, idproduto,quantidade,valorunitario,percentualdesconto,valordesconto,valortotal) 
			values(@ippedido,idprodutos,quantidades,valorunitarios,percentualdescontos,valordescontos,valortotals);
	commit;
end //
Delimiter ;