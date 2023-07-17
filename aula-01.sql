create function primeira_funcao() returns integer as '
	select (5 - 3) * 2
' language sql;

select primeira_funcao() as numero;