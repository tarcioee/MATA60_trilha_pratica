import random
import string
import datetime

# Funções auxiliares para geração de dados aleatórios
def random_string(length):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

def random_date(start_year=2000, end_year=2025):
    start_date = datetime.date(start_year, 1, 1)
    end_date = datetime.date(end_year, 12, 31)
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    return start_date + datetime.timedelta(days=random_days)

# Gerar INSERTS para cada tabela com múltiplas instâncias por query
def generate_categoria():
    values = []
    for i in range(1, 201):
        nm_categoria = f"Categoria {i}"
        min_estoque_loja = random.randint(0, 50)
        max_estoque_loja = random.randint(51, 200)
        min_estoque_deposito = random.randint(0, 100)
        max_estoque_deposito = random.randint(101, 500)
        values.append(f"('{nm_categoria}', {min_estoque_loja}, {max_estoque_loja}, {min_estoque_deposito}, {max_estoque_deposito}, {i})")
    return f"INSERT INTO Categoria (nm_categoria, min_estoque_loja, max_estoque_loja, min_estoque_deposito, max_estoque_deposito, cp_Categoria) VALUES \n" + ",\n".join(values) + ";"

def generate_produto():
    values = []
    for i in range(1, 201):
        nm_prod = f"Produto {i}"
        localizacao_prod = random.choice(['loja', 'deposito'])
        cd_ean_prod = random_string(12)
        idCategoria = random.randint(1, 200)
        idRfid = random.randint(1, 200)
        values.append(f"('{nm_prod}', '{localizacao_prod}', '{cd_ean_prod}', {idCategoria}, {idRfid}, {i})")
    return f"INSERT INTO Produto (nm_prod, localizacao_prod, cd_ean_prod, idCategoria, idRfid, cp_Produto) VALUES \n" + ",\n".join(values) + ";"

def generate_rfid():
    values = []
    for i in range(1, 201):
        ind_venda_dispositivo = random.choice(['TRUE', 'FALSE'])
        values.append(f"({ind_venda_dispositivo}, {i})")
    return f"INSERT INTO Rfid (ind_venda_dispositivo, cp_Rfid) VALUES \n" + ",\n".join(values) + ";"

def generate_fornecedor():
    values = []
    for i in range(1, 201):
        endereco_forn = f"Endereco {i}"
        localizacao_forn = f"Localizacao {i}"
        cnpj_forn = ''.join(random.choices(string.digits, k=14))
        uf_forn = random.choice(['SP', 'RJ', 'MG', 'BA', 'RS'])
        cidade_forn = f"Cidade {i}"
        status_forn = random.choice(['ativo', 'inativo'])
        values.append(f"('{endereco_forn}', '{localizacao_forn}', '{cnpj_forn}', '{uf_forn}', '{cidade_forn}', '{status_forn}', {i})")
    return f"INSERT INTO Fornecedor (endereco_forn, localizacao_forn, cnpj_forn, UF_forn, cidade_forn, status_forn, cp_Fornecedor) VALUES \n" + ",\n".join(values) + ";"

def generate_fornece():
    values = []
    for _ in range(1, 201):
        cp_Produto = random.randint(1, 200)
        cp_Fornecedor = random.randint(1, 200)
        preco_de_venda = round(random.uniform(10, 1000), 2)
        data_de_vencimento = random_date()
        data_de_venda = random_date()
        quantidade = random.randint(1, 100)
        values.append(f"({preco_de_venda}, '{data_de_vencimento}', '{data_de_venda}', {quantidade}, {cp_Produto}, {cp_Fornecedor})")
    return f"INSERT INTO Fornece (preço_de_venda, data_de_vencimento, data_de_venda, quantidade, cp_Produto, cp_Fornecedor) VALUES \n" + ",\n".join(values) + ";"

def generate_funcionario():
    values = []
    for i in range(1, 201):
        nm_func = f"Funcionario {i}"
        cpf_func = ''.join(random.choices(string.digits, k=11))
        idFunção = random.randint(1, 200)
        values.append(f"('{nm_func}', '{cpf_func}', {idFunção}, {i})")
    return f"INSERT INTO Funcionário (nm_func, cpf_func, idFunção, cp_Funcionário) VALUES \n" + ",\n".join(values) + ";"

def generate_funcao():
    values = []
    for i in range(1, 201):
        horas = random.randint(20, 40)
        salario = round(random.uniform(1500, 5000), 2)
        nm_funcao = f"Funcao {i}"
        values.append(f"({horas}, {salario}, '{nm_funcao}', {i})")
    return f"INSERT INTO Função (horas, salario, nm_função, cp_Função) VALUES \n" + ",\n".join(values) + ";"

def write_to_file(filename, content):
    with open(filename, 'w') as f:
        f.write(content)

# Gerar os arquivos SQL
write_to_file('populate_categoria.sql', generate_categoria())
write_to_file('populate_produto.sql', generate_produto())
write_to_file('populate_rfid.sql', generate_rfid())
write_to_file('populate_fornecedor.sql', generate_fornecedor())
write_to_file('populate_fornece.sql', generate_fornece())
write_to_file('populate_funcionario.sql', generate_funcionario())
write_to_file('populate_funcao.sql', generate_funcao())
