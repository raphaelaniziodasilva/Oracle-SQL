-- Esse é um esboço básico para a criação de um trigger em bancos de dados Oracle.

-- CREATE [OR REPLACE] TRIGGER [esquema.]nome_trigger: Essa é a declaração básica para criar um novo trigger ou substituir um existente, se o OR REPLACE for especificado. O esquema é opcional e representa o esquema no qual o trigger será criado.
CREATE [OR REPLACE] TRIGGER [esquema.]nome_trigger 
-- {BEFORE ou AFTER}: Indica se o trigger deve ser acionado antes ou depois do evento especificado.
{BEFORE ou AFTER} 
-- [evento] ON [esquema.]tabela_nome: Especifica o evento que acionará o trigger e a tabela associada a ele.
[evento] ON [esquema.]tabela_nome
-- [referencing Old as valor_anterior ou NEW as valor_novo): Opcionalmente, pode-se especificar os valores antigos e/ou novos que serão acessíveis dentro do corpo do trigger.
[referencing Old as valor_anterior ou NEW as valor_novo)
-- {nível de linha ou nível de instrução}: Define se o trigger será acionado para cada linha afetada pelo evento (nível de linha) ou uma vez para a instrução inteira (nível de instrução).
-- [WHEN (condição)]: Uma cláusula opcional que especifica uma condição que deve ser verdadeira para acionar o trigger.
{nível de linha ou nível de instrução} [WHEN (condição)]] DECLARE
-- DECLARE BEGIN corpo_trigger END;: O corpo do trigger, que é onde a lógica do trigger é definida. Pode conter comandos PL/SQL para realizar ações com base no evento acionador.
BEGIN
   corpo_trigger 
END;

--------------------------------------------------------------------------------------------------------------------

-- Esse código cria um trigger em um banco de dados Oracle que é acionado antes de uma atualização na tabela emp para cada linha afetada pela atualização. O trigger calcula a diferença salarial entre o valor antigo e o novo salário e exibe as informações usando a função DBMS_OUTPUT.PUT_LINE.

-- Nesse caso, o trigger é chamado de "mudancas_salariais" e é acionado antes de uma atualização na tabela "emp" (presumivelmente uma tabela de funcionários), para cada linha que está sendo atualizada.

-- SET SERVEROUTPUT ON: Este comando ativa a saída do servidor, permitindo que os resultados do DBMS_OUTPUT.PUT_LINE sejam exibidos.
SET SERVEROUTPUT ON

-- CREATE OR REPLACE TRIGGER mudancas_salariais: Aqui, estamos criando (ou substituindo se já existir) um trigger chamado "mudancas_salariais".
CREATE OR REPLACE TRIGGER mudancas_salariais
-- BEFORE UPDATE ON emp: O trigger é acionado antes de uma atualização na tabela "emp".
BEFORE UPDATE ON emp 
-- FOR EACH ROW: Indica que o trigger deve ser executado para cada linha que está sendo atualizada.
FOR EACH ROW 
-- DECLARE: Esta é a seção onde declaramos variáveis locais. No caso, a variável "saldo" é declarada como um número.
DECLARE 
   saldo number; 
-- BEGIN: Início do bloco de código do trigger.
BEGIN 
-- saldo := :NEW.sal - :OLD.sal;: Aqui, calculamos a diferença salarial entre o novo salário (:NEW.sal) e o salário anterior (:OLD.sal), e atribuímos o resultado à variável "saldo".
   saldo := :NEW.sal  - :OLD.sal; 
   DBMS_OUTPUT.PUT_LINE('Salario Anterior: ' || :OLD.sal); 
   DBMS_OUTPUT.PUT_LINE('Salario Novo: ' || :NEW.sal); 
   DBMS_OUTPUT.PUT_LINE('Diferenca Salarial: ' || saldo); 
END; 
/

-- Esse código é um exemplo de um comando de atualização (UPDATE) em um banco de dados Oracle, seguido por um comando PL/SQL que mostra a diferença salarial após a atualização.

