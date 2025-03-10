use music_stream_proyecto;

-- Comprobaciones 
select *
from artista;

select *
from albumes;

select *
from artistas_similares;

select *
from canciones;


select *
from artistas_similares;

USE music_stream_proyecto;



-- TABLA:ARTISTA. Cambiamos nombre de columna id a id_artista y añadimos una columna id como primary key autoincrement

ALTER TABLE artista
RENAME COLUMN ID TO ID_artista;

ALTER TABLE artista
DROP COLUMN ID;


ALTER TABLE artista
ADD COLUMN ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL;

USE music_stream_proyecto;

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

-- TABLA: ARTISTAS SIMILARES. Cambiamos nombre de columna id a id_artista y añadimos una columna id como primary key autoincrement

ALTER TABLE artistas_similares
RENAME COLUMN ID TO ID_artista_similar;

ALTER TABLE artistas_similares
DROP ID;

ALTER TABLE artistas_similares 
ADD COLUMN ID int;

ALTER TABLE artistas_similares 
MODIFY ID_artista VARCHAR(255) NOT NULL, 
MODIFY id_artista_similar VARCHAR(255) NOT NULL;

 
ALTER TABLE artistas_similares
ADD CONSTRAINT pk_artistas_similares 
PRIMARY KEY (id_artista, id_artista_similar);




-- TABLA: CANCIONES. Cambiamos nombre de columna id a id_canciones y añadimos una columna id como primary key autoincrement

ALTER TABLE canciones
RENAME COLUMN ID_canciones TO ID_artista;

ALTER TABLE canciones
RENAME COLUMN ID TO ID_canciones;

ALTER TABLE canciones
ADD COLUMN ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL;

ALTER TABLE canciones
RENAME COLUMN ID TO ID_canciones;

-- TABLA: ALBUMES.  Cambiamos nombre de columna id a id_album y añadimos una columna id como primary key autoincrement

ALTER TABLE albumes
RENAME COLUMN ID_album TO ID_artista;

ALTER TABLE albumes
RENAME COLUMN ID TO ID_album;

ALTER TABLE albumes
ADD COLUMN ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL;


-- Ahora vamos a añadir las foreign keys sin ejecutar (esperando tabla madre artista)

-- TABLA: ARTISTAS. No hay foreign key. Tabla madre.

-- TABLA: ARTISTAS SIMILARES
