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
    CPFUsuario CHAR(11) NOT NULL,
    NomeUsuario VARCHAR(150) NOT NULL,
    DataNascimento DATE NOT NULL,
    TelefoneUsuario VARCHAR(15) NOT NULL,
    EmailUsuario VARCHAR(150) NOT NULL UNIQUE,
    SenhaUsuario VARCHAR(100) NOT NULL,
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


-- TABELA PEDIDO

CREATE TABLE tbPedido (
    IdPedido INT PRIMARY KEY AUTO_INCREMENT,
    DataPedido DATE NOT NULL,
    ValorTotal DECIMAL(10,2) NOT NULL,
    IdUsuario INT NOT NULL,
    PedidoStatus VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pedido_usuario FOREIGN KEY (IdUsuario) REFERENCES tbUsuario(IdUsuario)
);

ALTER TABLE tbPedido ADD IdStatus INT NOT NULL, ADD CONSTRAINT fk_pedido_status FOREIGN KEY (IdStatus) REFERENCES tbStatusPedido(IdStatus);
ALTER TABLE tbPedido MODIFY COLUMN IdStatus INT NOT NULL DEFAULT 1;
ALTER TABLE tbPedido DROP COLUMN PedidoStatus;
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

ALTER TABLE tbPagamento ADD IdCartao INT NULL, ADD CONSTRAINT fk_pagamento_cartao FOREIGN KEY (IdCartao) REFERENCES tbCartao(IdCartao);
ALTER TABLE tbMarca ADD DescricaoMarca VARCHAR(150) NOT NULL;
ALTER TABLE tbCategoria ADD DescricaoCategoria VARCHAR(150) NOT NULL;
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
    IN vCPFUsuario CHAR(11),
    IN vNomeUsuario VARCHAR(150),
    IN vDataNascimento CHAR(10),
	IN vTelefoneUsuario VARCHAR(15),
    IN vEmailUsuario VARCHAR(150),
    IN vSenhaUsuario VARCHAR(100),
    IN vNumeroEndereco CHAR(6),
    IN vComplementoEndereco VARCHAR(50),
    IN vCep CHAR(8)
)
BEGIN
	INSERT INTO tbUsuario(CPFUsuario, NomeUsuario, DataNascimento, TelefoneUsuario, EmailUsuario, SenhaUsuario, NumeroEndereco, ComplementoEndereco, Cep) 
    VALUES(vCPFUsuario, vNomeUsuario, (STR_TO_DATE(vDataNascimento, '%d/%m/%Y')), vTelefoneUsuario, vEmailUsuario, vSenhaUsuario, vNumeroEndereco, vComplementoEndereco, vCep);
    
    SET vIdUsuario = LAST_INSERT_ID();
END$$

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
SELECT u.IdUsuario AS Codigo, u.CPFUsuario, u.NomeUsuario, u.TelefoneUsuario, u.EmailUsuario, u.SenhaUsuario, u.Cep, n.IdNivel, n.NomeNivel 
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
    IN vLogoMarca VARCHAR(255),
    IN vDescricaoMarca VARCHAR(150)
)
BEGIN
	INSERT INTO tbMarca(NomeMarca, LogoMarca, DescricaoMarca) VALUES (vNomeMarca, vLogoMarca, vDescricaoMarca);
    
    SET vIdMarca = LAST_INSERT_ID();
END$$

SELECT * FROM tbMarca;

-- procedure para cadastro das categorias
-- drop procedure sp_CadastroCategorias

DELIMITER $$
CREATE PROCEDURE sp_CadastroCategoria(
	OUT vIdCategoria INT,
    IN vNomeCategoria VARCHAR(50),
    IN vDescricaoCategoria VARCHAR(150)
)
BEGIN
	INSERT INTO tbCategoria(NomeCategoria, DescricaoCategoria) VALUES (vNomeCategoria, vDescricaoCategoria);
    
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
SELECT p.IdPedido, p.DataPedido, p.ValorTotal, u.NomeUsuario AS Usuario, s.IdStatus, s.NomeStatus FROM tbPedido p INNER JOIN tbUsuario u ON p.IdUsuario = u.IdUsuario INNER JOIN tbStatusPedido s ON p.IdStatus = s.IdStatus;

