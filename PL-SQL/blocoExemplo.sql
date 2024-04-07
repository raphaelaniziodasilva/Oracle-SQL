-- Este bloco PL/SQL tem a finalidade de buscar o nome e o cargo de um funcionário da tabela emp com empno igual a 7934 e exibir esses valores na saída do servidor.


-- SET SERVEROUTPUT ON: Habilita a saída do servidor para que as mensagens geradas pelo DBMS_OUTPUT.PUT_LINE sejam exibidas no console.
SET SERVEROUTPUT ON
-- DECLARE: Inicia a declaração de variáveis e outros itens. Neste caso, são declaradas duas variáveis, v_nome e v_cargo, ambas do tipo VARCHAR2(30).
DECLARE
  v_nome    VARCHAR2(30);
  v_cargo   VARCHAR2(30);
-- BEGIN: Marca o início do bloco anônimo, onde as instruções a serem executadas estão contidas.
BEGIN
-- SELECT ename, job INTO v_nome, v_cargo FROM emp WHERE empno = 7934;: Realiza uma consulta na tabela emp para obter o nome e o cargo do funcionário com empno igual a 7934
-- e armazena esses valores nas variáveis v_nome e v_cargo, respectivamente.
  SELECT ename, job
  INTO v_nome, v_cargo
  FROM emp
  WHERE empno = 7934;
-- DBMS_OUTPUT.PUT_LINE(v_nome);: Exibe o valor da variável v_nome na saída do servidor.
DBMS_OUTPUT.PUT_LINE(v_nome);
-- DBMS_OUTPUT.PUT_LINE(v_cargo);: Exibe o valor da variável v_cargo na saída do servidor.
DBMS_OUTPUT.PUT_LINE(v_cargo);
-- END;: Marca o fim do bloco anônimo.
END;
-- /: Esta barra indica o final do bloco e é usada para sinalizar ao interpretador PL/SQL que o bloco deve ser executado.
/

-- Ao executar este bloco PL/SQL, ele buscará o nome e o cargo do funcionário com empno igual a 7934 na tabela emp e exibirá esses valores na saída do servidor.


---------------------------------------------------------------------------------------------------------------------------------------------------


-- Este bloco PL/SQL tem o objetivo de calcular a soma dos salários dos funcionários de um departamento específico
-- (no caso, o departamento com o número 10) e exibir essa soma na saída do servidor.

SET SERVEROUTPUT ON
DECLARE    
  v_soma_sal   NUMBER; 
  v_deptno     NUMBER NOT NULL := 10;           
BEGIN
  SELECT SUM(sal)  
  INTO   v_soma_sal
  FROM   emp
  WHERE  deptno = v_deptno;
DBMS_OUTPUT.PUT_LINE('A soma dos salários do departamento ' || v_deptno || ' é ' || v_soma_sal);
END;
/

-- Ao executar este bloco PL/SQL, ele calculará a soma dos salários dos funcionários do departamento 10 na tabela emp e exibirá essa soma na saída do servidor.


---------------------------------------------------------------------------------------------------------------------------------------------------

-- Este bloco PL/SQL é um exemplo simples de uma operação de inserção de dados em uma tabela usando variáveis.

DECLARE
v_empno NUMBER := 11;
v_ename VARCHAR2(13) := 'SANDRA';
v_job VARCHAR2(13) := 'GERENTE';
v_deptno NUMBER := 10;
BEGIN
   INSERT INTO emp(empno, ename, job, deptno)
          VALUES (v_empno, v_ename, v_job, v_deptno);
END;
/

-- Em resumo, este bloco PL/SQL insere uma nova linha na tabela emp com o número do empregado 11, o nome 'SANDRA', o cargo 'GERENTE' e o número do departamento 10.


---------------------------------------------------------------------------------------------------------------------------------------------------


-- Este bloco PL/SQL é um exemplo de como usar uma variável para aumentar o salário de funcionários com um determinado cargo.

DECLARE
	v_sal_increase   NUMBER := 2000;
BEGIN
	UPDATE	emp
	SET		sal = sal + v_sal_increase
	WHERE	job = 'ANALYST';
END;
/

-- Em resumo, este bloco PL/SQL aumenta o salário de todos os funcionários com o cargo 'ANALYST' na tabela emp em 2000.


--------------------------------------------------------------------------------------------------------------------------------------------------


-- Este bloco PL/SQL é um exemplo de como excluir registros de uma tabela com base em uma condição específica.

DECLARE
	v_deptno   NUMBER := 10;               
BEGIN							
	DELETE FROM   emp
	WHERE         deptno = v_deptno;
END;
/

-- Em resumo, este bloco PL/SQL exclui todos os registros da tabela emp onde o número do departamento é 10.


---------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE tabela1
(col1 VARCHAR2(18));

INSERT INTO tabela1
  VALUES ('Campo com 18 bytes');

SET SERVEROUTPUT ON

DECLARE
  v_col1 VARCHAR2(18);
