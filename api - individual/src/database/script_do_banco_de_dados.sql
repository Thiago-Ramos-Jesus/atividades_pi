-- criação do banco de dados e das tabelas
-- drop database Omni_Textil;
CREATE DATABASE Omni_Textil;
USE Omni_Textil;

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR(45),
responsavel VARCHAR(70),
dtCadastro TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Tecido (
idTecido INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(15),
temperatura_max INT,
temperatura_min INT,
umidade_max INT,
umidade_min INT
);

CREATE TABLE Unidade (
idUnidade INT PRIMARY  KEY AUTO_INCREMENT,
nomeUnidade VARCHAR(15),
fkEmpresa INT,
FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
fkTecido INT,
FOREIGN KEY (fkTecido) REFERENCES Tecido(idTecido)
);

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
temperatura INT,
umidade INT,
data_hora DATETIME,
fkUnidade INT,
FOREIGN KEY (fkUnidade) REFERENCES Unidade(idUnidade)
);

CREATE TABLE Dados (
idDados INT PRIMARY KEY AUTO_INCREMENT,
temperatura INT,
umidade INT,
data_hora DATETIME,
fkUnidade INT,
fkSensor INT,
FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);

CREATE TABLE Usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80),
email VARCHAR(60),
senha VARCHAR(40),
cargo CHAR(5) constraint chkCargo check (cargo = 'ADMIN' or cargo = 'COMUM'),
dtCadastro TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
fkEmpresa INT,
FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
fkAdmin INT,
FOREIGN KEY (fkAdmin) REFERENCES Usuario(idUsuario)
);

insert into Empresa(nomeEmpresa,responsavel) value ('teste','Admin');

insert into Unidade(nomeUnidade,fkEmpresa) value ('unidade 1','1');

insert into Usuario(nome,email,senha,cargo,fkEmpresa) value ('Admin','admin@omni.com','admin','ADMIN',1);



-- -------------- *SELECTS GERAIS* --------------

-- -------------- SELECT DOS DADOS SEPARADAMENTE  --------------
SELECT * FROM Empresa;
SELECT * FROM Usuario;
SELECT * FROM Unidade;
SELECT * FROM Sensor;
SELECT * FROM Dados;


-- -------------- SELECT DO USUÁRIO --------------
-- select de todos os dados relacionando a empresa e o usuário
SELECT * FROM Usuario JOIN Empresa ON fkEmpresa=idEmpresa;

-- select de todos os dados para mostrar quem são os administradores
SELECT * FROM Usuario JOIN Usuario AS Administrador ON Administrador.fkAdmin = Usuario.idUsuario;

-- exibindo todos os usuários de uma determinada empresa
SELECT * FROM Usuario JOIN Empresa ON fkEmpresa = idEmpresa WHERE idEmpresa = 1;


-- -------------- SELECT DA UNIDADE --------------
-- select das unidades de todas as empresas
SELECT * FROM Unidade JOIN Empresa ON fkEmpresa=idEmpresa;

-- select das unidades de uma determinada empresa
SELECT * FROM Unidade JOIN Empresa ON fkEmpresa=idEmpresa WHERE idEmpresa = 1;

-- select das unidades e dos tecidos de todas as empresas
SELECT * FROM Unidade JOIN Empresa ON fkEmpresa = idEmpresa JOIN Tecido ON fkTecido = idTecido;

-- select das unidaes e dos tecidos de uma determinada unidade
SELECT * FROM Unidade JOIN Tecido ON fkTecido=idTecido WHERE idUnidade = 1;

-- select das unidades e dos tecidos de uma determinada empresa
SELECT * FROM Unidade JOIN Empresa ON fkEmpresa = idEmpresa JOIN Tecido ON fkTecido = idTecido WHERE idEmpresa = 1;


-- -------------- SELECT DO SENSOR --------------
-- mostrar os sensores de todas as unidades
SELECT * FROM Sensor JOIN Unidade ON fkUnidade = idUnidade;

-- mostrar os sensores de uma determinada unidade
SELECT * FROM Sensor JOIN Unidade ON fkUnidade = idUnidade WHERE idUnidade = 1;


-- -------------- SELECT DOS DADOS DOS SENSORES --------------
--  mostrar todos os dados dos sensores de todas as unidades
SELECT * FROM Dados JOIN Sensor ON fkSensor = idSensor;

--  mostrar todos os dados dos sensores de uma determinada unidade
SELECT * FROM Dados JOIN Sensor ON fkSensor = idSensor WHERE idSensor = 1;