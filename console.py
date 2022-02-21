from ctypes.wintypes import FLOAT
from PyQt5 import uic, QtWidgets, QtGui
from PyQt5.QtWidgets import QMessageBox
import mysql.connector
import mysql.connector.errors

numero_id = 0
# conexões com o banco de dados
banco = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="cofggcvf",
    database="dbstore")
# funções da tela login
def funcao_login():
    #frm_login.lineuser.setText("")
    nome_user =frm_login.lineuser.text()
    key = frm_login.linekey.text()
    
    cursor2 = banco.cursor()
    comando_sql = "SELECT senha FROM tbllogin WHERE login ='{}'".format(nome_user)
    cursor2.execute(comando_sql)
    #nome = cursor2.fetchall()
    senha_db = cursor2.fetchall()
    #print(nome, senha_db)
    if key == senha_db[0][0] : #nome[0][1] == nome_user and
        frm_login.close()
        frm_principal.show()
    else:
        #frm_login.close()
        QMessageBox.about(frm_login, "Erro", "Usuário ou senha invalido!")       
# funções da tela de cadastro Usuário
def cadastrousuario():
    linhanome = frm_caduser.lineNome.text() #campo Nome
    linhauser = frm_caduser.lineUser.text() #campo Usuário
    linhakey = frm_caduser.lineKey.text() #campo senha
    #comando mysql para inserir dados no banco
    cursor = banco.cursor()
    comando_SQL = "INSERT INTO tbllogin (nome, login, senha) VALUES (%s,%s,%s)"
    dados = (str(linhanome),str(linhauser),str(linhakey))
    cursor.execute(comando_SQL,dados)
    banco.commit()
    frm_caduser.lineNome.setText('')
    frm_caduser.lineUser.setText('')
    frm_caduser.lineKey.setText('')
# funções da tela da Calcular Markup
def calcular():
    dv = str(frm_markup.linedv.text()).replace(',','.')
    dv1 = float(dv)
    df = str(frm_markup.linedf.text()).replace(',','.')
    df1 = float(df)
    lp = str(frm_markup.linelp.text()).replace(',','.')
    lp1 = float(lp)
    markups = 100 / (100 - (dv1 + df1 + lp1))
    frm_markup.linemarkup.setText("{:.2f}".format(markups))
# funções da tela da Calcular Markup
def enviarmarkup():
    markups2 = frm_markup.linemarkup.text()
    precocompra = str(frm_produto.precounid.text()).replace(',','.')
    precocompra = float(precocompra)
    frm_markup.close()
    frm_produto.linemarkup.setText(str(markups2))
    if not precocompra == '':
        markup = float(frm_produto.linemarkup.text())
        venda = float(precocompra) + markup
        frm_produto.precovenda.setText("{:.2f}".format(venda).replace('.',','))
# funções da tela de produtos
def cadastroProduto():
    global numero_id
    id = frm_produto.lineID.text() #campo ID
    linhaCod = frm_produto.line_ean.text() #campo codico
    linhaDesc = frm_produto.line_descricao.text() #campo descrição 
    linhaGrupo = frm_produto.line_grupo.text() #campo grupo
    linhaFab = frm_produto.line_fabric.text() #campo fabricante 
    linhaUnd = frm_produto.line_tipo_und.text() #campo undade
    linhaPrecocomp = frm_produto.precounid.text().replace(',','.') #campo preço por unidade
    linhaprecovenda = frm_produto.precovenda.text().replace(',','.') #campo preço de venda
    linhamarkup = frm_produto.linemarkup.text().replace(',','.') #campo margem de lucro
    #comando mysql para inserir dados no banco
    if id == " ":
        cursor = banco.cursor()
        comando_SQL = "INSERT INTO tblproduto (ean, descricao, categoria, fabricante, unidade, precocusto, markup, precovenda) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
        dados = (str(linhaCod), str(linhaDesc), str(linhaGrupo), str(linhaFab), str(linhaUnd), float(linhaPrecocomp), float(linhamarkup), float(linhaprecovenda))
        cursor.execute(comando_SQL,dados)
        banco.commit()
    else:
        cursor = banco.cursor()
        cursor.execute ("UPDATE tblproduto SET ean='{}', descricao='{}', categoria='{}', fabricante='{}', unidade='{}', precocusto='{}', markup='{}', precovenda='{}' WHERE idproduto {}".format(linhaCod,linhaDesc,linhaGrupo,linhaFab,linhaUnd,linhaPrecocomp,linhamarkup,linhaprecovenda,numero_id))
        banco.commit()


    linhaCod = frm_produto.line_ean.setText('') #campo codico
    linhaDesc = frm_produto.line_descricao.setText('') #campo descrição 
    linhaGrupo = frm_produto.line_grupo.setText('') #campo grupo
    linhaFab = frm_produto.line_fabric.setText('') #campo fabricante 
    linhaUnd = frm_produto.line_tipo_und.setText('') #campo undade
    linhaPrecocomp = frm_produto.precounid.setText('') #campo preço por unidade
    linhaprecovenda = frm_produto.precovenda.setText('') #campo preço de venda
    linhamarkup = frm_produto.linemarkup.setText('') #campo margem de lucro
