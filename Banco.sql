create database AutoCollections;

use AutoCollections;

-- TABELA ENDEREÇO

CREATE TABLE tbEndereco (
    CEP CHAR(8) PRIMARY KEY, -- sem traço
    Estado CHAR(2) NOT NULL,
    Cidade VARCHAR(50) NOT NULL,
    Bairro VARCHAR(50) NOT NULL,
    Rua VARCHAR(70) NOT NULL,
    Numero INT NOT NULL,
    Complemento VARCHAR(50)
);

-- TABELA CLIENTE

CREATE TABLE tbCliente (
    IdCliente INT PRIMARY KEY AUTO_INCREMENT,
    CPF CHAR(11) NOT NULL,
    NomeCliente VARCHAR(150) NOT NULL,
    DataNascimentoCli DATE NOT NULL,
    TelefoneCliente VARCHAR(15) NOT NULL,
    EmailCliente VARCHAR(150) NOT NULL UNIQUE,
    CEP CHAR(8) NOT NULL,
    Senha VARCHAR(100) NOT NULL,
    CONSTRAINT fk_cliente_endereco FOREIGN KEY (CEP) REFERENCES tbEndereco(CEP)
);

-- TABELA FORNECEDOR

CREATE TABLE tbFornecedor (
    IdFornecedor INT PRIMARY KEY AUTO_INCREMENT,
    NomeFornecedor VARCHAR(150) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    TelefoneFornecedor VARCHAR(15) NOT NULL,
    EmailFornecedor VARCHAR(100) NOT NULL,
    CEP CHAR(8) NOT NULL,
    CONSTRAINT fk_fornecedor_endereco FOREIGN KEY (CEP) REFERENCES tbEndereco(CEP)
);

-- TABELA FUNCIONÁRIO

CREATE TABLE tbFuncionario (
    IdFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    NomeFuncionario VARCHAR(70) NOT NULL,
    CPF CHAR(11) NOT NULL,
    TelefoneFuncionario VARCHAR(15) NOT NULL,
    EmailFuncionario VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    CEP CHAR(8) NOT NULL,
    DataAdmissao DATE NOT NULL,
    CONSTRAINT fk_funcionario_endereco FOREIGN KEY (CEP) REFERENCES tbEndereco(CEP)
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
    Marca VARCHAR(30) NOT NULL,
    Categoria VARCHAR(30) NOT NULL,
    QuantidadeEstoque INT NOT NULL,
    QuantidadeMinima INT NOT NULL,
    Descricao VARCHAR(200) NOT NULL,
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (IdFornecedor) REFERENCES tbFornecedor(IdFornecedor)
);

-- TABELA PEDIDO

