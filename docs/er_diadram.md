# Diagrama Entidade-Relacionamento

## Entidades

### Clientes
- id_clientes (PK)
- nome
- estado
- data_cadastro

### Produtos
- id_produtos (PK)  
- categoria
- preco

### Pedidos
- id_pedido (PK)
- id_cliente (FK → Clientes)
- data_pedido
- status

### Items
- id_items (PK)
- pedido_id (FK → Pedidos)
- produto_id (FK → Produtos)
- quantidade

## Relacionamentos

- Clientes (1) → (N) Pedidos
- Pedidos (1) → (N) Items  
- Produtos (1) → (N) Items
