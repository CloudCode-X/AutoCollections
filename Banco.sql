create database dbAutoCollections;

/*drop database dbAutoCollections;*/

use dbAutoCollections;

create table tbEndereco(
CEP char(8) primary key, -- sem traço
Estado char(2) not null,
Cidade varchar(50) not null,
Bairro varchar(50) not null,
Rua varchar(70) not null,
Numero int not null,
Complemento varchar(50)
);

create table tbCliente(
Id_Cliente int primary key auto_increment,
CPF_Cliente char(11) not null,
Nome_Cliente varchar(150) not null,
DataNascimento_Cliente date not null,
Telefone_Cliente varchar(15) not null,
Email_Cliente varchar(150) not null,
CEP_Cliente char(8) not null,
Constraint fk_cliente_endereco foreign key (CEP_Cliente) references tbEndereco (CEP)
);

create table tbFornecedor(
Id_Fornecedor int primary key auto_increment,
Nome_Fornecedor varchar(70) not null,
CNPJ char(14) not null,
Telefone_Fornecedor varchar(15) not null,
Email_Fornecedor varchar(100) not null,
CEP_Fornecedor char(8) not null,
Constraint fk_fornecedor_endereco foreign key (CEP_Fornecedor) references tbEndereco (CEP)
);

create table tbFuncionario(
Id_Funcionario int primary key auto_increment,
Nome_Funcionario varchar(70) not null,
CPF_Funcionario char(11) not null,
Telefone_Funcionario varchar(15) not null,
Email_Funcionario varchar(150) not null,
Cargo varchar(50) not null,
CEP_Funcionario char(8) not null,
DataAdmissao date not null,
Constraint fk_funcionario_endereco foreign key (CEP_Funcionario) references tbEndereco (CEP)
);

create table tbProduto(
Id_Produto int primary key auto_increment,
Id_Fornecedor int not null,
Nome_Produto varchar(70) not null,
PrecoUnitario decimal(10,2) not null,
Escala varchar(10) not null, -- ex:"1:18"
Peso decimal(10,2) not null, -- em gramas
Material varchar(30) not null,
TipoProduto varchar(30) not null,
QuantidadePecas int not null,
Marca varchar(30) not null,
Categoria varchar(30) not null,
QuantidadeEstoque int not null,
QuantidadeMinima int not null,
Descricao varchar(200) not null,
Constraint fk_produto_fornecedor foreign key (Id_Fornecedor) references tbFornecedor (Id_Fornecedor)
);

create table tbPedido(
Id_Pedido int primary key auto_increment,
DataPedido date not null,
ValorTotal decimal(10,2) not null,
Id_Cliente int not null,
PedidoStatus varchar(50) not null,
Constraint fk_pedido_cliente foreign key (Id_Cliente) references tbCliente (Id_Cliente)
);

create table tbItemPedido(
Id_Pedido int not null,
Id_Produto int not null,
QuantidadeProduto int not null,
PrecoUnitario decimal(10,2) not null,
SubTotal decimal(10,2) not null,
primary key (Id_Pedido, Id_Produto),
Constraint fk_itempedido_pedido foreign key (Id_Pedido) references tbPedido (Id_Pedido),
Constraint fk_itempedido_produto foreign key (Id_Produto) references tbProduto (Id_Produto)
);

create table tbNotaFiscal(
Id_NF int primary key auto_increment,
ValorTotal decimal(10,2) not null,
DataEmissao date not null,
NumeroSerie int not null,
Id_Pedido int not null,
Constraint fk_notafiscal_pedido foreign key (Id_Pedido) references tbPedido (Id_Pedido)
);

create table tbCarrinho(
Id_Carrinho int primary key auto_increment,
Id_Cliente int not null,
ValorTotal decimal(10,2) not null,
Constraint fk_carrinho_cliente foreign key (Id_Cliente) references tbCliente (Id_Cliente)
);

create table tbItemCarrinho(
Id_Carrinho int not null,
Id_Produto int not null,
QuantidadeProduto int not null,
PrecoUnitario decimal(10,2) not null,
SubTotal decimal(10,2) not null,
primary key (Id_Carrinho, Id_Produto),
Constraint fk_itemcarrinho_carrinho foreign key (Id_Carrinho) references tbCarrinho (Id_Carrinho),
Constraint fk_itemcarrinho_produto foreign key (Id_Produto) references tbProduto (Id_Produto)
);

create table tbPagamento(
Id_Pagamento int primary key auto_increment,
Id_Pedido int not null,
MetodoPagamento varchar(30) not null,
ValorPagamento decimal(10,2) not null,
StatusPagamento varchar(20) not null,
CodigoTransacao varchar(100) not null,
DataCriacao datetime default current_timestamp,
DataConfirmacao datetime null,
Constraint fk_pagamento_pedido foreign key (Id_Pedido) references tbPedido (Id_Pedido)
);

create table tbCartao(
Id_Cartao int primary key auto_increment,
Id_Cliente int not null,
Bandeira varchar(20) not null,
UltimosDigitos char(4) not null,
Nome_Titular varchar(100) not null,
Validade char(5) not null, -- ex:"05/28"
DataCadastro datetime default current_timestamp,
DataAtualizacao datetime default current_timestamp on update current_timestamp,
constraint fk_cartao_cliente foreign key (Id_Cliente) references tbCliente (Id_Cliente)
);

create table tbEntrega(
Id_Entrega int primary key auto_increment,
Id_Pedido int not null,
CodigoRastreamento varchar(50),
DataEnvio date,
DataEntrega date,
StatusEntrega varchar(30) not null,
constraint fk_entrega_pedido foreign key (Id_Pedido) references tbPedido (Id_Pedido)
);