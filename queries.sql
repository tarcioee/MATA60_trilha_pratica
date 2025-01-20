– Queries simples
-- 1. Selecionando todos os funcionários:
SELECT * FROM Funcionário;

-- 2. Selecionando todas as funções:
SELECT * FROM Função;

-- 3. Selecionando todos os estabelecimentos:
SELECT * FROM Estabelecimento;

-- 4. Selecionando todos os fornecedores:
SELECT * FROM Fornecedor;

-- 5. Selecionando todas as categorias:
SELECT * FROM Categoria;

-- 6. Selecionando todos os produtos:
SELECT * FROM Produto;

-- 7. Selecionando todos os RFID:
SELECT * FROM Rfid;

-- 8. Selecionando todos os registros de venda:
SELECT * FROM Vende;

-- 9. Selecionando todos os registros de fornecimento:
SELECT * FROM Fornece;

-- 10. Selecionando todos os registros de reposição:
SELECT * FROM Repõem;

-- 11. Selecionando todos os produtos de uma categoria específica:
SELECT * FROM Produto WHERE idCategoria = 1;

-- 12. Selecionando todos os fornecedores ativos:
SELECT * FROM Fornecedor WHERE status_forn = 'ativo';

-- 13. Selecionando todos os funcionários com um nome específico:
SELECT * FROM Funcionário WHERE nm_func = 'João Silva';

-- 14. Selecionando todos os estabelecimentos em uma cidade específica:
SELECT * FROM Estabelecimento WHERE cidade_estab = 'São Paulo';

-- 15. Selecionando todos os produtos em estoque na loja:
SELECT * FROM Produto WHERE localizacao_prod = 'loja';

-- 16. Selecionando todos os fornecedores de um produto específico:
SELECT * FROM Fornece WHERE cp_Produto = 1;

-- 17. Selecionando todos os produtos com preço maior que 100:
SELECT * FROM Produto WHERE preço > 100;

-- 18. Selecionando todos os funcionários com mais de 30 anos:
SELECT * FROM Funcionário WHERE idade > 30;

-- 19. Selecionando todos os estabelecimentos em um estado específico:
SELECT * FROM Estabelecimento WHERE UF_estab = 'SP';

-- 20. Selecionando todos os produtos que possuem RFID vinculado:
SELECT * FROM Produto WHERE idRfid IS NOT NULL;

-- 21. Selecionando todos os produtos com EAN específico:
SELECT * FROM Produto WHERE cd_ean_prod = '123456789012';

-- 22. Selecionando todos os produtos com categoria secundária específica:
SELECT * FROM Produto WHERE ce_categoria_secundaria = 2;

-- 23. Selecionando todos os fornecedores com um CNPJ específico:
SELECT * FROM Fornecedor WHERE cnpj_forn = '12345678000199';

-- 24. Selecionando todos os funcionários de uma função específica:
SELECT * FROM Funcionário WHERE idFunção = 2;

-- 25. Selecionando todos os registros de venda de um estabelecimento específico:
SELECT * FROM Vende WHERE cp_Estabelecimento = 1;

--Queries intermediarias
-- 1. Selecionando os funcionários e suas respectivas funções:
SELECT Funcionário.nm_func, Função.nm_função
FROM Funcionário
JOIN Função ON Funcionário.idFunção = Função.cp_Função;

-- 2. Selecionando os produtos vendidos em cada estabelecimento:
SELECT Estabelecimento.nm_estab, Produto.nm_prod
FROM Vende
JOIN Estabelecimento ON Vende.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto;

-- 3. Contando o número de produtos vendidos por estabelecimento:
SELECT Estabelecimento.nm_estab, COUNT(Vende.cp_Produto) AS total_vendas
FROM Vende
JOIN Estabelecimento ON Vende.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
GROUP BY Estabelecimento.nm_estab;

-- 4. Selecionando o preço de venda e a quantidade fornecida para cada produto e fornecedor:
SELECT Produto.nm_prod, Fornecedor.cnpj_forn, Fornece.preço_de_venda, Fornece.quantidade
FROM Fornece
JOIN Produto ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor;

-- 5. Selecionando os produtos e as categorias a que pertencem:
SELECT Produto.nm_prod, Categoria.nm_categoria
FROM Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria;

-- 6. Contando o número de fornecedores para cada produto:
SELECT Produto.nm_prod, COUNT(Fornecedor.cnpj_forn) AS total_fornecedores
FROM Fornece
JOIN Produto ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Produto.nm_prod;

