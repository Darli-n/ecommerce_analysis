-- 1. Visão geral do banco de dados
SELECT 
    (SELECT COUNT(*) FROM clientes) as total_clientes,
    (SELECT COUNT(*) FROM produtos) as total_produtos,
    (SELECT COUNT(*) FROM pedidos) as total_pedidos,
    (SELECT COUNT(*) FROM items) as total_itens;

-- 2. Distribuição de pedidos por status
SELECT 
    status_pedido,
    COUNT(DISTINCT id_pedido) as total_pedidos,
    ROUND(COUNT(DISTINCT id_pedido) * 100.0 / (SELECT COUNT(*) FROM pedidos), 2) as percentual
FROM view_analise_vendas_completa
GROUP BY status_pedido
ORDER BY total_pedidos DESC;

-- 3. Distribuição geográfica dos clientes
SELECT 
    estado,
    COUNT(DISTINCT id_clientes) as total_clientes,
    COUNT(DISTINCT id_pedido) as total_pedidos
FROM view_analise_vendas_completa
GROUP BY estado
ORDER BY total_clientes DESC;

-- 4. Faixas de preço dos produtos
SELECT 
    faixa_preco,
    COUNT(DISTINCT id_produtos) as total_produtos,
    ROUND(AVG(preco_unitario), 2) as preco_medio
FROM view_analise_vendas_completa
GROUP BY faixa_preco
ORDER BY preco_medio DESC;
