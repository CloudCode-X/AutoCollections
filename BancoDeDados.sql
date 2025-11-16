CREATE DATABASE dbAutoCollections;
-- DROP DATABASE dbAutoCollections;
USE dbAutoCollections;

-- TABELA ESTADO
CREATE TABLE tbEstado(
	UFId INT PRIMARY KEY AUTO_INCREMENT,
    UF CHAR(2)
);

-- TABELA CIDADE

CREATE TABLE tbCidade(
	CidadeId INT PRIMARY KEY AUTO_INCREMENT,
    Cidade VARCHAR(200) NOT  NULL,
    IdUF INT NOT NULL,
    FOREIGN KEY (IdUF) REFERENCES tbEstado(UFId)
);

-- TABELA BAIRRO

CREATE TABLE tbBairro(
	BairroId INT PRIMARY KEY AUTO_INCREMENT,
	Bairro VARCHAR(200) NOT NULL,
    IdCidade INT NOT NULL,
	FOREIGN KEY (IdCidade) REFERENCES tbCidade(CidadeId)
);

-- TABELA ENDERECO

CREATE TABLE tbEndereco (
	Logradouro varchar(200) NOT NULL,
    CEP CHAR(8) PRIMARY KEY, -- sem traço
    IdUF INT NOT NULL,
    IdCidade INT NOT NULL,
    IdBairro INT NOT NULL,
    FOREIGN KEY (IdUF) REFERENCES tbEstado(UFId),
    FOREIGN KEY (IdCidade) REFERENCES tbCidade(CidadeId),
    FOREIGN KEY (IdBairro) REFERENCES tbBairro(BairroId)
);

-- TABELA USUARIO

CREATE TABLE tbUsuario (
    IdUsuario INT PRIMARY KEY AUTO_INCREMENT,
    CPF CHAR(11) NOT NULL,
    Nome VARCHAR(150) NOT NULL,
    DataNascimento DATE NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Senha VARCHAR(100) NOT NULL,
    NumeroEndereco CHAR(6) NOT NULL,
    ComplementoEndereco VARCHAR(50),
    Cep CHAR(8) NOT NULL,
    CONSTRAINT fk_usuario_endereco FOREIGN KEY (Cep) REFERENCES tbEndereco(CEP)
);


-- TABELA NIVEL DE ACESSO

CREATE TABLE tbNivelAcesso(
	IdNivel INT PRIMARY KEY AUTO_INCREMENT,
    NomeNivel VARCHAR(50) NOT NULL
);

INSERT INTO tbNivelAcesso(NomeNivel) VALUES ('Administrador'), ('Funcionário'), ('Cliente');

-- TABELA DE REFERENCIA DO NIVEL DE ACESSO DO USUARIO

CREATE TABLE tbUsuNivel(
	IdUsuario INT,
    IdNivel INT,
    PRIMARY KEY (IdUsuario, IdNivel),
  	CONSTRAINT fk_IdUsuario FOREIGN KEY(IdUsuario) REFERENCES tbUsuario(IdUsuario),
    CONSTRAINT fk_IdNivel FOREIGN KEY(IdNivel) REFERENCES tbNivelAcesso(IdNivel)
);

-- TABELA FORNECEDOR

CREATE TABLE tbFornecedor (
    IdFornecedor INT PRIMARY KEY AUTO_INCREMENT,
    NomeFornecedor VARCHAR(150) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    TelefoneFornecedor VARCHAR(15) NOT NULL,
    EmailFornecedor VARCHAR(100) NOT NULL,
    CepFornecedor CHAR(8) NOT NULL,
    CONSTRAINT fk_fornecedor_endereco FOREIGN KEY (CepFornecedor) REFERENCES tbEndereco(CEP)
);

-- TABELA CATEGORIA

CREATE TABLE tbCategoria(
	IdCategoria INT PRIMARY KEY AUTO_INCREMENT,
    NomeCategoria VARCHAR(50) NOT NULL
);