SELECT * FROM vwPedido;

DELIMITER $$
CREATE PROCEDURE sp_AdicionarItemPedido(
	IN vIdPedido INT,
    IN vIdProduto INT,
    IN vQuantidade INT
)
BEGIN
	DECLARE vPreco DECIMAL(10,2);
    DECLARE vSubTotal DECIMAL(10,2);
    DECLARE vEstoque INT;
    
    SELECT QuantidadeEstoque INTO vEstoque FROM tbProduto WHERE IdProduto = vIdProduto;
    
    IF vEstoque < vQuantidade THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Produto fora de estoque.';
	END IF;
    
    SELECT PrecoUnitario INTO vPreco FROM tbProduto WHERE IdProduto = vIdProduto;
    SET vSubTotal = vPreco * vQuantidade;
    
    INSERT INTO tbItemPedido(IdPedido, IdProduto, QuantidadeProduto, PrecoUnitario, SubTotal) VALUES (vIdPedido, vIdProduto, vQuantidade, vPreco, vSubTotal);
END $$

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

DELIMITER $$
CREATE PROCEDURE sp_CadastrarCartao(
	OUT vIdCartao INT,
    IN vIdUsuario INT,
    IN vBandeira VARCHAR(20),
    IN vUltimosDigitos CHAR(4),
    IN vNomeTitular VARCHAR(100),
    IN vValidadeMes CHAR(7),
    IN vTokenCartao VARCHAR(255)
)
BEGIN
	INSERT INTO tbCartao(IdUsuario, Bandeira, UltimosDigitos, NomeTitular, ValidadeMes, TokenCartao, DataCadastro)
    VALUES(vIdUsuario, vBandeira, vUltimosDigitos, vNomeTitular, vValidadeMes, vTokenCartao, NOW());
    
    SET vIdCartao = LAST_INSERT_ID();
END $$

DELIMITER $$
CREATE PROCEDURE sp_GerarPagamentoCartao(
	OUT vIdPagamento INT,
    IN vIdPedido INT,
    IN vIdCartao INT,
    IN vValorPagamento DECIMAL(10,2)
)
BEGIN
	DECLARE vIdUsuarioPedido INT;
    DECLARE vIdUsuarioCartao INT;
    DECLARE vCodigoTransacao VARCHAR(100);
    
	SET vCodigoTransacao = CONCAT('TX', FLOOR(RAND() * 1000000));

    SELECT IdUsuario INTO vIdUsuarioPedido FROM tbPedido WHERE IdPedido = vIdPedido;
    SELECT IdUsuario INTO vIdUsuarioCartao FROM tbCartao WHERE IdCartao = vIdCartao;
    
    INSERT INTO tbPagamento(IdPedido, MetodoPagamento, ValorPagamento, IdCartao, StatusPagamento, CodigoTransacao, DataCriacao) VALUES(vIdPedido, 'Cartão', vValorPagamento, vIdCartao, 'Pago', vCodigoTransacao, NOW());
    
    SET vIdPagamento = LAST_INSERT_ID();
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

DELIMITER $$
CREATE TRIGGER trg_AtualizarEstoque -- INSERT
AFTER INSERT ON tbItemPedido
FOR EACH ROW
BEGIN
	UPDATE tbProduto SET QuantidadeEstoque = QuantidadeEstoque - NEW.QuantidadeProduto WHERE IdProduto = NEW.IdProduto;
END $$

DELIMITER $$
CREATE TRIGGER trg_AtualizarValorPedido
AFTER INSERT ON tbItemPedido
FOR EACH ROW
BEGIN
	UPDATE tbPedido SET ValorTotal = (SELECT SUM(SubTotal) FROM tbItemPedido WHERE IdPedido = NEW.IdPedido) WHERE IdPedido = NEW.IdPedido;
END $$

DELIMITER $$
CREATE TRIGGER trg_AtualizarValorCarrinho
AFTER INSERT ON tbItemCarrinho
FOR EACH ROW
BEGIN
	UPDATE tbCarrinho SET ValorTotal = (SELECT COALESCE(SUM(SubTotal), 0) FROM tbItemCarrinho WHERE IdCarrinho = NEW.IdCarrinho) WHERE IdCarrinho = NEW.IdCarrinho;
