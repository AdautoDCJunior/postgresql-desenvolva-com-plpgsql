create table if not exists categoria (
    id serial primary key,
    nome varchar(255) unique not null
);

create table if not exists curso (
	id serial primary key,
	id_categoria integer references categoria(id),
	nome varchar(255) unique not null
);

create or replace function cria_curso(
	nome_curso varchar,
	nome_categoria varchar
) returns void as $$
	declare id_categoria integer;
	
	begin
		select id into id_categoria from categoria where nome = nome_categoria;
		
		if not found then
			insert into categoria (nome) values (nome_categoria)
				returning id into id_categoria;
		end if;
		
		insert into curso (nome, id_categoria) values (nome_curso, id_categoria);
	end
$$ language plpgsql;

select cria_curso('java', 'programação');

select * from curso;

select * from categoria;

create table if not exists instrutor_log(
	id serial primary key,
	informacao varchar(255),
	criada_em timestamp default current_timestamp
)

create or replace function cria_instrutor(nome_instrutor varchar, salario_instrutor decimal) returns void as $$ 
    declare
        id_instrutor_inserido integer;
        media_salarial decimal;
        instrutor_recebe_menos integer default 0;
        total_instrutores integer default 0;
        salario decimal;
        percentual decimal(5,2);
		
    begin
        insert into instrutor (nome, salario) values (nome_instrutor, salario_instrutor) returning id into id_instrutor_inserido;

        select avg(instrutor.salario) into media_salarial from instrutor where id <> id_instrutor_inserido;

        if salario_instrutor > media_salarial then
            insert into instrutor_log (informacao) values (nome_instrutor || ' recebe acima da média');
        end if;

        for salario in select instrutor.salario from instrutor where id <> id_instrutor_inserido loop
            total_instrutores := total_instrutores + 1;

            if salario_instrutor > salario then
                instrutor_recebe_menos := instrutor_recebe_menos + 1;
            end if;    
        end loop;

        percentual = instrutor_recebe_menos::decimal / total_instrutores::decimal * 100;

        insert into instrutor_log (informacao) 
            values (nome_instrutor || ' recebe mais do que ' || percentual || '% da grade de instrutores');
    end;
$$ language plpgsql;

select cria_instrutor('teste_1', 200);

select * from instrutor;

select * from instrutor_log;