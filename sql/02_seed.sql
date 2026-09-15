-- Dados de teste (ficticios, gerados para o trabalho)
-- FABRICANTE

INSERT INTO fabricante (nome, pais_origem, website) VALUES
('Fiat','Itália','https://www.fiat.com.br'),
('Hyundai','Coreia do Sul','https://www.hyundai.com.br'),
('Toyota','Japão','https://www.toyota.com.br'),
('Volkswagen','Alemanha','https://www.vw.com.br'),
('BYD','China','https://www.byd.com.br');

-- MODELO

INSERT INTO modelo (nome, categoria, tipo_combustivel, preco_tabela, nome_fabricante) VALUES
('Strada','Picape','Flex',115000.00,'Fiat'),
('Argo','Hatch','Flex',92000.00,'Fiat'),
('Pulse','SUV','Flex',130000.00,'Fiat'),
('HB20','Hatch','Flex',89000.00,'Hyundai'),
('HB20S','Sedan','Flex',98000.00,'Hyundai'),
('Creta','SUV','Flex',175000.00,'Hyundai'),
('Corolla','Sedan','Flex',185000.00,'Toyota'),
('Hilux','Picape','Diesel',280000.00,'Toyota'),
('Yaris','Hatch','Flex',115000.00,'Toyota'),
('Polo','Hatch','Flex',102000.00,'Volkswagen'),
('Virtus','Sedan','Flex',112000.00,'Volkswagen'),
('T-Cross','SUV','Flex',165000.00,'Volkswagen'),
('BYD Dolphin','Hatch','Elétrico',175000.00,'BYD'),
('BYD Seal','Sedan','Elétrico',280000.00,'BYD'),
('BYD King','Picape','Híbrido',380000.00,'BYD');

-- PESSOA

INSERT INTO pessoa (cpf, nome, sobrenome, endereco, data_nascimento) VALUES
('74583317042','Carlos','Oliveira','Rua das Flores, 123, São Paulo, SP','1985-03-12'),
('71413480004','Mariana','Santos','Av. Brasil, 456, Rio de Janeiro, RJ','1992-07-24'),
('72594383040','Fernando','Lima','Rua XV de Novembro, 789, Curitiba, PR','1978-11-05'),
('00984573062','Beatriz','Ferreira','Av. Paulista, 1000, São Paulo, SP','1990-01-30'),
('50578875055','Rafael','Costa','Rua do Comércio, 55, Belo Horizonte, MG','1988-09-18'),
('42376707080','Lucas','Mendes','Rua Augusta, 321, São Paulo, SP','1993-04-15'),
('71507653000','Juliana','Rodrigues','Av. Atlântica, 780, Rio de Janeiro, RJ','1987-08-22'),
('05105205022','Thiago','Almeida','Rua Marechal, 45, Porto Alegre, RS','1995-12-03'),
('74483510010','Camila','Barbosa','Av. Afonso Pena, 900, Belo Horizonte, MG','1991-06-17'),
('96509612089','Gustavo','Pereira','Rua XV de Novembro, 200, Curitiba, PR','1983-02-28'),
('93122083060','Fernanda','Gomes','Av. Boa Viagem, 1500, Recife, PE','1989-10-11'),
('29906280026','Rodrigo','Martins','Rua Consolação, 600, São Paulo, SP','1996-03-07'),
('35331417051','Patrícia','Nascimento','Av. Beira Mar, 300, Fortaleza, CE','1984-07-19'),
('42834063095','Eduardo','Cardoso','Rua das Acácias, 88, Campinas, SP','1990-11-25'),
('82391531001','Vanessa','Teixeira','Av. Sete de Setembro, 1200, Curitiba, PR','1994-01-08');

-- REVENDEDORA

INSERT INTO revendedora (cnpj, nome_oficial, nome_fantasia, cidade, estado, endereco, status_autorizacao) VALUES
('21812525000100','Oliveira Veículos Ltda','OliCars','São Paulo','SP','Av. Paulista, 2000','autorizada'),
('31126820000158','Santos Automóveis S.A.','SantosAuto','Rio de Janeiro','RJ','Rua da Carioca, 300','autorizada'),
('65768604000128','Lima Motors Comércio Ltda','LimaMotors','Curitiba','PR','Av. Sete de Setembro, 450','autorizada'),
('20845235000191','Ferreira & Cia Veículos','FerreiraCars','Belo Horizonte','MG','Rua dos Carijós, 120','autorizada'),
('15819445000175','Costa Automóveis Ltda','CostaAuto','Porto Alegre','RS','Av. Ipiranga, 678','autorizada'),
('60649084000110','Mendes Veículos Ltda','MendesCars','São Paulo','SP','Rua Augusta, 500','autorizada'),
('73196385000188','Rodrigues Auto Ltda','RodriguesAuto','Rio de Janeiro','RJ','Av. Brasil, 1200','autorizada'),
('22570782000137','Almeida Motors S.A.','AlmeidaMotors','Porto Alegre','RS','Av. Ipiranga, 900','autorizada'),
('30623332000193','Barbosa Veículos Ltda','BarbosaCars','Belo Horizonte', 'MG','Rua Tupis, 340','autorizada'),
('98403274000126','Pereira Automóveis Ltda','PereiraAuto','Curitiba','PR','Av. República, 780','autorizada'),
('22111877000192','Gomes & Filhos Veículos','GomesCars','Recife','PE','Rua do Sol, 230','autorizada'),
('44705737000185','Martins Comércio de Autos','MartinsAuto','Brasília','DF','SCS Quadra 3, Bloco A','autorizada'),
('12106063000106','Nascimento Veículos S.A.','NascimentoCars','Fortaleza','CE','Av. Monsenhor Tabosa, 600','autorizada'),
('41946241000105','Cardoso Motors Ltda','CardosoMotors','Campinas','SP','Rua Campos Sales, 150','autorizada'),
('40920536000140','Teixeira Automóveis Ltda','TeixeiraAuto','Curitiba','PR','Rua Emiliano Perneta, 420','autorizada');

