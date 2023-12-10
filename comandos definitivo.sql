-- A) Criação de todas as tabelas, considerando todas as constraints:
-- A.1) Tabela Alunos:
CREATE TABLE Alunos (
    RA VARCHAR(6) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo VARCHAR(1) NOT NULL,
    escolaridade VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    CONSTRAINT aluno_cpf UNIQUE (CPF)
);

-- A.2) Tabela Professores:
CREATE TABLE Professores (
    id VARCHAR(6) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo VARCHAR(1) NOT NULL,
    titulacao VARCHAR(100),
    telefone VARCHAR(20) NOT NULL,
    CONSTRAINT professor_cpf UNIQUE (CPF)
);

-- A.3) Tabela Periodo_ofertas:
CREATE TABLE Periodo_ofertas (
    id SERIAL PRIMARY KEY,
    data_inicial DATE NOT NULL,
    data_final DATE NOT NULL
);

-- A.4) Tabela Cursos:
CREATE TABLE Cursos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    carga_horaria INT NOT NULL,
    status BOOLEAN NOT NULL DEFAULT true,
    professor_responsavel VARCHAR REFERENCES Professores(id),
    periodo_oferta_id INT REFERENCES Periodo_ofertas(id),
    CONSTRAINT curso_identificador UNIQUE (nome, periodo_oferta_id)
);

-- A.5) Tabela Matriculas:
CREATE TABLE Matriculas (
    aluno_ra VARCHAR REFERENCES Alunos(RA),
    curso_id INT REFERENCES Cursos(id),
    data_matricula DATE NOT NULL,
    nota1 DECIMAL(4, 2),
    nota2 DECIMAL(4, 2),
	nota_final DECIMAL (4, 2),
    resultado VARCHAR(20),
    PRIMARY KEY (aluno_ra, curso_id)
);

-- B) Criação de um campo e-mail para professor, de preenchimento obrigatório:
ALTER TABLE Professores
ADD COLUMN email VARCHAR(100) NOT NULL;

-- C) Insira um campo e-mail para aluno, também de preenchimento obrigatório:
ALTER TABLE Alunos
ADD COLUMN email VARCHAR(100) NOT NULL;

-- D) Criação de índices para os professores e alunos pelos seus CPFs:
-- D.1) Criação de índice para CPF na tabela Professores:
CREATE INDEX indice_professores_cpf ON Professores (CPF);

-- D.2) Criação de índice para CPF na tabela Alunos:
CREATE INDEX indice_alunos_cpf ON Alunos (CPF);

-- E) Inserção de vários registros em todas as tabelas:
-- E.1) Inserção de vários registros na tabela Alunos:
INSERT INTO Alunos (RA, nome, CPF, data_nascimento, sexo, escolaridade, telefone, email)
VALUES
    ('E13579', 'João da Silva', '123.456.789-01', '1995-01-12', 'M', 'Pós-Graduado', '(21) 92345-6789', 'silvajoao@hotmail.com'),
    ('E02468', 'Maria de Souza', '987.654.321-09', '2003-02-02', 'F', 'Ensino Superior Completo', '(47) 98765-4321', 'souzamaria@yahoo.com'),
	('E33006', 'Emmanuel de Freitas Ribeiro', '248.163.264-02', '2005-03-24', 'M', 'Ensino Superior Incompleto', '(24) 93579-2468', 'emmanuel@gmail.com'),
	('E10261', 'Washington Cardoso', '171.429.798-01', '1995-07-13', 'M', 'Pós-Graduado', '(21) 95271-6019', 'wc.95@hotmail.com'),
    ('E81624', 'Carla Regina Liberdade', '367.654.321-90', '2004-02-18', 'F', 'Ensino Superior Completo', '(47) 98912-4811', 'lib.carla@yahoo.com'),
	('E92837', 'Herlan Amaral', '728.181.264-15', '2004-11-25', 'M', 'Ensino Superior Incompleto', '(24) 93579-8153', 'a.herlan@gmail.com'),
	('P92016', 'Evellyn Soares', '572.016.462-21', '1985-04-04', 'F', 'Mestrado', '(94) 78263-9236', 'soaresevellyn@gmail.com'),
	('P01287', 'André de Oliveira', '251.824.093-54', '1971-07-14', 'M', 'Doutorado', '(32) 94020-8292', 'oliveiraandre@yahoo.com');

