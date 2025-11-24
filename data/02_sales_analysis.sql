-- 1. Performance de vendas por mês
SELECT * FROM view_metricas_mensais;

-- 2. Vendas por categoria
SELECT 
    categoria,
    COUNT(DISTINCT id_pedido) as pedidos,
    SUM(quantidade) as unidades_vendidas,
    ROUND(SUM(valor_total_item), 2) as receita_total,
    ROUND(SUM(valor_total_item) / SUM(quantidade), 2) as ticket_medio_item
FROM view_analise_vendas_completa
GROUP BY categoria
ORDER BY receita_total DESC;

-- 3. Vendas por estado
SELECT 
    estado,
    COUNT(DISTINCT id_pedido) as total_pedidos,
    COUNT(DISTINCT id_clientes) as clientes_unicos,
    ROUND(SUM(valor_total_item), 2) as receita_total,
    ROUND(SUM(valor_total_item) / COUNT(DISTINCT id_pedido), 2) as ticket_medio_estado
FROM view_analise_vendas_completa
GROUP BY estado
ORDER BY receita_total DESC;

-- 4. Evolução mensal por categoria
SELECT 
    ano_mes_pedido,
    categoria,
    ROUND(SUM(valor_total_item), 2) as receita_mensal
FROM view_analise_vendas_completa
GROUP BY ano_mes_pedido, categoria
ORDER BY ano_mes_pedido, receita_mensal DESC;