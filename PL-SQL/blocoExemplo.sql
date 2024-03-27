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