-- E.2) Inserção de vários registros na tabela Professores:
INSERT INTO Professores (id, nome, CPF, data_nascimento, sexo, titulacao, telefone, email)
VALUES
    ('P81637', 'Carlos de Andrade', '925.251.618-46', '1980-03-03', 'M', null, '(22) 92634-0264', 'andradecarlos@hotmail.com'),
    ('P92016', 'Evellyn Soares', '572.016.462-21', '1985-04-04', 'F', 'Mestrado', '(94) 78263-9236', 'soaresevellyn@gmail.com'),
	('P01287', 'André de Oliveira', '251.824.093-54', '1971-07-14', 'M', 'Doutorado', '(32) 94020-8292', 'oliveiraandre@yahoo.com'),
	('P91727', 'Márcia Cabral', '782.816.018-91', '1971-02-12', 'F', 'Mestrado', '(23) 81625-8612', 'm.cabral@gmail.com'),
	('P16437', 'Lucas Farias', '917.012.619-72', '1990-09-25', 'M', 'Mestre', '(57) 91725-1082', 'l.farias@yahoo.com'),
	('P45272', 'Luciana Tavares', '018.910.715-82', '1987-05-26', 'F', 'Doutorado', '(11) 97142-8154', 'l.tavares@hotmail.com');

-- E.3) Inserção de vários registros na tabela Periodo_ofertas:
INSERT INTO Periodo_ofertas (data_inicial, data_final)
VALUES
	('2022-02-01', '2022-04-30'),
	('2022-06-01', '2022-08-31'),
	('2022-10-01', '2022-12-23'),
	('2023-02-01', '2023-04-30'),
	('2023-06-01', '2023-08-31'),
	('2023-10-01', '2023-12-23'),
	('2024-02-01', '2024-04-30'),
	('2024-06-01', '2024-08-31'),
	('2024-10-01', '2024-12-23');

-- E.4) Inserção de vários registros na tabela Cursos:
INSERT INTO Cursos (nome, valor, carga_horaria, status, professor_responsavel, periodo_oferta_id)
VALUES
	('Escrita Criativa', 60.00, 120, false, 'P01287', 1),
	('História dos Povos Originários das Américas', 100.00, 200, false, 'P91727', 1),
	('Benefícios e Aplicações dos Esportes na Terceira Idade', 90.00, 150, false, 'P45272', 2),
	('Libras', 70.00, 120, false, 'P16437', 2),
	('Programação em Python', 150.00, 200, false, 'P81637', 3),
	('Aplicações e Benefícios da Medicina Natural', 210.00, 300, false, 'P92016', 3),
    ('Data Science', 170.00, 160, true, 'P81637', 4),
    ('GitHub', 80.00, 100, true, 'P81637', 4),
	('Biotecnologia na saúde', 240.00, 200, true, 'P92016', 5),
	('Procedimentos em animais de Grande Porte', 300.00, 280, true, 'P92016', 5),
	('Soft Skills na era da IA', 140.00, 140, true, 'P91727', 6),
	('Biotecnologia na saúde', 190.00, 150, true, 'P92016', 6),
	('Microsoft Power BI', 180.00, 170, true, 'P81637', 7),
    ('Hacking Ético', 110.00, 140, true, 'P81637', 7),
	('Gestão de Projetos - Liderança Eficiente', 160.00, 150, true, 'P91727', 8),
	('Inglês para TI', 200.00, 160, false, 'P01287', 8),
	('Leitura Dinâmica', 100.00, 120, false, 'P91727', 9),
	('Programação Neurolinguística', 200.00, 220, false, 'P01287', 9);
	
-- E.5) Inserção de vários registros na tabela Matriculas:
INSERT INTO Matriculas (aluno_ra, curso_id, data_matricula, nota1, nota2, nota_final, resultado)
VALUES
    ('E13579', 7, '2023-01-01', 8.5, 7.5, 8, 'Aprovado'),
	('E02468', 8, '2023-01-01', 8, 4, 6, 'Reprovado'),
	('E33006', 9, '2023-05-01', 9, 9.5, 9.25, 'Aprovado'),
	('E10261', 10, '2023-05-01', 8.5, 7.5, 8, 'Aprovado'),
	('E81624', 8, '2023-01-01', 8, 8, 8, 'Aprovado'),
	('E92837', 10, '2023-05-01', 5, 7, 6, 'Reprovado'),
	('P92016', 11, '2023-09-01', 8.5, 9.5, 9, 'Aprovado'),
	('P01287', 9, '2023-05-01', 9, 9, 9, 'Aprovado');
	
-- F) Altere eventuais cadastros de professores cuja titulação esteja como “Mestre” para “Mestrado”:
UPDATE Professores
SET titulacao = 'Mestrado'
WHERE titulacao = 'Mestre';

