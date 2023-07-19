create temporary table if not exists a (nome varchar(255) not null);

create or replace function cria_a(nome varchar) returns void as $$
	begin
		insert into a (nome) values (cria_a.nome);
	end
$$ language plpgsql;

select cria_a('teste_1');

select * from a;

create or replace function cria_instrutor_falso() returns instrutor as $$
	begin
		return row(22, 'teste', 200::decimal)::instrutor;
	end
$$ language plpgsql;

-- create or replace function cria_instrutor_falso() returns instrutor as $$
-- 	declare retorno instrutor;
	
-- 	begin
-- 		select 23, 'teste', 200::decimal into retorno;
		
-- 		return retorno;
-- 	end
-- $$ language plpgsql;

select id, salario from cria_instrutor_falso();

create or replace function instrutores_bem_pagos(
	valor_salario decimal
) returns setof instrutor as $$
	begin
		return query select * from instrutor where salario > valor_salario;
	end
$$ language plpgsql;

select * from instrutores_bem_pagos(200);

-- create or replace function salario_ok(instrutor instrutor) returns varchar as $$
-- 	begin
-- 		if instrutor.salario > 300 then
-- 			return 'Salário está ok';
-- 		elseif instrutor.salario = 300 then
-- 			return 'Salário pode aumentar';
-- 		else
-- 			return 'Salário está defasado';
-- 		end if;
-- 	end
-- $$ language plpgsql;

-- create or replace function salario_ok(id_instrutor integer) returns varchar as $$
-- 	declare instrutor instrutor;

-- 	begin
-- 		select * from instrutor where id = id_instrutor into instrutor;
	
-- 		if instrutor.salario > 200 then
-- 			return 'Salário está ok';
-- 		else
-- 			return 'Salário pode aumentar';
-- 		end if;
-- 	end
-- $$ language plpgsql;

create or replace function salario_ok(instrutor instrutor) returns varchar as $$
	begin
		case instrutor.salario
			when 100 then
				return 'Salário muito baixo';
			when 200 then
				return 'Salário baixo';
			when 300 then
				return 'Salário ok';
			else
				return 'Salário ótimo';
		end case;
	end
$$ language plpgsql;

select nome, salario_ok(instrutor) from instrutor;