-- Consultas SQL
-- NOTA: os blocos marcados como "erro" falham de proposito,
-- para demonstrar que as restricoes do esquema estao ativas.
-- Q7-1 — SELECT com WHERE e ORDER BY

SELECT a.numero_do_chassi, a.cor, a.ano_fabricacao,
       a.quilometragem, a.preco_referencia_fipe, a.nome_modelo
FROM automovel a
WHERE a.condicao = 'usado'
ORDER BY a.preco_referencia_fipe DESC;

-- Q7-2 — BETWEEN

SELECT n.id_negociacao, n.data_negociacao,
       n.hora_negociacao, n.preco_pago, n.numero_do_chassi
FROM negociacao n
WHERE n.preco_pago BETWEEN 80000.00 AND 170000.00
ORDER BY n.preco_pago ASC;

-- Q7-3 — LIKE

SELECT p.cpf, p.nome, p.sobrenome, p.endereco
FROM pessoa p
WHERE p.endereco LIKE '%São Paulo%'
ORDER BY p.nome ASC;

-- Q7-4 — IN e ORDER BY

SELECT m.nome, m.categoria, m.tipo_combustivel,
       m.preco_tabela, m.nome_fabricante
FROM modelo m
WHERE m.tipo_combustivel IN ('Elétrico', 'Híbrido')
ORDER BY m.preco_tabela ASC;

-- Questão 5 INSERT com sucesso

INSERT INTO fabricante (nome, pais_origem, website)
VALUES ('Nissan', 'Japão', 'https://www.nissan.com.br');

-- INSERT erro

INSERT INTO pessoa (cpf, nome, sobrenome, endereco, data_nascimento)
VALUES ('12345678999', NULL, 'Silva', 'Rua Teste, 10', '1990-01-01');

-- DELETE com sucesso

INSERT INTO pessoa (cpf, nome, sobrenome, endereco, data_nascimento)
VALUES ('11122233344', 'Teste', 'Remocao', 'Rua Teste, 10', '1990-01-01');

DELETE FROM pessoa
WHERE cpf = '11122233344';

-- DELETE com erro

DELETE FROM pessoa
WHERE cpf = '74583317042';

-- UPDATE com sucesso UPDATE com erro

UPDATE automovel
SET quilometragem = quilometragem + 1000
WHERE numero_do_chassi = '9BWZZZ377VT004251';

-- Evidências da Questão 2 – Esquema Lógico-Relacional

SELECT
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'carros'
ORDER BY table_name, ordinal_position;

SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    string_agg(kcu.column_name, ', ' ORDER BY kcu.ordinal_position) AS colunas,
    ccu.table_name AS tabela_referenciada,
    ccu.column_name AS coluna_referenciada
FROM information_schema.table_constraints tc
LEFT JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
LEFT JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.table_schema = ccu.table_schema
WHERE tc.table_schema = 'carros'
  AND tc.constraint_type IN ('PRIMARY KEY', 'FOREIGN KEY')
GROUP BY
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    ccu.table_name,
    ccu.column_name
ORDER BY tc.table_name, tc.constraint_type, tc.constraint_name;

-- Evidências da Questão 6

SELECT nome, website
FROM fabricante
WHERE pais_origem = 'Japão';

SELECT a.numero_do_chassi, a.cor, a.nome_modelo, m.categoria
FROM automovel a
JOIN modelo m ON a.nome_modelo = m.nome;

SELECT p.nome, p.sobrenome, n.preco_pago, n.data_negociacao
FROM pessoa p
JOIN negociacao n ON p.cpf = n.cpf_comprador;

SELECT cpf_comprador AS cpf FROM negociacao
UNION
SELECT cpf_vendedor  AS cpf FROM negociacao
WHERE cpf_vendedor IS NOT NULL;