-- G) Como o projeto teve início em 2023, desconsiderando eventuais restrições, exclua os períodos letivos de anos anteriores:
-- G.1) Exclusão dos cursos anteriores a 2023 para posterior exclusão dos Períodos, devido à violação da restrição de chave estrangeira na tabela "Cursos":
DELETE FROM Cursos
WHERE periodo_oferta_id < 4;
-- G.2) Exclusão dos períodos anteriores a 2023:
DELETE FROM Periodo_ofertas
WHERE EXTRACT(YEAR FROM data_inicial) < 2023;

-- H) Para uma campanha de saúde da mulher, é necessário listar todos as alunas em ordem alfabética (ra, nome e e-mail):
SELECT RA, nome, email
FROM Alunos
WHERE sexo = 'F'
ORDER BY nome;

-- I) Listar todos os professores que tenham sua titulação não preenchida:
SELECT * FROM Professores
WHERE titulacao IS NULL;

-- J) Como exemplo de relatório, listar ra, nome e cpf e data de matrícula de todos os alunos matriculados em um curso específico, listando o nome e carga horária do mesmo:
SELECT M.aluno_ra, A.nome, A.CPF, M.data_matricula, C.nome AS curso, C.carga_horaria
FROM Matriculas M
JOIN Alunos A ON M.aluno_ra = A.RA
JOIN Cursos C ON M.curso_id = C.id
WHERE C.nome = 'Procedimentos em animais de Grande Porte';

-- K) Em outro, listar todos o nome do curso , carga_horária, valor, nome do professor e titulação do professor de todos os curso ofertados em um determinado período:
SELECT C.nome AS curso, C.carga_horaria, C.valor, P.nome AS professor, P.titulacao FROM Cursos C
JOIN Professores P ON C.professor_responsavel = P.id
WHERE C.periodo_oferta_id = 6;

-- L) Como é comum em homenagens, listar nome e e-mail de todos os alunos de um professor específico:
SELECT A.nome, A.email FROM Alunos A
JOIN Matriculas M ON A.RA = M.aluno_ra
JOIN Cursos C ON M.curso_id = C.id
WHERE C.professor_responsavel = 'P92016';

-- M) Gerar o boletim do aluno, com ra, nome, cpf do aluno, nome do curso, nota final e resultado final de todos os alunos aprovados:
SELECT A.RA, A.nome, A.CPF, C.nome AS curso, M.nota_final AS nota_final_boletim, M.resultado FROM Matriculas M
JOIN Alunos A ON M.aluno_ra = A.RA
JOIN Cursos C ON M.curso_id = C.id
WHERE M.resultado = 'Aprovado';

-- N) Listar a quantidade de alunos por curso em um determinado período de oferta:
SELECT C.nome AS curso, COUNT(M.aluno_ra) AS quantidade_alunos FROM Cursos C
JOIN Matriculas M ON C.id = M.curso_id
WHERE C.periodo_oferta_id = 5
GROUP BY C.nome;

-- O) Informar o valor do curso mais caro, do curso mais barato e o valor médio dos cursos:
SELECT MAX(valor) AS curso_mais_caro, MIN(valor) AS curso_mais_barato, AVG(valor) AS valor_medio FROM Cursos;

-- P) Informar o ticket médio dos cursos em um determinado período de oferta:
SELECT AVG(valor) AS ticket_medio FROM Cursos
WHERE periodo_oferta_id = 4;

-- Q) Para incentivo do corpo docente, listar nome e cpf de todos os professores que nunca foram alunos dos cursos ofertados:
SELECT p.nome, p.CPF
FROM Professores p
WHERE NOT EXISTS (
    SELECT 1
    FROM Matriculas m
    INNER JOIN Cursos c ON m.curso_id = c.id
    WHERE m.aluno_ra = p.id
);

-- R) Listar a quantidade de alunos do sexo masculino e a quantidade de alunos do sexo feminino matriculados nos cursos cuja mensalidade está acima do valor médio de todos os curso:
SELECT SUM(CASE WHEN A.sexo = 'M' THEN 1 ELSE 0 END) AS quantidade_masculino,
       SUM(CASE WHEN A.sexo = 'F' THEN 1 ELSE 0 END) AS quantidade_feminino
FROM Alunos A
JOIN Matriculas M ON A.RA = M.aluno_ra
JOIN Cursos C ON M.curso_id = C.id
WHERE C.valor > (SELECT AVG(valor) FROM Cursos);


-- 1) Comandos para exibição dos registros das tabelas por completo:
SELECT * FROM Alunos;
SELECT * FROM Professores ORDER BY id;
SELECT * FROM Cursos;
SELECT * FROM Matriculas;
SELECT * FROM Periodo_ofertas;

-- 2) Comandos para exclusão dos registros das tabelas por completo:
DELETE FROM Alunos
DELETE FROM Professores
DELETE FROM Cursos
DELETE FROM Matriculas
DELETE FROM Periodo_ofertas