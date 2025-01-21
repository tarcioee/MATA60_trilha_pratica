RF3: Cada produto individual está associado a uma tag RFID. O status desta tag determinará se um produto ainda está disponível em estoque ou não.
CREATE VIEW Produto_Estoque_Status AS
SELECT
	p.cp_Produto AS id_produto,
	p.nm_prod AS nome_produto,
	p.cd_ean_prod AS codigo_ean,
	r.cp_Rfid AS id_rfid,
	r.ind_venda_dispositivo AS status_tag,
	CASE
    	WHEN r.ind_venda_dispositivo = 0 THEN 'Disponível em estoque'
    	ELSE 'Indisponível'
	END AS status_produto
FROM Produto p
JOIN Rfid r ON p.idRfid = r.cp_Rfid;


RF5: O sistema deve ser capaz de prover relatórios que informem: i) o nível de estoque para cada categoria de produtos em cada loja ou depósito;
CREATE VIEW Relatorio_Estoque AS
SELECT
	c.nm_categoria AS Categoria,
	p.localizacao_prod AS Localizacao,
	COUNT(p.cp_Produto) AS Quantidade_Produto
FROM Produto p
JOIN Categoria c ON p.idCategoria = c.cp_Categoria
GROUP BY c.nm_categoria, p.localizacao_prod;

RF5: O sistema deve ser capaz de prover relatórios que informem: iv) produtos com maior proximidade de vencimento;
CREATE VIEW Produtos_Prox_Vencimento AS
SELECT
	p.nm_prod AS Nome_Produto,
	f.data_de_vencimento AS Data_Vencimento,
	e.nm_estab AS Estabelecimento,
	e.localizacao_esta AS Localizacao
FROM Produto p
JOIN Fornece f ON p.cp_Produto = f.cp_Produto
JOIN Estabelecimento e ON e.cp_Estabelecimento = f.cp_Produto
WHERE f.data_de_vencimento IS NOT NULL
ORDER BY f.data_de_vencimento ASC;