def excluir_produtos():
    global numero_id
    linha = frm_pesquisa_produto.tableWidget.currentRow()
    cursor = banco.cursor()
    cursor.execute("SELECT idproduto FROM tblproduto")
    dados_lidos = cursor.fetchall()
    valor_id = dados_lidos[linha][0]
    if valor_id != " ":
        cursor = banco.cursor()
        cursor.execute("delete from tblproduto WHERE idproduto ="+int(valor_id))
        #frm_pesquisa_produto.tableWidget.removeRow(linha)
    else:
        QMessageBox.about(frm_pesquisa_produto, "Erro", "Porduto não selecionado!")

def editar_produto():
    global numero_id
    linha = frm_pesquisa_produto.tableWidget.currentRow()

    cursor = banco.cursor()
    comando_SQL = "SELECT * FROM tblproduto"
    cursor.execute(comando_SQL)
    dados_lidos = cursor.fetchall()
    valor_id = dados_lidos[linha][0]
    cursor.execute("SELECT * FROM tblproduto WHERE idproduto="+str(valor_id))
    produto = cursor.fetchall()
    frm_produto.show()
    frm_produto.lineID.setText(str(produto[0][0])) #campo ID
    frm_produto.line_ean.setText(str(produto[0][1])) #campo EAN(codico do produto)
    frm_produto.line_descricao.setText(str(produto[0][2])) #campo descrição 
    frm_produto.line_grupo.setText(str(produto[0][3])) #campo grupo
    frm_produto.line_fabric.setText(str(produto[0][4])) #campo fabricante 
    frm_produto.line_tipo_und.setText(str(produto[0][5])) #campo undade
    frm_produto.precounid.setText(str(produto[0][6])) #campo preço por unidade
    frm_produto.precovenda.setText(str(produto[0][7])) #campo preço de venda
    frm_produto.linemarkup.setText(str(produto[0][8])) #campo margem de lucro
    
    numero_id = valor_id    
    frm_pesquisa_produto.close()
# funções da tela de cadastro clientes
def cadastroCliente():
    global numero_id
    idcliente = frm_cliente.line_id.text() #campo ID
    cnpjcpf = frm_cliente.line_cnpjcpf.text()
    descricao = frm_cliente.line_descricao.text()
    cep = frm_cliente.line_cep.text()
    endereco = frm_cliente.line_endereco.text()
    bairro = frm_cliente.line_bairro.text()
    cidade = frm_cliente.line_cidade.text()
    estado = frm_cliente.line_estado.text()
    telefone = frm_cliente.line_telefone.text()
    celular = frm_cliente.line_celular.txt()
    email = frm_cliente.line_email.text()
    #comando mysql para inserir dados no banco
    cursor = banco.cursor()
    comando_SQL_id = "SELECT id FROM tblcliente"
    cursor.execute(comando_SQL_id)
    numero_id = cursor.fetchall()
    if not idcliente == numero_id:
        cursor = banco.cursor()
        comando_SQL = "INSERT INTO tblcliente (cnpcpf,descricao,cep,endereco,bairro,cidade,uf,telefone,celular,email) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        dados = (str(cnpjcpf), str(descricao), str(cep), str(endereco), str(bairro), str(cidade), str(estado), str(telefone),str(celular),str(email))
        cursor.execute(comando_SQL,dados)
        banco.commit()
    else:
        cursor = banco.cursor()
        cursor.execute ("UPDATE tblcliente SET cnpcpf ='{}', descricao ='{}', cep ='{}', endereco ='{}', bairro ='{}',cidade ='{}', uf ='{}', telefone ='{}', celular = '{}', email = '{}' WHERE id {}".format(cnpjcpf,descricao,cep,endereco,bairro,cidade,estado,telefone,celular,email,numero_id))
        banco.commit()
