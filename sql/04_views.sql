-- Visoes (views), incluindo WITH CHECK OPTION
-- NOTA: os "testes de erro" falham de proposito: o WITH CHECK OPTION
-- impede que uma linha saia do filtro da view.
-- Questao 10 Visão 1 — vw_automoveis_estoque

CREATE OR REPLACE VIEW vw_automoveis_estoque AS
SELECT
    a.numero_do_chassi,
    a.nome_modelo,
    m.nome_fabricante,
    m.categoria,
    m.tipo_combustivel,
    a.cor,
    a.condicao,
    a.quilometragem,
    a.preco_referencia_fipe,
    e.status_disponibilidade,
    e.data_entrada,
    e.prazo_entrega,
    e.localizacao_veiculo,
    r.nome_fantasia AS revendedora,
    r.cidade,
    r.estado
FROM automovel a
JOIN modelo m
    ON a.nome_modelo = m.nome
JOIN estoque e
    ON a.numero_do_chassi = e.numero_do_chassi
JOIN revendedora r
    ON e.cnpj_revendedora = r.cnpj;

-- Teste da visão

SELECT *
FROM vw_automoveis_estoque
ORDER BY nome_fabricante, nome_modelo;

-- Teste visao 1

SELECT *
FROM vw_automoveis_estoque
ORDER BY nome_fabricante, nome_modelo;

-- Consulta usando a visão 1

SELECT
    nome_modelo,
    nome_fabricante,
    revendedora,
    cidade,
    preco_referencia_fipe
FROM vw_automoveis_estoque
WHERE status_disponibilidade = 'disponivel'
ORDER BY preco_referencia_fipe DESC;

-- Visão 2 — vw_negociacoes_detalhadas

CREATE OR REPLACE VIEW vw_negociacoes_detalhadas AS
SELECT
    n.id_negociacao,
    n.data_negociacao,
    n.hora_negociacao,
    n.preco_pago,
    a.numero_do_chassi,
    a.nome_modelo,
    m.nome_fabricante,
    pc.nome AS nome_comprador,
    pc.sobrenome AS sobrenome_comprador,
    CASE
        WHEN n.cpf_vendedor IS NOT NULL THEN 'Pessoa Física'
        WHEN n.cnpj_revendedora_vendedora IS NOT NULL THEN 'Revendedora'
        WHEN n.nome_fabricante_vendedor IS NOT NULL THEN 'Fabricante'
        ELSE 'Sem vendedor identificado'
    END AS tipo_vendedor
FROM negociacao n
JOIN automovel a
    ON n.numero_do_chassi = a.numero_do_chassi
JOIN modelo m
    ON a.nome_modelo = m.nome
JOIN pessoa pc
    ON n.cpf_comprador = pc.cpf;

-- Teste visao 2

SELECT *
FROM vw_negociacoes_detalhadas
ORDER BY data_negociacao;

-- Consulta usando a visão 2

SELECT
    tipo_vendedor,
    COUNT(*) AS quantidade_negociacoes,
    SUM(preco_pago) AS total_vendido,
    AVG(preco_pago) AS media_venda
FROM vw_negociacoes_detalhadas
GROUP BY tipo_vendedor
ORDER BY total_vendido DESC;

-- Visão 1 — Automóveis usados

CREATE OR REPLACE VIEW vw_automoveis_usados AS
SELECT
    numero_do_chassi,
    quilometragem,
    ano_fabricacao,
    possui_ar,
    tracao,
    cor,
    tipo_cambio,
    condicao,
    preco_referencia_fipe,
    nome_modelo
FROM automovel
WHERE condicao = 'usado'
WITH CHECK OPTION;

-- Teste de sucesso — atualização mantendo o automóvel como usado

UPDATE vw_automoveis_usados
SET quilometragem = quilometragem + 500
WHERE numero_do_chassi = '9BWZZZ377VT004251';

-- Teste de erro — tentativa de alterar para condição fora da view

UPDATE vw_automoveis_usados
SET condicao = 'novo'
WHERE numero_do_chassi = '9BWZZZ377VT004251';

-- Visão 2 — Revendedoras autorizadas

CREATE OR REPLACE VIEW vw_revendedoras_autorizadas AS
SELECT
    cnpj,
    nome_oficial,
    nome_fantasia,
    cidade,
    estado,
    endereco,
    status_autorizacao
FROM revendedora
WHERE status_autorizacao = 'autorizada'
WITH CHECK OPTION;

-- Teste de sucesso — atualização mantendo a revendedora autorizada

UPDATE vw_revendedoras_autorizadas
SET cidade = 'Campinas'
WHERE cnpj = '21812525000100';

-- Teste de erro — tentativa de retirar a revendedora da condição da view

UPDATE vw_revendedoras_autorizadas
SET status_autorizacao = 'pendente'
WHERE cnpj = '21812525000100';
