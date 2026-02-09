# E-commerce Database Project

Projeto lógico de banco de dados para um cenário de E-commerce. O esquema contempla a gestão de clientes (PF e PJ), múltiplos meios de pagamento, entregas e gerenciamento de estoque/fornecedores.

## Estrutura

A modelagem segue a estratégia de **Especialização/Generalização** para a tabela de Clientes, separando dados fiscais (CPF/CNPJ) em tabelas filhas para garantir integridade e normalização (3FN).

### Principais Entidades
- **Clients:** Tabela pai para PF e PJ.
- **Orders & Delivery:** Controle de status do pedido e rastreio logístico.
- **Product & Storage:** Gestão de catálogo e relacionamento N:M com fornecedores.

## Queries Implementadas

O arquivo `queries_and_data.sql` contém cenários reais de negócio:
1. Join complexo para unificar identificação de clientes PF/PJ.
2. Cálculo de valor total do pedido (Atributo derivado).
3. Filtros de agregação (HAVING) para identificar clientes recorrentes.

## Como rodar

1. Clone o repositório.
2. Execute o script `schema.sql` para criar a estrutura.
3. Execute `queries_and_data.sql` para popular o banco e testar as views.
