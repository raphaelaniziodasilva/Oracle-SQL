-- Essa função PL/SQL tem como objetivo retornar o salário de um funcionário (empregado) com base no ID do empregado (empno)

-- Define uma função chamada descobrir_salario que recebe um parâmetro p_id do tipo emp.empno%TYPE (o tipo de dado do campo empno da tabela emp) e retorna um número.
CREATE OR REPLACE FUNCTION descobrir_salario
(p_id IN emp.empno%TYPE)
RETURN NUMBER
-- IS: Início da seção de declaração e execução da função.
IS
-- Declaração de uma variável v_salario do tipo emp.sal%TYPE (o tipo de dado do campo sal da tabela emp) com valor inicial 0.
v_salario emp.sal%TYPE := 0;
-- BEGIN: Início da seção de execução da função.
BEGIN
-- Realiza uma consulta na tabela emp para obter o salário (sal) do empregado com o empno igual ao parâmetro p_id e armazena o resultado na variável v_salario.
SELECT sal INTO v_salario
  FROM emp
 WHERE empno = p_id;
 -- RETURN v_salario;: Retorna o valor do salário armazenado na variável v_salario.
RETURN v_salario;
END descobrir_salario;
/

-- chamando a função DESCOBRIR_SALARIO para cada registro na tabela emp e exibir o número do empregado (empno) juntamente com o salário retornado pela função. No entanto, é importante notar que a função DESCOBRIR_SALARIO deve ser criada previamente no banco de dados para que isso funcione corretamente.


SELECT empno, DESCOBRIR_SALARIO(empno)
FROM emp;

---------------------------------------------------------------------------------------------------------------

-- Essa função PL/SQL tem como objetivo retornar a forma ordinal de um número, ou seja, o número por extenso como "primeiro", "segundo", "terceiro", etc


CREATE OR REPLACE FUNCTION ordinal (
  p_numero        NUMBER)
RETURN VARCHAR2
IS
BEGIN
CASE p_numero
 WHEN 1 THEN RETURN 'primeiro';     
 WHEN 2 THEN RETURN 'segundo';     
 WHEN 3 THEN RETURN 'terceiro';     
 WHEN 4 THEN RETURN 'quarto';     
 WHEN 5 THEN RETURN 'quinto';     
 WHEN 6 THEN RETURN 'sexto';     
 WHEN 7 THEN RETURN 'sétimo';     
 WHEN 8 THEN RETURN 'oitavo';     
 WHEN 9 THEN RETURN 'nono';     
 ELSE RETURN 'não previsto';
END CASE;
END ordinal;
/

-- Essa função pode ser útil para converter números em suas formas ordinais em contextos como listas numeradas ou descrições sequenciais. Se tiver mais alguma dúvida ou precisar de mais informações, estou à disposição!

--------------------------------------------------------------------------------------------------------------

