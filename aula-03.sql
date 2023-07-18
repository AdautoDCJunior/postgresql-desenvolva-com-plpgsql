create or replace function primeira_pl() returns integer as $$
	declare primeira_variavel integer default 3;
	
	begin
		primeira_variavel := primeira_variavel * 2;
		
		declare primeira_variavel integer;
		
		begin
			primeira_variavel := 7;
		end;
		
		return primeira_variavel;
	end;
$$ language plpgsql;

select primeira_pl();