-- TABELA MARCA
CREATE TABLE tbMarca (
    IdMarca INT PRIMARY KEY AUTO_INCREMENT,
    NomeMarca VARCHAR(50) NOT NULL,
    LogoMarca VARCHAR(255) NULL
);

-- TABELA PRODUTO

CREATE TABLE tbProduto (
    IdProduto INT PRIMARY KEY AUTO_INCREMENT,
    IdFornecedor INT NOT NULL,
    NomeProduto VARCHAR(70) NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    Escala VARCHAR(10) NOT NULL, -- ex: "1:18"
    Peso DECIMAL(10,2) NOT NULL, -- em gramas
    Material VARCHAR(30) NOT NULL,
    TipoProduto VARCHAR(30) NOT NULL,
    QuantidadePecas INT NOT NULL,
    QuantidadeEstoque INT NOT NULL,
    QuantidadeMinima INT NOT NULL,
    Descricao VARCHAR(200) NOT NULL,
    IdCategoria INT NOT NULL,
    IdMarca INT NOT NULL,
	CONSTRAINT fk_produto_categoria FOREIGN KEY (IdCategoria) REFERENCES tbCategoria(IdCategoria),
    CONSTRAINT fk_produto_marca FOREIGN KEY (IdMarca) REFERENCES tbMarca(IdMarca),
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (IdFornecedor) REFERENCES tbFornecedor(IdFornecedor)
);

-- TABELA IMAGEM PRODUTO

CREATE TABLE tbImagemProduto (
	ImagemId INT PRIMARY KEY AUTO_INCREMENT,
    ProdutoId INT NOT NULL,
    CaminhoImagem VARCHAR(255) NOT NULL,
    FOREIGN KEY (ProdutoId) REFERENCES tbProduto(IdProduto)
);

-- TABELA DE STATUS DO PEDIDO

CREATE TABLE tbStatusPedido(
	IdStatus INT PRIMARY KEY AUTO_INCREMENT,
    NomeStatus VARCHAR(50) NOT NULL
);

INSERT INTO tbStatusPedido (NomeStatus) VALUES ('Em processamento'), ('Pago'), ('Enviado'), ('Finalizado'), ('Cancelado');

ALTER TABLE tbPedido ADD IdStatus INT NOT NULL, ADD CONSTRAINT fk_pedido_status FOREIGN KEY (IdStatus) REFERENCES tbStatusPedido(IdStatus);
ALTER TABLE tbPedido MODIFY COLUMN IdStatus INT NOT NULL DEFAULT 1;
ALTER TABLE tbPedido DROP COLUMN PedidoStatus;
-- TABELA PEDIDO

CREATE TABLE tbPedido (
    IdPedido INT PRIMARY KEY AUTO_INCREMENT,
    DataPedido DATE NOT NULL,
    ValorTotal DECIMAL(10,2) NOT NULL,
    IdUsuario INT NOT NULL,
    PedidoStatus VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pedido_usuario FOREIGN KEY (IdUsuario) REFERENCES tbUsuario(IdUsuario)
);

-- TABELA ITEM PEDIDO

CREATE TABLE tbItemPedido (
    IdPedido INT NOT NULL,
    IdProduto INT NOT NULL,
    QuantidadeProduto INT NOT NULL,
    SubTotal DECIMAL(10,2) NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (IdPedido, IdProduto),
    CONSTRAINT fk_itempedido_pedido FOREIGN KEY (IdPedido) REFERENCES tbPedido(IdPedido),
    CONSTRAINT fk_itempedido_produto FOREIGN KEY (IdProduto) REFERENCES tbProduto(IdProduto)
);

-- TABELA NOTA FISCAL

CREATE TABLE tbNotaFiscal (
    IdNF INT PRIMARY KEY AUTO_INCREMENT,
    ValorTotal DECIMAL(10,2) NOT NULL,
    DataEmissao DATE NOT NULL,
    NumeroSerie INT NOT NULL,
    IdPedido INT NOT NULL,
    CONSTRAINT fk_notafiscal_pedido FOREIGN KEY (IdPedido) REFERENCES tbPedido(IdPedido)
);

