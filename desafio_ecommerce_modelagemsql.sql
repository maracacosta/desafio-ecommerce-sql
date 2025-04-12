
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Tabela: Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY AUTO_INCREMENT,
    `Razão Social` VARCHAR(45),
    CNPJ VARCHAR(45)
);

-- Tabela: Produto
CREATE TABLE Produto (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,
    Categoria VARCHAR(45),
    `Descrição` VARCHAR(45),
    Valor DECIMAL(10,2)
);

-- Tabela: Disponibilizando_um_Produto (Relacionamento N:N entre Produto e Fornecedor)
CREATE TABLE Disponibilizando_um_Produto (
    Fornecedor_idFornecedor INT,
    Produto_idProduto INT,
    PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- Tabela: Estoque
CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY AUTO_INCREMENT,
    Local VARCHAR(45)
);

-- Tabela: Produto_has_Estoque (Relacionamento N:N com quantidade)
CREATE TABLE Produto_has_Estoque (
    Produto_idProduto INT,
    Estoque_idEstoque INT,
    Quantidade INT,
    PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

-- Tabela: Terceiro_Vendedor
CREATE TABLE Terceiro_Vendedor (
    idTerceiro INT PRIMARY KEY AUTO_INCREMENT,
    `Razão Social` VARCHAR(45),
    Local VARCHAR(45)
);

-- Tabela: ProdutosVendedor(Terceiro) (Relacionamento N:N com Quantidade)
CREATE TABLE ProdutosVendedor (
    Terceiro_idTerceiro INT,
    Produto_idProduto INT,
    Quantidade INT,
    PRIMARY KEY (Terceiro_idTerceiro, Produto_idProduto),
    FOREIGN KEY (Terceiro_idTerceiro) REFERENCES Terceiro_Vendedor(idTerceiro),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- Tabela: Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    `Nome Completo` VARCHAR(100),
    Identificação ENUM('PF', 'PJ'),
    `Endereço` VARCHAR(100),
    `Razão Social` VARCHAR(100),
    CPF VARCHAR(14),
    CNPJ VARCHAR(45),
    Telefone VARCHAR(20),
    DataCadastro DATE
);

-- Tabela: FormaPagamento
CREATE TABLE FormaPagamento (
    idFormaPagamento INT PRIMARY KEY AUTO_INCREMENT,
    TipoPagamento ENUM('Crédito', 'Débito', 'Boleto', 'Pix')
);

-- Tabela: ClienteFormaPagamento (Relacionamento N:N)
CREATE TABLE ClienteFormaPagamento (
    idCliente INT,
    idFormaPagamento INT,
    DetalhesPagamento VARCHAR(100),
    PRIMARY KEY (idCliente, idFormaPagamento),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idFormaPagamento) REFERENCES FormaPagamento(idFormaPagamento)
);

-- Tabela: StatusEntrega
CREATE TABLE StatusEntrega (
    idStatusEntrega INT PRIMARY KEY AUTO_INCREMENT,
    StatusEntrega VARCHAR(45)
);

-- Tabela: Frete
CREATE TABLE Frete (
    idFrete INT PRIMARY KEY AUTO_INCREMENT,
    valorFrete DECIMAL(10,2),
    TipoFrete VARCHAR(45),
    PrazoEntrega VARCHAR(45),
    TipoEntrega VARCHAR(45)
);

-- Tabela: Pedido
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    `Status do Pedido` VARCHAR(45),
    `Descrição` VARCHAR(100),
    Cliente_idCliente INT,
    Entrega_idEntrega INT,
    idFormaPagamento INT,
    idFrete INT,
    idStatusEntrega INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idFormaPagamento) REFERENCES FormaPagamento(idFormaPagamento),
    FOREIGN KEY (idFrete) REFERENCES Frete(idFrete),
    FOREIGN KEY (idStatusEntrega) REFERENCES StatusEntrega(idStatusEntrega)
);

-- Tabela: Entrega
CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT,
    statusEntrega ENUM('Enviado', 'Em trânsito', 'Entregue', 'Cancelado'),
    codigoRastreamento VARCHAR(45),
    dataEnvio DATE,
    dataEntrega DATE,
    motivoCancelamento VARCHAR(100),
    valorFrete DECIMAL(10,2),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Tabela: RelacaoDeProduto_Pedido (Relacionamento N:N com Quantidade)
