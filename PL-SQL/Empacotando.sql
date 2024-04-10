-- Esse é o esqueleto básico de como criar um pacote em PL/SQL. Aqui está uma explicação detalhada de cada parte do código:

-- definição de um novo pacote chamado nome_pacote. A cláusula OR REPLACE permite substituir um pacote existente com o mesmo nome, se necessário
CREATE [ OR REPLACE ] PACKAGE nome_pacote
-- {IS ou AS}: Indica o início da definição do pacote. Você pode usar IS ou AS, ambos têm o mesmo efeito.
{IS ou AS}

-- [ variáveis ]: Nesta seção, você pode declarar variáveis que serão usadas em todo o pacote. Essas variáveis podem ser usadas em todos os módulos e procedimentos do pacote.

[ variáveis ]

-- [ especificação dos cursores ]: Aqui você pode definir cursores que serão usados no pacote. Os cursores podem ser declarados uma vez e usados em vários módulos e procedimentos do pacote.

[ especificação dos cursores ]

-- [ especificação dos módulos ]: Nesta seção, você pode definir procedimentos e funções que compõem o pacote. Estes são os blocos de código que executam as operações desejadas.

[ especificação dos módulos ]

-- END [nome_pacote ];: Marca o fim do pacote. Se o nome do pacote for especificado após o END, é uma boa prática, mas não é estritamente necessário.
END [nome_pacote ];

-------------------------------------------------------------------------------------------------------------------------------

-- Esse código cria um pacote chamado faculdade com três constantes: cnome, cfone e cnota

CREATE OR REPLACE PACKAGE faculdade AS
cnome CONSTANT VARCHAR2(4) := 'FIAP';
cfone CONSTANT VARCHAR2(13) := '(11)3385-8010';
cnota CONSTANT NUMBER(2) := 10;
END faculdade;
/

-- Este bloco PL/SQL demonstra como utilizar a constante cnome do pacote faculdade para construir uma mensagem e exibi-la utilizando dbms_output.put_line.

SET SERVEROUTPUT ON

DECLARE
 melhor VARCHAR2(30);
BEGIN
  melhor := faculdade.cnome || ', a melhor faculdade';
  dbms_output.put_line(melhor);
END;
/

-- Este código resultará na exibição da mensagem 'FIAP, a melhor faculdade', assumindo que o valor da constante cnome seja 'FIAP'.

------------------------------------------------------------------------------------------------------------------------

-- Este código cria um pacote PL/SQL chamado rh com uma função e um procedimento


CREATE OR REPLACE PACKAGE rh as
FUNCTION descobrir_salario 
  (p_id IN emp.empno%TYPE) 
  RETURN NUMBER;
PROCEDURE reajuste
  (v_codigo_emp IN emp.empno%type,
   v_porcentagem IN number DEFAULT 25);
END rh;
/

-- Este pacote pode ser útil para encapsular funcionalidades relacionadas à gestão de recursos humanos, como o cálculo de salários e o reajuste dos mesmos

------------------------------------------------------------------------------------------------------------------------

-- Este código cria o corpo do pacote rh, que contém a implementação das funções e procedimentos declarados no pacote rh anteriormente

-- CREATE OR REPLACE PACKAGE BODY rh: Inicia a definição do corpo do pacote rh, que contém a implementação das funções e procedimentos.
CREATE OR REPLACE PACKAGE BODY rh
AS
-- FUNCTION descobrir_salario (p_id IN emp.empno%TYPE) RETURN NUMBER IS ...: Implementa a função descobrir_salario, que recebe um ID de funcionário p_id e retorna o salário desse funcionário. A função seleciona o salário da tabela emp onde o empno é igual a p_id.
 FUNCTION descobrir_salario
    (p_id IN emp.empno%TYPE)
 RETURN NUMBER
 IS
    v_salario emp.sal%TYPE := 0;
 BEGIN
    SELECT sal INTO v_salario
      FROM emp
     WHERE empno = p_id;
    RETURN v_salario;
 END descobrir_salario;

-- PROCEDURE reajuste (v_codigo_emp IN emp.empno%type, v_porcentagem IN number DEFAULT 25) IS ...: Implementa o procedimento reajuste, que recebe um código de empregado v_codigo_emp e uma porcentagem de reajuste v_porcentagem. O procedimento atualiza o salário do empregado (sal) na tabela emp adicionando o reajuste especificado.
 PROCEDURE reajuste
 (v_codigo_emp IN emp.empno%type,
  v_porcentagem IN number DEFAULT 25)
 IS
 BEGIN
 UPDATE emp
    SET sal = sal + (sal *( v_porcentagem / 100 ) )
  where empno = v_codigo_emp;
 COMMIT;
 END reajuste;

