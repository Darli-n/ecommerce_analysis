-- 1. Top clientes por valor gasto
SELECT 
    cliente,
    estado,
    COUNT(DISTINCT id_pedido) as total_pedidos,
    ROUND(SUM(valor_total_item), 2) as total_gasto,
    ROUND(AVG(valor_total_item), 2) as valor_medio_pedido
FROM view_analise_vendas_completa
GROUP BY cliente, estado
ORDER BY total_gasto DESC
LIMIT 10;

-- 2. Clientes por faixa de consumo
SELECT 
    CASE 
        WHEN total_gasto < 500 THEN 'Até R$ 500'
        WHEN total_gasto < 1000 THEN 'R$ 500 - 1000'
        WHEN total_gasto < 2000 THEN 'R$ 1000 - 2000'
        ELSE 'Acima de R$ 2000'
    END as faixa_consumo,
    COUNT(*) as total_clientes,
    ROUND(AVG(total_gasto), 2) as media_gasto
FROM (
    SELECT 
        id_clientes,
        cliente,
        SUM(valor_total_item) as total_gasto
    FROM view_analise_vendas_completa
    GROUP BY id_clientes, cliente
) as clientes_gasto
GROUP BY faixa_consumo
ORDER BY media_gasto DESC;

-- 3. Novos clientes por mês
SELECT 
    TO_CHAR(data_cadastro, 'YYYY-MM') as mes_cadastro,
    COUNT(*) as novos_clientes
FROM clientes
GROUP BY mes_cadastro
ORDER BY mes_cadastro;

-- 4. Retenção de clientes (clientes com múltiplos pedidos)
SELECT 
    COUNT(*) as total_clientes,
    SUM(CASE WHEN total_pedidos > 1 THEN 1 ELSE 0 END) as clientes_recorrentes,
    ROUND(SUM(CASE WHEN total_pedidos > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as taxa_retencao
FROM (
    SELECT 
        id_clientes,
        COUNT(DISTINCT id_pedido) as total_pedidos
    FROM view_analise_vendas_completa
    GROUP BY id_clientes
) as pedidos_por_cliente;