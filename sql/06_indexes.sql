-- Indices e analise de planos de execucao (EXPLAIN)
-- verifica consulta q12a

EXPLAIN
SELECT *
FROM automovel
WHERE numero_do_chassi = '9BWZZZ377VT004251';

-- indice secundario

CREATE INDEX idx_negociacao_cpf_comprador
ON negociacao(cpf_comprador);

-- verificar o plano de execução

EXPLAIN
SELECT
    a.numero_do_chassi,
    a.cor,
    a.ano_fabricacao,
    m.nome AS modelo,
    m.categoria
FROM automovel a
JOIN modelo m
    ON a.nome_modelo = m.nome
WHERE m.nome = 'Corolla';

-- segundo indice

CREATE INDEX IF NOT EXISTS idx_negociacao_cpf_comprador
ON negociacao(cpf_comprador);

EXPLAIN
SELECT *
FROM negociacao
WHERE cpf_comprador = '74583317042';

EXPLAIN
SELECT p.nome, p.sobrenome, n.data_negociacao, n.preco_pago
FROM pessoa p
JOIN negociacao n ON p.cpf = n.cpf_comprador
WHERE p.cpf = '74583317042';
