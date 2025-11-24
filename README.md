# 📊 Projeto de Análise de Dados - E-commerce

Análise exploratória completa de dados de um e-commerce fictício com SQL.

## 🗃️ Estrutura do Banco

- **clientes**: 30 clientes com dados demográficos
- **produtos**: 30 produtos categorizados por preço
- **pedidos**: 30 pedidos com status e datas
- **items**: 30 itens ligando pedidos e produtos

## 🚀 Como Executar

### Pré-requisitos
- PostgreSQL instalado
- Acesso a um banco de dados

### Setup do Banco

```bash
# Criar banco de dados
createdb ecommerce_analysis

# Executar scripts na ordem:
psql -d ecommerce_analysis -f data/01_schema.sql
psql -d ecommerce_analysis -f data/02_inserts.sql  
psql -d ecommerce_analysis -f data/03_views.sql