END $$

DELIMITER $$
CREATE TRIGGER trg_ConfirmarPagamento
AFTER INSERT ON tbPagamento
FOR EACH ROW
BEGIN
	IF NEW.StatusPagamento = 'Pago' THEN 
		UPDATE tbPedido SET IdStatus = 2 WHERE IdPedido = NEW.IdPedido;
    ELSEIF NEW.StatusPagamento = 'Cancelado' THEN
		UPDATE tbPedido SET IdStatus = 5 WHERE IdPedido = NEW.IdPedido;
	END IF;

END $$    

DELIMITER $$
CREATE TRIGGER trg_GerarNotaFiscal
AFTER INSERT ON tbPedido
FOR EACH ROW
BEGIN
	INSERT INTO tbNotaFiscal(ValorTotal, DataEmissao, NumeroSerie, IdPedido) VALUES(NEW.ValorTotal, CURRENT_DATE(), FLOOR(RAND() * 1000000), NEW.IdPedido);
END $$   

-- CALLS

-- CALLS na procedure CadastroEstado

CALL sp_CadastroEstado(@UF1, 'SP');
CALL sp_CadastroEstado(@UF2, 'RJ');
CALL sp_CadastroEstado(@UF3, 'MG');
CALL sp_CadastroEstado(@UF4, 'RS');
CALL sp_CadastroEstado(@UF5, 'PR');
SELECT * FROM tbEstado;

-- CALLS na procedure CadastroCidade

CALL sp_CadastroCidade(@Cidade1, 'São Paulo', @UF1);
CALL sp_CadastroCidade(@Cidade2, 'Rio de Janeiro', @UF2);
CALL sp_CadastroCidade(@Cidade3, 'Belo Horizonte', @UF3);
CALL sp_CadastroCidade(@Cidade4, 'Porto Alegre', @UF4);
CALL sp_CadastroCidade(@Cidade5, 'Curitiba', @UF5);
SELECT * FROM tbCidade;

-- CALLS na procedure CadastroBairro

CALL sp_CadastroBairro(@Bairro1, 'Jardins', @Cidade1);
CALL sp_CadastroBairro(@Bairro2, 'Ipanema', @Cidade2);
CALL sp_CadastroBairro(@Bairro3, 'Savassi', @Cidade3);
CALL sp_CadastroBairro(@Bairro4, 'Moinhos de Vento', @Cidade4);
CALL sp_CadastroBairro(@Bairro5, 'Consolação', @Cidade1);
CALL sp_CadastroBairro(@Bairro6, 'Copacabana', @Cidade2);
CALL sp_CadastroBairro(@Bairro7, 'Centro', @Cidade3);
CALL sp_CadastroBairro(@Bairro8, 'Floresta', @Cidade4);
CALL sp_CadastroBairro(@Bairro9, 'Rebouças', @Cidade5);
CALL sp_CadastroBairro(@Bairro10, 'Batel', @Cidade5);
SELECT * FROM tbBairro;

-- CALLS na procedure CadastroEndereco

CALL sp_CadastroEndereco('Rua das Palmeiras', '16203127', 'SP', 'São Paulo', 'Jardins');
CALL sp_CadastroEndereco('Av. Vieira Souto', '22420004', 'RJ', 'Rio de Janeiro', 'Ipanema');
CALL sp_CadastroEndereco('Av. Afonso Pena', '34128910', 'MG', 'Belo Horizonte', 'Savassi');
CALL sp_CadastroEndereco('Rua Padre Chagas', '90425590', 'RS', 'Porto Alegre', 'Moinhos de Vento');
CALL sp_CadastroEndereco('Rua Joaquim Nabuco', '89720310', 'PR', 'Curitiba', 'Batel');
CALL sp_CadastroEndereco('Rua Augusta', '01305000', 'SP', 'São Paulo', 'Consolação');
CALL sp_CadastroEndereco('Avenida Atlântica', '22021000', 'RJ', 'Rio de Janeiro', 'Copacabana');
CALL sp_CadastroEndereco('Avenida Afonso Pena', '30130001', 'MG', 'Belo Horizonte', 'Centro');
CALL sp_CadastroEndereco('Rua Gonçalo de Carvalho', '90570020', 'RS', 'Porto Alegre', 'Floresta');
CALL sp_CadastroEndereco('Rua XV de Novembro', '80010000', 'PR', 'Curitiba', 'Centro');
SELECT * FROM vwEndereco;