CREATE TABLE tbPedido (
    IdPedido INT PRIMARY KEY AUTO_INCREMENT,
    DataPedido DATE NOT NULL,
    ValorTotal DECIMAL(10,2) NOT NULL,
    IdCliente INT NOT NULL,
    PedidoStatus VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (IdCliente) REFERENCES tbCliente(IdCliente)
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
    IdCliente INT NOT NULL,
    ValorTotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_carrinho_cliente FOREIGN KEY (IdCliente) REFERENCES tbCliente(IdCliente)
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

-- TABELA CARTÃO

CREATE TABLE tbCartao (
    IdCartao INT PRIMARY KEY AUTO_INCREMENT,
    IdCliente INT NOT NULL,
    Bandeira VARCHAR(20) NOT NULL,
    UltimosDigitos CHAR(4) NOT NULL,
    NomeTitular VARCHAR(100) NOT NULL,
    ValidadeMes CHAR(7) NOT NULL,
    TokenCartao VARCHAR(255) NULL,
    Preferencial BOOLEAN DEFAULT FALSE,
    DataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_cartao_cliente FOREIGN KEY (IdCliente) REFERENCES tbCliente(IdCliente)
);

-- TABELA ENTREGA

CREATE TABLE tbEntrega (
    IdEntrega INT PRIMARY KEY AUTO_INCREMENT,
    IdPedido INT NOT NULL,
    Transportadora VARCHAR(100) NOT NULL,
    CodigoRastreamento VARCHAR(50),
    PrazoEstimado DATE,
    DataEnvio DATE,
    DataEntrega DATE,
    StatusEntrega VARCHAR(50) NOT NULL,
    FOREIGN KEY (IdPedido) REFERENCES tbPedido(IdPedido)
);

-- Procedures 

-- IN => Valor de entrada
-- OUT => Valor de saída
-- procedure para criar usuario
-- drop procedure sp_CadastroUsu
DELIMITER $$
CREATE PROCEDURE sp_CadastroUsu(
    IN vEmail VARCHAR(50),
    IN vNome VARCHAR(100),
    IN vSenha VARCHAR(100),
    IN vCPF VARCHAR(11),
    IN vEndereco VARCHAR(150),
    IN vTelefone VARCHAR(11),
    OUT vIdCli INT
)
BEGIN
	INSERT INTO tbUsuario (Email, Nome, Senha, CPF, Endereco, Telefone)
    VALUES (vEmail, vNome, vSenha, vCPF, vEndereco, vTelefone);

    SET vIdCli = LAST_INSERT_ID();
END $$
DELIMITER ;
-- call da procedure de cadastro:
CALL sp_CadastroUsu(
    'arthur@gmail.com',
    'Arthur dos Santos Reimberg',
    'art123',
    '12345678901',
    'Rua Algum Lugar, Número 42',
    '11945302356',
    @vIdCli
);

CALL sp_CadastroUsu(
    'lucas@gmail.com',
    'Lucas Hora',
    'luc123',
    '12345678912',
    'Rua Algum Lugar, Número 40',
    '11945302359',
    @vIdCli
);


-- procedure adicionar nivel de acesso
DELIMITER $$
CREATE PROCEDURE sp_AdicionarNivel(
	vUsuId INT,
    vNivelId INT
)
BEGIN
	INSERT INTO tbUsuNivel(IdUsuario, IdNivel)
    VALUES(vUsuId, vNivelId);
END$$

DELIMITER ;
CALL sp_AdicionarNivel(1, 2)

-- Procedure Cadastrar Produto
-- drop procedure sp_CadastrarProduto
DELIMITER $$
CREATE PROCEDURE sp_CadastrarProduto(
	vNomeProduto VARCHAR(100),
    vPreco DECIMAL(8,2),
    vDescricao varchar(2500),
    vMarca VARCHAR(100),
    vAvaliacao DECIMAL(2,1),
    vCategoria VARCHAR(100),
    vQtdEstoque INT
)
BEGIN
	DECLARE vIdProduto INT;
    
    -- Salva os valores do produto
	INSERT INTO tbProduto(NomeProduto, Descricao, Preco, Marca, Categoria,Avaliacao)
    VALUES(vNomeProduto, vDescricao, vPreco, vMarca, vCategoria,vAvaliacao);
    SET vIdProduto = LAST_INSERT_ID();

    -- Salva a quantidade em estoque
    INSERT INTO tbEstoque(IdProduto, QtdEstoque, Disponibilidade)
    VALUES(vIdProduto, vQtdEstoque, true);
    
END $$
DELIMITER ;
-- Produto 1 
CALL sp_CadastrarProduto(
	'Bateria Exemplo', 
    2000.99,
    'Bateria vendida pela loja y, 
    com as especificaçoes a seguir: xxxxxxxxxxxxxxxxxxx, xxxxxxxxxxxxxxx, xxxxxxxxxxxx' ,
    'Marca Exemplo', 
    4.5,
    'Percursão',
    20
);
-- Produto 2 
CALL sp_CadastrarProduto(
	'Guitarra Exemplo', 
    1500.00,
    'Guitarra vendida pela loja y, 
    com as especificaçoes a seguir: xxxxxxxxxxxxxxxxxxx, xxxxxxxxxxxxxxx, xxxxxxxxxxxx' ,
    'Marca Exemplo', 
    4.5,
    'Cordas',
    20
);



DELIMITER $$
CREATE PROCEDURE sp_AdicionarImagens( 
	vIdProduto INT,
    vImagemUrl VARCHAR(255)
)
BEGIN
    INSERT INTO tbImagens(IdProduto,UrlImagem)
    VALUES(vIdProduto,vImagemUrl);
END $$
DELIMITER ;
CALL sp_AdicionarImagens(1,'www.imagem.url.com.br3');


DELIMITER $$
CREATE PROCEDURE sp_AdministrarCarrinho(
    IN vIdUsuario INT,
    IN vIdProduto INT,
    IN vQtd INT
)
BEGIN
    DECLARE vIdCarrinho INT DEFAULT NULL;
    DECLARE vPrecoUnidadeCar DECIMAL(8,2);
    DECLARE vSubTotal DECIMAL(8,2);
    DECLARE vIdItemCarrinho INT DEFAULT NULL;

    -- Verifica se o carrinho do usuário já existe (ativo)
    SELECT IdCarrinho 
    INTO vIdCarrinho 
    FROM tbCarrinho 
    WHERE IdUsuario = vIdUsuario;

    -- Se o carrinho ainda não existir, cria um novo
    IF vIdCarrinho IS NULL THEN
        SELECT Preco INTO vPrecoUnidadeCar 
        FROM tbProduto 
        WHERE IdProduto = vIdProduto;

        SET vSubTotal = vPrecoUnidadeCar * vQtd;

        INSERT INTO tbCarrinho (IdUsuario, DataCriacao, Estado, ValorTotal)
        VALUES (vIdUsuario, CURDATE(), 1, vSubTotal);

        SET vIdCarrinho = LAST_INSERT_ID();

        INSERT INTO tbItemCarrinho (IdCarrinho, IdProduto, QtdItemCar, PrecoUnidadeCar, SubTotal)
        VALUES (vIdCarrinho, vIdProduto, vQtd, vPrecoUnidadeCar, vSubTotal);

    ELSE
        -- Carrinho já existe, verificar se o produto já foi adicionado
        SELECT IdItemCarrinho 
        INTO vIdItemCarrinho 
        FROM tbItemCarrinho 
        WHERE IdCarrinho = vIdCarrinho AND IdProduto = vIdProduto;

        IF vIdItemCarrinho IS NULL THEN
            -- Produto ainda não está no carrinho
            SELECT Preco INTO vPrecoUnidadeCar 
            FROM tbProduto 
            WHERE IdProduto = vIdProduto;

            SET vSubTotal = vPrecoUnidadeCar * vQtd;

            INSERT INTO tbItemCarrinho (IdCarrinho, IdProduto, QtdItemCar, PrecoUnidadeCar, SubTotal)
            VALUES (vIdCarrinho, vIdProduto, vQtd, vPrecoUnidadeCar, vSubTotal);
            -- Atualiza o total do carrinho com base na soma dos subtotais
			UPDATE tbCarrinho
			SET ValorTotal = ValorTotal + vSubTotal
			WHERE IdCarrinho = vIdCarrinho;
        END IF;
    END IF;
END $$
DELIMITER ;

select * from tbcarrinho;
SELECT * FROM TBITEMCARRINHO;
CALL sp_AdministrarCarrinho(1, 1, 20);



DELIMITER $$
CREATE PROCEDURE sp_GerarVenda(
    IN vIdUsuario INT, 
    IN vTipoPag VARCHAR(50),
    IN vIdCarrinho INT
)
BEGIN
	DECLARE vIdVenda INT;
    DECLARE vIdProduto INT;
    DECLARE vQtdItem INT;
    DECLARE vPreco DECIMAL(8,2);
	DECLARE vQtdTotal INT;
    DECLARE vValorTotal DECIMAL(8,2);
    DECLARE done INT DEFAULT 0;
    
    -- Cursor que percorre todos os itens do carrinho
    DECLARE curItens CURSOR FOR
    SELECT IdProduto, QtdItemCar, PrecoUnidadeCar
    FROM tbItemCarrinho
    WHERE IdCarrinho = vIdCarrinho;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1; 
    
   -- Encontrar o valor total do carrinho
   SELECT ValorTotal INTO vValorTotal FROM tbCarrinho WHERE IdCarrinho = vIdCarrinho AND Estado = 1;
   -- Encontrar quantidade total
   SELECT SUM(QtdItemCar) INTO vQtdTotal from tbItemCarrinho WHERE IdCarrinho = vIdCarrinho;
   -- cria a venda 
   INSERT INTO tbVenda(IdUsuario, TipoPag, QtdTotal, ValorTotal)
   VALUES(vIdUsuario, vTipoPag, vQtdTotal, vValorTotal);
   SET vIdVenda = LAST_INSERT_ID();
   
   -- Abrir o cursor/loop
   OPEN curItens;
	read_loop: LOOP
			FETCH curItens INTO vIdProduto, vQtdItem, vPreco;
			IF done THEN
				LEAVE read_loop;
			END IF;
			
		-- Insere item de venda
		INSERT INTO tbItemVenda(IdVenda, IdProduto, PrecoUni, Qtd)
		VALUES(vIdVenda, vIdProduto, vPreco, vQtdItem);
		
		-- Atualizar estoque do produto
		UPDATE tbEstoque
		SET QtdEstoque = QtdEstoque - vQtdItem, Disponibilidade = IF (QtdEstoque - vQtdItem <= 0, 0, 1)
		WHERE IdProduto = vIdProduto;
	END LOOP;
	
    CLOSE curItens;
    
    UPDATE tbCarrinho
    SET Estado = 0
    WHERE IdCarrinho = vIdCarrinho;
    
END $$
DELIMITER ;
CALL sp_GerarVenda(1,'Pix',1);

select * from tbVend