-- Estrutura da linguagem PL/SQL

-- Em PL/SQL, um bloco anônimo é um conjunto de instruções SQL e PL/SQL que são executadas de forma sequencial.
-- O bloco anônimo não possui um nome e é delimitado pelas palavras-chave BEGIN e END.


-- DECLARE: Esta seção é usada para declarar variáveis e outros itens. No caso, é declarada uma variável v_variavel do tipo VARCHAR2 com tamanho 5.
DECLARE 
		v_variavel varchar2(5);
        
-- BEGIN: Esta é a seção principal do bloco, onde as instruções são executadas sequencialmente. Aqui, uma consulta SELECT é usada 
-- para buscar um valor da coluna nome_coluna da tabela nome_tabela e armazená-lo na variável v_variavel usando a cláusula INTO.
BEGIN 
		Select  nome_coluna
	into v_variavel
		from nome_tabela;
        
-- EXCEPTION: Esta seção é usada para lidar com exceções que podem ocorrer durante a execução do bloco.
EXCEPTION 
		When exception_name then
END;

-- / (barra): Esta barra indica o final do bloco e é usada para sinalizar ao interpretador PL/SQL que o bloco deve ser executado.
/


-- No geral, este bloco PL/SQL seleciona um valor da coluna nome_coluna da tabela nome_tabela e o armazena na variável v_variavel. 
-- Se ocorrer uma exceção não tratada durante a execução da consulta, o bloco será encerrado.


---------------------------------------------------------------------------------------------------------------------------------------------------


-- Este bloco PL/SQL demonstra o uso da função DBMS_OUTPUT.PUT_LINE para exibir uma mensagem na saída do servidor.

-- SET SERVEROUTPUT ON: Esta instrução habilita a saída do servidor para que as mensagens geradas pelo DBMS_OUTPUT.PUT_LINE sejam exibidas no console.
SET SERVEROUTPUT ON

-- DECLARE: Inicia a declaração de variáveis e outros itens. Neste caso, declara-se a variável v_teste como uma string de até 30 caracteres e atribui-se a ela o valor 'Hello, World'.
DECLARE
    v_teste VARCHAR2(30):='Hello, World';
    
-- BEGIN: Marca o início do bloco anônimo, onde as instruções a serem executadas estão contidas.
BEGIN

-- DBMS_OUTPUT.PUT_LINE(v_teste);: Esta linha utiliza a função DBMS_OUTPUT.PUT_LINE para exibir o valor da variável v_teste no console.
	DBMS_OUTPUT.PUT_LINE(v_teste);
    
-- END;: Marca o fim do bloco anônimo.
END;

-- /: Esta barra indica o final do bloco e é usada para sinalizar ao interpretador PL/SQL que o bloco deve ser executado.
/


---------------------------------------------------------------------------------------------------------------------------------------------------


-- Este trecho de código PL/SQL contém declarações de variáveis e constantes com diferentes tipos e atribuições.

-- v_nascimento DATE;: Declara uma variável chamada v_nascimento do tipo DATE, mas não a inicializa com um valor.
v_nascimento DATE; 

-- v_data DATE := SYSDATE + 7;: Declara a variável v_data do tipo DATE e a inicializa com a data atual (SYSDATE) mais 7 dias.
v_data DATE := SYSDATE + 7; 

-- v_codigo NUMBER(2) NOT NULL := 10;: Declara a variável v_codigo do tipo NUMBER(2), que pode armazenar números inteiros de até 2 dígitos.
-- A cláusula NOT NULL indica que a variável não pode ser nula. A variável é inicializada com o valor 10.
v_codigo NUMBER(2) NOT NULL := 10; 

-- v_UF VARCHAR2(2) := 'SP';: Declara a variável v_UF do tipo VARCHAR2(2), que pode armazenar strings de até 2 caracteres. A variável é inicializada com a string 'SP'.
v_UF VARCHAR2(2) := ‘ ‘SP’’; 

-- v_loc VARCHAR2(2) DEFAULT 'RJ';: Declara a variável v_loc do tipo VARCHAR2(2) e define um valor padrão 'RJ'. Se nenhum valor for atribuído à variável, ela terá o valor 'RJ'.
v_loc VARCHAR2(2) DEFAULT ‘‘RJ’’;

-- v_teste_logico BOOLEAN := (v_valor1 < v_valor2);: Este trecho não está correto, pois PL/SQL não possui um tipo de dados BOOLEAN.
-- Para realizar testes lógicos, você pode usar expressões condicionais diretamente em instruções IF.
v_teste_logico BOOLEAN := (v_valor1 < v_valor2); 

-- c_const CONSTANT NUMBER := 54;: Declara uma constante chamada c_const do tipo NUMBER com o valor 54. 
-- Constantes em PL/SQL são imutáveis e devem ser inicializadas com um valor constante.
c_const CONSTANT NUMBER := 54;

