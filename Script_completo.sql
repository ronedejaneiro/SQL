 PROJETO: Sistema de Gerenciamento de Fornecedores e Peças

CREATE TABLE fornecedores (
    fid INT NOT NULL PRIMARY KEY,
    fnome VARCHAR(20) NOT NULL,
    ende VARCHAR(50) NOT NULL
);

CREATE TABLE pecas (
    pid INT PRIMARY KEY,
    pnome VARCHAR(20) NOT NULL,
    cor VARCHAR(20) NOT NULL
);

CREATE TABLE catalogo (
    fid INT NOT NULL,
    pid INT NOT NULL,
    preco REAL NOT NULL,
    PRIMARY KEY (pid, fid),
    FOREIGN KEY (pid) REFERENCES pecas(pid),
    FOREIGN KEY (fid) REFERENCES fornecedores(fid)
);



INSERT INTO fornecedores (fid, fnome, ende) VALUES
(1, 'Tech Solutions Ltda.', 'Rua A, 123, SP'),
(2, 'Componentes Premium', 'Av. B, 456, RJ'),
(3, 'Peças de Qualidade', 'Travessa C, 789, MG'),
(4, 'Metalúrgica Fenix', 'Rua D, 101, RS'),
(5, 'Eletrônicos Modernos', 'Av. E, 202, BA'),
(6, 'Sem Estoque S.A.', 'Rua F, 303, DF');

INSERT INTO pecas (pid, pnome, cor) VALUES
(101, 'Parafuso', 'prata'),
(102, 'Engrenagem', 'vermelha'),
(103, 'Cabo', 'azul'),
(104, 'Mola', 'preta'),
(105, 'Placa de Circuito', 'verde'),
(106, 'LED', 'vermelha'),
(107, 'Resistor', 'marrom'),
(108, 'Eixo', 'prata'),
(109, 'Carcaça', 'vermelha'),
(110, 'Sensor', 'branco');

INSERT INTO catalogo (fid, pid, preco) VALUES
(1, 101, 10.00),
(1, 102, 25.50),
(1, 103, 5.00),
(2, 104, 50.00),
(2, 106, 15.00),
(3, 105, 100.00),
(3, 107, 150.00),
(4, 108, 20.00),
(4, 109, 100.00),
(5, 110, 150.00);



-- Q1: Obter o nome dos fornecedores que fornecem alguma peça vermelha.
SELECT DISTINCT f.fnome
FROM fornecedores f 
JOIN catalogo c ON f.fid = c.fid 
JOIN pecas p ON c.pid = p.pid
WHERE p.cor = 'vermelha';

-- Q2: Fornecedores que fornecem peças com preço de 100 ou 150.
SELECT DISTINCT f.fnome
FROM fornecedores f 
JOIN catalogo c ON f.fid = c.fid 
WHERE c.preco IN (100, 150);

-- Q3: FID dos fornecedores que fornecem peça vermelha OU peça com preço 150.
SELECT DISTINCT f.fid
FROM fornecedores f 
JOIN catalogo c ON f.fid = c.fid 
JOIN pecas p ON c.pid = p.pid
WHERE p.cor = 'vermelha' OR c.preco = 150;

-- Q4: FID dos fornecedores que fornecem alguma peça vermelha E alguma peça verde.
-- Utilizando a lógica de interseção para garantir que ambas as condições sejam atendidas.
SELECT c.fid
FROM catalogo c JOIN pecas p ON c.pid = p.pid
WHERE p.cor = 'vermelha'
INTERSECT
SELECT c.fid
FROM catalogo c JOIN pecas p ON c.pid = p.pid
WHERE p.cor = 'verde';

-- Q5: Nome das peças que possuem pelo menos um fornecedor.
SELECT DISTINCT p.pnome
FROM pecas p 
JOIN catalogo c ON p.pid = c.pid;
