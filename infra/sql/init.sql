-- CREATE ALUNO - TRIGGER - FUNCTION

CREATE SEQUENCE seq_ra START 1;

CREATE TABLE Aluno (
    id_aluno INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ra VARCHAR (7) UNIQUE NOT NULL,
    nome VARCHAR (80) NOT NULL,
    sobrenome VARCHAR (80) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR (200),
    email VARCHAR (80),
    celular VARCHAR (20) NOT NULL
);

-- cria o RA
CREATE OR REPLACE FUNCTION gerar_ra() RETURNS TRIGGER AS $$
BEGIN
    NEW.ra := 'AAA' || TO_CHAR(nextval('seq_ra'), 'FM0000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_gerar_ra
BEFORE INSERT ON Aluno
FOR EACH ROW EXECUTE FUNCTION gerar_ra();




-- CREATE LIVRO
CREATE TABLE Livro (
    id_livro INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR (200) NOT NULL,
    autor VARCHAR (150) NOT NULL,
    editora VARCHAR (100) NOT NULL,
    ano_publicacao VARCHAR (5),
    isbn VARCHAR (20),
    quant_total INTEGER NOT NULL,
    quant_disponivel INTEGER NOT NULL,
    valor_aquisicao DECIMAL (10,2),
    status_livro_emprestado VARCHAR (20)
);


-- CREATE EMPRESTIMO
CREATE TABLE Emprestimo (
    id_emprestimo INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_aluno INT REFERENCES Aluno(id_aluno),
    id_livro INT REFERENCES Livro(id_livro),
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    status_emprestimo VARCHAR (20)
);



-- ALUNO
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('Conor', 'McGregor', '2005-01-15', 'Rua UFC, 123', 'mcgregor@ufc.com', '16998959876'),
('Amanda', 'Nunes', '2004-03-22', 'Rua UFC, 456', 'amanda.nunes@ufc.com', '16995992305'),
('Angelina', 'Jolie', '2003-07-10', 'Rua Hollywood, 789', 'jolie@cinema.com', '16991915502'),
('Natalie', 'Portman', '2002-11-05', 'Rua Hollywood, 101', 'natalie.portman@cinema.com', '16993930703'),
('Shaquille', 'ONeal', '2004-09-18', 'Rua NBA, 202', 'shaquille@gmail.com', '16993937030'),
('Harry', 'Kane', '2000-05-18', 'Rua Futebol, 2024', 'kane@futi.com', '16998951983'),
('Jaqueline', 'Carvalho', '2001-12-10', 'Rua Volei, 456', 'jack@volei.com', '16991993575'),
('Sheilla', 'Castro', '2003-04-25', 'Rua Volei, 2028', 'sheilla.castro@volei.com', '16981974547'),
('Gabriela', 'Guimarães', '2007-08-19', 'Rua Volei, 2028', 'gaby@volei.com', '16983932215'),
('Magic', 'Johnson', '2003-07-08', 'Rua NBA, 1999', 'magic@gmail.com', '16993932020');





-- LIVRO
INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'HarperCollins', '1954', '978-0007525546', 10, 10, 150.00, 'Disponível'),
('1984', 'George Orwell', 'Companhia das Letras', '1949', '978-8535906770', 8, 8, 90.00, 'Disponível'),
('Dom Quixote', 'Miguel de Cervantes', 'Penguin Classics', '1605', '978-0142437230', 6, 6, 120.00, 'Disponível'),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Agir', '1943', '978-8522008731', 12, 12, 50.00, 'Disponível'),
('A Revolução dos Bichos', 'George Orwell', 'Penguin', '1945', '978-0141036137', 7, 7, 80.00, 'Disponível'),
('O Hobbit', 'J.R.R. Tolkien', 'HarperCollins', '1937', '978-0007458424', 9, 9, 140.00, 'Disponível'),
('O Conde de Monte Cristo', 'Alexandre Dumas', 'Penguin Classics', '1844', '978-0140449266', 5, 5, 110.00, 'Disponível'),
('Orgulho e Preconceito', 'Jane Austen', 'Penguin Classics', '1813', '978-0141439518', 7, 7, 90.00, 'Disponível'),
('Moby Dick', 'Herman Melville', 'Penguin Classics', '1851', '978-0142437247', 4, 4, 100.00, 'Disponível'),
('Guerra e Paz', 'Liev Tolstói', 'Companhia das Letras', '1869', '978-8535922343', 3, 3, 130.00, 'Disponível');



-- Inserindo Emprestimos
INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES 
(1, 2, '2024-09-01', '2024-09-15', 'Em andamento'),
(2, 1, '2024-09-02', '2024-09-16', 'Em andamento'),
(3, 5, '2024-09-03', '2024-09-17', 'Em andamento'),
(5, 3, '2024-09-04', '2024-09-18', 'Em andamento'),
(4, 6, '2024-09-05', '2024-09-19', 'Em andamento'),
(6, 4, '2024-09-06', '2024-09-20', 'Em andamento'),
(7, 8, '2024-09-07', '2024-09-21', 'Em andamento'),
(8, 7, '2024-09-08', '2024-09-22', 'Em andamento'),
(10, 9, '2024-09-09', '2024-09-23', 'Em andamento'),
(9, 10, '2024-09-10', '2024-09-24', 'Em andamento'),
(1, 10, '2024-09-11', '2024-09-25', 'Em andamento'),
(2, 3, '2024-09-11', '2024-09-25', 'Em andamento'),
(4, 5, '2024-09-11', '2024-09-25', 'Em andamento'),
(6, 2, '2024-09-11', '2024-09-25', 'Em andamento');



