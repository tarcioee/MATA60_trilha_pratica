RF5: O sistema deve ser capaz de prover relatórios que informem: ii) os fornecedores mais frequentes, com menores custos para cada categoria de produtos;
DELIMITER $$
CREATE PROCEDURE Fornecedores_Mais_Frequentes()
BEGIN
	SELECT
    	c.nm_categoria AS Categoria,
    	f.cnpj_forn AS Fornecedor,
    	COUNT(fp.cp_Produto) AS Frequencia,
    	MIN(fp.preço_de_venda) AS Menor_Custo
	FROM Fornece fp
	JOIN Produto p ON fp.cp_Produto = p.cp_Produto
	JOIN Categoria c ON p.idCategoria = c.cp_Categoria
	JOIN Fornecedor f ON fp.cp_Fornecedor = f.cp_Fornecedor
	GROUP BY c.nm_categoria, f.cnpj_forn
	ORDER BY c.nm_categoria, Frequencia DESC, Menor_Custo ASC;
END $$
DELIMITER ;

RF5: O sistema deve ser capaz de prover relatórios que informem: iii) as lojas com maior vazão de produtos num período;
CREATE PROCEDURE Lojas_Maior_Vazao(IN data_inicio DATE, IN data_fim DATE)
BEGIN
	SELECT
    	e.nm_estab AS Loja,
    	SUM(v.quantidade) AS Total_Vendido
	FROM Vende v
	JOIN Estabelecimento e ON v.cp_Estabelecimento = e.cp_Estabelecimento
	WHERE v.data_de_venda BETWEEN data_inicio AND data_fim
	GROUP BY e.nm_estab
	ORDER BY Total_Vendido DESC;
END $$
DELIMITER ;
