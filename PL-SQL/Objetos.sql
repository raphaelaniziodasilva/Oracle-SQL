-- Esse é um exemplo de uma consulta SQL que seleciona o nome de todos os objetos do tipo 'TABLE' (tabela) no banco de dados do usuário atual, ordenados alfabeticamente pelo nome do objeto.

SELECT object_name
    FROM user_objects
    WHERE object_type = 'TABLE'
    ORDER BY object_name
/

--------------------------------------------------------------------------------------------------------------------

-- Esta é outra consulta SQL que seleciona o tipo e o nome de todos os objetos no banco de dados do usuário atual que estão marcados como 'INVALID' (inválidos), ordenados primeiro pelo tipo de objeto e depois pelo nome do objeto.

SELECT object_type, object_name
    FROM user_objects
    WHERE status = 'INVALID'
    ORDER BY object_type, object_name
/

--------------------------------------------------------------------------------------------------------------------

-- Esta consulta SQL seleciona o tipo de objeto, o nome do objeto e a data e hora da última modificação (last_ddl_time) para todos os objetos no banco de dados do usuário atual que foram modificados hoje ou após a meia-noite de hoje (utilizando a função TRUNC(SYSDATE) para obter a data atual sem a parte fracionária de horas, minutos e segundos). Os resultados são ordenados primeiro pelo tipo de objeto e depois pelo nome do objeto.

SELECT object_type, object_name, 
        last_ddl_time
    FROM user_objects
    WHERE last_ddl_time >= TRUNC (SYSDATE)
    ORDER BY object_type, object_name
/

--------------------------------------------------------------------------------------------------------------------

-- Esta consulta SQL seleciona o nome do objeto, o número da linha e o texto de todas as linhas de código-fonte nos objetos do usuário atual onde o texto contenha a substring 'DEPT' (ignorando maiúsculas e minúsculas). Os resultados são ordenados pelo nome do objeto e pelo número da linha.

SELECT name, line, text
    FROM user_source
    WHERE UPPER (text) 
    LIKE '%DEPT%'
    ORDER BY name, line
/

--------------------------------------------------------------------------------------------------------------------

-- Essa consulta SQL seleciona o nome do objeto e o nome do procedimento de todos os procedimentos do usuário atual que possuem authid igual a 'CURRENT_USER'. Os resultados são ordenados primeiro pelo nome do objeto e depois pelo nome do procedimento.

SELECT   object_name
    , procedure_name 
    FROM user_procedures
    WHERE authid = 'CURRENT_USER'
    ORDER BY object_name, procedure_name
/

--------------------------------------------------------------------------------------------------------------------

-- Esta consulta SQL seleciona todas as colunas de todas as linhas da tabela user_triggers onde o status do trigger é 'DISABLED'.

SELECT *
    FROM user_triggers 
    WHERE status = 'DISABLED'
/

--------------------------------------------------------------------------------------------------------------------

-- Essa consulta SQL seleciona todas as colunas de todas as linhas da tabela user_triggers onde o nome da tabela é 'EMP' e o tipo do trigger contém a string 'EACH ROW'.

SELECT *
    FROM user_triggers 
    WHERE table_name = 'EMP'
    AND trigger_type LIKE '%EACH ROW'
/

--------------------------------------------------------------------------------------------------------------------

-- Essa consulta SQL seleciona todas as colunas de todas as linhas da tabela user_triggers onde o evento de disparo (triggering_event) contém a string 'UPDATE'.

SELECT *
    FROM user_triggers 
    WHERE triggering_event LIKE '%UPDATE%'
/