-- END rh;: Marca o fim do corpo do pacote rh.
END rh;
/

-- Este corpo de pacote fornece funcionalidades para obter o salário de um funcionário com base em seu ID e para reajustar o salário de um funcionário. Lembre-se de que as operações de atualização (UPDATE) em bancos de dados devem ser tratadas com cuidado, especialmente quando envolvem informações sensíveis como salários

------------------------------------------------------------------------------------------------------------------------

-- Este código cria o corpo do pacote rh com a implementação dos cursores, funções e procedimentos declarados no pacote rh
CREATE OR REPLACE PACKAGE BODY rh AS

  -- CURSOR c_sal RETURN RegEmp IS ...: Declara um cursor chamado c_sal que retorna registros do tipo RegEmp, que deve ser um tipo definido anteriormente. Este cursor seleciona o número do empregado (empno) e o salário (sal) da tabela emp ordenados pelo salário em ordem decrescente.
  CURSOR c_sal RETURN RegEmp IS
     SELECT empno, sal FROM emp ORDER BY sal DESC;

  -- FUNCTION contrata_func (...) RETURN INT IS ...: Implementa a função contrata_func que recebe informações sobre um novo funcionário e o insere na tabela emp. Retorna o novo número do empregado.
  FUNCTION contrata_func (
       v_ename  emp.ename%TYPE,
       v_job    emp.job%TYPE,
       v_mgr    emp.mgr%TYPE,
       v_sal    emp.sal%TYPE,
       v_comm   emp.comm%TYPE,
       v_deptno emp.deptno%TYPE) RETURN INT IS
     cod_novo_emp INT;
  BEGIN
     SELECT max(empno) + 1 INTO cod_novo_emp FROM emp;
     INSERT INTO emp (empno, ename, job, mgr, 
                      hiredate, sal, comm, deptno) 
              VALUES (cod_novo_emp, v_ename, v_job, 
                      v_mgr, SYSDATE, v_sal,
                      v_comm, v_deptno);
     RETURN cod_novo_emp;
  END contrata_func;

  -- PROCEDURE demite_func (...) IS ...: Implementa o procedimento demite_func que recebe o número do empregado e o remove da tabela emp.   
  PROCEDURE demite_func (v_empno emp.empno%TYPE) IS
  BEGIN
     DELETE FROM emp WHERE empno = v_empno;
  END demite_func;

  -- FUNCTION sal_ok (...) RETURN BOOLEAN IS ...: Implementa a função sal_ok que verifica se um determinado salário está dentro do intervalo de salários existentes na tabela emp.
  FUNCTION sal_ok
     (v_sal emp.sal%TYPE) 
      RETURN BOOLEAN IS
     min_sal emp.sal%TYPE;
     max_sal emp.sal%TYPE;
  BEGIN
     SELECT min(sal), max(sal) INTO 
            min_sal, max_sal
       FROM emp;
     RETURN (v_sal >= min_sal) AND (v_sal <= max_sal);
  END sal_ok;

  -- PROCEDURE reajuste (...) IS ...: Implementa o procedimento reajuste que recebe o número do empregado e a porcentagem de reajuste do salário. O procedimento calcula o novo salário com o reajuste e o atualiza na tabela emp se o novo salário for válido.
 PROCEDURE reajuste
 (v_codigo_emp IN emp.empno%type,
  v_porcentagem IN number DEFAULT 25)
 IS
  v_sal emp.sal%TYPE;
 BEGIN
     SELECT sal INTO v_sal 
       FROM emp 
      WHERE empno = v_codigo_emp;
     IF sal_ok(v_sal + (v_sal*(v_porcentagem/100))) THEN
        UPDATE emp
           SET sal = 
                  v_sal + (v_sal*(v_porcentagem/100))
         WHERE empno = v_codigo_emp;
     ELSE
        RAISE salario_invalido;
     END IF;
 END reajuste;

  -- FUNCTION maiores_salarios (...) RETURN RegEmp IS ...: Implementa a função maiores_salarios que retorna os n maiores salários da tabela emp usando o cursor c_sal.
  FUNCTION maiores_salarios (n INT) RETURN RegEmp IS
     emp_rec RegEmp;
  BEGIN
     OPEN c_sal;
     FOR i IN 1..n LOOP
        FETCH c_sal INTO emp_rec;
     END LOOP;
     CLOSE c_sal;
     RETURN emp_rec;
  END maiores_salarios;

END rh;

-- Este corpo de pacote fornece funcionalidades para manipulação de funcionários, como contratação, demissão, reajuste de salário e consulta dos maiores salários