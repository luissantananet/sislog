from PyQt5 import uic, QtWidgets 
from PyQt5.QtWidgets import QMessageBox
import mysql.connector
import mysql.connector.errors

numero_id = 0
# conexões com o banco de dados
banco = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="Cofggcvf",
    database="newprojet"
)
# fuções da tela login
def funcao_login():
    #frm_login.lineuser.setText("")
    nome_user =frm_login.lineuser.text()
    key = frm_login.linekey.text()
    
    cursor2 = banco.cursor()
    comando_sql = "SELECT senha FROM login WHERE nome ='{}'".format(nome_user)
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
# fuções da tela de cadastro produtos
def cadastroProduto():
    global numero_id

    linhaCod = frm_produto.lineEdit_3.text() #campo codico
    linhaDesc = frm_produto.lineEdit_2.text() #campo descrição 
    linhaGrupo = frm_produto.lineEdit_4.text() #campo grupo
    linhaFab = frm_produto.lineEdit_6.text() #campo fabricante 
    linhaUnd = frm_produto.lineEdit_7.text() #campo undade
    linhaPrecocomp = frm_produto.precounid.text() #campo preço por unidade
    linhaprecovenda = frm_produto.precovenda.text() #campo preço de venda
    linhamarkup = frm_produto.linemarkup.text() #campo margem de lucro
    quantestoque = frm_produto.quantestoque.text() #campo de quantidade estoque
    #comando mysql para inserir dados no banco
    cursor = banco.cursor()
    comando_SQL_id = "SELECT id FROM produtos"
    cursor.execute(comando_SQL_id)
    numero_id = cursor.fetchall()

    if not linhaCod == numero_id:
        cursor = banco.cursor()
        comando_SQL = "INSERT INTO produtos (codico, descricao, grupo, fabricante, unidade, pcound, pcovenda, markup, quantestoque) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        dados = (str(linhaCod), str(linhaDesc), str(linhaGrupo), str(linhaFab), str(linhaUnd), str(linhaPrecocomp), str(linhaprecovenda), str(linhamarkup), str(quantestoque))
        cursor.execute(comando_SQL,dados)
        banco.commit()
    else:
        cursor = banco.cursor()
        cursor.execute ("UPDATE produtos SET codico ='{}', descricao ='{}', grupo ='{}', fabricante ='{}', unidade ='{}',pcound ='{}', pcovenda ='{}', markup ='{}', quantestoque ='{}' WHERE id {}".format(linhaCod, linhaDesc, linhaGrupo, linhaFab, linhaUnd, linhaPrecocomp, linhaprecovenda, linhamarkup,quantestoque, numero_id))
        banco.commit()
# fuções da tela de cadastro Usuário
def cadastrousuario():
    linhauser = frm_caduser.lineUser.text() #campo Usuário
    linhakey = frm_caduser.lineKey.text() #campo senha
    #comando mysql para inserir dados no banco
    cursor = banco.cursor()
    comando_SQL = "INSERT INTO login (nome, senha) VALUES (%s,%s)"
    dados = (str(linhauser),str(linhakey))
    cursor.execute(comando_SQL,dados)
    banco.commit()
    frm_caduser.lineUser.setText('')
    frm_caduser.lineKey.setText('')
# fuções da tela da Calcular Markup
def calcular():
    dv = float(frm_markup.linedv.text())
    df = float(frm_markup.linedf.text())
    lp = float(frm_markup.linelp.text())
    markups = 100 / (100 - (dv + df + lp))
    frm_markup.linemarkup.setText("{:.2f}".format(markups))

def enviarmarkup():
    markups2 = frm_markup.linemarkup.text()
    precocompra = frm_produto.precounid.text()
    frm_markup.close()
    frm_produto.linemarkup.setText(str(markups2))
    if not precocompra == '':
        markup = float(frm_produto.linemarkup.text())
        venda = float(precocompra) + markup
        frm_produto.precovenda.setText("{:.2f}".format(venda))

def funcao_cancela():
    frm_login.close()

def funcao_cadastro():
    frm_produto.show()
    id = frm_produto.lineID.text()
    if id == "":
        id = 0
        ids =int(id)+1
        frm_produto.lineID.setText(ids)
def chamamarkup():
    frm_markup.show()

def chamacaduser():
    frm_caduser.show()

def ChamaVenda():
    frm_vendas.show()

def fechaVendas():
    frm_vendas.close()