SELECT 
    a.ra, 
    a.nome, 
    a.sobrenome, 
    a.celular, 
    l.titulo, 
    l.autor, 
    l.editora, 
    e.data_emprestimo, 
    e.data_devolucao, 
    e.status_emprestimo
FROM 
    Emprestimo e
JOIN 
    Aluno a ON e.id_aluno = a.id_aluno
JOIN 
    Livro l ON e.id_livro = l.id_livro;

INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('Dom Casmurro' ,	'Machado de Assis' ,	'Penguin'	, '1899'	,'9788571641428' ,	'5' ,	'45.00' ,	'Disponível')
('Iracema',	'José de Alencar',	'Ática'	'1865',	'9788508070201'	'3' ,'39.90' , 'Emprestado')
('O Cortiço'	'Aluísio Azevedo'	'Ateliê Editorial'	'1890'	'9788574620617'	'4'	'42.50'	'Disponível')
('Memórias Póstumas de Brás Cubas'	,'Machado de Assis'	,'Nova Fronteira'	,'1881'	,'9788520934819',	'2',	'55.00',	'Disponível')
('Senhora'	'José de Alencar',	'Martin Claret',	'1875',	'9788572327303',	'3'	,'29.90'	,'Emprestado')
('Triste Fim de Policarpo Quaresma',	'Lima Barreto',	'Zahar',	'1911'	,'9788537808905',	'4'	,'49.90',	'Disponível')
('Canaã	Graça Aranha'	'Companhia Editora Nacional'	'1902'	'9788572326504'	'2'	'44.90'	'Disponível')
('Inocência'	'Visconde de Taunay	Ática'	'1872'	'9788508094214'	'5'	'34.90'	'Disponível')
('Lucíola'	'José de Alencar	L&PM'	'1862'	'9788525407875'	'3'	'37.90'	'Emprestado')
('O Mulato'	'Aluísio Azevedo	Penguin'	'1881'	'9788571643770'	'2'	'32.90'	'Disponível')

INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('1984'	'George Orwell',	'Companhia das Letras',	'1949',	'9788535925660',	'5',	'59.90'	,'Disponível')
('O Pequeno Príncipe',	'Antoine de Saint-Exupéry	,Agir',	'1943',	'9788522035255',	'8',	'24.90',	'Disponível'))
('Orgulho e Preconceito'	,'Jane Austen	Martin Claret',	'1813',	'9788572327020',	'3'	,'54.90','Emprestado')
('Crime e Castigo'	,'Fiódor Dostoiévski	Penguin',	'1866'	,'9788572326979',	'4',	'69.90',	'Disponível')
('O Conde de Monte Cristo'	,'Alexandre Dumas	Zahar'	,'1844',	'9788537812357'	,'2',	'79.90',	'Disponível')
('Os Miseráveis',	'Victor Hugo	Nova Fronteira'	,'1862',	'9788520938831',	'3',	'84.90',	'Emprestado')
('Hamlet	William ' ,'Shakespeare	L&PM'	,'1603',	'9788525407677',	'5',	'39.90',	'Disponível')
('O Retrato de Dorian Gray'	'Oscar Wilde,	Martin Claret'	,'1890',	'9788572327877',	'4',	'49.90'	,'Disponível')
('Anna Kariênina	Liev Tolstói',	'Companhia das Letras'	,'1877'	,'9788535913438',	'3',	'89.90',	'Disponível')
('Madame Bovary	Gustave Flaubert'	,'Globo',	'1857',	'9788525057032'	,'2'	,'59.90',	'Emprestado')

INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('O Senhor dos Anéis',	'J.R.R. Tolkien	HarperCollins',	'1954'	'9780007141326',	'3',	'99.90',	'Disponível')
('O Hobbit'	'J.R.R. Tolkien	HarperCollins',	'1937'	,'9780007458424'	,'4'	'79.90',	'Disponível')
('Harry Potter e a Pedra Filosofal'	,'J.K. Rowling	Rocco'	'1997'	'9788532511019'	'6'	'59.90'	'Emprestado')
('Percy Jackson e o Ladrão de Raios'	,'Rick Riordan	Intrínseca',	'2005'	,'9788598078355',	'5',	'44.90',	'Disponível')
('As Crônicas de Nárnia'	,'C.S. Lewis	WMF Martins Fontes',	'1950',	'9788578270696',	'4'	,'89.90'	,'Disponível')
('Eragon	Christopher', 'Paolini	Rocco',	'2002'	,'9788532511010'	,'3',	'69.90'	,'Indisponível')
('A Bússola de Ouro'	,'Philip Pullman	Objetiva'	,'1995',	'9788539003456',	'2','54.90',	'Disponível')
('O Nome do Vento',	'Patrick Rothfuss'	,'Arqueiro'	'2007',	'9788576860738'	,'3'	,'84.90'	,'Emprestado')
('A Guerra dos Tronos',	'George R.R. Martin	Leya',	'1996'	'9788579800243'	,'5','99.90',	'Disponível')
('Mistborn: O Império Final'	,'Brandon Sanderson	LeYa'	,'2006',	'9788535908335'	'4',	'79.90'	,'Disponível')

INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES
('Vidas Secas', 'Graciliano Ramos', 'Record', '1938', '9788501013656', '6', '5', '48.90', 'Disponível'),
('Capitães da Areia', 'Jorge Amado', 'Companhia das Letras', '1937', '9788535925888', '7', '6', '52.90', 'Disponível'),
('O Guarani', 'José de Alencar', 'Ática', '1857', '9788508050203', '5', '4', '39.90', 'Disponível'),
('Mar Morto', 'Jorge Amado', 'Record', '1936', '9788501010143', '3', '2', '47.50', 'Emprestado'),
('A Moreninha', 'Joaquim Manuel de Macedo', 'Martin Claret', '1844', '9788572326566', '4', '3', '34.90', 'Disponível'),
('O Ateneu', 'Raul Pompeia', 'Nova Fronteira', '1888', '9788520934865', '5', '5', '45.00', 'Disponível'),
('Til', 'José de Alencar', 'Martin Claret', '1872', '9788572327228', '3', '2', '29.90', 'Emprestado'),
('A Escrava Isaura', 'Bernardo Guimarães', 'Zahar', '1875', '9788537812223', '4', '3', '32.90', 'Disponível'),
('O Primo Basílio', 'Eça de Queirós', 'Companhia das Letras', '1878', '9788535913151', '5', '4', '56.90', 'Disponível'),
('Os Maias', 'Eça de Queirós', 'Companhia das Letras', '1888', '9788535909635', '6', '5', '64.90', 'Disponível');

INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('Grande Sertão: Veredas', 'João Guimarães Rosa', 'Nova Fronteira', '1956', '9788520932052', '6', '5', '72.90', 'Disponível'),
('O Tempo e o Vento', 'Erico Verissimo', 'Companhia das Letras', '1949', '9788535913700', '5', '4', '68.50', 'Disponível'),
('São Bernardo', 'Graciliano Ramos', 'Record', '1934', '9788501013632', '4', '3', '46.90', 'Emprestado'),
('Menino de Engenho', 'José Lins do Rego', 'José Olympio', '1932', '9788503010103', '5', '4', '42.00', 'Disponível'),
('Fogo Morto', 'José Lins do Rego', 'José Olympio', '1943', '9788503010455', '3', '2', '48.00', 'Emprestado'),
('Sagarana', 'João Guimarães Rosa', 'Nova Fronteira', '1946', '9788520932120', '4', '3', '54.90', 'Disponível'),
('O Quinze', 'Rachel de Queiroz', 'José Olympio', '1930', '9788503007516', '6', '6', '38.90', 'Disponível'),
('O Amanuense Belmiro', 'Cyro dos Anjos', 'Record', '1937', '9788501012116', '4', '3', '44.90', 'Emprestado'),
('Angústia', 'Graciliano Ramos', 'Record', '1936', '9788501013649', '5', '4', '49.90', 'Disponível'),
('O Pagador de Promessas', 'Dias Gomes', 'Civilização Brasileira', '1959', '9788520905933', '3', '2', '35.00', 'Disponível');



INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('O Velho e o Mar', 'Ernest Hemingway', 'Editora Record', '1952', '9788501001204', '5', '5', '42.90', 'Disponível'),
('Adeus às Armas', 'Ernest Hemingway', 'Editora Record', '1929', '9788501001211', '4', '3', '39.90', 'Emprestado'),
('Guerra e Paz', 'Liev Tolstói', 'Companhia das Letras', '1869', '9788535913458', '6', '5', '79.90', 'Disponível'),
('Anna Karenina', 'Liev Tolstói', 'Companhia das Letras', '1877', '9788535913438', '5', '4', '89.90', 'Disponível'),
('O Processo', 'Franz Kafka', 'Editora Globo', '1925', '9788525057018', '4', '3', '49.90', 'Emprestado'),
('A Metamorfose', 'Franz Kafka', 'Editora Globo', '1915', '9788525057025', '3', '2', '39.90', 'Disponível'),
('O Grande Gatsby', 'F. Scott Fitzgerald', 'Suma de Letras', '1925', '9788556510329', '5', '4', '45.90', 'Disponível'),
('Tender is the Night', 'F. Scott Fitzgerald', 'Suma de Letras', '1934', '9788556510336', '4', '3', '48.90', 'Emprestado'),
('Drácula', 'Bram Stoker', 'Martin Claret', '1897', '9788572327358', '6', '5', '54.90', 'Disponível'),
('Frankenstein', 'Mary Shelley', 'Martin Claret', '1818', '9788572327365', '5', '4', '49.90', 'Disponível');



INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('O Alquimista', 'Paulo Coelho', 'HarperCollins', '1988', '9788575424125', '6', '6', '39.90', 'Disponível'),
('Brida', 'Paulo Coelho', 'HarperCollins', '1990', '9788575424156', '5', '4', '42.90', 'Disponível'),
('A Hora da Estrela', 'Clarice Lispector', 'Rocco', '1977', '9788532510350', '4', '3', '44.90', 'Emprestado'),
('Perto do Coração Selvagem', 'Clarice Lispector', 'Rocco', '1943', '9788532510367', '3', '2', '49.90', 'Disponível'),
('Feliz Ano Velho', 'Marcelo Rubens Paiva', 'Globo', '1982', '9788525049310', '5', '5', '39.90', 'Disponível'),
('O Filho Eterno', 'Cristovão Tezza', 'Objetiva', '2007', '9788573025764', '4', '3', '52.90', 'Emprestado'),
('Nosso Mundo', 'Lygia Fagundes Telles', 'Editora Ática', '1965', '9788508012342', '3', '3', '44.90', 'Disponível'),
('As Meninas', 'Lygia Fagundes Telles', 'Editora Globo', '1973', '9788525049327', '4', '4', '49.90', 'Disponível'),
('Se Eu Fechar os Olhos Agora', 'Edney Silvestre', 'Record', '2008', '9788501074221', '5', '4', '54.90', 'Disponível'),
('O Filho de Mil Homens', 'Valter Hugo Mãe', 'Companhia das Letras', '2009', '9788535926502', '4', '3', '59.90', 'Emprestado');


INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('Macunaíma', 'Mário de Andrade', 'Companhia das Letras', '1928', '9788535913717', '5', '5', '52.90', 'Disponível'),
('A Bagaceira', 'José Américo de Almeida', 'José Olympio', '1928', '9788503010509', '4', '3', '46.90', 'Emprestado'),
('O Seminarista', 'Rubem Fonseca', 'Record', '1971', '9788501072104', '3', '3', '39.90', 'Disponível'),
('O Homem Nu', 'Fernando Sabino', 'Record', '1966', '9788501072159', '5', '4', '44.90', 'Disponível'),
('A Casa das Sete Mulheres', 'Letícia Wierzchowski', 'Objetiva', '2002', '9788573024989', '4', '3', '49.90', 'Emprestado'),
('As Três Marias', 'Rachel de Queiroz', 'José Olympio', '1939', '9788503010752', '6', '5', '42.90', 'Disponível'),
('O Encontro Marcado', 'Fernando Sabino', 'Record', '1956', '9788501072173', '4', '4', '47.90', 'Disponível'),
('O Ateneu', 'Raul Pompeia', 'Nova Fronteira', '1888', '9788520934865', '5', '4', '45.00', 'Disponível'),
('O Navio Negreiro', 'Castro Alves', 'Martin Claret', '1869', '9788572327563', '3', '3', '39.90', 'Emprestado'),
('A Rosa do Povo', 'Carlos Drummond de Andrade', 'Companhia das Letras', '1945', '9788535913724', '5', '5', '54.90', 'Disponível');


INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('Iracema', 'José de Alencar', 'Ática', '1865', '9788508070201', '4', '3', '39.90', 'Emprestado'),
('Senhora', 'José de Alencar', 'Martin Claret', '1875', '9788572327303', '3', '2', '29.90', 'Emprestado'),
('Lucíola', 'José de Alencar', 'L&PM', '1862', '9788525407875', '3', '3', '37.90', 'Emprestado'),
('O Mulato', 'Aluísio Azevedo', 'Penguin', '1881', '9788571643770', '2', '2', '32.90', 'Disponível'),
('O Cortiço', 'Aluísio Azevedo', 'Ateliê Editorial', '1890', '9788574620617', '4', '4', '42.50', 'Disponível'),
('Triste Fim de Policarpo Quaresma', 'Lima Barreto', 'Zahar', '1911', '9788537808905', '4', '4', '49.90', 'Disponível'),
('Canaã', 'Graça Aranha', 'Companhia Editora Nacional', '1902', '9788572326504', '2', '2', '44.90', 'Disponível'),
('Inocência', 'Visconde de Taunay', 'Ática', '1872', '9788508094214', '5', '5', '34.90', 'Disponível'),
('Memórias Póstumas de Brás Cubas', 'Machado de Assis', 'Nova Fronteira', '1881', '9788520934819', '2', '2', '55.00', 'Disponível'),
('Dom Casmurro', 'Machado de Assis', 'Penguin', '1899', '9788571641428', '5', '5', '45.00', 'Disponível');


INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('O Alquimista', 'Paulo Coelho', 'HarperCollins', '1988', '9788575424125', '6', '6', '39.90', 'Disponível'),
('Brida', 'Paulo Coelho', 'HarperCollins', '1990', '9788575424156', '5', '4', '42.90', 'Disponível'),
('A Hora da Estrela', 'Clarice Lispector', 'Rocco', '1977', '9788532510350', '4', '3', '44.90', 'Emprestado'),
('Perto do Coração Selvagem', 'Clarice Lispector', 'Rocco', '1943', '9788532510367', '3', '2', '49.90', 'Disponível'),
('Feliz Ano Velho', 'Marcelo Rubens Paiva', 'Globo', '1982', '9788525049310', '5', '5', '39.90', 'Disponível'),
('O Filho Eterno', 'Cristovão Tezza', 'Objetiva', '2007', '9788573025764', '4', '3', '52.90', 'Emprestado'),
('Nosso Mundo', 'Lygia Fagundes Telles', 'Editora Ática', '1965', '9788508012342', '3', '3', '44.90', 'Disponível'),
('As Meninas', 'Lygia Fagundes Telles', 'Editora Globo', '1973', '9788525049327', '4', '4', '49.90', 'Disponível'),
('Se Eu Fechar os Olhos Agora', 'Edney Silvestre', 'Record', '2008', '9788501074221', '5', '4', '54.90', 'Disponível'),
('O Filho de Mil Homens', 'Valter Hugo Mãe', 'Companhia das Letras', '2009', '9788535926502', '4', '3', '59.90', 'Emprestado');



INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('Lionel', 'Messi', '2001-06-24', 'Rua Futebol, 345', 'messi@futi.com', '16999887766'),
('Cristiano', 'Ronaldo', '2000-02-05', 'Rua Futebol, 678', 'ronaldo@futi.com', '16999776655'),
('Serena', 'Williams', '2002-09-26', 'Rua Tennis, 123', 'serena@tennis.com', '16999665544'),
('Venus', 'Williams', '2000-06-17', 'Rua Tennis, 456', 'venus@tennis.com', '16999554433'),
('LeBron', 'James', '2003-12-30', 'Rua NBA, 101', 'lebron@gmail.com', '16999443322'),
('Stephen', 'Curry', '2001-03-14', 'Rua NBA, 303', 'curry@gmail.com', '16999332211'),
('Simone', 'Biles', '2004-03-14', 'Rua Ginastica, 202', 'simone@gym.com', '16999221100'),
('Gabby', 'Douglas', '2002-12-31', 'Rua Ginastica, 303', 'gabby@gym.com', '16999110099'),
('Tom', 'Brady', '2000-08-03', 'Rua NFL, 404', 'brady@nfl.com', '16999009988'),
('Kobe', 'Bryant', '2001-08-23', 'Rua NBA, 505', 'kobe@nba.com', '16998998877');


INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('Usain', 'Bolt', '2000-08-21', 'Rua Atletismo, 101', 'usain@track.com', '16998887766'),
('Michael2', 'Phelps', '2001-06-30', 'Rua Natação, 202', 'phelps@swim.com', '16998776655'),
('Neymar', 'Jr', '2002-02-05', 'Rua Futebol, 909', 'neymar@futi.com', '16998665544'),
('Megan', 'Rapinoe', '2003-07-05', 'Rua Futebol, 808', 'rapinoe@futi.com', '16998554433'),
('Roger', 'Federer', '2001-08-08', 'Rua Tennis, 707', 'federer@tennis.com', '16998443322'),
('Rafael', 'Nadal', '2000-06-03', 'Rua Tennis, 606', 'nadal@tennis.com', '16998332211'),
('Katie', 'Ledecky', '2004-03-17', 'Rua Natação, 505', 'ledecky@swim.com', '16998221100'),
('Simone', 'Manuel', '2002-10-12', 'Rua Natação, 404', 'manuel@swim.com', '16998110099'),
('Kevin7', 'Durant', '2000-09-29', 'Rua NBA, 303', 'durant@gmail.com', '16998009988'),
('Anthony4', 'Davis', '2001-03-11', 'Rua NBA, 202', 'davis@gmail.com', '16997998877');


INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES
('Lea', 'Seydoux', '2003-05-10', 'Rua Cinema, 101', 'lea@cinema.com', '16997887766'),
('Timothée', 'Chalamet', '2002-12-27', 'Rua Cinema, 202', 'timothee@cinema.com', '16997776655'),
('Zendaya', 'Coleman', '2001-09-01', 'Rua Hollywood, 303', 'zendaya@cinema.com', '16997665544'),
('Tom', 'Holland', '2002-06-01', 'Rua Hollywood, 404', 'holland@cinema.com', '16997554433'),
('Gal', 'Gadot', '2000-04-30', 'Rua Cinema, 505', 'gadot@cinema.com', '16997443322'),
('Chris', 'Hemsworth', '2001-08-11', 'Rua Hollywood, 606', 'hemsworth@cinema.com', '16997332211'),
('Scarlett', 'Johansson', '2000-11-22', 'Rua Cinema, 707', 'scarlett@cinema.com', '16997221100'),
('Robert2', 'Downey', '2002-04-04', 'Rua Hollywood, 808', 'robert@cinema.com', '16997110099'),
('Chris', 'Evans', '2001-06-13', 'Rua Cinema, 909', 'evans@cinema.com', '16997009988'),
('Mark', 'Ruffalo', '2000-10-22', 'Rua Hollywood, 1010', 'ruffalo@cinema.com', '16996998877');

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES
('Kylian', 'Mbappé', '2003-12-20', 'Rua Futebol, 111', 'mbappe@futi.com', '16996887766'),
('Erling', 'Haaland', '2002-07-21', 'Rua Futebol, 222', 'haaland@futi.com', '16996776655'),
('Marta', 'Silva', '2001-02-19', 'Rua Futebol, 333', 'marta@futi.com', '16996665544'),
('Alexia', 'Putellas', '2000-03-07', 'Rua Futebol, 444', 'alexia@futi.com', '16996554433'),
('Sadio', 'Mané', '2000-04-10', 'Rua Futebol, 555', 'mane@futi.com', '16996443322'),
('Mohamed', 'Salah', '2001-06-15', 'Rua Futebol, 666', 'salah@futi.com', '16996332211'),
('Virgil', 'van Dijk', '2002-07-08', 'Rua Futebol, 777', 'vdijk@futi.com', '16996221100'),
('Luis', 'Suárez', '2000-01-24', 'Rua Futebol, 888', 'suarez@futi.com', '16996110099'),
('Kevin', 'De Bruyne', '2001-09-28', 'Rua Futebol, 999', 'debruyne@futi.com', '16996009988'),
('Harry', 'Maguire', '2002-03-05', 'Rua Futebol, 1010', 'maguire@futi.com', '16995998877');


INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES
('Michael2', 'Jordan', '2000-02-17', 'Rua NBA, 111', 'mjordan@gmail.com', '16995887766'),
('Kawhi', 'Leonard', '2001-06-29', 'Rua NBA, 222', 'kleonard@gmail.com', '16995776655'),
('Giannis', 'Antetokounmpo', '2002-12-06', 'Rua NBA, 333', 'giannis@gmail.com', '16995665544'),
('Luka', 'Doncic', '2000-02-28', 'Rua NBA, 444', 'doncic@gmail.com', '16995554433'),
('James', 'Harden', '2001-08-09', 'Rua NBA, 555', 'harden@gmail.com', '16995443322'),
('Anthony2', 'Edwards', '2002-05-23', 'Rua NBA, 666', 'edwards@gmail.com', '16995332211'),
('Jayson', 'Tatum', '2000-03-03', 'Rua NBA, 777', 'tatum@gmail.com', '16995221100'),
('Joel', 'Embiid', '2001-04-16', 'Rua NBA, 888', 'embiid@gmail.com', '16995110099'),
('Stephen', 'Curry', '2002-03-14', 'Rua NBA, 999', 'curry@gmail.com', '16995009988'),
('Kevin2', 'Durant', '2000-09-29', 'Rua NBA, 1010', 'durant@gmail.com', '16994998877');

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES
('Emma', 'Stone', '2001-11-06', 'Rua Hollywood, 111', 'emma@cinema.com', '16993887766'),
('Ryan', 'Gosling', '2000-12-12', 'Rua Hollywood, 222', 'ryan@cinema.com', '16993776655'),
('Margot', 'Robbie', '2002-07-02', 'Rua Hollywood, 333', 'margot@cinema.com', '16993665544'),
('Chris', 'Pratt', '2000-06-21', 'Rua Hollywood, 444', 'pratt@cinema.com', '16993554433'),
('Gal', 'Gadot', '2003-04-30', 'Rua Hollywood, 555', 'gadot@cinema.com', '16993443322'),
('Zendaya', 'Coleman', '2002-09-01', 'Rua Hollywood, 666', 'zendaya@cinema.com', '16993332211'),
('Robert3', 'Pattinson', '2001-05-13', 'Rua Hollywood, 777', 'robert@cinema.com', '16993221100'),
('Anne', 'Hathaway', '2000-11-12', 'Rua Hollywood, 888', 'anne@cinema.com', '16993110099'),
('Will', 'Smith', '2002-09-25', 'Rua Hollywood, 999', 'will@cinema.com', '16993009988'),
('Jennifer', 'Lawrence', '2001-08-15', 'Rua Hollywood, 1010', 'jlawrence@cinema.com', '16992998877'),

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES
('Billie', 'Eilish', '2003-12-18', 'Rua Música, 101', 'billie@music.com', '16989887766'),
('Adele', 'Adkins', '2002-05-05', 'Rua Música, 202', 'adele@music.com', '16989776655'),
('Taylor', 'Swift', '2000-12-13', 'Rua Música, 303', 'taylor@music.com', '16989665544'),
('Ed', 'Sheeran', '2001-02-17', 'Rua Música, 404', 'ed@music.com', '16989554433'),
('Bruno', 'Mars', '2000-10-08', 'Rua Música, 505', 'bruno@music.com', '16989443322'),
('Dua', 'Lipa', '2002-08-22', 'Rua Música, 606', 'dua@music.com', '16989332211'),
('Harry', 'Styles', '2001-02-01', 'Rua Música, 707', 'harry@music.com', '16989221100'),
('Ariana', 'Grande', '2003-06-26', 'Rua Música, 808', 'ariana@music.com', '16989110099'),
('Shawn', 'Mendes', '2000-08-08', 'Rua Música, 909', 'shawn@music.com', '16989009988'),
('Lady', 'Gaga', '2001-03-28', 'Rua Música, 1010', 'gaga@music.com', '16988998877');

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES
('Simone', 'Biles', '2003-03-14', 'Rua Ginastica, 111', 'simone@gym.com', '16987887766'),
('Gabby', 'Douglas', '2002-12-31', 'Rua Ginastica, 222', 'gabby@gym.com', '16987776655'),
('Nastia', 'Liukin', '2001-10-30', 'Rua Ginastica, 333', 'nastia@gym.com', '16987665544'),
('Shawn', 'Johnson', '2000-09-19', 'Rua Ginastica, 444', 'shawn@gym.com', '16987554433'),
('Katelyn', 'Ohashi', '2002-06-09', 'Rua Ginastica, 555', 'katelyn@gym.com', '16987443322'),
('Suni', 'Lee', '2003-06-09', 'Rua Ginastica, 666', 'suni@gym.com', '16987332211'),
('Aly', 'Raisman', '2000-05-25', 'Rua Ginastica, 777', 'aly@gym.com', '16987221100'),
('Dominique', 'Dawes', '2001-03-24', 'Rua Ginastica, 888', 'dominique@gym.com', '16987110099'),
('McKayla', 'Maroney', '2002-07-09', 'Rua Ginastica, 999', 'mckayla@gym.com', '16987009988'),
('Oksana', 'Chusovitina', '2000-06-19', 'Rua Ginastica, 1010', 'oksana@gym.com', '16986998877');

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES
('Jack1', 'Harlow', '2002-03-31', 'Rua Música, 111', 'jack@music.com', '16985887766'),
('Olivia1', 'Rodrigo', '2003-02-20', 'Rua Música, 222', 'olivia@music.com', '16985776655'),
('Doja1', 'Cat', '2001-10-21', 'Rua Música, 333', 'doja@music.com', '16985665544'),
('Billie1', 'Eilish', '2002-12-18', 'Rua Música, 444', 'billie@music.com', '16985554433'),
('Lil1', 'Nas X', '2000-04-09', 'Rua Música, 555', 'lilnasx@music.com', '16985443322'),
('Ariana1', 'Grande', '2003-06-26', 'Rua Música, 666', 'ariana@music.com', '16985332211'),
('Dua1', 'Lipa', '2001-08-22', 'Rua Música, 777', 'dua@music.com', '16985221100'),
('Harry1', 'Styles', '2000-02-01', 'Rua Música, 888', 'harry@music.com', '16985110099'),
('Shawn1', 'Mendes', '2002-08-08', 'Rua Música, 999', 'shawn@music.com', '16985009988'),
('Selena1', 'Gomez', '2001-07-22', 'Rua Música, 1010', 'selena@music.com', '16984998877');


INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES
('Marcus1', 'Rashford', '2000-10-31', 'Rua Futebol, 111', 'rashford@futi.com', '16984887766'),
('Phil1', 'Foden', '2001-05-28', 'Rua Futebol, 222', 'foden@futi.com', '16984776655'),
('Pedri1', 'Gonzalez', '2002-11-25', 'Rua Futebol, 333', 'pedri@futi.com', '16984665544'),
('João1', 'Felix', '2000-11-10', 'Rua Futebol, 444', 'joao@futi.com', '16984554433'),
('Vinicius1', 'Junior', '2001-07-12', 'Rua Futebol, 555', 'vinicius@futi.com', '16984443322'),
('Philippe1', 'Coutinho', '2002-06-12', 'Rua Futebol, 666', 'coutinho@futi.com', '16984332211'),
('Ansu1', 'Fati', '2003-10-31', 'Rua Futebol, 777', 'ansu@futi.com', '16984221100'),
('Rodrygo1', 'Goes', '2001-01-09', 'Rua Futebol, 888', 'rodrygo@futi.com', '16984110099'),
('Ferran1', 'Torres', '2002-02-29', 'Rua Futebol, 999', 'ferran@futi.com', '16984009988'),
('Jude1', 'Bellingham', '2003-06-29', 'Rua Futebol, 1010', 'jude@futi.com', '16983998877');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES 
(3, 7, '2024-09-12', '2024-09-26', 'Em andamento'),
(5, 1, '2024-09-12', '2024-09-26', 'Em andamento'),
(8, 4, '2024-09-13', '2024-09-27', 'Em andamento'),
(10, 2, '2024-09-13', '2024-09-27', 'Em andamento'),
(1, 6, '2024-09-14', '2024-09-28', 'Em andamento'),
(2, 9, '2024-09-14', '2024-09-28', 'Em andamento'),
(4, 8, '2024-09-15', '2024-09-29', 'Em andamento'),
(6, 10, '2024-09-15', '2024-09-29', 'Em andamento'),
(7, 5, '2024-09-16', '2024-09-30', 'Em andamento'),
(9, 3, '2024-09-16', '2024-09-30', 'Em andamento');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(1, 4, '2024-08-15', '2024-08-29', 'Devolvido'),
(2, 6, '2024-08-16', '2024-08-30', 'Devolvido'),
(3, 2, '2024-08-17', '2024-08-31', 'Devolvido'),
(4, 1, '2024-08-18', '2024-09-01', 'Devolvido'),
(5, 7, '2024-08-19', '2024-09-02', 'Devolvido'),
(6, 3, '2024-08-20', '2024-09-03', 'Atrasado'),
(7, 5, '2024-08-21', '2024-09-04', 'Atrasado'),
(8, 8, '2024-08-22', '2024-09-05', 'Devolvido'),
(9, 9, '2024-08-23', '2024-09-06', 'Devolvido'),
(10, 10, '2024-08-24', '2024-09-07', 'Atrasado');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(1, 3, '2024-08-25', '2024-09-08', 'Devolvido'),
(2, 5, '2024-08-26', '2024-09-09', 'Devolvido'),
(3, 7, '2024-08-27', '2024-09-10', 'Em andamento'),
(4, 2, '2024-08-28', '2024-09-11', 'Em andamento'),
(5, 1, '2024-08-29', '2024-09-12', 'Devolvido'),
(6, 6, '2024-08-30', '2024-09-13', 'Em andamento'),
(7, 4, '2024-08-31', '2024-09-14', 'Atrasado'),
(8, 9, '2024-09-01', '2024-09-15', 'Em andamento'),
(9, 8, '2024-09-02', '2024-09-16', 'Devolvido'),
(10, 3, '2024-09-03', '2024-09-17', 'Em andamento');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(1, 9, '2024-09-04', '2024-09-18', 'Atrasado'),
(2, 7, '2024-09-05', '2024-09-19', 'Devolvido'),
(3, 10, '2024-09-06', '2024-09-20', 'Em andamento'),
(4, 6, '2024-09-07', '2024-09-21', 'Devolvido'),
(5, 8, '2024-09-08', '2024-09-22', 'Atrasado'),
(6, 9, '2024-09-09', '2024-09-23', 'Devolvido'),
(7, 2, '2024-09-10', '2024-09-24', 'Em andamento'),
(8, 1, '2024-09-11', '2024-09-25', 'Devolvido'),
(5, 4, '2024-09-12', '2024-09-26', 'Em andamento'),
(7, 5, '2024-09-13', '2024-09-27', 'Atrasado');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(1, 2, '2024-07-01', '2024-07-15', 'Devolvido'),
(2, 4, '2024-07-02', '2024-07-16', 'Devolvido'),
(3, 6, '2024-07-03', '2024-07-17', 'Em andamento'),
(4, 8, '2024-07-04', '2024-07-18', 'Atrasado'),
(5, 10, '2024-07-05', '2024-07-19', 'Devolvido'),
(6, 1, '2024-07-06', '2024-07-20', 'Em andamento'),
(7, 3, '2024-07-07', '2024-07-21', 'Devolvido'),
(8, 5, '2024-07-08', '2024-07-22', 'Atrasado'),
(9, 7, '2024-07-09', '2024-07-23', 'Devolvido'),
(10, 9, '2024-07-10', '2024-07-24', 'Em andamento');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(1, 3, '2024-07-11', '2024-07-25', 'Em andamento'),
(2, 5, '2024-07-12', '2024-07-26', 'Devolvido'),
(3, 7, '2024-07-13', '2024-07-27', 'Atrasado'),
(4, 9, '2024-07-14', '2024-07-28', 'Devolvido'),
(5, 1, '2024-07-15', '2024-07-29', 'Em andamento'),
(6, 2, '2024-07-16', '2024-07-30', 'Devolvido'),
(7, 4, '2024-07-17', '2024-07-31', 'Atrasado'),
(8, 6, '2024-07-18', '2024-08-01', 'Em andamento'),
(9, 8, '2024-07-19', '2024-08-02', 'Devolvido'),
(10, 10, '2024-07-20', '2024-08-03', 'Atrasado');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(1, 5, '2024-07-21', '2024-08-04', 'Em andamento'),
(2, 6, '2024-07-22', '2024-08-05', 'Devolvido'),
(3, 7, '2024-07-23', '2024-08-06', 'Em andamento'),
(4, 8, '2024-07-24', '2024-08-07', 'Atrasado'),
(5, 9, '2024-07-25', '2024-08-08', 'Devolvido'),
(6, 10, '2024-07-26', '2024-08-09', 'Em andamento'),
(7, 1, '2024-07-27', '2024-08-10', 'Devolvido'),
(8, 2, '2024-07-28', '2024-08-11', 'Em andamento'),
(9, 3, '2024-07-29', '2024-08-12', 'Atrasado'),
(8, 4, '2024-07-30', '2024-08-13', 'Devolvido');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(1, 6, '2024-08-01', '2024-08-15', 'Em andamento'),
(2, 7, '2024-08-02', '2024-08-16', 'Devolvido'),
(3, 8, '2024-08-03', '2024-08-17', 'Atrasado'),
(4, 9, '2024-08-04', '2024-08-18', 'Em andamento'),
(5, 10, '2024-08-05', '2024-08-19', 'Devolvido'),
(6, 1, '2024-08-06', '2024-08-20', 'Em andamento'),
(7, 2, '2024-08-07', '2024-08-21', 'Atrasado'),
(8, 3, '2024-08-08', '2024-08-22', 'Devolvido'),
(9, 4, '2024-08-09', '2024-08-23', 'Em andamento'),
(10, 5, '2024-08-10', '2024-08-24', 'Devolvido');


INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(7, 7, '2024-08-11', '2024-08-25', 'Atrasado'),
(2, 8, '2024-08-12', '2024-08-26', 'Devolvido'),
(6, 9, '2024-08-13', '2024-08-27', 'Em andamento'),
(4, 10, '2024-08-14', '2024-08-28', 'Devolvido'),
(5, 1, '2024-08-15', '2024-08-29', 'Em andamento'),
(6, 2, '2024-08-16', '2024-08-30', 'Atrasado'),
(7, 3, '2024-08-17', '2024-08-31', 'Devolvido'),
(8, 4, '2024-08-18', '2024-09-01', 'Em andamento'),
(9, 5, '2024-08-19', '2024-09-02', 'Devolvido'),
(10, 6, '2024-08-20', '2024-09-03', 'Atrasado');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES
(1, 8, '2024-09-01', '2024-09-15', 'Em andamento'),
(2, 9, '2024-09-02', '2024-09-16', 'Em andamento'),
(3, 10, '2024-09-02', '2024-09-16', 'Em andamento'),
(4, 1, '2024-09-03', '2024-09-17', 'Atrasado'),
(5, 2, '2024-09-03', '2024-09-17', 'Em andamento'),
(6, 3, '2024-09-04', '2024-09-18', 'Devolvido'),
(7, 4, '2024-09-04', '2024-09-18', 'Em andamento'),
(8, 5, '2024-09-05', '2024-09-19', 'Em andamento'),
(9, 6, '2024-09-05', '2024-09-19', 'Devolvido'),
(10, 7, '2024-09-06', '2024-09-20', 'Atrasado');