def excluirCliente():
    linhacliente = frm_pesquisa_cliente.tableWidget.currentRow()
    frm_pesquisa_cliente.tableWidget.removeRow(linhacliente)

    cursor = banco.cursor()
    cursor.execute("SELECT idcliente FROM tblcliente")
    dados_lidos = cursor.fetchall()
    valor_id = dados_lidos[linhacliente][0]
    cursor.execute("DELETE FROM tblcliente WHERE idcliente="+str(valor_id))
def editarCliente():
    global numero_id
    linhacliente = frm_pesquisa_cliente.tableWidget.currentRow()
    
    cursor = banco.cursor()
    comando_SQL = "SELECT * FROM tblcliente"
    cursor.execute(comando_SQL)
    dados_lidos = cursor.fetchall()
    valor_id = dados_lidos[linhacliente][0]
    cursor.execute("SELECT * FROM tblcliente WHERE idcliente="+str(valor_id))
    clientes = cursor.fetchall()
    frm_produto.show()

    frm_cliente.line_id.setText(str(clientes[0][0])) #campo ID
    frm_cliente.line_cnpjcpf.setText(str(clientes[0][1])) #campo CNPJ/CPF
    frm_cliente.line_descricao.setText(str(clientes[0][2])) #campo Descrição
    frm_cliente.line_cep.setText(str(clientes[0][3])) #campo CEP
    frm_cliente.line_endereco.setText(str(clientes[0][4])) #campo Endereço
    frm_cliente.line_bairro.setText(str(clientes[0][5])) #campo Bairro
    frm_cliente.line_cidade.setText(str(clientes[0][6])) #campo Cidade
    frm_cliente.line_estado.setText(str(clientes[0][7])) #campo Estado
    frm_cliente.line_telefone.setText(str(clientes[0][8])) #campo Telefone
    frm_cliente.line_celular.setText(str(clientes[0][9])) #campo Celular
    frm_cliente.line_email.setText(str(clientes[0][10])) #campo E-mail
    
    numero_id = valor_id 
# funções da tela vendas(pedidos)
def inserir_produto():
    # Inserindo produtos no grid(lista)
    rowPosition = frm_vendas.tableWidget.rowCount()
    frm_vendas.tableWidget.insertRow(rowPosition)
    idprod = frm_vendas.line_idprod.text()
    line_descprod = frm_vendas.line_descprod.text()
    quant = frm_vendas.edt_quant.text()
    valorund = frm_vendas.edt_valorund.text()
    porsdesc = frm_vendas.edt_porsdesc.text()
    valordesc = frm_vendas.edt_valordesc.text()
    numcols = frm_vendas.tableWidget.columnCount()
    numrows = frm_vendas.tableWidget.rowCount()
    frm_vendas.tableWidget.setRowCount(numrows)
    frm_vendas.tableWidget.setColumnCount(numcols)
    frm_vendas.tableWidget.setItem(numrows -1,0,QtGui.QTableWidgetItem(idprod))
    frm_vendas.tableWidget.setItem(numrows -1,1,QtGui.QTableWidgetItem(line_descprod))
    frm_vendas.tableWidget.setItem(numrows -1,2,QtGui.QTableWidgetItem(quant))
    frm_vendas.tableWidget.setItem(numrows -1,3,QtGui.QTableWidgetItem(valorund))
    frm_vendas.tableWidget.setItem(numrows -1,4,QtGui.QTableWidgetItem(porsdesc))
    frm_vendas.tableWidget.setItem(numrows -1,5,QtGui.QTableWidgetItem(valordesc))

    totalitem = len(numrows) + 1
    totalquant = (frm_vendas.tableWidget.setItem(numrows -1,2,QtGui.QTableWidgetItem(quant))) + quant

    frm_vendas.line_itenstotal.insert(totalitem)
    frm_vendas.line_valortotal.insert(totalquant)


