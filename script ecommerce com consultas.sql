-- ============================
-- Criação das tabelas
-- ============================

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Identificacao` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(100) NOT NULL,
  `CPF_CNPJ` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB;

-- Tabela Pagamento
CREATE TABLE IF NOT EXISTS `Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `Valor` DECIMAL(10,2) NOT NULL,
  `FormaPagamento` VARCHAR(45) NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `DataPagamento` DATETIME NOT NULL,
  `idPedido` INT,
  PRIMARY KEY (`idPagamento`)
) ENGINE=InnoDB;

-- Tabela Entrega
CREATE TABLE IF NOT EXISTS `Entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NOT NULL,
  `CodRastreio` VARCHAR(100) NOT NULL,
  `Transportadora` VARCHAR(45) NOT NULL,
  `idPedido` INT,
  PRIMARY KEY (`idEntrega`)
) ENGINE=InnoDB;

-- Tabela Pedido
CREATE TABLE IF NOT EXISTS `Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(100),
  `Cliente_idCliente` INT NOT NULL,
  `Frete` FLOAT NOT NULL,
  PRIMARY KEY (`idPedido`),
  FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente`(`idCliente`)
) ENGINE=InnoDB;

-- Tabela Produto
CREATE TABLE IF NOT EXISTS `Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(100) NOT NULL,
  `Valor` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB;

-- Tabela Fornecedor
CREATE TABLE IF NOT EXISTS `Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `RazaoSocial` VARCHAR(100) NOT NULL,
  `CNPJ` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idFornecedor`)
) ENGINE=InnoDB;

-- Tabela DisponibilizaProduto
CREATE TABLE IF NOT EXISTS `DisponibilizaProduto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  FOREIGN KEY (`Fornecedor_idFornecedor`) REFERENCES `Fornecedor`(`idFornecedor`),
  FOREIGN KEY (`Produto_idProduto`) REFERENCES `Produto`(`idProduto`)
) ENGINE=InnoDB;

-- Tabela Estoque
CREATE TABLE IF NOT EXISTS `Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Local` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idEstoque`)
) ENGINE=InnoDB;

-- Tabela ProdutoEmEstoque
CREATE TABLE IF NOT EXISTS `ProdutoEmEstoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  FOREIGN KEY (`Produto_idProduto`) REFERENCES `Produto`(`idProduto`),
  FOREIGN KEY (`Estoque_idEstoque`) REFERENCES `Estoque`(`idEstoque`)
) ENGINE=InnoDB;

-- Tabela ProdutoPorPedido
CREATE TABLE IF NOT EXISTS `ProdutoPorPedido` (
  `Pedido_idPedido` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Produto_idProduto`),
  FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido`(`idPedido`),
  FOREIGN KEY (`Produto_idProduto`) REFERENCES `Produto`(`idProduto`)
) ENGINE=InnoDB;

-- Tabela VendedorTerceiro
CREATE TABLE IF NOT EXISTS `VendedorTerceiro` (
  `idVendedorTerceiro` INT NOT NULL AUTO_INCREMENT,
  `RazaoSocial` VARCHAR(100) NOT NULL,
  `Local` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idVendedorTerceiro`)
) ENGINE=InnoDB;