-- POSSUI

INSERT INTO possui (cpf, cnpj) VALUES
('74583317042', '21812525000100'),
('71413480004', '31126820000158'),
('72594383040', '65768604000128'),
('00984573062', '20845235000191'),
('50578875055', '15819445000175'),
('42376707080', '60649084000110'),
('71507653000', '73196385000188'),
('05105205022', '22570782000137'),
('74483510010', '30623332000193'),
('96509612089', '98403274000126'),
('93122083060', '22111877000192'),
('29906280026', '44705737000185'),
('35331417051', '12106063000106'),
('42834063095', '41946241000105'),
('82391531001', '40920536000140');

-- AUTOMOVEL

INSERT INTO automovel (numero_do_chassi, quilometragem, ano_fabricacao, possui_ar, tracao, cor, tipo_cambio, condicao, preco_referencia_fipe, nome_modelo) VALUES
('9BWZZZ377VT004251',45000, 2021, TRUE,  FALSE, 'Branco','Manual','usado',85000.00,'Strada'),
('9BWZZZ377VT004252',12000,2023,TRUE,FALSE,'Prata','Automático','seminovo',87000.00,'HB20'),
('9BWZZZ377VT004253',0,2024,TRUE,FALSE,'Preto','Automático','novo',185000.00,'Corolla'),
('9BWZZZ377VT004254',78000,2019,FALSE,FALSE,'Vermelho','Manual','usado',72000.00,'Polo'),
('9BWZZZ377VT004255',5000,2024,TRUE,FALSE,'Azul','Automático','seminovo',168000.00,'BYD Dolphin'),
('9BWZZZ377VT004256',8000,2023, TRUE,FALSE,'Branco','Automático','seminovo',88000.00,'Argo'),
('9BWZZZ377VT004257',32000,2022,TRUE,FALSE,'Cinza','Automático','usado',118000.00,'Pulse'),
('9BWZZZ377VT004258',0,2024,TRUE,FALSE,'Prata','Automático','novo',175000.00,'Creta'),
('9BWZZZ377VT004259',15000,2023,TRUE,FALSE,'Branco','Manual','seminovo',92000.00,'HB20S'),
('9BWZZZ377VT004260',60000,2020,TRUE,TRUE,'Preto','Automático','usado',230000.00,'Hilux'),
('9BWZZZ377VT004261', 22000,2022,TRUE,FALSE,'Vermelho','Automático','usado',108000.00,'Yaris'),
('9BWZZZ377VT004262',0,2024,TRUE,FALSE,'Prata','Automático','novo',112000.00,'Virtus'),
('9BWZZZ377VT004263',5000,2024,TRUE,FALSE,'Azul','Automático','seminovo',158000.00,'T-Cross'),
('9BWZZZ377VT004264',3000,2024,TRUE,FALSE,'Branco','Automático','seminovo',265000.00,'BYD Seal'),
('9BWZZZ377VT004265',0,2025,TRUE,TRUE,'Preto','Automático','novo',380000.00,'BYD King');

-- ESTOQUE

INSERT INTO estoque (status_disponibilidade, data_entrada, prazo_entrega, localizacao_veiculo, numero_do_chassi, cnpj_revendedora, nome_fabricante) VALUES
('disponivel','2024-01-10',NULL,'Pátio A - Vaga 01','9BWZZZ377VT004251','21812525000100',NULL),
('disponivel','2024-02-15',NULL,'Pátio B - Vaga 03','9BWZZZ377VT004252','31126820000158',NULL),
('reservado','2024-03-01',30,'Fábrica Toyota SP','9BWZZZ377VT004253','65768604000128','Toyota'),
('disponivel','2023-11-20',NULL,'Pátio C - Vaga 07','9BWZZZ377VT004254','20845235000191',NULL),
('disponivel','2024-04-05',NULL,'Pátio A - Vaga 12','9BWZZZ377VT004255','15819445000175',NULL),
('disponivel','2024-02-01',NULL,'Pátio A - Vaga 02','9BWZZZ377VT004256','60649084000110',NULL),
('disponivel','2024-03-10',NULL,'Pátio B - Vaga 05','9BWZZZ377VT004257','73196385000188',NULL),
('reservado','2024-04-01',20,'Fábrica Hyundai SP','9BWZZZ377VT004258','22570782000137','Hyundai'),
('disponivel','2024-01-20',NULL,'Pátio C - Vaga 02','9BWZZZ377VT004259','30623332000193',NULL),
('disponivel','2024-02-28',NULL,'Pátio A - Vaga 08','9BWZZZ377VT004260','98403274000126',NULL),
('disponivel','2024-03-15',NULL,'Pátio B - Vaga 11','9BWZZZ377VT004261','22111877000192',NULL),
('reservado','2024-04-10',15,'Fábrica VW SP','9BWZZZ377VT004262','44705737000185','Volkswagen'),
('disponivel','2024-04-20',NULL,'Pátio A - Vaga 15','9BWZZZ377VT004263','12106063000106',NULL),
('disponivel','2024-05-01',NULL,'Pátio C - Vaga 09','9BWZZZ377VT004264','41946241000105',NULL),
('reservado','2024-05-05',45,'Fábrica BYD SP','9BWZZZ377VT004265','40920536000140','BYD');