-- SET SERVEROUTPUT ON: Este comando ativa a saída do servidor, permitindo que os resultados do DBMS_OUTPUT.PUT_LINE sejam exibidos.
SET SERVEROUTPUT ON

-- UPDATE EMP SET sal = sal * 2 WHERE empno = 7900: Este é o comando de atualização. Ele multiplica o salário atual (sal) por 2 para o funcionário com empno igual a 7900. Isso significa que o salário é dobrado para o funcionário com esse número de identificação.
UPDATE EMP     SET sal = sal * 2   WHERE empno = 7900
/ 
Salario Anterior: 950
Salario Novo: 1900
Diferenca Salarial: 950

-- Depois que o comando de atualização é executado, ele altera o salário do funcionário com empno 7900 de 950 para 1900. A diferença salarial é então calculada como 1900 - 950 = 950, conforme mostrado pelas linhas de saída DBMS_OUTPUT.PUT_LINE do trigger anteriormente definido, que provavelmente foi acionado automaticamente pela atualização.

--------------------------------------------------------------------------------------------------------------------

-- Esse código é um exemplo de criação de um trigger em um banco de dados Oracle que é acionado antes de uma operação de inserção (INSERT), atualização (UPDATE) ou exclusão (DELETE) na tabela "emp". O trigger é executado para cada linha afetada pela operação.

-- SET SERVEROUTPUT ON: Este comando ativa a saída do servidor para que as mensagens geradas pelo DBMS_OUTPUT.PUT_LINE sejam exibidas.
SET SERVEROUTPUT ON

-- CREATE OR REPLACE TRIGGER mudancas_salariais: Aqui estamos criando (ou substituindo se já existir) um trigger chamado "mudancas_salariais".
CREATE OR REPLACE TRIGGER mudancas_salariais 
-- BEFORE INSERT OR UPDATE OR DELETE ON emp: O trigger é acionado antes de uma operação de inserção, atualização ou exclusão na tabela "emp".
BEFORE INSERT OR UPDATE OR DELETE ON emp 
-- FOR EACH ROW: Indica que o trigger deve ser executado para cada linha afetada pela operação.
FOR EACH ROW 
-- DECLARE: Esta é a seção onde declaramos variáveis locais. No caso, a variável "saldo" é declarada como um número.
DECLARE 
   saldo number; 
-- BEGIN: Início do bloco de código do trigger.
BEGIN 
-- saldo := :NEW.sal - :OLD.sal;: Aqui, calculamos a diferença salarial entre o novo salário (:NEW.sal) e o salário anterior (:OLD.sal), e atribuímos o resultado à variável "saldo".
   saldo := :NEW.sal  - :OLD.sal; 
   -- DBMS_OUTPUT.PUT_LINE(...): Estas chamadas são usadas para imprimir mensagens na saída do servidor. Aqui, estamos exibindo o salário anterior, o novo salário e a diferença salarial.
   DBMS_OUTPUT.PUT_LINE('Salario Anterior: ' || :OLD.sal); 
   DBMS_OUTPUT.PUT_LINE('Salario Novo: ' || :NEW.sal); 
   DBMS_OUTPUT.PUT_LINE('Diferenca Salarial: ' || saldo); 
END; 
/

-- Esse código mostra o acionamento do trigger "mudancas_salariais" com uma instrução INSERT na tabela "emp"

--SET SERVEROUTPUT ON: Ativa a saída do servidor para que as mensagens geradas pelo DBMS_OUTPUT.PUT_LINE sejam exibidas.
SET SERVEROUTPUT ON

--
-- Acionando o gatilho com uma instrução INSERT
--
-- INSERT INTO emp (empno, sal) VALUES (1000, 2780);: É uma instrução SQL de inserção que adiciona um novo registro à tabela "emp" com o número do empregado (empno) igual a 1000 e o salário (sal) igual a 2780.
INSERT INTO emp (empno, sal)
VALUES (1000, 2780);

-- O trigger "mudancas_salariais" é acionado antes da inserção, conforme especificado pelo comando BEFORE INSERT no seu código. O trigger executa o bloco PL/SQL que calcula e exibe a diferença salarial entre o novo salário e o salário anterior.

