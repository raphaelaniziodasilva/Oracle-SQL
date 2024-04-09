-- Esse bloco de código SQL serve para criar uma tabela chamada erros. Em seguida, define a saída do servidor ON para habilitar a saída do servidor.

-- criando uma tabela chamada erros 
CREATE TABLE erros
(usuario  VARCHAR2(30), -- coluna
 data     DATE, -- coluna
 cod_erro NUMBER, -- coluna
 msg_erro VARCHAR2(100)); -- coluna
\
-- Esta instrução habilita a saída do servidor para que as mensagens geradas pelo bloco PL/SQL sejam exibidas no console ou na interface de desenvolvimento.
SET SERVEROUTPUT ON

DECLARE 
   -- Declara uma variável chamada cod do mesmo tipo que a coluna cod_erro da tabela erros.
   cod   erros.cod_erro%TYPE;
   -- Declara uma variável chamada msg do mesmo tipo que a coluna msg_erro da tabela erros.
   msg   erros.msg_erro%TYPE;    
   -- Declara e inicializa a variável cinco com o valor 5.
   cinco NUMBER := 5; 
BEGIN    
  -- Tenta dividir cinco por (cinco - cinco), o que resultará em uma divisão por zero, gerando uma exceção ZERO_DIVIDE.
  DBMS_OUTPUT.PUT_LINE (cinco / ( cinco - cinco )); 

  -- EXCEPTION ... WHEN ZERO_DIVIDE THEN ... WHEN OTHERS THEN: Esta parte trata as exceções geradas no bloco BEGIN ... END;.
EXCEPTION    
  -- Captura a exceção ZERO_DIVIDE, obtém o código de erro da exceção (SQLCODE) e a mensagem de erro (SQLERRM), e insere essas informações na tabela erros junto com o nome do usuário atual (USER), a data atual (SYSDATE).
  WHEN ZERO_DIVIDE THEN
        cod := SQLCODE;
        msg := SUBSTR(SQLERRM, 1, 100);
        insert into erros values (USER, SYSDATE, cod, msg);   
        
  -- WHEN OTHERS THEN ...: Captura qualquer outra exceção não tratada e imprime "Erro imprevisto" na saída do servidor. 
  WHEN OTHERS THEN         
        DBMS_OUTPUT.PUT_LINE ('Erro imprevisto'); END;
/

--------------------------------------------------------------------------------------------------------------

-- Esse bloco PL/SQL tem como objetivo buscar informações de um empregado com o número de empregado (empno) específico na tabela "emp" e exibir essas informações na saída padrão.

DECLARE
  e_meu_erro EXCEPTION;
  emprec emp%ROWTYPE;   CURSOR cursor_emp IS 
         SELECT empno, ename             
         FROM emp           
         WHERE empno = 1111;
BEGIN
   OPEN cursor_emp;
   LOOP
      FETCH cursor_emp INTO emprec.deptno, emprec.sal;
      IF cursor_emp%NOTFOUND THEN
         RAISE e_meu_erro;
      END IF;
         DBMS_OUTPUT.PUT_LINE ('Codigo : ' || emprec.empno);
         DBMS_OUTPUT.PUT_LINE ('Nome   : ' || emprec.ename);
      EXIT WHEN cursor_emp%NOTFOUND;
   END LOOP;
EXCEPTION
   WHEN E_MEU_ERRO THEN
         DBMS_OUTPUT.PUT_LINE ('Codigo nao cadastrado');
         ROLLBACK;
END;
/

--------------------------------------------------------------------------------------------------------------

-- Esse bloco PL/SQL tenta excluir um registro da tabela "dept" com o número do departamento (deptno) igual a 10 e, se ocorrer uma violação de integridade referencial (no caso, a violação da restrição de chave estrangeira), ele captura a exceção e exibe uma mensagem indicando a violação e, em seguida, faz um rollback da transação.

DECLARE   
  e_meu_erro EXCEPTION;   
  PRAGMA EXCEPTION_INIT (e_meu_erro, -2292); 
BEGIN   
  DELETE FROM dept    
  WHERE deptno = 10;   
  COMMIT; 
EXCEPTION   WHEN  e_meu_erro  THEN    
  DBMS_OUTPUT.PUT_LINE ('Integridade Referencial Violada');    
  ROLLBACK; 
END;
/

--------------------------------------------------------------------------------------------------------------

-- O erro ORA-20901 que você está recebendo indica que o departamento que você tentou excluir (deptno = 33) não existe na tabela "dept". Isso ocorre porque você está verificando se a exclusão foi bem-sucedida usando IF SQL%NOTFOUND THEN, mas essa verificação só é válida para operações de recuperação de dados (como SELECT).

DECLARE    
  e_meu_erro EXCEPTION;    
  PRAGMA EXCEPTION_INIT (e_meu_erro, -2292); 
BEGIN    
  DELETE FROM dept     
  WHERE deptno = 33;    
  IF SQL%NOTFOUND THEN       
    RAISE_APPLICATION_ERROR (-20901, 'Departamento Inexistente');       
      ROLLBACK;    
    END IF;     
    COMMIT; 
EXCEPTION    
  WHEN  e_meu_erro  THEN     
    DBMS_OUTPUT.PUT_LINE ('Integridade Referencial Violada');     
    ROLLBACK; 
END; /

ERROR at line 1:
ORA-20901: Departamento Inexistente

--------------------------------------------------------------------------------------------------------------

-- Este bloco PL/SQL tenta excluir um registro da tabela "dept" com deptno igual a 10. Se ocorrer um erro durante a exclusão, ele captura a exceção específica (ZERO_DIVIDE neste caso) e exibe uma mensagem indicando o erro no bloco interno. Em seguida, ele tenta executar uma operação de divisão por zero (cinco / ( cinco - cinco )) fora do bloco interno para gerar outra exceção. Se ocorrer qualquer outra exceção (além de ZERO_DIVIDE), ele captura a exceção "OUTROS" e insere informações sobre o erro na tabela "erros".
  
DECLARE
   cod   erros.cod_erro%TYPE;
   msg   erros.msg_erro%TYPE;
   cinco NUMBER := 5;
BEGIN
    BEGIN
        DELETE FROM dept
         WHERE deptno = 10;
    EXCEPTION
       WHEN ZERO_DIVIDE THEN
            DBMS_OUTPUT.PUT_LINE ('Erro no bloco interno');
    END;
    DBMS_OUTPUT.PUT_LINE (cinco / ( cinco - cinco ));
EXCEPTION
    WHEN OTHERS THEN
        cod := SQLCODE;
        msg := SUBSTR(SQLERRM, 1, 100);
        insert into erros values (USER, SYSDATE, cod, msg);
END;
/