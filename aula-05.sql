-- create or replace function tabuada(numero integer) returns setof integer as $$
-- 	begin
-- 		return next numero * 1;
-- 		return next numero * 2;
-- 		return next numero * 3;
-- 		return next numero * 4;
-- 		return next numero * 5;
-- 		return next numero * 6;
-- 		return next numero * 7;
-- 		return next numero * 8;
-- 		return next numero * 9;
-- 		return next numero * 10;
-- 	end
-- $$ language plpgsql;

-- create or replace function tabuada(numero integer) returns setof varchar as $$
-- 	declare multiplicador integer default 1;
-- 	declare resultado integer;
	
-- 	begin
-- 		while multiplicador < 10 loop
-- 			resultado = numero * multiplicador;
-- 			return next concat(numero, ' X ', multiplicador, ' = ', resultado);
			
-- 			multiplicador := multiplicador + 1;
-- 		end loop;
-- 	end
-- $$ language plpgsql;

create or replace function tabuada(numero integer) returns setof varchar as $$
	declare resultado integer;
	
	begin
		for multiplicador in 1..9 loop
			resultado = numero * multiplicador;
			return next concat(numero, ' X ', multiplicador, ' = ', resultado);
		end loop;
	end
$$ language plpgsql;

select * from tabuada(13);

create or replace function instrutor_com_salario(
	out nome varchar,
	out salario_ok varchar
) returns setof record as $$
	declare instrutor instrutor;
	
	begin
		for instrutor in select * from instrutor loop
			nome = instrutor.nome;
			salario_ok = salario_ok(instrutor.id);
			
			return next;
		end loop;
	end
$$ language plpgsql;

select * from instrutor_com_salario();