BEGIN
  SELECT col1 INTO v_col1
    FROM tabela1;
  DBMS_OUTPUT.PUT_LINE ('Valor = ' || v_col1);
END;
/

-- Esse comando esvazia a tabela tabela1, removendo todos os dados dela. Cuidado ao usar esse comando, pois ele não pode ser desfeito e remove todos os dados permanentemente.
TRUNCATE TABLE tabela1;

-- Esse comando altera a definição da coluna col1 da tabela tabela1, mudando seu tipo para VARCHAR2 com tamanho máximo de 30 bytes. Antes dessa alteração, o tipo e/ou tamanho da coluna eram diferentes.
ALTER TABLE tabela1
MODIFY col1 VARCHAR2(30);

-- Esse comando insere um valor na tabela tabela1, na coluna col1. O valor inserido é uma string de 30 bytes, que agora é aceita devido à alteração feita anteriormente na coluna.
INSERT INTO tabela1
  VALUES ('Tamanho alterado para 30 bytes');

-- Esse comando ativa a saída do servidor, permitindo que mensagens sejam exibidas durante a execução de blocos PL/SQL.
SET SERVEROUTPUT ON


-- O bloco PL/SQL seguinte tem a seguinte estrutura:

-- Declaração de variáveis locais.
DECLARE
  v_col1 VARCHAR2(18);
-- Início do bloco de código.
BEGIN
-- Seleção do valor da coluna col1 da tabela tabela1 e atribuição desse valor à variável v_col1.
  SELECT col1 INTO v_col1
    FROM tabela1;
-- Exibição do valor da variável v_col1 na saída do servidor.
  DBMS_OUTPUT.PUT_LINE ('Valor = ' || v_col1);
END;
/

-- erro ocorre porque a variável v_col1 foi declarada com tamanho insuficiente para armazenar a string de 30 bytes inserida na tabela. Para corrigir esse erro, a declaração da variável v_col1 deve ser modificada para VARCHAR2(30) ou um tamanho maior, para que possa armazenar o valor corretamente.
ORA-06502: PL/SQL: numeric or value error: character string buffer too small
ORA-06512: at line 4


-- para corrigir esse erro usando outra forma e modificando  O bloco PL/SQL 

-- DECLARE: a variável v_col1 é declarada com o tipo tabela1.col1%TYPE. Isso significa que a variável terá o mesmo tipo da coluna col1 da tabela tabela1
DECLARE
  v_col1 tabela1.col1%TYPE;
  -- BEGIN: Início do bloco de código PL/SQL, onde as instruções serão executadas.
BEGIN
-- Esta instrução SQL seleciona o valor da coluna col1 da tabela tabela1 e o armazena na variável v_col1.
  SELECT col1 INTO v_col1
    FROM tabela1;
  -- Esta instrução exibe na saída do servidor a mensagem "Valor = " concatenada com o valor da variável v_col1. Isso permite visualizar o valor da coluna col1 recuperado da tabela tabela1.
  DBMS_OUTPUT.PUT_LINE ('Valor = ' || v_col1);
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------

-- Esse bloco PL/SQL tem o objetivo de selecionar o valor da coluna col1 da tabela tabela1, calcular o comprimento desse valor e, se o comprimento for maior que 25, exibir o valor na saída do servidor. Vamos analisar cada parte:


DECLARE
  -- declarando as variáveis
  v_col1 tabela1.col1%TYPE; -- v_col1, do mesmo tipo da coluna col1 da tabela tabela1, 
  v_tamanho NUMBER(3); -- v_tamanho, do tipo NUMBER(3)
-- BEGIN: Início do bloco de código PL/SQL, onde as instruções serão executadas.
BEGIN
  -- Esta instrução SQL seleciona o comprimento da coluna col1 (usando a função LENGTH) e o valor da coluna col1 da tabela tabela1, e os armazena nas variáveis v_tamanho e v_col1, respectivamente.
  SELECT LENGTH(col1), col1 INTO v_tamanho, v_col1     
    FROM tabela1;   
  -- IF v_tamanho > 25 THEN: Esta condição verifica se o valor de v_tamanho é maior que 25.
  IF v_tamanho > 25 THEN  
    -- Se a condição for verdadeira, esta instrução exibe na saída do servidor a mensagem "Texto = " concatenada com o valor da variável v_col1    
    DBMS_OUTPUT.PUT_LINE ('Texto = ' || v_col1);   
  END IF; 
END;
/


DECLARE
  v_col1    tabela1.col1%TYPE;   
  v_tamanho NUMBER(3); 
BEGIN   
  SELECT LENGTH(col1), col1 INTO v_tamanho, v_col1     
    FROM tabela1;   

  -- Esta linha verifica se o valor da variável v_tamanho é maior que 25. Se essa condição for verdadeira, o bloco de código dentro do IF é executado. Caso contrário, o bloco de código dentro do ELSE (se houver) será executado.
  IF v_tamanho > 25 THEN      
    DBMS_OUTPUT.PUT_LINE ('Texto = ' || v_col1);
  ELSE
    DBMS_OUTPUT.PUT_LINE ('Texto menor ou igual a 25');
  END IF; 
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE
  v_col1    tabela1.col1%TYPE;   
  v_tamanho NUMBER(3); 