-- TABELA CARRINHO

CREATE TABLE tbCarrinho (
    IdCarrinho INT PRIMARY KEY AUTO_INCREMENT,
    IdUsuario INT NOT NULL,
    ValorTotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_carrinho_usuario FOREIGN KEY (IdUsuario) REFERENCES tbUsuario(IdUsuario)
);

-- TABELA ITEM CARRINHO

CREATE TABLE tbItemCarrinho (
    IdCarrinho INT NOT NULL,
    IdProduto INT NOT NULL,
    QuantidadeProduto INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    SubTotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (IdCarrinho, IdProduto),
    CONSTRAINT fk_itemcarrinho_carrinho FOREIGN KEY (IdCarrinho) REFERENCES tbCarrinho(IdCarrinho),
    CONSTRAINT fk_itemcarrinho_produto FOREIGN KEY (IdProduto) REFERENCES tbProduto(IdProduto)
);

-- TABELA PAGAMENTO

CREATE TABLE tbPagamento (
    IdPagamento INT PRIMARY KEY AUTO_INCREMENT,
    IdPedido INT NOT NULL,
    MetodoPagamento VARCHAR(30) NOT NULL,
    ValorPagamento DECIMAL(10,2) NOT NULL,
    StatusPagamento VARCHAR(20) NOT NULL,
    CodigoTransacao VARCHAR(100) NOT NULL,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataConfirmacao DATETIME NULL,
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (IdPedido) REFERENCES tbPedido(IdPedido)
);

-- TABELA CARTAO

CREATE TABLE tbCartao (
    IdCartao INT PRIMARY KEY AUTO_INCREMENT,
    IdUsuario INT NOT NULL,
    Bandeira VARCHAR(20) NOT NULL,
    UltimosDigitos CHAR(4) NOT NULL,
    NomeTitular VARCHAR(100) NOT NULL,
    ValidadeMes CHAR(7) NOT NULL,
    TokenCartao VARCHAR(255) NULL,
    DataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cartao_usuario FOREIGN KEY (IdUsuario) REFERENCES tbUsuario(IdUsuario)
);

-- Procedures 

-- procedure para adicionar a estado
-- drop procedure sp_CadastroEstado

DELIMITER $$
CREATE PROCEDURE sp_CadastroEstado(
	OUT vUFId INT,
	IN vUF CHAR(2)
)
BEGIN
	INSERT INTO tbEstado(UF) VALUES (vUF);SET 
    
    vUFId = LAST_INSERT_ID();
END $$

-- procedure para adicionar o cidade
-- drop procedure sp_CadastroCidade

DELIMITER $$
CREATE PROCEDURE sp_CadastroCidade(
	OUT vCidadeId INT,
	IN vCidade VARCHAR(200),
    IN vUFId INT
)
BEGIN
    INSERT INTO tbCidade(Cidade, IdUF) VALUES (vCidade, vUFId);
    
    SET vCidadeId = LAST_INSERT_ID();
END $$

SELECT * FROM tbCidade;

-- procedure para adicionar o bairro
-- drop procedure sp_CadastroBairro

DELIMITER $$
CREATE PROCEDURE sp_CadastroBairro(
	OUT vBairroId INT,
	IN vBairro VARCHAR(200),
    IN vCidadeId INT
)
BEGIN
    INSERT INTO tbBairro(Bairro, IdCidade) VALUES (vBairro, vCidadeId);
    
    SET vBairroId = LAST_INSERT_ID();
END $$

SELECT * FROM tbBairro;

-- procedure para adicionar o endereço
-- drop procedure sp_CadastroEndereco