def finaliza_venda():
    pass

def salvar_prod_editado():# Esta função provavelmente não sera utilizada(em Observação)
    pass
# fuções para charmar as telas do sistema
def funcao_cancela():
    frm_login.close()
def chamacliente():
    frm_cliente.show()
def chamaestoque():
    frm_estoque.show()
def chamaproduto():
    frm_produto.show() 
def chamamarkup():
    frm_markup.show()
def chamacaduser():
    frm_caduser.show()
def ChamaVenda():
    frm_vendas.show()
def fechaVendas():
    frm_vendas.close()
def Chamapesquisa_produto():
    frm_pesquisa_produto.show()
    cursor = banco.cursor()
    comando_SQL = "SELECT * FROM tblproduto"
    cursor.execute(comando_SQL)
    dados_lidos = cursor.fetchall()
    frm_pesquisa_produto.tableWidget.setRowCount(len(dados_lidos))
    frm_pesquisa_produto.tableWidget.setColumnCount(8)
    for i in range(0, len(dados_lidos)):
        for j in range(0, 5):
            frm_pesquisa_produto.tableWidget.setItem(i,j,QtWidgets.QTableWidgetItem(str(dados_lidos[i][j])))

if __name__ == "__main__":
    # chamando as telas
    app = QtWidgets.QApplication([])
    frm_login = uic.loadUi(r'.\forms\frm_login.ui')
    frm_principal = uic.loadUi(r'.\forms\frm_principal.ui')
    frm_vendas = uic.loadUi(r'.\forms\frm_vendas.ui')
    frm_produto = uic.loadUi(r'.\forms\frm_produto.ui')
    frm_pesquisa_produto = uic.loadUi(r'.\forms\frm_pesquisa_produtos.ui')
    frm_pesquisa_cliente = uic.loadUi(r'.\forms\frm_pesquisa_clientes.ui')
    frm_caduser = uic.loadUi(r'.\forms\frm_caduser.ui')
    frm_markup = uic.loadUi(r'.\forms\frm_markup.ui')
    frm_cliente = uic.loadUi(r'.\forms\frm_cadastro_Cliente.ui')
    frm_estoque= uic.loadUi(r'.\forms\frm_estoque.ui')
    # botões da tela login
    frm_login.linekey.setEchoMode(QtWidgets.QLineEdit.Password)
    frm_login.btnlogin.clicked.connect(funcao_login)
    frm_login.btnexit.clicked.connect(funcao_cancela)
    # botões da tela principal
    frm_principal.actionProdutos.triggered.connect(chamaproduto)
    frm_principal.actionCaixa.triggered.connect(ChamaVenda)
    frm_principal.actionUser.triggered.connect(chamacaduser)
    frm_principal.actionClientes.triggered.connect(chamacliente)
    frm_principal.actionEstoque.triggered.connect(chamaestoque)

    # botões da tela venda(caixa)
    frm_vendas.btn_pesquisaprod.clicked.connect(Chamapesquisa_produto)
    frm_vendas.btn_fechar.clicked.connect(fechaVendas)
    # botões da tela cadastro de produtos
    frm_produto.btnSalvar.clicked.connect(cadastroProduto)
    frm_produto.btnPesquisa.clicked.connect(Chamapesquisa_produto)
    frm_produto.btn_calc_markup.clicked.connect(chamamarkup)
    # botões da tela markup
    frm_markup.btncalcular.clicked.connect(calcular)
    frm_markup.btnenviar.clicked.connect(enviarmarkup)    
    # botões da tela cadastro de Usuáios
    frm_caduser.btnSalvar.clicked.connect(cadastrousuario)
    # botões da tela de pesquisa
    frm_pesquisa_produto.btnExcluir.clicked.connect(excluir_produtos)
    frm_pesquisa_produto.btnEdit.clicked.connect(editar_produto)
    frm_pesquisa_produto.btn_estoque.clicked.connect(chamaestoque)

    frm_login.show()
    app.exec()