BEGIN   
  SELECT LENGTH(col1), col1 INTO v_tamanho, v_col1     
    FROM tabela1;   
  IF v_tamanho > 25 THEN      
    DBMS_OUTPUT.PUT_LINE ('Texto = ' || v_col1);
  ELSIF v_tamanho > 20 THEN
    DBMS_OUTPUT.PUT_LINE ('Texto maior que 20');
  ELSIF v_tamanho > 15 THEN
    DBMS_OUTPUT.PUT_LINE ('Texto maior que 15');
  ELSE
    DBMS_OUTPUT.PUT_LINE ('Texto menor ou igual a 15');
  END IF; 
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------

-- Este bloco PL/SQL calcula o comprimento da coluna col1 da tabela tabela1 e verifica se esse comprimento é maior que 25 e se o ano atual é posterior a 1999 (século XXI). Vamos analisar cada parte:

-- usando AND: &&

DECLARE
  v_tamanho NUMBER(3); 
BEGIN   
  SELECT LENGTH(col1) INTO v_tamanho     
    FROM tabela1;   
  IF v_tamanho > 25 AND
    TO_CHAR(SYSDATE, 'YYYY') > 1999 THEN  
    DBMS_OUTPUT.PUT_LINE ('Maior que 25 bytes e século XXI');
  END IF; 
END;
/

-- usando OR: ||

DECLARE
  v_tamanho NUMBER(3); 
BEGIN   
  SELECT LENGTH(col1) INTO v_tamanho     
    FROM tabela1;   
  IF v_tamanho > 25 OR
    TO_CHAR(SYSDATE, 'YYYY') > 1999 THEN
    DBMS_OUTPUT.PUT_LINE ('Maior que 25 bytes ou século XXI');
  END IF; 
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------

-- Esse trecho de código é um bloco PL/SQL que tem o objetivo de inserir 10 registros na tabela1 com um texto diferente em cada registro.

DECLARE
  -- declarando a variável v_contador como um número inteiro com tamanho 2 e é inicializada com o valor 1
  v_contador NUMBER(2) :=1; 
BEGIN   
  -- LOOP - Inicia um loop infinito, onde o código dentro do bloco será repetido várias vezes até que uma condição de saída seja atendida
  LOOP
    -- É um comando de inserção que adiciona um novo registro na tabela1 com o texto "Inserindo texto numero " seguido pelo valor atual de v_contador.
    INSERT INTO tabela1
    VALUES ('Inserindo texto numero ' || v_contador);
    -- Incrementa o valor de v_contador em 1 a cada iteração.
    v_contador := v_contador + 1;  
    -- É uma condição de saída do loop. Quando o valor de v_contador ultrapassar 10, o loop será interrompido. 
  EXIT WHEN v_contador > 10;   
  -- Finaliza o loop
  END LOOP;
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------

-- Esse bloco PL/SQL é uma forma mais simplificada de inserir 10 registros na tabela1 com um texto diferente em cada registro.

BEGIN   
  -- FOR i IN 1..10 LOOP - Inicia um loop que executa 10 vezes, onde i é a variável de iteração que assume valores de 1 a 10.
  FOR i IN 1..10 LOOP
    -- É um comando de inserção que adiciona um novo registro na tabela1 com o texto "Inserindo texto numero " seguido pelo valor atual de i.
    INSERT INTO tabela1
    VALUES ('Inserindo texto numero ' || i);
  END LOOP;
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE
  v_contador NUMBER(2) :=1; 
BEGIN   
  WHILE v_contador <= 10 LOOP
    INSERT INTO tabela1
    VALUES ('Inserindo texto numero ' || v_contador);
    v_contador := v_contador + 1;   
  END LOOP;
END;

---------------------------------------------------------------------------------------------------------------------------------------------------

--Esse bloco PL/SQL utiliza rótulos (loopexterno) para identificar os loops e controlar o fluxo de execução dentro deles

BEGIN   
  -- Define um rótulo para o loop externo, permitindo que você se refira a ele posteriormente no código
  <<loopexterno>>
  -- Inicia um loop externo que executa 3 vezes, onde i é a variável de iteração que assume valores de 1 a 3.
  FOR i IN 1..3 LOOP
    -- Rótulo para o loop externo, marcando o início de seu bloco de código
    <<loopexterno>>   
    --  Inicia um loop interno que executa 5 vezes, onde j é a variável de iteração que assume valores de 1 a 5.
    FOR j IN 1..5 LOOP
        -- É um comando de inserção que adiciona um novo registro na tabela1 com o texto "Inserindo texto numero " seguido pelo valor atual de i e j.
        INSERT INTO tabela1
        VALUES ('Inserindo texto numero ' || i || j);
    -- Finaliza o loop interno e volta para o início do próximo ciclo do loop externo.
    END LOOP loopexterno;
  -- Finaliza o loop externo
  END LOOP loopexterno;
END;
/