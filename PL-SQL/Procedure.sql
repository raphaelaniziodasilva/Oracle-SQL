-- código PL/SQL, que é uma linguagem de programação usada para escrever procedimentos armazenados, funções e blocos de código no Oracle Database Em resumo, este código PL/SQL cria um procedimento armazenado chamado quadrado que calcula o quadrado de um número passado como parâmetro e o exibe no console. Em seguida, ele executa o procedimento quadrado com o número 5 como argumento.

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE quadrado
(p_num IN NUMBER :=0)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE (p_num*p_num );
END quadrado;
/

EXECUTE quadrado(5);

------------------------------------------------------------------------------------------------------------

-- Este procedimento PL/SQL chamado reajuste recebe dois parâmetros: v_codigo_emp, que é o código do empregado a ser atualizado, e v_porcentagem, que é a porcentagem de reajuste a ser aplicada ao salário do empregado. Se nenhum valor for fornecido para v_porcentagem, ele assume o valor padrão de 25%.

CREATE OR REPLACE PROCEDURE reajuste
(v_codigo_emp IN emp.empno%type,
v_porcentagem IN number DEFAULT 25)
IS
BEGIN
	UPDATE emp
           SET sal = sal + (sal *( v_porcentagem / 100 ) )
           where empno = v_codigo_emp;
           COMMIT;
END reajuste;
/

-- consulta para exibir o número do empregado (empno) e o salário (sal) do empregado com empno igual a 7839, seguido pela execução do procedimento reajuste para o empregado com empno igual a 7839 e, finalmente, outra consulta para exibir o número do empregado e o salário após o reajuste.

SELECT empno, sal
  FROM emp
 WHERE empno = 7839;

EXECUTE reajuste(7839);

SELECT empno, sal
  FROM emp
 WHERE empno = 7839;

-- Este procedimento pode ser útil para realizar reajustes salariais em massa para os empregados da tabela emp. Por exemplo, se você quiser dar um aumento de 10% a todos os empregados, poderia chamar reajuste com v_porcentagem igual a 10.


------------------------------------------------------------------------------------------------------------

-- Este procedimento PL/SQL chamado consulta_emp recebe um parâmetro de entrada p_id que representa o número do empregado (empno) e dois parâmetros de saída p_nome e p_salario que são respectivamente o nome (ename) e o salário (sal) do empregado com o empno fornecido.

CREATE OR REPLACE PROCEDURE consulta_emp
(p_id IN emp.empno%TYPE,
 p_nome OUT emp.ename%TYPE,
 p_salario OUT emp.sal%TYPE)
IS 
BEGIN
    SELECT ename, sal INTO
           p_nome, p_salario
      FROM emp
     WHERE empno  = p_id;
END consulta_emp;
/

-------------------------------------------------------------------------------------------------------------

-- Este bloco PL/SQL demonstra como usar o procedimento consulta_emp para recuperar o nome e o salário de um empregado com o número de empregado 7839 e exibi-los usando DBMS_OUTPUT.PUT_LINE. Aqui está o que cada parte do código faz:

SET SERVEROUTPUT ON

DECLARE
   v_nome    emp.ename%TYPE;
   v_salario emp.sal%TYPE;
BEGIN
   consulta_emp(7839, v_nome, v_salario);
   DBMS_OUTPUT.PUT_LINE(v_nome);
   DBMS_OUTPUT.PUT_LINE(v_salario);
END;
/

-------------------------------------------------------------------------------------------------------------

-- Este procedimento PL/SQL chamado formata_fone recebe um parâmetro p_fone do tipo VARCHAR2 que representa um número de telefone e formata esse número de telefone no formato (XXX) XXXX-XXXX.

CREATE OR REPLACE PROCEDURE formata_fone
(p_fone IN OUT VARCHAR2)
IS
BEGIN
    p_fone := ' (' || SUBSTR(p_fone, 1, 3) || ') ' || SUBSTR(p_fone, 4, 4) || '- ' || SUBSTR(p_fone, 8);
END formata_fone;
/

SET SERVEROUTPUT ON

-- Este procedimento pode ser útil para formatar números de telefone armazenados em um banco de dados ou recebidos como entrada em um formato não padronizado para um formato mais legível.

-------------------------------------------------------------------------------------------------------------

-- Este bloco PL/SQL demonstra como usar o procedimento formata_fone para formatar um número de telefone e exibi-lo usando DBMS_OUTPUT.PUT_LINE. Aqui está o que cada parte do código faz:

DECLARE
   v_fone VARCHAR2(30) := '01138858010';
BEGIN
   Formata_fone(v_fone);
   DBMS_OUTPUT.PUT_LINE(v_fone);
END;
/

-- Ao executar este bloco de código, você verá o número de telefone '01138858010' formatado como '(011) 3885-8010' sendo exibido na saída.

-------------------------------------------------------------------------------------------------------------

-- O erro ORA-00904: nome inválido de coluna indica que o SQL statement está tentando fazer referência a uma coluna que não existe na tabela. No contexto do procedimento REAJUSTE, a linha 10 está causando o problema.

SHOW ERRORS

Erros para PROCEDURE REAJUSTE:

LINE/COL ERROR
-------- -------------------------------------------
8/2      PL/SQL: SQL Statementignored
10/26    PL/SQL: ORA-00904: nome inválido de coluna


CREATE OR REPLACE PROCEDURE errotst AS
    v_conta NUMBER;
BEGIN
    v_conta := 7
END errotst;
/


-- O erro PLS-00103 ocorre porque o compilador esperava um ponto e vírgula (;) após a atribuição v_conta := 7. O código do procedimento errotst deve terminar com um ponto e vírgula para indicar o fim da declaração

SELECT line, position, text
  FROM user_errors
 WHERE name = 'ERROTST'
 ORDER BY sequence;

 LINE POSITION TEXT
----- -------- -----------------------------------------------------------
    5        1 PLS-00103: Encountered the symbol "END" when expecting one of the following:
                  * & = - + ; < / > at in is mod remainder not rem <an exponent (**)> <> or != or ~= >= <= <> and or like LIKE2_ LIKE4_ LIKEC_ between || multiset member SUBMULTISET_ The symbol ";" was substituted for "END" to continue.


-------------------------------------------------------------------------------------------------------------

-- O procedimento incluir_dept que você criou está correto e funcionará conforme o esperado. Ele é usado para inserir um novo departamento na tabela dept com os valores fornecidos ou com os valores padrão se nenhum valor for fornecido.

CREATE OR REPLACE PROCEDURE incluir_dept
(p_cod  IN dept.deptno%TYPE DEFAULT '50',
 p_nome IN dept.dname%TYPE DEFAULT 'FIAP',
 p_loc  IN dept.loc%TYPE DEFAULT 'SP')
IS
BEGIN
  INSERT INTO dept(deptno, dname, loc)
  VALUES(p_cod, p_nome, p_loc);
END incluir_dept;
/