SELECT p.cpf, p.nome
FROM pessoa p
WHERE p.cpf IN (
    SELECT cpf_comprador
    FROM negociacao
)
AND p.cpf NOT IN (
    SELECT cpf_vendedor
    FROM negociacao
    WHERE cpf_vendedor IS NOT NULL
);

SELECT cpf_comprador AS cpf FROM negociacao
INTERSECT
SELECT cpf_vendedor  AS cpf FROM negociacao
WHERE cpf_vendedor IS NOT NULL;

SELECT r.nome_fantasia, f.nome AS nome_fabricante
FROM revendedora r
CROSS JOIN fabricante f;

SELECT a.numero_do_chassi, a.cor, a.quilometragem,
       MAX(r.data_revisao) AS ultima_revisao
FROM automovel a
JOIN estoque e  ON a.numero_do_chassi = e.numero_do_chassi
JOIN revisao r  ON a.numero_do_chassi = r.numero_do_chassi
WHERE e.status_disponibilidade = 'disponivel'
GROUP BY a.numero_do_chassi, a.cor, a.quilometragem;

-- Questão 9 Consulta 1 — JOIN + ORDER BY

SELECT
    a.numero_do_chassi,
    a.nome_modelo,
    a.cor,
    a.condicao,
    r.nome_fantasia AS revendedora,
    r.cidade
FROM automovel a
JOIN estoque e
    ON a.numero_do_chassi = e.numero_do_chassi
JOIN revendedora r
    ON e.cnpj_revendedora = r.cnpj
WHERE e.status_disponibilidade = 'disponivel'
ORDER BY r.cidade, a.nome_modelo;

-- Consulta 2 — GROUP BY + COUNT

SELECT
    f.nome AS fabricante,
    COUNT(a.numero_do_chassi) AS quantidade_automoveis
FROM fabricante f
JOIN modelo m
    ON f.nome = m.nome_fabricante
JOIN automovel a
    ON m.nome = a.nome_modelo
GROUP BY f.nome
ORDER BY quantidade_automoveis DESC;

-- Consulta 3 — GROUP BY + HAVING

SELECT
    r.nome_fantasia,
    r.cidade,
    COUNT(e.id_estoque) AS quantidade_em_estoque
FROM revendedora r
JOIN estoque e
    ON r.cnpj = e.cnpj_revendedora
GROUP BY r.nome_fantasia, r.cidade
HAVING COUNT(e.id_estoque) >= 1
ORDER BY quantidade_em_estoque DESC;

-- Consulta 4 — Subconsulta não correlacionada

SELECT
    numero_do_chassi,
    nome_modelo,
    cor,
    preco_referencia_fipe
FROM automovel
WHERE preco_referencia_fipe > (
    SELECT AVG(preco_referencia_fipe)
    FROM automovel
)
ORDER BY preco_referencia_fipe DESC;

-- Consulta 5 — EXISTS

SELECT
    p.cpf,
    p.nome,
    p.sobrenome
FROM pessoa p
WHERE EXISTS (
    SELECT 1
    FROM negociacao n
    WHERE n.cpf_comprador = p.cpf
)
ORDER BY p.nome;

-- Consulta 6 — WITH + agregação

WITH vendas_classificadas AS (
    SELECT
        preco_pago,
        CASE
            WHEN cpf_vendedor IS NOT NULL THEN 'Pessoa Física'
            WHEN cnpj_revendedora_vendedora IS NOT NULL THEN 'Revendedora'
            WHEN nome_fabricante_vendedor IS NOT NULL THEN 'Fabricante'
            ELSE 'Sem vendedor identificado'
        END AS tipo_vendedor
    FROM negociacao
)
SELECT
    tipo_vendedor,
    COUNT(*) AS quantidade_negociacoes,
    SUM(preco_pago) AS total_vendido,
    AVG(preco_pago) AS media_venda
FROM vendas_classificadas
GROUP BY tipo_vendedor
ORDER BY total_vendido DESC;