-- Tabela ProdutosPorVendedor
CREATE TABLE IF NOT EXISTS `ProdutosPorVendedor` (
  `VendedorTerceiro_idVendedorTerceiro` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`VendedorTerceiro_idVendedorTerceiro`, `Pedido_idPedido`),
  FOREIGN KEY (`VendedorTerceiro_idVendedorTerceiro`) REFERENCES `VendedorTerceiro`(`idVendedorTerceiro`),
  FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido`(`idPedido`)
) ENGINE=InnoDB;

-- ============================
-- INSERÇÕES
-- ============================
INSERT INTO Cliente (Nome, Identificacao, Endereco, CPF_CNPJ) VALUES
('João Silva', '123456789', 'Rua A, 123', '111.222.333-44'),
('Maria Oliveira', '987654321', 'Av. Central, 456', '222.333.444-55');

INSERT INTO Pedido (Status, Descricao, Cliente_idCliente, Frete) VALUES
('Pendente', 'Pedido de teste', 1, 15.90),
('Enviado', 'Pedido com entrega', 2, 25.00);

INSERT INTO Produto (Categoria, Descricao, Valor) VALUES
('Eletrônico', 'Fone de ouvido', 99.90),
('Livros', 'Livro de SQL', 59.90);

INSERT INTO Fornecedor (RazaoSocial, CNPJ) VALUES
('Tech Supplies LTDA', '12.345.678/0001-90'),
('Livros & Cia', '98.765.432/0001-01');

INSERT INTO DisponibilizaProduto (Fornecedor_idFornecedor, Produto_idProduto) VALUES
(1, 1),
(2, 2);

INSERT INTO Estoque (Local) VALUES
('Centro - SP'),
('Zona Norte - SP');

INSERT INTO ProdutoEmEstoque (Produto_idProduto, Estoque_idEstoque, Quantidade) VALUES
(1, 1, 50),
(2, 2, 100);

INSERT INTO ProdutoPorPedido (Pedido_idPedido, Produto_idProduto, Quantidade) VALUES
(1, 1, 2),
(2, 2, 3);

INSERT INTO VendedorTerceiro (RazaoSocial, Local) VALUES
('Loja do João', 'Shopping Eldorado'),
('Mega Outlet', 'Centro Comercial');

INSERT INTO ProdutosPorVendedor (VendedorTerceiro_idVendedorTerceiro, Pedido_idPedido) VALUES
(1, 1),
(2, 2);

-- ============================
-- CONSULTAS SQL AVANÇADAS (PARTE COMERCIAL)
-- ============================

-- 1. Pedidos realizados por cada cliente
SELECT 
  p.idPedido,
  c.nome AS cliente,
  p.data_pedido,
  p.valor_total
FROM Pedido p
JOIN Cliente c ON p.cliente_id = c.idCliente
ORDER BY p.data_pedido DESC;

-- 2. Produtos vendidos por pedido com subtotais
SELECT 
  p.idPedido,
  pr.nome AS produto,
  ip.quantidade,
  ip.preco_unitario,
  (ip.quantidade * ip.preco_unitario) AS subtotal
FROM ItemPedido ip
JOIN Produto pr ON ip.produto_id = pr.idProduto
JOIN Pedido p ON ip.pedido_id = p.idPedido
ORDER BY p.idPedido, produto;

-- 3. Clientes que gastaram mais de R$ 500
SELECT 
  c.nome AS cliente,
  SUM(p.valor_total) AS total_gasto
FROM Pedido p
JOIN Cliente c ON p.cliente_id = c.idCliente
GROUP BY c.nome
HAVING SUM(p.valor_total) > 500;

-- 4. Total de pedidos por forma de pagamento
SELECT 
  f.tipo AS forma_pagamento,
  COUNT(*) AS total_pedidos
FROM Pedido p
JOIN Pagamento pag ON p.pagamento_id = pag.idPagamento
JOIN FormaPagamento f ON pag.forma_pagamento_id = f.idFormaPagamento
GROUP BY f.tipo
HAVING COUNT(*) >= 1;

-- 5. Entregas com destino para Belo Horizonte
SELECT 
  p.idPedido,
  e.endereco_entrega,
  e.cidade,
  e.data_envio,
  e.codigo_rastreio
FROM Pedido p
JOIN Entrega e ON p.entrega_id = e.idEntrega
WHERE e.cidade = 'Belo Horizonte';

-- 6. Produtos com estoque menor que 20
SELECT 
  nome,
  estoque
FROM Produto
WHERE estoque < 20
ORDER BY estoque ASC;

-- 7. Clientes que ainda não realizaram pedidos
SELECT 
  c.nome AS cliente
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.cliente_id
WHERE p.idPedido IS NULL;

-- 8. Algum vendedor também é fornecedor
SELECT 
  v.nome AS vendedor,
  f.nome AS fornecedor,
  v.cpf_cnpj
FROM Vendedor v
JOIN Fornecedor f ON v.cpf_cnpj = f.cpf_cnpj;

-- 9.  Relação de produtos fornecedores e estoques
SELECT 
  f.nome AS fornecedor,
  p.nome AS produto,
  p.estoque
FROM ProdutoFornecedor pf
JOIN Fornecedor f ON pf.fornecedor_id = f.idFornecedor
JOIN Produto p ON pf.produto_id = p.idProduto
ORDER BY f.nome, p.nome;

-- 10. Relação de nomes dos fornecedores e nomes dos produtos
SELECT 
  DISTINCT f.nome AS fornecedor,
  p.nome AS produto
FROM ProdutoFornecedor pf
JOIN Fornecedor f ON pf.fornecedor_id = f.idFornecedor
JOIN Produto p ON pf.produto_id = p.idProduto
ORDER BY f.nome, p.nome;

-- 11. 