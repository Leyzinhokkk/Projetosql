#SQL
CREATE TABLE Produtos (
    ProdutoID INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    QuantidadeDisponivel INTEGER NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL
);

#PY
CREATE TABLE Vendas (
    VendaID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProdutoID INTEGER,
    QuantidadeVendida INTEGER NOT NULL,
    DataVenda DATE NOT NULL,
    FOREIGN KEY (ProdutoID) REFERENCES Produtos (ProdutoID)
);

class Produto:
    def __init__(self, produto_id, nome, descricao, quantidade_disponivel, preco):
        self.produto_id = produto_id
        self.nome = nome
        self.descricao = descricao
        self.quantidade_disponivel = quantidade_disponivel
        self.preco = preco

    def __str__(self):
        return f"ID: {self.produto_id}, Nome: {self.nome}, Quantidade: {self.quantidade_disponivel}, Preço: {self.preco}"

class Venda:
    def __init__(self, venda_id, produto_id, quantidade_vendida, data_venda):
        self.venda_id = venda_id
        self.produto_id = produto_id
        self.quantidade_vendida = quantidade_vendida
        self.data_venda = data_venda

    def __str__(self):
        return f"ID da Venda: {self.venda_id}, ProdutoID: {self.produto_id}, Quantidade Vendida: {self.quantidade_vendida}, Data: {self.data_venda}"


import sqlite3
from datetime import datetime

conn = sqlite3.connect('estoque.db')
cursor = conn.cursor()

# Criação das tabelas de Produtos e Vendas
cursor.execute('''
CREATE TABLE IF NOT EXISTS Produtos (
    ProdutoID INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    QuantidadeDisponivel INTEGER NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Vendas (
    VendaID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProdutoID INTEGER,
    QuantidadeVendida INTEGER NOT NULL,
    DataVenda DATE NOT NULL,
    FOREIGN KEY (ProdutoID) REFERENCES Produtos (ProdutoID)
)
''')
conn.commit()


def cadastrar_produto(nome, descricao, quantidade, preco):
    cursor.execute('''
    INSERT INTO Produtos (Nome, Descricao, QuantidadeDisponivel, Preco)
    VALUES (?, ?, ?, ?)
    ''', (nome, descricao, quantidade, preco))
    conn.commit()
    print("Produto cadastrado com sucesso!")


def remover_produto(produto_id):
    cursor.execute('''
    DELETE FROM Produtos
    WHERE ProdutoID = ?
    ''', (produto_id,))
    conn.commit()
    print("Produto removido com sucesso!")

# Cadastrar produtos
cadastrar_produto("Teclado Mecânico", "Teclado com iluminação RGB", 10, 250.00)
cadastrar_produto("Mouse Gamer", "Mouse com alta precisão", 15, 150.00)

print("\nLista de Produtos:")
listar_produtos()

atualizar_quantidade(1, 20)
  
remover_produto(2)

print("\nLista de Produtos Atualizada:")
listar_produtos()
conn.close()

