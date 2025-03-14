USE prueba_music_stream_proyecto;

-- COMPROBACIONES

SELECT *
FROM albumes;

SELECT *
FROM artista;

SELECT *
FROM canciones;

SELECT *
FROM artistas_similares;

-- AÑADIENDO FOREIGN KEYS

-- CAMBIO ID EN ARTISTA A LOS BUENOS

SET SQL_SAFE_UPDATES = 0;
UPDATE artista
SET Biografía = 'Ke Personajes es un grupo argentino de cumbia fundado en 2016 y liderado por Emanuel Noir'
WHERE Artista = 'Ke personajes';
UPDATE artista
SET ID_artista = '66CXWjxzNUsdJxJ2JdwvnR'
WHERE Artista = 'Ariana Grande';
UPDATE artista
SET ID_artista = '6XyY86QOPPrYVGvF9ch6wz'
WHERE Artista = 'Linkin Park';
UPDATE artista
SET ID_artista = '5Ho1vKl1Uz8bJlk4vbmvmf'
WHERE Artista = 'Amelie Lens';
UPDATE artista
SET ID_artista = '0lAWpj5szCSwM4rUMHYmrr'
WHERE Artista = 'Måneskin';
UPDATE artista
SET ID_artista = '06Q5VlSAku57lFzyME3HrM'
WHERE Artista = 'Ke personajes';

-- TABLA ARTISTA - tabla madre. no tiene foreign key

SELECT *
FROM artista;

ALTER TABLE artista
MODIFY COLUMN ID_artista VARCHAR(255) NOT NULL,
ADD PRIMARY KEY (ID_artista);

-- TABLA ALBUMES

SELECT *
FROM albumes;

ALTER TABLE albumes
RENAME COLUMN ID_album TO ID_artista;

ALTER TABLE albumes
ADD COLUMN ID_album INT AUTO_INCREMENT NOT NULL PRIMARY KEY;

ALTER TABLE albumes
MODIFY COLUMN ID_album INT FIRST;

ALTER TABLE albumes
MODIFY COLUMN ID_artista VARCHAR(255);

ALTER TABLE albumes
ADD CONSTRAINT fk_albumes_artistas
FOREIGN KEY (ID_artista)
REFERENCES artista(ID_artista)
ON DELETE CASCADE ON UPDATE CASCADE;
  

-- TABLA CANCIONES

SELECT *
FROM canciones; 

ALTER TABLE canciones
RENAME COLUMN ID TO ID_artista;

ALTER TABLE canciones
ADD COLUMN ID_cancion INT AUTO_INCREMENT NOT NULL PRIMARY KEY;

ALTER TABLE canciones
MODIFY COLUMN ID_cancion INT FIRST;

ALTER TABLE canciones
MODIFY COLUMN ID_artista VARCHAR(255);

ALTER TABLE canciones
ADD CONSTRAINT fk_canciones_artista
FOREIGN KEY (ID_artista)
REFERENCES artista(ID_artista);

ALTER TABLE canciones
ADD COLUMN ID_album INT;

ALTER TABLE canciones
ADD CONSTRAINT fk_canciones_albumes
FOREIGN KEY (ID_artista)
REFERENCES albumes(ID_artista);

-- TABLA ARTISTAS SIMILARES

SELECT *
FROM artistas_similares;

ALTER TABLE artistas_similares
RENAME COLUMN ID_artista_original TO ID_artista;

ALTER TABLE artistas_similares
MODIFY COLUMN ID_artista_original VARCHAR(255);

SET SQL_SAFE_UPDATES = 0;
UPDATE artistas_similares
SET ID_artista_original = '66CXWjxzNUsdJxJ2JdwvnR'
WHERE Artista_original = 'Ariana Grande';
UPDATE artistas_similares
SET ID_artista_original = '6XyY86QOPPrYVGvF9ch6wz'
WHERE Artista_original = 'Linkin Park';
UPDATE artistas_similares
SET ID_artista_original = '5Ho1vKl1Uz8bJlk4vbmvmf'
WHERE Artista_original = 'Amelie Lens';
UPDATE artistas_similares
SET ID_artista_original = '0lAWpj5szCSwM4rUMHYmrr'
WHERE Artista_original = 'Måneskin';
UPDATE artistas_similares
SET ID_artista_original = '06Q5VlSAku57lFzyME3HrM'
WHERE Artista_original = 'Ke personajes';