-- 7. Selecionando os produtos e a quantidade de estoque no estabelecimento:
SELECT Produto.nm_prod, SUM(Repõem.quantidade) AS quantidade_estoque
FROM Repõem
JOIN Produto ON Repõem.cp_Produto = Produto.cp_Produto
GROUP BY Produto.nm_prod;

-- 8. Selecionando os produtos e o número de vendas em cada estabelecimento:
SELECT Produto.nm_prod, Estabelecimento.nm_estab, COUNT(Vende.cp_Produto) AS num_vendas
FROM Vende
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Estabelecimento ON Vende.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
GROUP BY Produto.nm_prod, Estabelecimento.nm_estab;

-- 9. Selecionando os fornecedores e a quantidade total fornecida de cada produto:
SELECT Fornecedor.cnpj_forn, Produto.nm_prod, SUM(Fornece.quantidade) AS total_fornecido
FROM Fornece
JOIN Produto ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Fornecedor.cnpj_forn, Produto.nm_prod;

-- 10. Selecionando os produtos com seu preço de venda e a quantidade fornecida:
SELECT Produto.nm_prod, Fornece.preço_de_venda, Fornece.quantidade
FROM Produto
JOIN Fornece ON Produto.cp_Produto = Fornece.cp_Produto;

-- 11. Selecionando o total de vendas de cada produto por estabelecimento:
SELECT Estabelecimento.nm_estab, Produto.nm_prod, SUM(Vende.quantidade) AS total_vendas
FROM Vende
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Estabelecimento ON Vende.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
GROUP BY Estabelecimento.nm_estab, Produto.nm_prod;

-- 12. Selecionando os funcionários que trabalharam em reposições em um estabelecimento específico:
SELECT Funcionário.nm_func, Estabelecimento.nm_estab
FROM Repõem
JOIN Funcionário ON Repõem.cp_Funcionário = Funcionário.cp_Funcionário
JOIN Estabelecimento ON Repõem.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
WHERE Estabelecimento.nm_estab = 'Loja A';

-- 13. Selecionando os produtos e a quantidade fornecida por fornecedor, filtrando pelo fornecedor ativo:
SELECT Produto.nm_prod, SUM(Fornece.quantidade) AS total_fornecido, Fornecedor.cnpj_forn
FROM Fornece
JOIN Produto ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
WHERE Fornecedor.status_forn = 'ativo'
GROUP BY Produto.nm_prod, Fornecedor.cnpj_forn;

-- 14. Selecionando a média de preço de venda por categoria de produto:
SELECT Categoria.nm_categoria, AVG(Fornece.preço_de_venda) AS media_preço
FROM Fornece
JOIN Produto ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
GROUP BY Categoria.nm_categoria;

-- 15. Selecionando os produtos com seu preço de venda, quantidade fornecida e o estabelecimento que mais vendeu cada produto:
SELECT Produto.nm_prod, Fornece.preço_de_venda, SUM(Fornece.quantidade) AS total_fornecido, Estabelecimento.nm_estab
FROM Fornece
JOIN Produto ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Estabelecimento ON Estabelecimento.cp_Estabelecimento = Vende.cp_Estabelecimento
JOIN Vende ON Vende.cp_Produto = Produto.cp_Produto
GROUP BY Produto.nm_prod, Estabelecimento.nm_estab
ORDER BY total_fornecido DESC
LIMIT 1;
– Queries avançadas
-- 1. Selecionando o total de vendas por produto e estabelecimento, incluindo categoria e fornecedor:
SELECT Estabelecimento.nm_estab, Produto.nm_prod, Categoria.nm_categoria, Fornecedor.cnpj_forn, SUM(Vende.quantidade) AS total_vendas
FROM Vende
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Estabelecimento ON Vende.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Fornece ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Estabelecimento.nm_estab, Produto.nm_prod, Categoria.nm_categoria, Fornecedor.cnpj_forn;

-- 2. Selecionando o total de estoque em cada estabelecimento por produto e categoria:
SELECT Estabelecimento.nm_estab, Produto.nm_prod, Categoria.nm_categoria, SUM(Repõem.quantidade) AS total_estoque
FROM Repõem
JOIN Produto ON Repõem.cp_Produto = Produto.cp_Produto
JOIN Estabelecimento ON Repõem.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
GROUP BY Estabelecimento.nm_estab, Produto.nm_prod, Categoria.nm_categoria;

