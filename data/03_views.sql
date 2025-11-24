-- VIEW principal para análise de vendas
CREATE OR REPLACE VIEW view_analise_vendas_completa AS
SELECT 
    -- Dados do pedido
    ped.id_pedido,
    ped.data_pedido,
    ped.status as status_pedido,
    
    -- Dados do cliente
    c.id_clientes,
    c.nome as cliente,
    c.estado,
    c.data_cadastro,
    
    -- Dados do produto
    pr.id_produtos,
    pr.categoria,
    pr.preco as preco_unitario,
    
    -- Dados do item
    i.id_items,
    i.quantidade,
    
    -- Cálculos
    (i.quantidade * pr.preco) as valor_total_item,
    
    -- Informações derivadas
    EXTRACT(YEAR FROM ped.data_pedido) as ano_pedido,
    EXTRACT(MONTH FROM ped.data_pedido) as mes_pedido,
    TO_CHAR(ped.data_pedido, 'YYYY-MM') as ano_mes_pedido,
    
    -- Categorização
    CASE 
        WHEN pr.preco < 100 THEN 'Baixo valor'
        WHEN pr.preco < 500 THEN 'Médio valor'
        ELSE 'Alto valor'
    END as faixa_preco,
    
    CASE 
        WHEN i.quantidade = 1 THEN '1 unidade'
        WHEN i.quantidade <= 3 THEN '2-3 unidades'
        ELSE '4+ unidades'
    END as faixa_quantidade

FROM pedidos ped
JOIN clientes c ON ped.id_cliente = c.id_clientes
JOIN items i ON ped.id_pedido = i.pedido_id
JOIN produtos pr ON i.produto_id = pr.id_produtos;

-- VIEW para métricas mensais
CREATE OR REPLACE VIEW view_metricas_mensais AS
SELECT 
    ano_mes_pedido,
    COUNT(DISTINCT id_pedido) as total_pedidos,
    COUNT(DISTINCT id_clientes) as clientes_unicos,
    SUM(quantidade) as itens_vendidos,
    ROUND(SUM(valor_total_item), 2) as receita_total,
    ROUND(SUM(valor_total_item) / COUNT(DISTINCT id_pedido), 2) as ticket_medio
FROM view_analise_vendas_completa
GROUP BY ano_mes_pedido
ORDER BY ano_mes_pedido;

-- VIEW para top produtos
CREATE OR REPLACE VIEW view_top_produtos AS
SELECT 
    id_produtos,
    categoria,
    faixa_preco,
    SUM(quantidade) as unidades_vendidas,
    ROUND(SUM(valor_total_item), 2) as receita_total,
    COUNT(DISTINCT id_pedido) as pedidos_com_produto
FROM view_analise_vendas_completa
GROUP BY id_produtos, categoria, faixa_preco
ORDER BY receita_total DESC;