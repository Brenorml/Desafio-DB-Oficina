-- criação do banco de dados para Oficina
-- drop database oficina;
-- show databases;
create database oficina;
use oficina;

-- Tabelas entidades --

-- criar tabela cliente
create table cliente(
	idCliente int auto_increment primary key,    
	nome varchar(10), 
	inicial_nome_meio char(3),
    sobrenome varchar(20),
    CPF char(11) not null unique,
    endereço varchar(255),
    contato char(11) not null,
    veiculo enum('moto', 'carro'),
    matriculaVeiculo varchar(6) not null unique,
    constraint unique_cpf_cliente unique(CPF),
    constraint unique_matricula_veiculo unique(matriculaVeiculo)
);

-- criar tabela Mecânico
create table Mecanico(
	idMecanico int auto_increment primary key,
    CPF char(11) not null unique,
    localidade varchar(45),
    especialidade enum('geral', 'eletrica', 'funilaria', 'pintura', 'retifica') default 'geral',    
    contato char(11) not null,
    veiculoCliente int,
    constraint unique_cpf_mecanico unique (CPF),
    constraint fk_veiculo_avalicao foreign key(veiculoCliente) references cliente(idCliente)
);

-- criar tabela Ordem de Serviço
create table ordemServiço(
	idOS int auto_increment primary key,
    clienteOS int,
    descriçãoPedido varchar(255) not null,
    valor float not null,
    dataEmissao date not null,
    statusOS enum('aguardando', 'autorizado', 'processando', 'concluido') not null,
    dataConclusao date not null,
    constraint fk_associação_OS foreign key(clienteOS) references cliente(idCliente)
);

-- criar tabela pagamento
create table pagamento(
	idPagamento int auto_increment primary key,
    valor float not null,
    tipoPagamento enum('boleto', 'crédito', 'débito', 'dinheiro') not null,
    parcelarCompra enum('3X', '6X', '12x') default '3X',    
    clientePG int,
    constraint fk_valor_cliente foreign key(clientePG) references ordemServiço(idOS)
    );


-- criar tabela peça
create table peça(
	idPeça int auto_increment primary key, 
	descrição varchar(100), 
    valorUnitario float,
    quantidade int,
    disponibilidade boolean default true    
);

-- criar tabela serviços
create table serviços(
	idServiço int auto_increment primary key,
    tipoServiço enum('geral', 'eletrica', 'funilaria', 'pintura', 'retifica')not null,
    serviçoPrevisto longtext not null,
    valorMO float,
    tempoPrevisto float
);

-- Tabelas relacionamentos

-- criar tabela preenchimento_OS
create table cadastroOS(
	idOSmecanico int,
    idOSordemServiço int,
    listaServiço varchar(225) ,
    listaPeça varchar(225),
    primary key(idOSmecanico, idOSordemServiço),
    constraint fk_cadastroOS_mecanico foreign key(idOSmecanico) references mecanico(idMecanico),
    constraint fk_cadastroOS_OS foreign key(idOSordemServiço) references ordemServiço(idOS)
);
  
-- criar tabela pagamento_OS
create table pagamentoOS(
	idPGordemServiço int,
    idPGpagemento int,    
    primary key(idPGordemServiço, idPGpagemento),
    constraint fk_pagamentoOS_OS foreign key(idPGordemServiço) references ordemServiço(idOS),
    constraint fk_pagamentoOS_pagamento foreign key(idPGpagemento) references pagamento(idPagamento)	
);

-- criar tabela peças_necessárias
create table peçaOS(
	idPÇordemServiço int,
    idPÇpeça int,
    quantidadePeçaOS int,
    primary key(idPÇordemServiço, idPÇpeça),
    constraint fk_peçaOS_OS foreign key(idPÇordemServiço) references ordemServiço(idOS),
    constraint fk_peçaOS_peça foreign key(idPÇpeça) references peça(idPeça)    
);

-- criar tabela serviços_necessários
create table serviçoOS(
	idSVordemServiço int,
    idSVserviços int,
    quantidadeServiçosOS int,
    primary key(idSVordemServiço, idSVserviços),
    constraint fk_serviçoOS_OS foreign key(idSVordemServiço) references ordemServiço(idOS),
    constraint fk_serviçoOS_serviços foreign key(idSVserviços) references serviços(idServiço)    
);

-- use information_schema;
-- select * from referential_constraints where constraint_schema = 'ecommerce';