-- 3. Selecionando a média de preço de venda e total de produtos vendidos por fornecedor e categoria:
SELECT Fornecedor.cnpj_forn, Categoria.nm_categoria, AVG(Fornece.preço_de_venda) AS media_preço, SUM(Vende.quantidade) AS total_vendas
FROM Fornece
JOIN Produto ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Vende ON Vende.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Fornecedor.cnpj_forn, Categoria.nm_categoria;

-- 4. Selecionando o total de vendas por produto e a quantidade fornecida, considerando fornecedor e categoria:
SELECT Produto.nm_prod, Categoria.nm_categoria, Fornecedor.cnpj_forn, SUM(Vende.quantidade) AS total_vendas, SUM(Fornece.quantidade) AS total_fornecido
FROM Vende
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Fornece ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Produto.nm_prod, Categoria.nm_categoria, Fornecedor.cnpj_forn;

-- 5. Selecionando o total de produtos vendidos por categoria e fornecedor, considerando o preço de venda:
SELECT Categoria.nm_categoria, Fornecedor.cnpj_forn, SUM(Vende.quantidade) AS total_vendas, AVG(Fornece.preço_de_venda) AS media_preço
FROM Vende
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Fornece ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Categoria.nm_categoria, Fornecedor.cnpj_forn;

-- 6. Selecionando os produtos e a quantidade vendida por estabelecimento, fornecedor e categoria:
SELECT Estabelecimento.nm_estab, Produto.nm_prod, Fornecedor.cnpj_forn, Categoria.nm_categoria, SUM(Vende.quantidade) AS total_vendas
FROM Vende
JOIN Estabelecimento ON Vende.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Fornece ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Estabelecimento.nm_estab, Produto.nm_prod, Fornecedor.cnpj_forn, Categoria.nm_categoria;

-- 7. Selecionando o total de vendas por produto, fornecedor e categoria, considerando o estoque:
SELECT Produto.nm_prod, Fornecedor.cnpj_forn, Categoria.nm_categoria, SUM(Vende.quantidade) AS total_vendas, SUM(Repõem.quantidade) AS total_estoque
FROM Vende
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Fornece ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
JOIN Repõem ON Repõem.cp_Produto = Produto.cp_Produto
GROUP BY Produto.nm_prod, Fornecedor.cnpj_forn, Categoria.nm_categoria;

-- 8. Selecionando o total de vendas por estabelecimento, considerando fornecedor, categoria e produto:
SELECT Estabelecimento.nm_estab, Fornecedor.cnpj_forn, Categoria.nm_categoria, Produto.nm_prod, SUM(Vende.quantidade) AS total_vendas
FROM Vende
JOIN Estabelecimento ON Vende.cp_Estabelecimento = Estabelecimento.cp_Estabelecimento
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Fornece ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Estabelecimento.nm_estab, Fornecedor.cnpj_forn, Categoria.nm_categoria, Produto.nm_prod;

-- 9. Selecionando o total de estoque e vendas por produto e categoria, incluindo fornecedor:
SELECT Produto.nm_prod, Categoria.nm_categoria, SUM(Repõem.quantidade) AS total_estoque, SUM(Vende.quantidade) AS total_vendas, Fornecedor.cnpj_forn
FROM Repõem
JOIN Produto ON Repõem.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Vende ON Vende.cp_Produto = Produto.cp_Produto
JOIN Fornece ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Produto.nm_prod, Categoria.nm_categoria, Fornecedor.cnpj_forn;

-- 10. Selecionando o total de vendas de cada produto por categoria e fornecedor, com preço de venda médio:
SELECT Produto.nm_prod, Categoria.nm_categoria, Fornecedor.cnpj_forn, SUM(Vende.quantidade) AS total_vendas, AVG(Fornece.preço_de_venda) AS media_preço
FROM Vende
JOIN Produto ON Vende.cp_Produto = Produto.cp_Produto
JOIN Categoria ON Produto.idCategoria = Categoria.cp_Categoria
JOIN Fornece ON Fornece.cp_Produto = Produto.cp_Produto
JOIN Fornecedor ON Fornece.cp_Fornecedor = Fornecedor.cp_Fornecedor
GROUP BY Produto.nm_prod, Categoria.nm_categoria, Fornecedor.cnpj_forn;

