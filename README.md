# Banco de Dados Relacional — Concessionária de Automóveis

Modelagem e implementação de um banco de dados relacional em **PostgreSQL** para um domínio de
compra e venda de automóveis: fabricantes, modelos, veículos, revendedoras, estoque, revisões
e negociações.

Projeto da disciplina INF1383 (Banco de Dados) — Ciência da Computação, PUC-Rio.

## O que o projeto cobre

| Tema | Onde |
|---|---|
| DDL: 9 tabelas, chaves primárias e estrangeiras, constraints `CHECK` | `sql/01_schema.sql` |
| Massa de dados de teste (fictícia) | `sql/02_seed.sql` |
| Consultas: `JOIN`, `GROUP BY`/`HAVING`, subconsultas, `EXISTS`, `UNION`/`INTERSECT`, CTEs (`WITH`) | `sql/03_queries.sql` |
| Visões, incluindo `WITH CHECK OPTION` | `sql/04_views.sql` |
| Funções PL/pgSQL, stored procedure e trigger | `sql/05_functions_procedures_triggers.sql` |
| Índices secundários e análise de planos com `EXPLAIN` | `sql/06_indexes.sql` |

## Modelo

Nove relações. As decisões de modelagem principais:

- **MODELO × AUTOMÓVEL** são entidades separadas: o modelo é a descrição comercial (Corolla, HB20),
  o automóvel é a unidade física identificada pelo número do chassi. Isso evita repetir categoria,
  combustível e preço de tabela em cada veículo.
- **NEGOCIAÇÃO** é entidade própria, e não um atributo do automóvel, porque cada transação carrega
  dados próprios (data, hora, preço efetivamente pago) e porque o mesmo veículo pode ser negociado
  várias vezes ao longo do tempo.
- O vendedor de uma negociação pode ser pessoa física, revendedora ou fabricante — modelado por três
  chaves estrangeiras opcionais, resolvidas em consulta com `CASE`.

A tabela `automovel` foi analisada e está na **3ª Forma Normal**: todos os atributos não-chave
dependem diretamente de `numero_do_chassi`, e os atributos do modelo comercial vivem em `modelo`,
sem dependências transitivas.

## Destaques técnicos

**Trigger de regra de negócio** — quando uma negociação é inserida, o veículo correspondente deixa
automaticamente de constar como disponível em estoque:

```sql
CREATE TRIGGER trg_atualizar_estoque_apos_negociacao
AFTER INSERT ON negociacao
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_estoque_apos_negociacao();
```

**Índices e o otimizador** — foram criados índices secundários sobre `automovel(nome_modelo)` e
`negociacao(cpf_comprador)`, atributos usados em filtros e junções. Rodando `EXPLAIN`, o PostgreSQL
às vezes escolhe `Seq Scan` mesmo com o índice disponível: com poucas linhas, varrer a tabela inteira
custa menos que acessar o índice. Os índices continuam corretos do ponto de vista de projeto — o
ganho aparece conforme o volume cresce.

**`WITH CHECK OPTION`** — as views `vw_automoveis_usados` e `vw_revendedoras_autorizadas` recusam
um `UPDATE` que jogaria a linha para fora do filtro da própria view.

## Como rodar

Com um PostgreSQL disponível:

```bash
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/postgres ./run.sh
```

Ou, via Docker:

```bash
docker run --name pg-carros -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres:16
./run.sh
```

Alguns comandos **falham de propósito** e isso faz parte da demonstração: são os testes que provam
que `NOT NULL`, as chaves estrangeiras e o `WITH CHECK OPTION` estão de fato ativos. Eles estão
marcados com comentários nos arquivos.

## Observação sobre os dados

Todos os dados são fictícios, gerados para o trabalho. CPFs, CNPJs e chassis não correspondem a
pessoas, empresas ou veículos reais.
