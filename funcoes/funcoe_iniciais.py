from PyQt5 import uic, QtWidgets 
from PyQt5.QtWidgets import QMessageBox
import mysql.connector
import mysql.connector.errors
banco = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="1@!Cofggcvf",
    database="newprojet"
)
def funcao_cadastro():
    frm_produto.show()

    precocompra = frm_produto.precounid.text()
    markup = 0
    while precocompra != precocompra or markup != markup:
        
            calcprecovenda(precocompra,markup)
        
            
def calcprecovenda(compra, mark):
    #precocompra = float(frm_produto.precounid.text())
    #markup = float(frm_produto.linemarkup.text())
    if not compra == '' or mark == '':
        venda = compra + mark
        frm_produto.precovenda.setText("{:.2f}".format(venda))


def chamamarkup():
    frm_markup.show()
def cadastroProduto():
    linhaCod = frm_produto.lineEdit_3.text() #campo codico
    linhaDesc = frm_produto.lineEdit_2.text() #campo descrição 
    linhaGrupo = frm_produto.lineEdit_4.text() #campo grupo
    linhaFab = frm_produto.lineEdit_6.text() #campo fabricante 
    linhaUnd = frm_produto.lineEdit_7.text() #campo undade
    linhaPrecocomp = frm_produto.precounid.text() #campo preço por unidade
    linhaprecovenda = frm_produto.precovenda.text() #campo preço de venda
    #comando mysql para inserir dados no banco
    cursor = banco.cursor()
    comando_SQL = "INSERT INTO produtos (codico, descricao, grupo, fabricante, unidade, pcound, pcovenda) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    dados = (str(linhaCod),str(linhaDesc),str(linhaGrupo),str(linhaFab),str(linhaUnd), str(linhaPrecocomp), str(linhaprecovenda))
    cursor.execute(comando_SQL,dados)
    banco.commit()

def calcular():
    dv = float(frm_markup.linedv.text())
    df = float(frm_markup.linedf.text())
    lp = float(frm_markup.linelp.text())
    markups = 100 / (100 - (dv + df + lp))
    frm_markup.linemarkup.setText("{:.2f}".format(markups))
def enviarmarkup():
    markups2 = frm_markup.linemarkup.text()
    precocompra = frm_produto.precounid.text()
    vendas = frm_produto.precovenda.text()
    #print(type(precocompra))
    print(markups2)
    frm_markup.close()
    frm_produto.linemarkup.setText(str(markups2))
    
    if not vendas == '':
        markup = float(frm_produto.linemarkup.text())
        venda = float(precocompra) + markup
        frm_produto.precovenda.setText("{:.2f}".format(venda))


        
            
if __name__ == '__main__':
    app = QtWidgets.QApplication([])
    frm_principal = uic.loadUi(r'.\NovoProjeto\forms\frm_principal.ui')
    frm_principal.actionProdutos.triggered.connect(funcao_cadastro)
    frm_produto = uic.loadUi(r'.\NovoProjeto\forms\frm_produto.ui')
    frm_markup = uic.loadUi(r'.\NovoProjeto\forms\frm_markup.ui')
    frm_produto.btnSalvar.clicked.connect(cadastroProduto)
    #frm_produto.btnPesquisa.clicked.connect(Chamapesquisa)
    frm_produto.btnPesquisamarkup.clicked.connect(chamamarkup)
    frm_markup.btncalcular.clicked.connect(calcular)
    frm_markup.btnenviar.clicked.connect(enviarmarkup)
    frm_principal.show()
    app.exec()