-- O DBMS_OUTPUT.PUT_LINE deve exibir as seguintes mensagens (se não houver erro):
Salario Anterior:
Salario Novo: 2780
Diferenca Salarial:


-- Esse código mostra o acionamento do trigger "mudancas_salariais" com uma instrução UPDATE na tabela "emp".

-- SET SERVEROUTPUT ON: Ativa a saída do servidor para que as mensagens geradas pelo DBMS_OUTPUT.PUT_LINE sejam exibidas.
SET SERVEROUTPUT ON

--
-- Acionando o gatilho com uma instrução UPDATE
--
-- UPDATE EMP SET sal = sal * 2 WHERE empno = 1000;: É uma instrução SQL de atualização que dobra o salário (sal) do funcionário com o número de empregado (empno) igual a 1000.
UPDATE EMP
   SET sal = sal * 2
 WHERE empno = 1000;

-- O trigger "mudancas_salariais" é acionado antes da atualização, conforme especificado pelo comando BEFORE UPDATE no seu código. O trigger executa o bloco PL/SQL que calcula e exibe a diferença salarial entre o novo salário e o salário anterior.

-- O DBMS_OUTPUT.PUT_LINE exibe as seguintes mensagens:
Salario Anterior: 2780
Salario Novo: 5560
Diferenca Salarial: 2780


-- Esse código mostra o acionamento do trigger "mudancas_salariais" com uma instrução DELETE na tabela "emp". Aqui está o que acontece passo a passo:
SET SERVEROUTPUT ON

-- 
-- Acionando o gatilho com uma instrução DELETE
--
-- DELETE emp WHERE empno = 1000;: É uma instrução SQL de exclusão que remove o registro do funcionário com o número de empregado (empno) igual a 1000.
DELETE emp
 WHERE empno = 1000;

-- O trigger "mudancas_salariais" é acionado antes da exclusão, conforme especificado pelo comando BEFORE DELETE no seu código. O trigger executa o bloco PL/SQL que calcula e exibe a diferença salarial entre o novo salário (que não existe mais, pois o registro foi excluído) e o salário anterior.

-- O DBMS_OUTPUT.PUT_LINE exibe as seguintes mensagens:
Salario Anterior: 5560
Salario Novo:
Diferenca Salarial:

--------------------------------------------------------------------------------------------------------------------

-- Esse código cria uma tabela chamada "auditoria" para armazenar registros de auditoria de operações realizadas em outra tabela chamada "emp". Além disso, define um procedimento chamado "registra" que é usado para inserir registros na tabela "auditoria", e um trigger chamado "mudancas_salariais" que é acionado antes de operações de inserção, atualização ou exclusão na tabela "emp" para registrar as mudanças na tabela "auditoria".

-- SET SERVEROUTPUT ON: Esta instrução é usada no SQL*Plus para habilitar a saída de mensagens do servidor. No contexto de um script SQL, isso permite exibir mensagens de saída do procedimento armazenado ou trigger.
SET SERVEROUTPUT ON

-- CREATE TABLE auditoria (...): Cria uma tabela chamada "auditoria" com as colunas "codigo" (número inteiro de até 5 dígitos), "hora" (data e hora da operação), "operacao" (tipo de operação realizada: INSERT, UPDATE ou DELETE), "antigo" (valor antigo do salário) e "novo" (novo valor do salário).
CREATE TABLE auditoria
(codigo   NUMBER(5),
 hora     DATE,
 operacao VARCHAR2(6),
 antigo   NUMBER (7,2),
 novo     NUMBER (7,2));
  
-- CREATE OR REPLACE PROCEDURE registra (...) AS: Define uma procedure chamada "registra" com parâmetros de entrada para código, operação, valor antigo e novo valor. A diretiva PRAGMA AUTONOMOUS_TRANSACTION; indica que esta procedure será executada em uma transação independente.
CREATE OR REPLACE PROCEDURE registra
 (p_codigo   IN  VARCHAR2,
  P_operacao IN  VARCHAR2,
  P_antigo   IN  NUMBER,
  P_novo     IN  NUMBER) AS
  PRAGMA AUTONOMOUS_TRANSACTION;

