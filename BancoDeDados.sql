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


CALL sp_CadastroEstado(@vUFId, "SP");
CALL sp_CadastroEstado(@vUFId, "RJ");
CALL sp_CadastroEstado(@vUFId, "MG");
CALL sp_CadastroEstado(@vUFId, "RS");
CALL sp_CadastroEstado(@vUFId, "RN");
CALL sp_CadastroEstado(@vUFId, "CE");
CALL sp_CadastroEstado(@vUFId, "PE");
CALL sp_CadastroEstado(@vUFId, "BA");
CALL sp_CadastroEstado(@vUFId, "ES");
CALL sp_CadastroEstado(@vUFId, "PR");
SELECT * FROM tbEstado;
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

CALL sp_CadastroCidade(@vCidadeId, "São Paulo", 1);
CALL sp_CadastroCidade(@vCidadeId, "Rio de Janeiro", 2);
CALL sp_CadastroCidade(@vCidadeId, "Belo Horizonte", 3);
CALL sp_CadastroCidade(@vCidadeId, "Porto Alegre", 4);
CALL sp_CadastroCidade(@vCidadeId, "Natal", 5);
CALL sp_CadastroCidade(@vCidadeId, "Fortaleza", 6);
CALL sp_CadastroCidade(@vCidadeId, "Recife", 7);
CALL sp_CadastroCidade(@vCidadeId, "Salvador", 8);
CALL sp_CadastroCidade(@vCidadeId, "Vitória", 9);
CALL sp_CadastroCidade(@vCidadeId, "Curitiba", 10);

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

CALL sp_CadastroBairro(@vBairroId, "Pinheiros", 1);
CALL sp_CadastroBairro(@vBairroId, "Copacabana", 2);
CALL sp_CadastroBairro(@vBairroId, "Savassi", 3);
CALL sp_CadastroBairro(@vBairroId, "Moinhos de Vento", 4);
CALL sp_CadastroBairro(@vBairroId, "Ponta Negra", 5);
CALL sp_CadastroBairro(@vBairroId, "Meireles", 6);
CALL sp_CadastroBairro(@vBairroId, "Boa Viagem", 7);
CALL sp_CadastroBairro(@vBairroId, "Pelourinho", 8);
CALL sp_CadastroBairro(@vBairroId, "Jardim da Penha", 9);
CALL sp_CadastroBairro(@vBairroId, "Batel", 10);

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


CALL sp_CadastroEndereco("Rua dos Pinheiros", "05422001", "SP", "São Paulo", "Pinheiros");
CALL sp_CadastroEndereco("Avenida Atlântica","22021001","RJ","Rio de Janeiro","Copacabana");
CALL sp_CadastroEndereco("Praça Diogo de Vasconcelos","30112010","MG","Belo Horizonte","Savassi");
CALL sp_CadastroEndereco("Rua Padre Chagas","90570080","RS","Porto Alegre","Moinhos de Vento");
CALL sp_CadastroEndereco("Rua Aristides Porpino Filho","59090720","RN","Natal","Ponta Negra");
CALL sp_CadastroEndereco("Avenida Beira Mar","60165121","CE","Fortaleza","Meireles");
CALL sp_CadastroEndereco("Avenida Boa Viagem","51021000","PE","Recife","Boa Viagem");
CALL sp_CadastroEndereco("Largo do Pelourinho","40026280","BA","Salvador","Pelourinho");
CALL sp_CadastroEndereco("Avenida Fernando Ferrari","29075505","ES","Vitória","Jardim da Penha");
CALL sp_CadastroEndereco("Avenida do Batel","80420090","PR","Curitiba","Batel");

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
    
    SET vIdUsuario = LAST_INSERT_ID();
END$$

CALL sp_CadastroUsuario(@vIdUsuario, '12345678901', 'Mariana Ribeiro', '15/03/1998', '11987654321', 'mariana.ribeiro@gmail.com', 'senha123', '791', 'Apto 12B', '05422001');
CALL sp_CadastroUsuario(@vIdUsuario, '98765432100', 'Lucas Azevedo', '08/11/1995', '21999887766', 'lucas.azevedo@gmail.com', 'senha123', '1702', 'Bloco C', '22021001');
CALL sp_CadastroUsuario(@vIdUsuario, '32165498700', 'Bianca Martins', '22/07/2000', '31988776655', 'bianca.martins@gmail.com', 'senha123', '300', 'Sala 10', '30112010');
CALL sp_CadastroUsuario(@vIdUsuario, '15975346800', 'Carlos Menezes', '10/01/1990', '51998877665', 'carlos.menezes@gmail.com', 'senha123', '300', NULL, '90570080');
CALL sp_CadastroUsuario(@vIdUsuario, '25836914700', 'Juliana Barros', '05/09/2002', '84988776655', 'juliana.barros@gmail.com', 'senha123', '2199', 'Casa 02', '59090720');
CALL sp_CadastroUsuario(@vIdUsuario,'74185296300','Renato Albuquerque','19/04/1988','85999887755','renato.albuquerque@gmail.com','senha123','2500','Cobertura','60165121');
CALL sp_CadastroUsuario(@vIdUsuario,'85236974100','Paula Freitas','30/06/1997','81988776644','paula.freitas@gmail.com','senha123','4000','Apto 501','51021000');
CALL sp_CadastroUsuario(@vIdUsuario,'96325874100','Rafael Santos','12/12/1999','71988776611','rafael.santos@gmail.com','senha123','22',NULL,'40026280');
CALL sp_CadastroUsuario(@vIdUsuario,'45612378900','Larissa Gomes','17/02/2001','27999887766','larissa.gomes@gmail.com','senha123','514','Fundos','29075505');
CALL sp_CadastroUsuario(@vIdUsuario,'65498732100','Thiago Moraes','09/10/1994','41988776655','thiago.moraes@gmail.com','senha123','1230','Apto 34A','80420090');

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

CALL sp_NivelUsuario(1,1);
CALL sp_NivelUsuario(2,2);
CALL sp_NivelUsuario(3,2);
CALL sp_NivelUsuario(4,3);
CALL sp_NivelUsuario(5,3);
CALL sp_NivelUsuario(6,3);
CALL sp_NivelUsuario(7,3);
CALL sp_NivelUsuario(8,3);
CALL sp_NivelUsuario(9,3);
CALL sp_NivelUsuario(10,3);

SELECT * FROM vwUsu;