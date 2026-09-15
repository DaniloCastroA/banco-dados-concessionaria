-- Funcoes, stored procedure e trigger
-- Função 1 — calcular idade de um automóvel

CREATE OR REPLACE FUNCTION fn_idade_automovel(ano INT)
RETURNS INT AS $$
BEGIN
    RETURN EXTRACT(YEAR FROM CURRENT_DATE)::INT - ano;
END;
$$ LANGUAGE plpgsql;

-- Teste da função 1

SELECT
    numero_do_chassi,
    nome_modelo,
    ano_fabricacao,
    fn_idade_automovel(ano_fabricacao) AS idade_automovel
FROM automovel
ORDER BY idade_automovel DESC;

-- Função 2 — classificar valor FIPE

CREATE OR REPLACE FUNCTION fn_classificar_fipe(preco NUMERIC)
RETURNS VARCHAR(30) AS $$
BEGIN
    IF preco < 100000 THEN
        RETURN 'Baixo valor';
    ELSIF preco BETWEEN 100000 AND 200000 THEN
        RETURN 'Valor intermediário';
    ELSE
        RETURN 'Alto valor';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Teste da função 2

SELECT
    numero_do_chassi,
    nome_modelo,
    preco_referencia_fipe,
    fn_classificar_fipe(preco_referencia_fipe) AS classificacao_fipe
FROM automovel
ORDER BY preco_referencia_fipe DESC;

-- Procedure — atualizar status de estoque após venda

CREATE OR REPLACE PROCEDURE pr_marcar_automovel_vendido(chassi_param VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE estoque
    SET status_disponibilidade = 'vendido'
    WHERE numero_do_chassi = chassi_param;
END;
$$;

-- Verificação antes da procedure

SELECT
    numero_do_chassi,
    status_disponibilidade
FROM estoque
WHERE numero_do_chassi = '9BWZZZ377VT004251';

-- Executando a procedure

CALL pr_marcar_automovel_vendido('9BWZZZ377VT004251');

-- Verificação depois da procedure

SELECT
    numero_do_chassi,
    status_disponibilidade
FROM estoque
WHERE numero_do_chassi = '9BWZZZ377VT004251';

-- Função da trigger criacao trigger

CREATE OR REPLACE FUNCTION fn_atualizar_estoque_apos_negociacao()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE estoque
    SET status_disponibilidade = 'vendido'
    WHERE numero_do_chassi = NEW.numero_do_chassi;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_atualizar_estoque_apos_negociacao ON negociacao;

CREATE TRIGGER trg_atualizar_estoque_apos_negociacao
AFTER INSERT ON negociacao
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_estoque_apos_negociacao();

-- Teste da Trigger

UPDATE estoque
SET status_disponibilidade = 'disponivel'
WHERE numero_do_chassi = '9BWZZZ377VT004251';

SELECT
    numero_do_chassi,
    status_disponibilidade
FROM estoque
WHERE numero_do_chassi = '9BWZZZ377VT004251';

INSERT INTO negociacao (
    data_negociacao,
    hora_negociacao,
    preco_pago,
    numero_do_chassi,
    cpf_comprador,
    cpf_vendedor,
    cnpj_revendedora_vendedora,
    nome_fabricante_vendedor
)
VALUES (
    CURRENT_DATE,
    CURRENT_TIME,
    90000.00,
    '9BWZZZ377VT004251',
    '74583317042',
    NULL,
    '21812525000100',
    NULL
);

SELECT
    numero_do_chassi,
    status_disponibilidade
FROM estoque
WHERE numero_do_chassi = '9BWZZZ377VT004251';