-- BEGIN ... END;: Delimita o bloco de código da procedure "registra". Dentro deste bloco, há uma instrução INSERT INTO que adiciona um novo registro à tabela "auditoria" com os valores passados como parâmetros, incluindo o código, a data e hora atuais, a operação realizada, o valor antigo e o novo valor.
BEGIN
  INSERT INTO auditoria (codigo, hora, operacao, antigo, novo)
  VALUES (p_codigo, SYSDATE, p_operacao, p_antigo, p_novo);
  -- COMMIT;: Confirma a transação, gravando as alterações no banco de dados.
  COMMIT;
END;
/

-- CREATE OR REPLACE TRIGGER mudancas_salariais ...: Define um trigger chamado "mudancas_salariais" que é acionado antes de uma inserção, atualização ou exclusão na tabela "emp" (presumivelmente uma tabela de empregados).
CREATE OR REPLACE TRIGGER mudancas_salariais 
BEFORE INSERT OR UPDATE OR DELETE ON emp 
-- FOR EACH ROW: Indica que o trigger será executado uma vez para cada linha afetada pela operação (inserção, atualização ou exclusão).
FOR EACH ROW 

-- BEGIN ... END;: Delimita o bloco de código do trigger "mudancas_salariais". Dentro deste bloco, há um CASE que verifica o tipo de operação sendo realizada (inserção, atualização ou exclusão) e chama a procedure "registra" com os parâmetros apropriados, incluindo o código do empregado afetado, a operação realizada, o valor antigo do salário (quando aplicável) e o novo valor do salário.
BEGIN 

   CASE
     WHEN INSERTING THEN
          registra(:NEW.empno, 'INSERT', :OLD.sal, :NEW.sal);  
     WHEN UPDATING THEN
          registra(:OLD.empno, 'UPDATE', :OLD.sal, :NEW.sal);  
     WHEN DELETING THEN
          registra(:OLD.empno, 'DELETE', :OLD.sal, :NEW.sal); 

  -- END CASE;: Finaliza a estrutura CASE. 
  END CASE;

END; 
/

-- Esse trecho de código SQL demonstra como acionar o gatilho mudancas_salariais com uma instrução INSERT na tabela emp e então consultar a tabela auditoria para verificar o registro inserido.

-- SET SERVEROUTPUT ON: Habilita a saída de mensagens do servidor, que pode incluir mensagens geradas por triggers ou procedimentos.
SET SERVEROUTPUT ON

-- ALTER SESSION SET nls_date_format='DD/MM/YY HH24:MI:SS';: Define o formato de data e hora a ser usado nas saídas da sessão para exibir a data e hora no formato "DD/MM/YY HH24:MI:SS" (dia/mês/ano hora:minuto:segundo).
ALTER SESSION SET nls_date_format='DD/MM/YY HH24:MI:SS';

--
-- Acionando o gatilho com uma instrução INSERT
--
-- INSERT INTO emp (empno, sal) VALUES (1000, 2780);: Insere um novo registro na tabela emp com o número de empregado (empno) 1000 e um salário (sal) de 2780.
INSERT INTO emp (empno, sal)
VALUES (1000, 2780);

-- SELECT * FROM auditoria;: Consulta a tabela auditoria para exibir todos os registros presentes nela. Após a execução do INSERT, o gatilho mudancas_salariais é acionado e insere um novo registro na tabela auditoria para refletir a inserção do novo registro na tabela emp.
SELECT * FROM auditoria;


--
-- Acionando o gatilho com uma instrução UPDATE
--

UPDATE EMP
   SET sal = sal * 2
 WHERE empno = 1000;

SELECT * FROM auditoria;


-- 
-- Acionando o gatilho com uma instrução DELETE
--

DELETE emp
 WHERE empno = 1000;

SELECT * FROM auditoria;



