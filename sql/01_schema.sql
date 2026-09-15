-- Esquema: criacao das tabelas, chaves e constraints
CREATE TABLE fabricante (
    nome VARCHAR(80) NOT NULL,
    pais_origem VARCHAR(50) NOT NULL,
    website VARCHAR(150)
);

CREATE TABLE modelo (
    nome VARCHAR(80) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    tipo_combustivel VARCHAR(30) NOT NULL,
    preco_tabela DECIMAL(12, 2),
    nome_fabricante VARCHAR(80) NOT NULL
);

CREATE TABLE automovel (
    numero_do_chassi VARCHAR(30) NOT NULL,
    quilometragem INTEGER NOT NULL DEFAULT 0,
    ano_fabricacao SMALLINT NOT NULL,
    possui_ar BOOLEAN NOT NULL DEFAULT FALSE,
    tracao BOOLEAN NOT NULL DEFAULT FALSE,
    cor VARCHAR(40),
    tipo_cambio VARCHAR(30),
    condicao VARCHAR(20) NOT NULL,
    preco_referencia_fipe DECIMAL(12, 2),
    nome_modelo VARCHAR(80) NOT NULL
);

CREATE TABLE pessoa (
    cpf CHAR(11) NOT NULL,
    nome VARCHAR(80) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150),
    data_nascimento DATE NOT NULL
);

CREATE TABLE revendedora (
    cnpj CHAR(14) NOT NULL,
    nome_oficial VARCHAR(120) NOT NULL,
    nome_fantasia VARCHAR(120),
    cidade VARCHAR(80) NOT NULL,
    estado CHAR(2) NOT NULL,
    endereco VARCHAR(150),
    status_autorizacao VARCHAR(30) NOT NULL
);

CREATE TABLE possui (
    cpf CHAR(11) NOT NULL,
    cnpj CHAR(14) NOT NULL
);

CREATE TABLE estoque (
    id_estoque SERIAL,
    status_disponibilidade VARCHAR(30) NOT NULL,
    data_entrada DATE NOT NULL,
    prazo_entrega INTEGER,
    localizacao_veiculo VARCHAR(150),
    numero_do_chassi VARCHAR(30) NOT NULL,
    cnpj_revendedora CHAR(14) NOT NULL,
    nome_fabricante VARCHAR(80)
);

CREATE TABLE revisao (
    id_revisao SERIAL,
    data_revisao DATE NOT NULL,
    quilometragem_revisao INTEGER NOT NULL,
    descricao TEXT,
    numero_do_chassi VARCHAR(30) NOT NULL
);

CREATE TABLE negociacao (
    id_negociacao SERIAL,
    data_negociacao DATE NOT NULL,
    hora_negociacao TIME NOT NULL,
    preco_pago DECIMAL(12, 2) NOT NULL,
    numero_do_chassi VARCHAR(30) NOT NULL,
    cpf_comprador CHAR(11) NOT NULL,
    cpf_vendedor CHAR(11),
    cnpj_revendedora_vendedora CHAR(14),
    nome_fabricante_vendedor VARCHAR(80)
);

-- ## Criando PK via ALTER TABLE

ALTER TABLE
    fabricante
ADD
    CONSTRAINT pk_fabricante PRIMARY KEY (nome);

ALTER TABLE
    modelo
ADD
    CONSTRAINT pk_modelo PRIMARY KEY (nome);

ALTER TABLE
    automovel
ADD
    CONSTRAINT pk_automovel PRIMARY KEY (numero_do_chassi);

ALTER TABLE
    pessoa
ADD
    CONSTRAINT pk_pessoa PRIMARY KEY (cpf);

ALTER TABLE
    revendedora
ADD
    CONSTRAINT pk_revendedora PRIMARY KEY (cnpj);

ALTER TABLE
    possui
ADD
    CONSTRAINT pk_possui PRIMARY KEY (cpf, cnpj);

ALTER TABLE
    estoque
ADD
    CONSTRAINT pk_estoque PRIMARY KEY (id_estoque);

ALTER TABLE
    revisao
ADD
    CONSTRAINT pk_revisao PRIMARY KEY (id_revisao);

ALTER TABLE
    negociacao
ADD
    CONSTRAINT pk_negociacao PRIMARY KEY (id_negociacao);

-- ## Criando as FKs via ALTER TABLE

ALTER TABLE
    modelo
ADD
    CONSTRAINT fk_modelo_fabricante FOREIGN KEY (nome_fabricante) REFERENCES fabricante(nome);

ALTER TABLE
    automovel
ADD
    CONSTRAINT fk_automovel_modelo FOREIGN KEY (nome_modelo) REFERENCES modelo(nome);

ALTER TABLE
    possui
ADD
    CONSTRAINT fk_possui_pessoa FOREIGN KEY (cpf) REFERENCES pessoa(cpf);

ALTER TABLE
    possui
ADD
    CONSTRAINT fk_possui_revendedora FOREIGN KEY (cnpj) REFERENCES revendedora(cnpj);

ALTER TABLE
    estoque
ADD
    CONSTRAINT fk_estoque_automovel FOREIGN KEY (numero_do_chassi) REFERENCES automovel(numero_do_chassi);

ALTER TABLE
    estoque
ADD
    CONSTRAINT fk_estoque_revendedora FOREIGN KEY (cnpj_revendedora) REFERENCES revendedora(cnpj);

ALTER TABLE
    estoque
ADD
    CONSTRAINT fk_estoque_fabricante FOREIGN KEY (nome_fabricante) REFERENCES fabricante(nome);

ALTER TABLE
    revisao
ADD
    CONSTRAINT fk_revisao_automovel FOREIGN KEY (numero_do_chassi) REFERENCES automovel(numero_do_chassi);

ALTER TABLE
    negociacao
ADD
    CONSTRAINT fk_negociacao_automovel FOREIGN KEY (numero_do_chassi) REFERENCES automovel(numero_do_chassi);

ALTER TABLE
    negociacao
ADD
    CONSTRAINT fk_negociacao_comprador FOREIGN KEY (cpf_comprador) REFERENCES pessoa(cpf);

ALTER TABLE
    negociacao
ADD
    CONSTRAINT fk_negociacao_vendedor_pf FOREIGN KEY (cpf_vendedor) REFERENCES pessoa(cpf);

ALTER TABLE
    negociacao
ADD
    CONSTRAINT fk_negociacao_vendedor_rev FOREIGN KEY (cnpj_revendedora_vendedora) REFERENCES revendedora(cnpj);

ALTER TABLE
    negociacao
ADD
    CONSTRAINT fk_negociacao_vendedor_fab FOREIGN KEY (nome_fabricante_vendedor) REFERENCES fabricante(nome);

-- ## Dando check de domínio

ALTER TABLE automovel
ADD CONSTRAINT ck_automovel_quilometragem
CHECK (quilometragem >= 0);

ALTER TABLE automovel
ADD CONSTRAINT ck_automovel_condicao
CHECK (condicao IN ('novo', 'seminovo', 'usado'));

ALTER TABLE negociacao
ADD CONSTRAINT ck_negociacao_preco_pago
CHECK (preco_pago > 0);

ALTER TABLE modelo
ADD CONSTRAINT ck_modelo_preco_tabela
CHECK (preco_tabela IS NULL OR preco_tabela > 0);

ALTER TABLE revisao
ADD CONSTRAINT ck_revisao_quilometragem
CHECK (quilometragem_revisao >= 0);
