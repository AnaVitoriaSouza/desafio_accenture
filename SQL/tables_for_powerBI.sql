
--Criação da Tabela transacoes_fraude_entradas
CREATE TABLE transacoes_fraude_entradas (
id int IDENTITY(1,1) PRIMARY KEY, 
cliente_id int NOT NULL, 
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
nome varchar(255) NOT NULL
) 

-- Inserir dados na tabela transacoes_fraude_entradas
INSERT INTO transacoes_fraude_entradas (cliente_id , nome)
SELECT C.cliente_id, C.nome
from entradas E1
inner join entradas E2 
ON E1.cliente_id = E2.cliente_id and 
DATEDIFF(SECOND,E1.data, E2.data) > 0 and 
DATEDIFF(SECOND,E1.data, E2.data) < 120 
INNER JOIN clientes C
ON E1.cliente_id = C.cliente_id


--------------------------------------------------------------------------------------------------------------------

--Criação da Tabela transacoes_fraude_saidas
CREATE TABLE transacoes_fraude_saidas (
id int IDENTITY(1,1) PRIMARY KEY, 
cliente_id int NOT NULL, 
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
nome varchar(255) NOT NULL
) 

-- Inserir dados na tabela transacoes_fraude_saidas
INSERT INTO transacoes_fraude_saidas (cliente_id , nome)
SELECT C.cliente_id, C.nome
from saidas S1
inner join saidas S2 
ON S1.cliente_id = S2.cliente_id and 
DATEDIFF(SECOND,S1.data, S2.data) > 0 and 
DATEDIFF(SECOND,S1.data, S2.data) < 120 
INNER JOIN clientes C
ON S1.cliente_id = C.cliente_id

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- Criando a tabela de fraudes_entradas
CREATE TABLE fraudes_entradas (
	id int IDENTITY(1,1) PRIMARY KEY,
	cliente_id int,
	FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
	nome varchar(255) NOT NULL, 
	telefone varchar(20) NOT NULL, 
	email varchar(255)
)


-- Inserção de clientes, nome, telefone, email na tabela fraudes_entradas:
INSERT INTO fraudes_entradas (cliente_id , nome, telefone, email)
SELECT DISTINCT(C.cliente_id), C.nome, C.telefone, C.email
from entradas E1
inner join entradas E2 
ON E1.cliente_id = E2.cliente_id and 
DATEDIFF(SECOND,E1.data, E2.data) > 0 and 
DATEDIFF(SECOND,E1.data, E2.data) < 120 
INNER JOIN clientes C
ON E1.cliente_id = C.cliente_id

--------------------------------------------------------------------------------------------------------------------

-- Criando a tabela de fraudes_saida
CREATE TABLE fraudes_saidas (
	id int IDENTITY(1,1) PRIMARY KEY,
	cliente_id int,
	FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
	nome varchar(255) NOT NULL, 
	telefone varchar(20) NOT NULL, 
	email varchar(255)
)


-- Inserção de clientes, nome, telefone, email na tabela de fraudes_saida:
INSERT INTO fraudes_saidas(cliente_id , nome, telefone, email)
SELECT DISTINCT(C.cliente_id), C.nome, C.telefone, C.email
from saidas S1
inner join saidas S2 
ON S1.cliente_id = S2.cliente_id and 
 
DATEDIFF(SECOND,S1.data, S2.data) < 120 
INNER JOIN clientes C
ON S1.cliente_id = C.cliente_id
