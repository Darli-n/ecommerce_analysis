-- 1. Top produtos mais vendidos
SELECT * FROM view_top_produtos LIMIT 10;

-- 2. Produtos por desempenho (Matriz BCG simplificada)
SELECT 
    id_produtos,
    categoria,
    unidades_vendidas,
    receita_total,
    CASE 
        WHEN unidades_vendidas > (SELECT AVG(unidades_vendidas) FROM view_top_produtos) 
             AND receita_total > (SELECT AVG(receita_total) FROM view_top_produtos) THEN 'Estrela'
        WHEN unidades_vendidas > (SELECT AVG(unidades_vendidas) FROM view_top_produtos) THEN 'Vaca Leiteira'
        WHEN receita_total > (SELECT AVG(receita_total) FROM view_top_produtos) THEN 'Interrogação'
        ELSE 'Abacaxi'
    END as categoria_desempenho
FROM view_top_produtos
ORDER BY receita_total DESC;

-- 3. Mix de produtos por pedido
SELECT 
    AVG(produtos_por_pedido) as media_produtos_por_pedido,
    MAX(produtos_por_pedido) as max_produtos_por_pedido,
    MIN(produtos_por_pedido) as min_produtos_por_pedido
FROM (
    SELECT 
        pedido_id,
        COUNT(*) as produtos_por_pedido
    FROM items
    GROUP BY pedido_id
) as produtos_pedido;

-- 4. Categorias mais lucrativas
SELECT 
    categoria,
    COUNT(DISTINCT id_produtos) as variedade_produtos,
    SUM(unidades_vendidas) as total_vendido,
    ROUND(SUM(receita_total), 2) as receita_categoria,
    ROUND(SUM(receita_total) / COUNT(DISTINCT id_produtos), 2) as receita_por_produto
FROM view_top_produtos
GROUP BY categoria
ORDER BY receita_categoria DESC;