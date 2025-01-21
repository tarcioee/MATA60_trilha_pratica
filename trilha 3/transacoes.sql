//Para caso de venda de produto
BEGIN TRANSACTION;

-- 1. Registrar a venda do produto
INSERT INTO Vende (info_item_comprado, preço, data_de_venda, quantidade, cp_Estabelecimento, cp_Produto)
VALUES ('Produto A', 99.99, '2025-01-20', 1, 1, 1);

-- 2. Atualizar o status do RFID do produto para indicar que ele foi vendido
UPDATE Rfid
SET ind_venda_dispositivo = TRUE
WHERE cp_Rfid = (SELECT idRfid FROM Produto WHERE cp_Produto = 1);

COMMIT;

//Para caso de fornecimento de produto
BEGIN TRANSACTION;

-- 1. Registrar o fornecimento do produto (inserção na tabela Fornece)
INSERT INTO Fornece (preço_de_venda, data_de_vencimento, data_de_venda, quantidade, cp_Produto, cp_Fornecedor)
VALUES (120.00, '2025-02-20', '2025-01-20', 100, 1, 1);

-- 2. Atualizar o estoque do produto no estabelecimento (supondo que o estoque inicial do produto seja controlado na tabela Produto)
UPDATE Produto
SET localizacao_prod = 'deposito'
	quantidade_estoque = quantidade_estoque + 100 -- atualização do estoque após o fornecimento
WHERE cp_Produto = 1;

-- 3. Atualizar o estoque do produto no fornecedor (na tabela Fornecedor ou em uma tabela associativa, caso necessário)
UPDATE Fornecedor
SET status_forn = 'ativo' -- Alterar status, se necessário, com base no fornecimento
WHERE cp_Fornecedor = 1;

-- 4. Caso haja necessidade de alguma atualização adicional no fornecedor, como o histórico de transações
-- (essa parte pode ser expandida conforme os requisitos específicos)

COMMIT;
