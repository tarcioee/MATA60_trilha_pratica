import random
from faker import Faker

# Instanciar o Faker
fake = Faker()

# Função para gerar dados para a tabela 'Função'
def gerar_funcao():
    sql = "INSERT INTO Função (horas, salario, nm_função, cp_Função) VALUES\n"
    for i in range(200):
        horas = random.randint(20, 44)
        salario = round(random.uniform(1000, 10000), 2)
        nm_funcao = fake.job()
        cp_funcao = i + 1
        sql += f"({horas}, {salario}, '{nm_funcao}', {cp_funcao}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Rfid'
def gerar_rfid():
    sql = "INSERT INTO Rfid (ind_venda_dispositivo, cp_Rfid) VALUES\n"
    for i in range(200):
        ind_venda_dispositivo = random.choice([True, False])
        cp_rfid = i + 1
        sql += f"({ind_venda_dispositivo}, {cp_rfid}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Categoria'
def gerar_categoria():
    sql = "INSERT INTO Categoria (nm_categoria, min_estoque_loja, max_estoque_loja, min_estoque_deposito, max_estoque_deposito, cp_Categoria) VALUES\n"
    for i in range(200):
        nm_categoria = fake.word()
        min_estoque_loja = random.randint(10, 100)
        max_estoque_loja = random.randint(min_estoque_loja + 1, 200)
        min_estoque_deposito = random.randint(50, 200)
        max_estoque_deposito = random.randint(min_estoque_deposito + 1, 300)
        cp_categoria = i + 1
        sql += f"('{nm_categoria}', {min_estoque_loja}, {max_estoque_loja}, {min_estoque_deposito}, {max_estoque_deposito}, {cp_categoria}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Produto'
def gerar_produto():
    sql = "INSERT INTO Produto (nm_prod, localizacao_prod, cd_ean_prod, ce_categoria_principal, ce_categoria_secundaria, cp_Produto, idCategoria, idRfid) VALUES\n"
    for i in range(200):
        nm_prod = fake.word()
        localizacao_prod = random.choice(['loja', 'deposito'])
        cd_ean_prod = fake.ean(length=12)
        ce_categoria_principal = random.randint(1, 200)
        ce_categoria_secundaria = random.randint(1, 200)
        cp_produto = i + 1
        id_categoria = random.randint(1, 200)
        id_rfid = random.randint(1, 200)
        sql += f"('{nm_prod}', '{localizacao_prod}', '{cd_ean_prod}', {ce_categoria_principal}, {ce_categoria_secundaria}, {cp_produto}, {id_categoria}, {id_rfid}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Estabelecimento'
def gerar_estabelecimento():
    sql = "INSERT INTO Estabelecimento (nm_estab, cnpj_estab, localizacao_esta, endereco_estab, UF_estab, cidade_estab, cp_Estabelecimento) VALUES\n"
    for i in range(200):
        nm_estab = fake.company()
        cnpj_estab = fake.unique.cnpj()
        localizacao_esta = fake.address()
        endereco_estab = fake.address()
        uf_estab = random.choice(['SP', 'RJ', 'MG', 'BA', 'PR'])
        cidade_estab = fake.city()
        cp_estabelecimento = i + 1
        sql += f"('{nm_estab}', '{cnpj_estab}', '{localizacao_esta}', '{endereco_estab}', '{uf_estab}', '{cidade_estab}', {cp_estabelecimento}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Fornecedor'
def gerar_fornecedor():
    sql = "INSERT INTO Fornecedor (endereco_forn, localizacao_forn, cnpj_forn, UF_forn, cidade_forn, status_forn, cp_Fornecedor) VALUES\n"
    for i in range(200):
        endereco_forn = fake.address()
        localizacao_forn = fake.address()
        cnpj_forn = fake.unique.cnpj()
        uf_forn = random.choice(['SP', 'RJ', 'MG', 'BA', 'PR'])
        cidade_forn = fake.city()
        status_forn = random.choice(['ativo', 'inativo'])
        cp_fornecedor = i + 1
        sql += f"('{endereco_forn}', '{localizacao_forn}', '{cnpj_forn}', '{uf_forn}', '{cidade_forn}', '{status_forn}', {cp_fornecedor}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Funcionário'
def gerar_funcionario():
    sql = "INSERT INTO Funcionário (nm_func, cpf_func, cp_Funcionário, idFunção) VALUES\n"
    for i in range(200):
        nm_func = fake.name()
        cpf_func = fake.unique.cpf()
        cp_funcionario = i + 1
        id_funcao = random.randint(1, 200)
        sql += f"('{nm_func}', '{cpf_func}', {cp_funcionario}, {id_funcao}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Fornece'
def gerar_fornece():
    sql = "INSERT INTO Fornece (preço_de_venda, data_de_vencimento, data_de_venda, quantidade, cp_Produto, cp_Fornecedor) VALUES\n"
    for i in range(200):
        preco_de_venda = round(random.uniform(10, 500), 2)
        data_de_vencimento = fake.date_this_decade()
        data_de_venda = fake.date_this_year()
        quantidade = random.randint(1, 100)
        cp_produto = random.randint(1, 200)
        cp_fornecedor = random.randint(1, 200)
        sql += f"({preco_de_venda}, '{data_de_vencimento}', '{data_de_venda}', {quantidade}, {cp_produto}, {cp_fornecedor}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Vende'
def gerar_vende():
    sql = "INSERT INTO Vende (info_item_comprado, preço, data_de_venda, quantidade, cp_Estabelecimento, cp_Produto) VALUES\n"
    for i in range(200):
        info_item_comprado = fake.sentence()
        preco = round(random.uniform(10, 500), 2)
        data_de_venda = fake.date_this_year()
        quantidade = random.randint(1, 100)
        cp_estabelecimento = random.randint(1, 200)
        cp_produto = random.randint(1, 200)
        sql += f"('{info_item_comprado}', {preco}, '{data_de_venda}', {quantidade}, {cp_estabelecimento}, {cp_produto}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função para gerar dados para a tabela 'Repõem'
def gerar_repoem():
    sql = "INSERT INTO Repõem (cp_Estabelecimento, cp_Funcionário) VALUES\n"
    for i in range(200):
        cp_estabelecimento = random.randint(1, 200)
        cp_funcionario = random.randint(1, 200)
        sql += f"({cp_estabelecimento}, {cp_funcionario}),\n"
    
    return sql.rstrip(",\n") + ";"

# Função principal para rodar todas as funções
def main():
    with open('insert_statements.sql', 'w') as file:
        file.write(gerar_funcao() + "\n\n")
        file.write(gerar_rfid() + "\n\n")
        file.write(gerar_categoria() + "\n\n")
        file.write(gerar_produto() + "\n\n")
        file.write(gerar_estabelecimento() + "\n\n")
        file.write(gerar_fornecedor() + "\n\n")
        file.write(gerar_funcionario() + "\n\n")
        file.write(gerar_fornece() + "\n\n")
        file.write(gerar_vende() + "\n\n")
        file.write(gerar_repoem() + "\n\n")

if __name__ == '__main__':
    main()
