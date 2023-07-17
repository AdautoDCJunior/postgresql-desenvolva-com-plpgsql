create table if not exists instrutor (
	id serial primary key,
	nome varchar(255) not null,
	salario decimal(10,2)
);

insert into instrutor (nome, salario) values ('teste_1', 100);
insert into instrutor (nome, salario) values ('teste_2', 250);
insert into instrutor (nome, salario) values ('teste_3', 500);
insert into instrutor (nome, salario) values ('teste_4', 50);
insert into instrutor (nome, salario) values ('teste_5', 125);

create or replace function dobra_salario(
	instrutor instrutor
) returns decimal as $$
	select instrutor.salario * 2 as dobro;
$$ language sql;

select nome, dobra_salario(instrutor) as desejo from instrutor;

create or replace function cria_instrutor_falso() returns instrutor as $$
	select 22 as id, 'nome_falso' as nome, 200 as salario;
$$  language sql;

select * from cria_instrutor_falso();

create or replace function instrutores_bem_pagos(
	valor_salario decimal
) returns setof instrutor as $$
	select * from instrutor where salario > valor_salario
$$ language sql

-- create or replace function instrutores_bem_pagos_test(
-- 	valor_salario decimal
-- ) returns Table(
-- 	id integer,
-- 	nome varchar(255),
-- 	salario decimal(10,2)
-- ) as $$
-- 	select * from instrutor where salario > valor_salario
-- $$ language sql

-- create or replace function instrutores_bem_pagos_out(
-- 	valor_salario decimal,
-- 	out nome varchar(255),
-- 	out salario decimal(10,2)
-- ) returns setof record as $$
-- 	select nome, salario from instrutor where salario > valor_salario
-- $$ language sql

select * from instrutores_bem_pagos(200);

create or replace function soma_e_produto(
	numero_1 integer,
	numero_2 integer,
	out soma integer,
	out produto integer
) as $$
	select numero_1 + numero_2 as soma, numero_1 * numero_2 as produto;
$$ language sql

select * from soma_e_produto(3, 5);