-- Tabela de clientes
CREATE TABLE clientes (
    id_clientes SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    estado VARCHAR(2),
    data_cadastro DATE
);

-- Tabela de produtos
CREATE TABLE produtos (
    id_produtos SERIAL PRIMARY KEY,
    categoria VARCHAR(50),
    preco NUMERIC(10,2)
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_clientes)
);

-- Tabela de itens dos pedidos
CREATE TABLE items (
    id_items SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (produto_id) REFERENCES produtos(id_produtos)
);
