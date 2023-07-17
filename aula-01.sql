create function primeira_funcao() returns integer as '
	select (5 - 3) * 2
' language sql;

select primeira_funcao() as numero;

create function soma_dois_numeros(
	numero_1 integer,
	numero_2 integer
) returns integer as '
	select numero_1 + numero_2
' language sql;

select soma_dois_numeros(4, 4) as numero;

create temp table if not exists a (
	id serial primary key,
	nome varchar(255)
);

create or replace function cria_a(nome varchar) returns void as $$
	insert into a (nome) values (cria_a.nome);
$$ language sql;

select cria_a('Teste');

select * from a;