-- REVISAO

INSERT INTO revisao (data_revisao, quilometragem_revisao, descricao, numero_do_chassi) VALUES
('2023-06-10',30000,'Troca de óleo, filtros e revisão geral','9BWZZZ377VT004251'),
('2023-12-05',10000,'Revisão de 10.000 km, alinhamento e balanceamento','9BWZZZ377VT004252'),
('2022-08-20',50000,'Troca de pastilhas de freio e revisão completa','9BWZZZ377VT004251'),
('2023-03-14',70000,'Troca de correia dentada e fluido de freio','9BWZZZ377VT004254'),
('2024-01-30',4000,'Primeira revisão de garantia','9BWZZZ377VT004255'),
('2024-01-15',7000,'Revisão de 7.000 km e troca de óleo','9BWZZZ377VT004256'),
('2023-11-20',30000,'Troca de pastilhas e alinhamento','9BWZZZ377VT004257'),
('2023-06-10',55000,'Revisão completa e troca de correia','9BWZZZ377VT004260'),
('2023-09-05',20000,'Troca de óleo e filtros','9BWZZZ377VT004261'),
('2024-02-28',4500,'Primeira revisão de garantia','9BWZZZ377VT004263'),
('2024-03-10',2500,'Revisão de entrega e checklist completo','9BWZZZ377VT004264'),
('2023-08-22',40000,'Troca de fluido de freio e revisão geral','9BWZZZ377VT004256'),
('2024-01-30',17000,'Alinhamento, balanceamento e troca de óleo','9BWZZZ377VT004252'),
('2024-02-15',8000,'Revisão de 8.000 km','9BWZZZ377VT004259'),
('2023-07-19',50000,'Troca de embreagem e revisão completa','9BWZZZ377VT004254');

-- NEGOCIACAO

INSERT INTO negociacao (data_negociacao, hora_negociacao, preco_pago, numero_do_chassi, cpf_comprador, cpf_vendedor, cnpj_revendedora_vendedora, nome_fabricante_vendedor) VALUES
('2024-01-15','10:30:00',83000.00,'9BWZZZ377VT004251','71413480004',NULL,'21812525000100',NULL),
('2024-02-20','14:00:00',86500.00,'9BWZZZ377VT004252','72594383040',NULL,'31126820000158',NULL),
('2024-03-10','09:15:00',184000.00,'9BWZZZ377VT004253','00984573062',NULL,NULL,'Toyota'),
('2024-03-25','16:45:00',70000.00,'9BWZZZ377VT004254','50578875055','74583317042', NULL,NULL),
('2024-04-12','11:00:00',165000.00,'9BWZZZ377VT004255','74583317042',NULL,'15819445000175',NULL),
('2024-02-05','09:00:00',87000.00,'9BWZZZ377VT004256','42376707080',NULL,'60649084000110',NULL),
('2024-03-15','14:30:00',116000.00,'9BWZZZ377VT004257','71507653000',NULL,'73196385000188',NULL),
('2024-04-02','10:00:00',173000.00,'9BWZZZ377VT004258','05105205022',NULL,NULL,'Hyundai'),
('2024-02-10','15:00:00',91000.00,'9BWZZZ377VT004259','74483510010','42376707080', NULL,NULL),
('2024-03-01','11:30:00',228000.00,'9BWZZZ377VT004260','96509612089',NULL,'98403274000126',NULL),
('2024-03-20','16:00:00',106000.00,'9BWZZZ377VT004261','93122083060','71507653000', NULL,NULL),
('2024-04-12','09:30:00',110000.00,'9BWZZZ377VT004262','29906280026',NULL,NULL,'Volkswagen'),
('2024-04-25','13:00:00',155000.00,'9BWZZZ377VT004263','35331417051',NULL,'12106063000106',NULL),
('2024-05-03','10:45:00',263000.00,'9BWZZZ377VT004264','42834063095',NULL,'41946241000105',NULL),
('2024-05-10','14:00:00',63000.00,'9BWZZZ377VT004254','82391531001','50578875055', NULL,NULL);