DELIMITER $$
CREATE PROCEDURE sp_CadastroEndereco(
    IN vLogradouro varchar(200),
    IN vCEP CHAR(9), -- com traço
    IN vUF VARCHAR(200),
    IN vCidade VARCHAR(200),
    IN vBairro VARCHAR(200)
)
BEGIN
	DECLARE vUFId INT;
    DECLARE vCidadeId INT;
    DECLARE vBairroId INT;

	SELECT UFId INTO vUFId FROM tbEstado WHERE UF = vUF;
    SELECT CidadeId INTO vCidadeId FROM tbCidade WHERE Cidade = vCidade;
    SELECT BairroId INTO vBairroId FROM tbBairro WHERE Bairro = vBairro;
    
    INSERT INTO tbEndereco(Logradouro, CEP, IdUf, IdCidade, IdBairro) VALUES (vLogradouro, vCEP, vUFId, vCidadeId, vBairroId);
    
END $$

CREATE OR REPLACE VIEW vwEndereco AS
SELECT  e.Logradouro, e.CEP, e.IdUF, es.UF AS Estado, e.IdCidade, c.Cidade AS Cidade, e.IdBairro, b.Bairro AS Bairro
FROM tbEndereco e INNER JOIN tbEstado es ON e.IdUF = es.UFId INNER JOIN tbCidade c ON e.IdCidade = c.CidadeId INNER JOIN tbBairro b ON e.IdBairro = b.BairroId;

SELECT * FROM vwEndereco;

-- procedure de Cadastro do Usuario
-- drop procedure sp_CadastroUsuario

DELIMITER $$
CREATE PROCEDURE sp_CadastroUsuario(
	OUT vIdUsuario INT,
    IN vCPF CHAR(11),
    IN vNome VARCHAR(150),
    IN vDataNascimento CHAR(10),
	IN vTelefone VARCHAR(15),
    IN vEmail VARCHAR(150),
    IN vSenha VARCHAR(100),
    IN vNumeroEndereco CHAR(6),
    IN vComplementoEndereco VARCHAR(50),
    IN vCep CHAR(8)
)
BEGIN
	INSERT INTO tbUsuario(CPF, Nome, DataNascimento, Telefone, Email, Senha, NumeroEndereco, ComplementoEndereco, Cep) 
    VALUES(vCPF, vNome, (STR_TO_DATE(vDataNascimento, '%d/%m/%Y')), vTelefone, vEmail, vSenha, vNumeroEndereco, vComplementoEndereco, vCep);
    
    SELECT DATE_FORMAT(vDataNascimento, '%d/%m/%Y') AS DataNascimento;
    
    SET vIdUsuario = LAST_INSERT_ID();
END$$

-- ARRUMAR O STR TO DATE

SELECT * FROM tbUsuario;

-- procedure para definir o nivel do usuario
-- drop procedure sp_NivelUsuario

DELIMITER $$
CREATE PROCEDURE sp_NivelUsuario(
	vIdUsuario INT,
    vIdNivel INT
)
BEGIN
	INSERT INTO tbUsuNivel(IdUsuario, IdNivel)
    VALUES(vIdUsuario, vIdNivel);
END $$

CREATE OR REPLACE VIEW vwUsu AS
SELECT u.IdUsuario AS Codigo, u.CPF, u.Nome, u.Telefone, u.Email, u.Senha, u.Cep, n.IdNivel, n.NomeNivel 
FROM tbUsuario u INNER JOIN tbUsuNivel un ON u.IdUsuario = un.IdUsuario INNER JOIN tbNivelAcesso n ON n.IdNivel = un.IdNivel;

SELECT * FROM vwUsu;

-- procedure para cadastro de Fornecedor
-- drop procedure sp_CadastroFornecedor

DELIMITER $$
CREATE PROCEDURE sp_CadastroFornecedor(
	OUT vIdFornecedor INT,
    IN vNomeFornecedor VARCHAR(150),
    IN vCNPJ CHAR(14),
    IN vTelefoneFornecedor VARCHAR(15),
    IN vEmailFornecedor VARCHAR(100),
    IN vCepFornecedor CHAR(8)
)
BEGIN
	INSERT INTO tbFornecedor(NomeFornecedor, CNPJ, TelefoneFornecedor, EmailFornecedor, CepFornecedor) VALUES(vNomeFornecedor, vCNPJ, vTelefoneFornecedor, vEmailFornecedor, vCepFornecedor);
    
    SET vIdFornecedor = LAST_INSERT_ID();
