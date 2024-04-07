-- Esse bloco de código é um exemplo de um bloco anônimo em PL/SQL, usado no Oracle Database

--  Esta instrução é usada para ativar a saída do servidor. Ela permite que o código PL/SQL exiba mensagens no console ou em uma ferramenta que esteja sendo usada para executar o código.
SET SERVEROUTPUT ON

-- Inicia a seção de declaração, onde variáveis, cursores, etc., são declarados.
DECLARE
    -- Declara uma variável do tipo emp%ROWTYPE. Isso significa que emprec terá a mesma estrutura que a tabela emp
    emprec emp%ROWTYPE;

-- Inicia o bloco de código principal.
BEGIN
-- Realiza uma consulta na tabela emp e atribui o resultado à variável emprec. A consulta seleciona todas as colunas (*) da tabela onde empno é igual a 7839.
SELECT *
    INTO emprec
    FROM emp
WHERE empno = 7839;
    -- exibem os valores das colunas da tabela emp para o registro encontrado com empno = 7839. Cada linha exibe o nome da coluna seguido pelo valor correspondente.
    DBMS_OUTPUT.PUT_LINE ('Codigo   = ' || emprec.empno);
    DBMS_OUTPUT.PUT_LINE ('Nome     = ' || emprec.ename);
    DBMS_OUTPUT.PUT_LINE ('Cargo    = ' || emprec.job);
    DBMS_OUTPUT.PUT_LINE ('Gerente  = ' || emprec.mgr);
    DBMS_OUTPUT.PUT_LINE ('Data     = ' || emprec.hiredate);
    DBMS_OUTPUT.PUT_LINE ('Sala     = ' || emprec.sal);
    DBMS_OUTPUT.PUT_LINE ('Comissao = ' || emprec.comm);
    DBMS_OUTPUT.PUT_LINE ('Depart.  = ' || emprec.deptno);  
END;
/

--------------------------------------------------------------------------------------------------------------------------------

-- Esse bloco de código é um exemplo de um script PL/SQL que executa uma exclusão de dados de uma tabela e utiliza DBMS_OUTPUT.PUT_LINE para exibir o número de linhas excluídas. Em seguida, ele executa um ROLLBACK para desfazer a exclusão, ou seja, as linhas são excluídas temporariamente até que o ROLLBACK seja chamado, o que as restaura.

BEGIN
    -- Esta instrução DELETE que remove as linhas da tabela emp onde o valor da coluna deptno é igual a 10.
    DELETE 
        FROM emp
    WHERE deptno = 10;
    -- Esta linha usa DBMS_OUTPUT.PUT_LINE para exibir uma mensagem na saída, mostrando o número de linhas afetadas pela instrução DELETE. SQL%ROWCOUNT é uma variável especial que contém o número de linhas afetadas pela última instrução SQL.
    DBMS_OUTPUT.PUT_LINE ('Linhas apagadas = ' || SQL%ROWCOUNT);
    --  Esta instrução ROLLBACK desfaz todas as mudanças feitas desde o início da transação atual. Neste caso, ele desfaria a exclusão das linhas, restaurando os dados excluídos.
    ROLLBACK;
END;
/

--------------------------------------------------------------------------------------------------------------------------------

-- Esse bloco de código PL/SQL é um exemplo de como usar um cursor para percorrer os resultados de uma consulta e exibi-los utilizando DBMS_OUTPUT.PUT_LINE

DECLARE
    -- Declara uma variável do tipo emp%ROWTYPE, que é uma estrutura que representa uma linha da tabela emp.
    emprec emp%ROWTYPE;   
    -- Declara um cursor chamado cursor_emp que seleciona os departamentos (deptno) e a soma dos salários (SUM(sal)) da tabela emp agrupados por departamento (GROUP BY deptno).
    CURSOR cursor_emp IS 
        SELECT deptno, SUM(sal)             
            FROM emp        
        GROUP BY deptno;
BEGIN
    -- Abre o cursor cursor_emp, executando a consulta definida nele.
    OPEN cursor_emp;
    -- Inicia um loop que irá percorrer todas as linhas retornadas pelo cursor
    LOOP
        -- A cada iteração do loop, a instrução FETCH obtém os valores do cursor e os armazena na variável emprec.
        FETCH cursor_emp INTO emprec.deptno, emprec.sal;
        -- Verifica se não há mais linhas para serem lidas no cursor. Se não houver mais linhas, o loop é encerrado.
        EXIT WHEN cursor_emp%NOTFOUND;
        -- Exibe na saída (DBMS_OUTPUT.PUT_LINE) o número do departamento e o salário total do departamento.
        DBMS_OUTPUT.PUT_LINE ('Departamento: ' || emprec.deptno);
        DBMS_OUTPUT.PUT_LINE ('Salario     : ' || emprec.sal);
    END LOOP;
    -- Fecha o cursor após o loop.
    CLOSE cursor_emp;
END;
/

--------------------------------------------------------------------------------------------------------------------------------

-- Esse bloco de código PL/SQL também utiliza um cursor para percorrer os resultados de uma consulta e exibi-los utilizando DBMS_OUTPUT.PUT_LINE

-- Esta é a seção onde você declara variáveis e cursores que serão usados no bloco de código.
DECLARE   
  -- Declara um cursor chamado cursor_emp que seleciona os departamentos (deptno) e a soma dos salários (SUM(sal)) da tabela emp agrupados por departamento (GROUP BY deptno).
  CURSOR cursor_emp IS          
    SELECT deptno, SUM(sal) soma           
    FROM emp          
  GROUP BY deptno; 
-- Inicia a seção executável do bloco de código.
BEGIN    
  -- Inicia um loop FOR que percorre todas as linhas retornadas pelo cursor cursor_emp.
  FOR emprec IN cursor_emp LOOP     
    -- Exibe na saída (DBMS_OUTPUT.PUT_LINE) o número do departamento (deptno) e o total dos salários (soma) para esse departamento, utilizando a variável emprec que representa a linha atual do cursor.
    DBMS_OUTPUT.PUT_LINE ('Departamento: ' || emprec.deptno);       
    DBMS_OUTPUT.PUT_LINE ('Salario     : ' || emprec.soma);    
    -- Finaliza o loop FOR
  END LOOP; 
END; 
/

--------------------------------------------------------------------------------------------------------------------------------

-- Este bloco de código PL/SQL também realiza a mesma operação que os anteriores, utilizando um loop FOR para percorrer os resultados de uma consulta e exibir os dados. Aqui está o que cada parte faz:

-- Inicia a seção executável do bloco de código.
BEGIN   
  -- Define um loop FOR que percorre os resultados da consulta embutida no próprio loop, sem a necessidade de declarar explicitamente um cursor. A cada iteração, emprec representará uma linha da consulta, contendo o número do departamento (deptno) e o total dos salários (soma) para esse departamento.
  FOR emprec IN (SELECT deptno, SUM(sal) soma 
    FROM emp GROUP BY deptno) 
  LOOP    
    -- Exibe na saída (DBMS_OUTPUT.PUT_LINE) o número do departamento e o total dos salários para esse departamento, utilizando a variável emprec que representa a linha atual da consulta.    
    DBMS_OUTPUT.PUT_LINE ('Departamento: ' || emprec.deptno);        
    DBMS_OUTPUT.PUT_LINE ('Salario     : ' || emprec.soma);    
  -- Finaliza o loop FOR
  END LOOP; 
END; 
/