-- CALLS na procedure CadastroUsuario

CALL sp_CadastroUsuario(@User1, '15492367885', 'Lucas Ferreira', '12/04/1990', '(11)98765-0001', 'lucas.ferreira@mail.com', '12345678', '12', 'Apto 101', '16203127'); -- Jardins
CALL sp_CadastroUsuario(@User2, '97513286570', 'Mariana Alves', '05/09/1985', '(21)98888-0002', 'mariana.alves@mail.com', 'mariana123', '200', NULL, '22420004'); -- Ipanema
CALL sp_CadastroUsuario(@User3, '48393038759', 'Rafael Costa', '30/11/1992', '(31)97777-0003', 'rafael.costa@mail.com', 'rafinhaCosta', '5', NULL, '34128910'); -- Savassi
CALL sp_CadastroUsuario(@User4, '28174197079', 'Bianca Rocha', '18/07/1995', '(51)96666-0004', 'bianca.rocha@mail.com', '56123', '88', NULL, '90425590'); -- Moinhos de Vento
CALL sp_CadastroUsuario(@User5, '19430170007', 'Leonardo Pires', '02/02/1988', '(41)95555-0005', 'leo.pires@mail.com', 'adolfo', '10', 'Bloco B', '16203127'); -- Batel
SELECT * FROM tbUsuario;

-- CALLS na procedure NivelUsuario

CALL sp_NivelUsuario(@User1, 1);
CALL sp_NivelUsuario(@User2, 2);
CALL sp_NivelUsuario(@User3, 2);
CALL sp_NivelUsuario(@User4, 3);
CALL sp_NivelUsuario(@User5, 3);
SELECT * FROM vwUsu;

-- CALLS na procedure CadastroFornecedor

CALL sp_CadastroFornecedor(@For1, 'AutoParts Distribuição', '56103473000179', '(11)91234-0001', 'contato@autoparts.com', '01305000'); -- Consolação
CALL sp_CadastroFornecedor(@For2, 'Colecionáveis BR', '57548424000102', '(21)92345-0002', 'vendas@colecionaveis.com', '22021000'); -- Copacabana
CALL sp_CadastroFornecedor(@For3, 'MiniWorld Import', '71669202000179', '(31)93456-0003', 'import@miniworld.com', '30130001'); -- Centro
CALL sp_CadastroFornecedor(@For4, 'ScaleModels SA', '96121841000126', '(51)94567-0004', 'sac@scalemodels.com', '90570020'); -- Floresta
CALL sp_CadastroFornecedor(@For5, 'PremiumDiecast', '62689228000198', '(41)95678-0005', 'suporte@premiumdiecast.com', '80010000'); --  Centro
SELECT * FROM tbFornecedor;

-- CALLS na procedure CadastroMarca