END $$

SELECT * FROM tbFornecedor;

-- procedure para cadastro das marcas
-- drop procedure sp_CadastroMarca

DELIMITER $$
CREATE PROCEDURE sp_CadastroMarca(
	OUT vIdMarca INT,
    IN vNomeMarca VARCHAR(50),
    IN vLogoMarca VARCHAR(255)
)
BEGIN
	INSERT INTO tbMarca(NomeMarca, LogoMarca) VALUES (vNomeMarca, vLogoMarca);
    
    SET vIdMarca = LAST_INSERT_ID();
END$$

SELECT * FROM tbMarca;

-- procedure para cadastro das categorias
-- drop procedure sp_CadastroCategorias

DELIMITER $$
CREATE PROCEDURE sp_CadastroCategoria(
	OUT vIdCategoria INT,
    IN vNomeCategoria VARCHAR(50)
)
BEGIN
	INSERT INTO tbCategoria(NomeCategoria) VALUES (vNomeCategoria);
    
    SET vIdCategoria = LAST_INSERT_ID();
END $$

SELECT * FROM tbCategoria;

-- procedure para cadastro de produto
-- drop procedure sp_CadastroProduto

DELIMITER $$
CREATE PROCEDURE sp_CadastroProduto(
	OUT vIdProduto INT,
    IN vIdFornecedor INT,
    IN vNomeProduto VARCHAR(70),
    IN vPrecoUnitario DECIMAL(10,2),
    IN vEscala VARCHAR(10),
    IN vPeso DECIMAL(10,2),
    IN vMaterial VARCHAR(30),
    IN vTipoProduto VARCHAR(30),
    IN vQuantidadePecas INT,
    IN vQuantidadeEstoque INT,
    IN vQuantidadeMinima INT,
    IN vDescricao VARCHAR(200),
    IN vIdCategoria INT,
    IN vIdMarca INT
)
BEGIN
	INSERT INTO tbProduto(IdFornecedor, NomeProduto, PrecoUnitario, Escala, Peso, Material, TipoProduto, QuantidadePecas, QuantidadeEstoque, QuantidadeMinima, Descricao, IdCategoria, IdMarca)
    VALUES(vIdFornecedor, vNomeProduto, vPrecoUnitario, vEscala, vPeso, vMaterial, vTipoProduto, vQuantidadePecas, vQuantidadeEstoque, vQuantidadeMinima, vDescricao, vIdCategoria, vIdMarca);
    
    SET vIdProduto = LAST_INSERT_ID();
END $$

CREATE OR REPLACE VIEW vwProduto AS
SELECT p.IdProduto, p.NomeProduto, p.PrecoUnitario, p.Escala, p.Peso, p.Material, p.TipoProduto, p.QuantidadePecas, p.QuantidadeEstoque, p.QuantidadeMinima, p.Descricao, c.NomeCategoria, m.NomeMarca, f.NomeFornecedor
FROM tbProduto p INNER JOIN tbCategoria c on p.IdCategoria = c.IdCategoria
				INNER JOIN tbMarca m on p.IdMarca = m.IdMarca
                INNER JOIN tbFornecedor f on p.IdFornecedor = f.IdFornecedor;

SELECT * FROM vwProduto;

-- procedure para o cadastro de imagens
-- drop procedure sp_CadastroImagemProduto

DELIMITER $$
CREATE PROCEDURE sp_CadastroImagemProduto(
	OUT vImagemId INT,
    IN vProdutoId INT,
    IN vCaminhoImagem VARCHAR(255)
)
BEGIN
	INSERT INTO tbImagemProduto(ProdutoId, CaminhoImagem) VALUES (vProdutoId, vCaminhoImagem);
    
    SET vImagemId = LAST_INSERT_ID();