def Chamapesquisa():
    frm_pesquisa.show()
    cursor = banco.cursor()
    comando_SQL = "SELECT * FROM produtos"
    cursor.execute(comando_SQL)
    dados_lidos = cursor.fetchall()
    frm_pesquisa.tableWidget.setRowCount(len(dados_lidos))
    frm_pesquisa.tableWidget.setColumnCount(8)
    for i in range(0, len(dados_lidos)):
        for j in range(0, 5):
            frm_pesquisa.tableWidget.setItem(i,j,QtWidgets.QTableWidgetItem(str(dados_lidos[i][j])))

def exclir_produtos():
    linha = frm_pesquisa.tableWidget.currentRow()
    frm_pesquisa.tableWidget.removeRow(linha)

    cursor = banco.cursor()
    cursor.execute("SELECT id FROM produtos")
    dados_lidos = cursor.fetchall()
    valor_id = dados_lidos[linha][0]
    cursor.execute("DELETE FROM produtos WHERE id="+str(valor_id))

def editar_produto():
    global numero_id
    linha = frm_pesquisa.tableWidget.currentRow()

    cursor = banco.cursor()
    comando_SQL = "SELECT * FROM produtos"
    cursor.execute(comando_SQL)
    dados_lidos = cursor.fetchall()
    valor_id = dados_lidos[linha][0]
    cursor.execute("SELECT * FROM produtos WHERE id"+str(valor_id))
    produto = cursor.fetchall()
    frm_produto.show()

    frm_produto.lineEdit_3.setText(str(produto[0][0])) #campo codico
    frm_produto.lineEdit_2.setText(str(produto[0][1])) #campo descrição 
    frm_produto.lineEdit_4.setText(str(produto[0][2])) #campo grupo
    frm_produto.lineEdit_6.setText(str(produto[0][3])) #campo fabricante 
    frm_produto.lineEdit_7.setText(str(produto[0][4])) #campo undade
    frm_produto.precounid.setText(str(produto[0][5])) #campo preço por unidade
    frm_produto.precovenda.setText(str(produto[0][6])) #campo preço de venda
    frm_produto.markup.textsetText(str(produto[0][7])) #campo margem de lucro
    numero_id = valor_id    

def salvar_prod_editado():
    pass
# fuções da tela de cadastro clientes
def cadastroCliente():
    pass

if __name__ == "__main__":
    # chamando as telas
    app = QtWidgets.QApplication([])
    frm_login = uic.loadUi(r'.\NovoProjeto\forms\frm_login.ui')
    frm_principal = uic.loadUi(r'.\NovoProjeto\forms\frm_principal.ui')
    frm_vendas = uic.loadUi(r'.\NovoProjeto\forms\frm_vendas.ui')
    frm_produto = uic.loadUi(r'.\NovoProjeto\forms\frm_produto.ui')
    frm_pesquisa = uic.loadUi(r'.\NovoProjeto\forms\frm_pesquisa_v2.ui')
    frm_caduser = uic.loadUi(r'.\NovoProjeto\forms\frm_caduser.ui')
    frm_markup = uic.loadUi(r'.\NovoProjeto\forms\frm_markup.ui')
    # botões da tela login
    frm_login.linekey.setEchoMode(QtWidgets.QLineEdit.Password)
    frm_login.btnlogin.clicked.connect(funcao_login)
    frm_login.btnexit.clicked.connect(funcao_cancela)
    # botões da tela principal
    frm_principal.actionProdutos.triggered.connect(funcao_cadastro)
    frm_principal.actionCaixa.triggered.connect(ChamaVenda)
    frm_principal.actionUser.triggered.connect(chamacaduser)
    # botões da tela venda(caixa)
    frm_vendas.btnpesquisaprod_2.clicked.connect(Chamapesquisa)
    frm_vendas.btnfechar.clicked.connect(fechaVendas)
    # botões da tela cadastro de produtos
    frm_produto.btnSalvar.clicked.connect(cadastroProduto)
    frm_produto.btnPesquisa.clicked.connect(Chamapesquisa)
    frm_produto.btnPesquisamarkup.clicked.connect(chamamarkup)
    # botões da tela markup
    frm_markup.btncalcular.clicked.connect(calcular)
    frm_markup.btnenviar.clicked.connect(enviarmarkup)    
    # botões da tela cadastro de Usuáios
    frm_caduser.btnSalvar.clicked.connect(cadastrousuario)
    # botões da tela de pesquisa
    frm_pesquisa.btnExcluir.clicked.connect(exclir_produtos)
    frm_pesquisa.btnEdit.clicked.connect(editar_produto)

    frm_login.show()
    app.exec()