CREATE TABLE RelacaoDeProduto_Pedido (
    Produto_idProduto INT,
    Pedido_idPedido INT,
    Quantidade INT,
    PRIMARY KEY (Produto_idProduto, Pedido_idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

# Gerar script SQL com dados fictícios para testes baseado na estrutura anterior


-- Inserções de dados fictícios

-- Fornecedores
INSERT INTO Fornecedor (`Razão Social`, CNPJ) VALUES 
('Brinquedos Felizes S/A', '12.345.678/0001-90'),
('Mundo da Criança Ltda', '98.765.432/0001-10'),
('Diversão e Magia EIRELI', '11.222.333/0001-44');

-- Produtos
INSERT INTO Produto (Categoria, `Descrição`, Valor) VALUES 
('Educativo', 'Blocos de Montar - 100 peças', 89.90),
('Eletrônico', 'Carrinho Controle Remoto', 199.99),
('Plush', 'Urso de Pelúcia Grande', 149.50),
('Tabuleiro', 'Jogo da Memória Infantil', 59.90);

-- Estoques
INSERT INTO Estoque (Local) VALUES 
('São Paulo - Centro'),
('Rio de Janeiro - Barra'),
('Curitiba - Batel');

-- Disponibilizando um Produto
INSERT INTO Disponibilizando_um_Produto (Fornecedor_idFornecedor, Produto_idProduto) VALUES 
(1, 1), (1, 2), (2, 3), (3, 4);

-- Produto_has_Estoque
INSERT INTO Produto_has_Estoque (Produto_idProduto, Estoque_idEstoque, Quantidade) VALUES 
(1, 1, 50), (2, 1, 30), (3, 2, 20), (4, 3, 40);

-- Terceiros - Vendedores
INSERT INTO Terceiro_Vendedor (`Razão Social`, Local) VALUES 
('BrinqTop Vendas', 'Campinas'),
('KidsWorld Market', 'Recife');

-- ProdutosVendedor
INSERT INTO ProdutosVendedor (Terceiro_idTerceiro, Produto_idProduto, Quantidade) VALUES 
(1, 1, 10), (1, 4, 5), (2, 2, 15), (2, 3, 7);

-- Clientes
INSERT INTO Cliente (`Nome Completo`, Identificação, `Endereço`, `Razão Social`, CPF, CNPJ, Telefone, DataCadastro) VALUES 
('Maria Silva', 'PF', 'Rua das Flores, 123', NULL, '123.456.789-00', NULL, '(11) 99999-0001', '2024-04-01'),
('João Oliveira', 'PF', 'Av. Paulista, 1000', NULL, '987.654.321-00', NULL, '(11) 99999-0002', '2024-04-02'),
('Brinquedos e Cia Ltda', 'PJ', 'Rua Industrial, 55', 'Brinquedos e Cia Ltda', NULL, '77.888.999/0001-66', '(11) 99999-0003', '2024-04-03'),
('Mundo Infantil Comércio', 'PJ', 'Av. das Crianças, 456', 'Mundo Infantil Comércio', NULL, '22.333.444/0001-11', '(11) 99999-0004', '2024-04-04');

-- Formas de Pagamento
INSERT INTO FormaPagamento (TipoPagamento) VALUES 
('Crédito'), ('Débito'), ('Pix'), ('Boleto');

-- ClienteFormaPagamento
INSERT INTO ClienteFormaPagamento (idCliente, idFormaPagamento, DetalhesPagamento) VALUES 
(1, 1, 'Visa final 1234'), (1, 3, 'Pix CPF'),
(2, 2, 'Master final 4321'), 
(3, 4, 'Boleto empresarial'), (3, 1, 'Cielo CredCorp'),
(4, 3, 'Pix CNPJ');

-- StatusEntrega
INSERT INTO StatusEntrega (StatusEntrega) VALUES 
('Enviado'), ('Em trânsito'), ('Entregue'), ('Cancelado');

-- Frete
INSERT INTO Frete (valorFrete, TipoFrete, PrazoEntrega, TipoEntrega) VALUES 
(19.90, 'PAC', '7 dias úteis', 'Normal'),
(29.90, 'Sedex', '3 dias úteis', 'Expresso');

-- Pedidos
INSERT INTO Pedido (`Status do Pedido`, `Descrição`, Cliente_idCliente, idFormaPagamento, idFrete, idStatusEntrega) VALUES 
('Pago', 'Pedido de blocos e urso', 1, 1, 1, 3),
('Enviado', 'Carrinho controle remoto', 2, 2, 2, 2),
('Cancelado', 'Jogo da memória', 3, 4, 1, 4);

-- Entregas
INSERT INTO Entrega (idPedido, statusEntrega, codigoRastreamento, dataEnvio, dataEntrega, motivoCancelamento, valorFrete) VALUES 
(1, 'Entregue', 'BR123456SP', '2024-04-03', '2024-04-10', NULL, 19.90),
(2, 'Em trânsito', 'BR654321RJ', '2024-04-04', NULL, NULL, 29.90),
(3, 'Cancelado', 'BR000111PR', NULL, NULL, 'Cliente desistiu', 19.90);

-- RelacaoDeProduto_Pedido
INSERT INTO RelacaoDeProduto_Pedido (Produto_idProduto, Pedido_idPedido, Quantidade) VALUES 
(1, 1, 2), (3, 1, 1),
(2, 2, 1),
(4, 3, 3);

-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT c.`Nome Completo`, COUNT(p.idPedido) AS total_pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY c.idCliente;

-- 2. Algum vendedor também é fornecedor?
SELECT t.`Razão Social` AS Vendedor, f.`Razão Social` AS Fornecedor
FROM Terceiro_Vendedor t
JOIN Fornecedor f ON t.`Razão Social` = f.`Razão Social`;

-- 3. Relação de produtos, fornecedores e estoques
SELECT pr.`Descrição` AS Produto, f.`Razão Social` AS Fornecedor, e.Local AS Estoque, pe.Quantidade
FROM Produto pr
JOIN Disponibilizando_um_Produto dp ON pr.idProduto = dp.Produto_idProduto
JOIN Fornecedor f ON dp.Fornecedor_idFornecedor = f.idFornecedor
JOIN Produto_has_Estoque pe ON pr.idProduto = pe.Produto_idProduto
JOIN Estoque e ON pe.Estoque_idEstoque = e.idEstoque;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos
SELECT f.`Razão Social` AS Fornecedor, p.`Descrição` AS Produto
FROM Fornecedor f
JOIN Disponibilizando_um_Produto dp ON f.idFornecedor = dp.Fornecedor_idFornecedor
JOIN Produto p ON dp.Produto_idProduto = p.idProduto;

-- 5. Produtos vendidos por vendedor e quantidade total
SELECT t.`Razão Social` AS Vendedor, p.`Descrição` AS Produto, pv.Quantidade
FROM ProdutosVendedor pv
JOIN Produto p ON pv.Produto_idProduto = p.idProduto
JOIN Terceiro_Vendedor t ON pv.Terceiro_idTerceiro = t.idTerceiro;

-- 6. Clientes com mais de um método de pagamento
SELECT c.`Nome Completo`, COUNT(cf.idFormaPagamento) AS qtd_pagamentos
FROM Cliente c
JOIN ClienteFormaPagamento cf ON c.idCliente = cf.idCliente
GROUP BY c.idCliente
HAVING qtd_pagamentos > 1;

-- 7. Pedidos com valor total estimado (produto * quantidade)
SELECT p.idPedido, c.`Nome Completo`, SUM(pr.Valor * rp.Quantidade) AS valor_total
FROM Pedido p
JOIN Cliente c ON p.Cliente_idCliente = c.idCliente
JOIN RelacaoDeProduto_Pedido rp ON p.idPedido = rp.Pedido_idPedido
JOIN Produto pr ON rp.Produto_idProduto = pr.idProduto
GROUP BY p.idPedido;

-- 8. Pedidos entregues com tempo de entrega calculado
SELECT e.idPedido, e.codigoRastreamento, DATEDIFF(e.dataEntrega, e.dataEnvio) AS dias_para_entrega
FROM Entrega e
WHERE e.statusEntrega = 'Entregue';

-- 9. Total de pedidos por status do pedido (com filtro mínimo)
SELECT `Status do Pedido`, COUNT(*) AS total
FROM Pedido
GROUP BY `Status do Pedido`
HAVING total > 0;

-- 10. Listar produtos não vendidos (sem aparecer em pedidos)
SELECT p.`Descrição`
FROM Produto p
LEFT JOIN RelacaoDeProduto_Pedido rp ON p.idProduto = rp.Produto_idProduto
WHERE rp.Pedido_idPedido IS NULL;