CALL sp_CadastroMarca(@IdMarca1, 'Mercedes-Benz', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/567px-Mercedes-Logo.svg.png?20230111203159', 'Marca alemã tradicional, conhecida por luxo, conforto e tecnologia avançada. Famosa por sedãs executivos e SUVs premium.');
CALL sp_CadastroMarca(@IdMarca2, 'Porsche', 'https://upload.wikimedia.org/wikipedia/de/thumb/7/70/Porsche_Logo.svg/500px-Porsche_Logo.svg.png?20250407095904', 'Especialista alemã em esportivos de alto desempenho. Ícone pela precisão, engenharia e pelo clássico 911.');
CALL sp_CadastroMarca(@IdMarca3, 'BMW', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/BMW.svg/1024px-BMW.svg.png',  'Marca alemã focada em performance e dirigibilidade. Conhecida pelo slogan “prazer em dirigir” e por carros esportivos e premium.');
CALL sp_CadastroMarca(@IdMarca4, 'Audi', 'https://toppng.com/uploads/preview/audi-car-logo-11530962094iugeww1llh.png', 'Mistura tecnologia, design moderno e tração quattro. Famosa por interiores refinados e pela identidade visual com luzes marcantes.');
CALL sp_CadastroMarca(@IdMarca5, 'Lamborghini', 'https://e7.pngegg.com/pngimages/259/599/png-clipart-lamborghini-logo-lamborghini-sports-car-audi-logo-lamborghini-emblem-car-thumbnail.png', 'Marca italiana de supercarros agressivos e de alta performance. Conhecida pelo design extravagante e motores V10/V12.');
CALL sp_CadastroMarca(@IdMarca6, 'Maserati', 'https://logosmarcas.net/wp-content/uploads/2021/04/Maserati-Logo.png', 'Italiana de luxo esportivo, combinando elegância e desempenho. Se destaca pelo estilo sofisticado e som característico do motor.');
SELECT * FROM tbMarca;

-- CALLS na procedure CadastroCategoria

CALL sp_CadastroCategoria(@IdCat1, 'Edição limitada', 'Modelos produzidos em quantidade restrita, numerados ou exclusivos. Muito valorizados por colecionadores devido à raridade.');
CALL sp_CadastroCategoria(@IdCat2, 'Pré-montado', 'Miniaturas prontas para uso, já montadas de fábrica. Perfeitas para colecionadores que querem apenas expor ou colecionar sem montagem.');
CALL sp_CadastroCategoria(@IdCat3, 'Montável', 'Miniaturas que vêm em peças para o cliente montar. Ideais para quem gosta da experiência de construção e personalização desde o início.');
CALL sp_CadastroCategoria(@IdCat4, 'Personalizáveis', 'Miniaturas que permitem alterações de cores, peças, rodas ou detalhes especiais. Ideais para quem deseja criar um modelo único.');
SELECT * FROM tbCategoria;

-- CALLS na procedure CadastroProduto

CALL sp_CadastroProduto(
    @Prod1, @For1,
    'Miniatura Lamborghini Revuelto Hybrid', 439.90, '1:18', 400.00,
    'Metal', 'Edição limitada', 1, 39, 1,
    'Miniatura de Lamborghini Revuelto Hybrid, ano 2023, da série Special Edition na escala 1:18. Feito em metal.', @IdCat1, @IdMarca1
);

CALL sp_CadastroProduto(
    @Prod2, @For1,
    'Miniatura Lamborghini Countach', 349.90, '1:64', 100.00,
    'Plástico', 'Pré-Montado', 1, 42, 1,
    'O Lamborghini Countach foi um automóvel superesportivo produzido pela Lamborghini, na Itália. O primeiro protótipo surgiu em 1971, e aprodução durou até 1990. Feito em Plástico',
    @IdCat1, @IdMarca1
);

CALL sp_CadastroProduto(
    @Prod1, @For1,
    'Miniatura Lamborghini Countach', 349.90, '1:64', 100.00,
    'Plástico', 'Pré-Montado', 1, 42, 1,
    'O Lamborghini Countach foi um automóvel superesportivo produzido pela Lamborghini, na Itália. O primeiro protótipo surgiu em 1971, e aprodução durou até 1990. Feito em Plástico',
    @IdCat1, @IdMarca1
);

SELECT * FROM vwProduto;

-- CALLS na procedure CadastroImagemProduto

CALL sp_CadastroImagemProduto(@Img1, @Prod1, 'https://cdn.awsli.com.br/2500x2500/2571/2571273/produto/232947404/img_9814-0dv03gq0ud.JPG');
CALL sp_CadastroImagemProduto(@Img2, @Prod2, '/assets/img/miniPorscheCoupe.png');
CALL sp_CadastroImagemProduto(@Img3, @Prod3, '/assets/img/miniBmwM6.png');
CALL sp_CadastroImagemProduto(@Img4, @Prod4, '/assets/img/miniAudiMadeira.png');
CALL sp_CadastroImagemProduto(@Img5, @Prod5, '/assets/img/miniLamboHybrid.png');
SELECT * FROM tbImagemProduto;

-- CALLS na procedure CadastroCarrinho

CALL sp_CadastroCarrinho(@Carrinho1, 1);
CALL sp_CadastroCarrinho(@Carrinho2, 2);
CALL sp_CadastroCarrinho(@Carrinho3, 3);
CALL sp_CadastroCarrinho(@Carrinho4, 4);
CALL sp_CadastroCarrinho(@Carrinho5, 5);

-- CALLS na procedure AdicionarItemCarrinho

CALL sp_AdicionarItemCarrinho(1, @Prod1, 1);
CALL sp_AdicionarItemCarrinho(2, @Prod2, 2);
CALL sp_AdicionarItemCarrinho(3, @Prod3, 1);
CALL sp_AdicionarItemCarrinho(4, @Prod4, 1);
CALL sp_AdicionarItemCarrinho(5, @Prod5, 3);
SELECT * FROM tbItemCarrinho;   

-- CALLS na procedure CriarPedido

CALL sp_CriarPedido(@Pedido1, @User1, 1);
CALL sp_CriarPedido(@Pedido2, @User2, 1);
CALL sp_CriarPedido(@Pedido3, @User3, 1);
CALL sp_CriarPedido(@Pedido4, @User4, 1);
CALL sp_CriarPedido(@Pedido5, @User5, 1);
SELECT * FROM vwPedido;

-- CALLS na procedure AdicionarItemPedido

CALL sp_AdicionarItemPedido(@Pedido1, @Prod1, 1);
CALL sp_AdicionarItemPedido(@Pedido2, @Prod2, 2);
CALL sp_AdicionarItemPedido(@Pedido3, @Prod3, 1);
CALL sp_AdicionarItemPedido(@Pedido4, @Prod4, 1);
CALL sp_AdicionarItemPedido(@Pedido5, @Prod5, 2);
SELECT * FROM tbItemPedido;

-- CALLS na procedure CadastrarCartao

CALL sp_CadastrarCartao(@IdCarrinho1, @User1, 'Visa', '1234', 'Lucas Ferreira', '12/2030', '166');
CALL sp_CadastrarCartao(@IdCarrinho2, @User2, 'MasterCard', '2222', 'Mariana Alves', '11/2029', 'TOKEN_MARIANA_2');
CALL sp_CadastrarCartao(@IdCarrinho3, @User3, 'Visa', '3553', 'Rafael Costa', '10/2031', 'TOKEN_RAFAEL_3');
CALL sp_CadastrarCartao(@IdCarrinho4, @User4, 'Elo', '4454', 'Bianca Rocha', '09/2028', 'TOKEN_BIANCA_4');
CALL sp_CadastrarCartao(@IdCarrinho5, @User5, 'Amex', '1565', 'Leonardo Píres', '08/2032', 'TOKEN_GUSTAVO_5');
SELECT * FROM tbCartao;

-- CALLS na procedure GerarPagamentoCartao

CALL sp_GerarPagamentoCartao(@Pay1, @Pedido1, @IdCarrinho1, 549.90);
CALL sp_GerarPagamentoCartao(@Pay2, @Pedido2, @IdCarrinho2, 579.80);
CALL sp_GerarPagamentoCartao(@Pay3, @Pedido3, @IdCarrinho3, 289.90);
CALL sp_GerarPagamentoCartao(@Pay4, @Pedido4, @IdCarrinho4, 1149.90);
CALL sp_GerarPagamentoCartao(@Pay5, @Pedido5, @IdCarrinho5, 879.80);
SELECT * FROM tbPagamento;

-- CALLS na procedure RegistrarPagamento

CALL sp_RegistrarPagamento(@Reg1, @Pedido1, 'PIX', 549.90, 'Pago', 'PIX-2025001');
CALL sp_RegistrarPagamento(@Reg2, @Pedido2, 'Boleto', 579.80, 'Pago', 'BOLETO-2025002');
CALL sp_RegistrarPagamento(@Reg3, @Pedido3, 'PIX', 289.90, 'Pago', 'PIX-2025003');
CALL sp_RegistrarPagamento(@Reg4, @Pedido4, 'Boleto', 1149.90, 'Pago', 'BOLETO-2025004');
CALL sp_RegistrarPagamento(@Reg5, @Pedido5, 'PIX', 879.80, 'Pago', 'PIX-2025005');
SELECT * FROM tbPagamento;