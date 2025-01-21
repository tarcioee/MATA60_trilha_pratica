import psycopg2
import csv
import time

# Configurações de conexão com o banco de dados
db_config = {
    'dbname': 'seu_banco',
    'user': 'seu_usuario',
    'password': 'sua_senha',
    'host': 'localhost',
    'port': 5432
}

# Arquivo contendo as queries
query_file = 'queries.sql'
# Arquivo CSV para salvar os tempos
output_csv = 'query_execution_times.csv'

# Função para carregar queries de um arquivo

def load_queries(file_path):
    with open(file_path, 'r') as file:
        content = file.read()
    return [query.strip() for query in content.split(';') if query.strip()]

# Função para executar uma query e medir o tempo
def execute_query(cursor, query):
    start_time = time.time()
    cursor.execute(query)
    cursor.fetchall()  # Garantir que os resultados sejam buscados
    end_time = time.time()
    return end_time - start_time

# Carregar queries
queries = load_queries(query_file)

# Conectar ao banco de dados
connection = psycopg2.connect(**db_config)
cursor = connection.cursor()

# Criar ou sobrescrever o arquivo CSV
with open(output_csv, mode='w', newline='') as csv_file:
    writer = csv.writer(csv_file)
    writer.writerow(['Query_Index', 'Execution_Number', 'Execution_Time'])

    # Loop por cada query
    for index, query in enumerate(queries, start=1):
        print(f'Executando Query {index}/{len(queries)}')
        
        for execution in range(1, 51):  # Executar cada query 50 vezes
            try:
                exec_time = execute_query(cursor, query)
                writer.writerow([index, execution, exec_time])
                print(f'Query {index}, Execução {execution}: {exec_time:.4f} segundos')
            except Exception as e:
                print(f'Erro ao executar Query {index}, Execução {execution}: {e}')
                writer.writerow([index, execution, 'ERROR'])

# Fechar conexão
cursor.close()
connection.close()

print(f'Tempos de execução salvos em {output_csv}')
