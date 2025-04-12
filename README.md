# 🛒 Desafio E-commerce - Modelagem de Banco de Dados

Este projeto faz parte do bootcamp **Heineken - Inteligência Artificial Aplicada a Dados com Copilot**, da plataforma DIO.

O objetivo do desafio é aplicar os conceitos de modelagem lógica de banco de dados relacionais em um cenário realista de **e-commerce**, utilizando o **MySQL Workbench**. A proposta inclui modelar o banco, criar o script SQL, inserir dados fictícios e desenvolver queries avançadas de análise.

---

## 📌 Cenário Proposto

O desafio parte de um modelo de e-commerce com os seguintes **refinamentos obrigatórios**:

- **Cliente PF e PJ**: Cada cliente pode ser Pessoa Física ou Jurídica, mas não ambas.
- **Formas de Pagamento**: Um cliente pode ter mais de uma forma de pagamento cadastrada.
- **Entrega**: Cada pedido possui status e código de rastreio, além de datas de envio e entrega.

---

## 🧠 Modelagem

O modelo lógico foi desenvolvido no MySQL Workbench.

Ele contempla entidades como:

- Cliente (PF/PJ)
- Pedido
- Produto
- Fornecedor
- Estoque
- Vendedor (Terceiro)
- Entrega
- Formas de Pagamento

Foram implementadas **chaves primárias, estrangeiras, relacionamentos e constraints** conforme o cenário.

---

## 🧪 Queries de Análise

O projeto inclui um conjunto de queries que exploram aspectos importantes do banco de dados, como:

- Quantidade de pedidos por cliente
- Clientes com múltiplos métodos de pagamento
- Produtos vendidos e não vendidos
- Relação de produtos, fornecedores e estoques
- Verificação se algum vendedor também é fornecedor
- Cálculo de valor total dos pedidos
- Tempo de entrega por pedido (com cálculo de dias)
- Pedidos por status com filtros (HAVING)
- JOINs complexos entre tabelas


---

## 👩‍💻 Sobre mim

Desenvolvido por **Mara Costa** como parte do aprendizado prático no bootcamp da DIO.

---