ALTER TABLE artistas_similares
MODIFY COLUMN ID_artista_original VARCHAR(255) PRIMARY KEY;

ALTER TABLE artistas_similares
ADD COLUMN ID_artista_similar INT AUTO_INCREMENT NOT NULL PRIMARY KEY;

ALTER TABLE artistas_similares
MODIFY COLUMN ID_artista_similar INT FIRST;

ALTER TABLE artistas_similares
ADD CONSTRAINT fk_artistas_similares_artista
FOREIGN KEY (ID_artista)
REFERENCES artista(ID_artista)
ON DELETE CASCADE ON UPDATE CASCADE;

-- CREACIÓN TABLA ARTISTAS EN CANCIONES

SELECT *
FROM Artistas_en_canciones;

SELECT *
FROM canciones;

CREATE TABLE Artistas_en_canciones (
    ID_artista VARCHAR(225),
    ID_cancion INT,
    PRIMARY KEY (ID_artista, ID_cancion),
    CONSTRAINT fk_artistas_en_canciones_artistas
        FOREIGN KEY (ID_artista) REFERENCES artista(ID_artista) ON DELETE CASCADE,
    CONSTRAINT fk_artistas_en_canciones_canciones
        FOREIGN KEY (ID_cancion) REFERENCES canciones(ID_cancion) ON DELETE CASCADE
    );

-- INSERTAR:

INSERT INTO Artistas_en_canciones (ID_artista, ID_cancion)
SELECT a.ID_artista, c.ID_cancion
FROM artista AS a
JOIN canciones AS c ON a.ID_artista = c.ID_artista;
    
-- 1.¿Cuál es el artista con más albums?
    
SELECT Artista, COUNT(*) AS Numero_Albumes
	FROM albumes
	GROUP BY Artista
	ORDER BY Numero_Albumes DESC
	LIMIT 1;

-- 2.¿Qué género es el mejor valorado?

SELECT al.Género AS Género, SUM(a.Oyentes) AS Total_Oyentes
	FROM Albumes AS al
    INNER JOIN Artista AS a ON al.ID_artista = a.ID_artista
	GROUP BY al.Género
	LIMIT 1;

-- COMPROBACION: 

SELECT *
	FROM Albumes AS al
    INNER JOIN Artista AS a ON al.ID_artista = a.ID_artista
	GROUP BY al.Género
	LIMIT 1;
    
-- 3.¿En qué año se lanzaron más álbumes? 

SELECT Año_lanzamiento, COUNT(*) AS Numero_Albumes
	FROM albumes
	GROUP BY Año_lanzamiento
	ORDER BY Numero_Albumes DESC
	LIMIT 1;
    
-- 4.Obtener el nombre del artista cuya canción tiene el mayor número de reproducciones

SELECT a.Artista, c.Nombre_canción, a.Reproducciones
	FROM artista AS a
	JOIN canciones AS c ON a.ID_artista = c.ID_artista
	LIMIT 1;
    
-- 5.¿Cuál es el artista con más valoración?

SELECT Artista, MAX(Reproducciones) AS Valoracion_Promedio
	FROM artista
	LIMIT 1;

-- 6.¿Cuál es el album más valorado de los años pares de mi selección?

SELECT al.Nombre_album, a.Artista, al.Año_lanzamiento, a.Reproducciones
	FROM albumes AS al
    INNER JOIN Artista AS a ON al.ID_artista = a.ID_artista
	WHERE MOD(Año_lanzamiento, 2) = 0
	LIMIT 1;

-- 7¿Qué artista estuvo más tiempo y cuántos albums tiene?

SELECT Artista, MAX(2024  - Año_lanzamiento) AS Años_carrera, COUNT(ID_album) AS Número_albumes
FROM albumes
GROUP BY Artista;

SELECT *
FROM albumes;