END $$

SELECT * FROM tbImagemProduto;

-- procedure para criacao dos pedidos
-- drop procedure sp_CriarPedido

DELIMITER $$
CREATE PROCEDURE sp_CriarPedido(
    OUT vIdPedido INT,
    IN vIdUsuario INT,
    IN vIdStatus INT
)
BEGIN
    INSERT INTO tbPedido(DataPedido, ValorTotal, IdUsuario, IdStatus)
    VALUES (CURRENT_DATE(), 0, vIdUsuario, vIdStatus);

    SET vIdPedido = LAST_INSERT_ID();
END $$
CREATE OR REPLACE VIEW vwPedido AS
SELECT p.IdPedido, p.DataPedido, p.ValorTotal, u.Nome AS Usuario, s.IdStatus, s.NomeStatus FROM tbPedido p INNER JOIN tbUsuario u ON p.IdUsuario = u.IdUsuario INNER JOIN tbStatusPedido s ON p.IdStatus = s.IdStatus;

SELECT * FROM vwPedido;

-- procedure de cadastro do carrinho
-- drop procedure sp_CadastroCarrinho

DELIMITER $$
CREATE PROCEDURE sp_CadastroCarrinho(
	OUT vIdCarrinho INT,
    IN vIdUsuario INT
)
BEGIN
	INSERT INTO tbCarrinho(IdUsuario, ValorTotal) VALUES (vIdUsuario, 0);
    
    SET vIdCarrinho = LAST_INSERT_ID();
END $$

SELECT * FROM tbCarrinho;

-- procedure para adicionar itens no carrinho
-- drop procedure sp_AdicionarItemCarrinho

DELIMITER $$
CREATE PROCEDURE sp_AdicionarItemCarrinho(
	IN vIdCarrinho INT,
    IN vIdProduto INT,
    IN vQuantidade INT
)
BEGIN
	DECLARE vPreco DECIMAL(10,2);
    DECLARE vSubTotal DECIMAL(10,2);
    
    SELECT PrecoUnitario INTO vPreco FROM tbProduto WHERE IdProduto = vIdProduto;
    
    SET vSubTotal = vPreco * vQuantidade;
    
    INSERT INTO tbItemCarrinho(IdCarrinho, IdProduto, QuantidadeProduto, PrecoUnitario, SubTotal) VALUES (vIdCarrinho, vIdProduto, vQuantidade, vPreco, vSubTotal);
    
END $$

-- procedure para pagamento
-- drop procedure sp_RegistrarPagamento

DELIMITER $$
CREATE PROCEDURE sp_RegistrarPagamento(
    OUT vIdPagamento INT,
    IN vIdPedido INT,
    IN vMetodoPagamento VARCHAR(30),
    IN vValorPagamento DECIMAL(10,2),
    IN vStatusPagamento VARCHAR(20), 
    IN vCodigoTransacao VARCHAR(100)
)
BEGIN
    DECLARE vDataConfirmacao DATETIME;

    IF vStatusPagamento = 'Pago' THEN 
		SET vDataConfirmacao = NOW();
		UPDATE tbPedido SET IdStatus = 2 WHERE IdPedido = vIdPedido;
    ELSEIF vStatusPagamento = 'Cancelado' THEN
        SET vDataConfirmacao = NULL;
        UPDATE tbPedido SET IdStatus = 5 WHERE IdPedido = vIdPedido;
    ELSE
        SET vDataConfirmacao = NULL;
    END IF;

    INSERT INTO tbPagamento(IdPedido, MetodoPagamento, ValorPagamento, StatusPagamento, CodigoTransacao, DataConfirmacao) VALUES (vIdPedido, vMetodoPagamento, vValorPagamento, vStatusPagamento, vCodigoTransacao, vDataConfirmacao);

    SET vIdPagamento = LAST_INSERT_ID();
END $$
