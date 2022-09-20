use oficina;
show tables;

-- persistindo entidades

-- persistindo tabela cliente
insert into cliente(nome, inicial_nome_meio, sobrenome, CPF, endereço, contato, veiculo, matriculaVeiculo)
	values('Breno', 'R', 'Lucena', 12345678900, 'Rua de cá, 6', 22222222222, 'carro', '11AA22'),
		  ('Melian', 'R', 'Tolkien', 12345678901, 'Rua de lá, 2 - Menegroth/Doriath', 33333333333, 'moto', '22AA33'),
		  ('Thingol', 'R', 'Tolkien', 12345678902, 'Rua de lá, 2 - Menegroth/Doriath', 44444444444, 'moto', '33AA44'),
          ('Luthien', null, 'Tinuviel', 12345678903, 'Rua do além, 1 - Menegroth/Doriath', 11111111111, 'carro', '44AA55'),
          ('Sidnei', 'D', 'Magalhaes', 12345678911, 'Rua de cá, 10', 999999999, 'carro', '99AA77');
select * from cliente;

-- persistindo tabela Mecânico
insert into mecanico(CPF, localidade, especialidade, contato, veiculoCliente)
	values(12345678904, 'Funilaria Bom Dia', 'funilaria', 32165498700, 1),
		  (12345678905, 'Mecanica Santo Antonio', 'geral', 32165498701, 2),
		  (12345678906, 'Mecanica Santo Antonio', 'eletrica', 32165498701, 3),
          (12345678907, 'Funilaria Bom Dia', 'pintura', 32165498700, 4),
          (12345678908, 'Mecanica Santo Antonio', 'retifica', 32165498701, 5);
select * from mecanico;

-- persistindo tabela Ordem de Serviço
insert into ordemServiço(clienteOS, descriçãoPedido, valor, dataEmissao, statusOS, dataConclusao) 
	values(2, 'troca de pneu dianteiro e traseiro', 600.00, 20/09/2022, 'autorizado', 20/09/2022),
		  (3, 'troca de manoplas', 150.00, 20/09/2022, 'concluido', 20/09/2022),
		  (5, 'troca da repimboca da parafuseta', 2000.00, 20/09/2022, 'processando', 23/09/2022);
select * from ordemServiço;

-- persistindo tabela pagamento
insert into pagamento(valor, tipoPagamento, parcelarCompra, clientePG) 
	values(600.00, 'boleto', null, 1),
		  (150.00, 'crédito', default, 2),
          (2000.00, 'débito', null, 3);
select * from pagamento;

-- persistindo tabela peça
insert into peça(descrição, valorUnitario, quantidade, disponibilidade) 
	values('manopla', 75.00, 30, true),
		  ('pneu moto', 300.00, 60, true),
          ('repimboca', 2000.00, 10, true),
          ('banco', 200.00, 0, false);
select * from peça;

-- persistindo tabela serviços
insert into serviços(tipoServiço, serviçoPrevisto, valorMO, tempoPrevisto) 
	values('geral', 'Retirada de pneu, desmontagem, inserção do novo pneu, teste', 200.00, 2.00),
		  ('geral', 'Retirada das manoplas, montagem das novas manoplas, teste', 100.00, 0.30),
          ('retifica', 'retirada do componente, desmontagem, inserção da peça, montagem, teste', 300.00, 4.00);
select * from serviços;

-- persistindo relacionamentos

-- persistindo tabela cadastroOS
insert into cadastroOS(idOSmecanico, idOSordemServiço, listaServiço, listaPeça) 
	values(2, 1, 'desmontagem e montagem pneu', 'pneu'),
		  (2, 2, 'desmontagem e montagem manopla', 'manopla'),
          (5, 3, 'desmontagem e montagem repimboca', 'repimboca');
select * from cadastroOS;

-- persistindo tabela pagamento_OS
insert into pagamentoOS(idPGordemServiço, idPGpagemento) 
	values(1, 1),
		  (2, 2),
          (3, 3);
select * from pagamentoOS;
 
 -- persistindo tabela peças_necessárias
insert into peçaOS(idPÇordemServiço, idPÇpeça, quantidadePeçaOS)
	values(1, 2, 2),
		  (2, 1, 2),
          (3, 3, 1);
select * from pagamentoOS;

-- persistindo tabela serviços_necessários
insert into serviçoOS(idSVordemServiço, idSVserviços, quantidadeServiçosOS) 
	values(1, 1, 2),
		  (2, 2, 2), 
          (3, 3, 1);
select * from serviçoOS;

-- Queries dos dados persistidos
select * from cliente as c, ordemServiço as o where idCliente = idOS;

select concat(nome, ' ', sobrenome) as Cliente, serviçoPrevisto as Pedido from cliente, serviços group by idCliente;

-- Recuperar pedido realizado por cada cliente
select * from cliente as c, ordemServiço as o 
	where c.idCliente = o.idOS
    group by idOS;

-- Recuperar o pedido com produto associado
select * from cliente
	inner join ordemServiço on idCliente = idOS
	inner join peça on idCliente = idPeça
    order by nome;
    
select * from cliente inner join pedido on idCliente = idPedidoCliente
	inner join produtoPedido on idPEpedido = idPedido
    group by idCliente;
    
-- Recuperar quantos pedidos foram realizados por cada cliente
select idCliente, nome, count(*) as Numero_de_pedidos from cliente inner join ordemServiço on idCliente = idOS
	inner join Mecanico on idCliente = idMecanico
    group by idCliente;

