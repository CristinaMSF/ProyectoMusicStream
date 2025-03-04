CREATE SCHEMA proyecto_music_stream;
USE proyecto_music_stream;

# Creamos la tabla artistas  # FALTA: ORDENAR COLUMNAS ARTISTAS/CANCIONES
-- Se incluye id_artista, que es la primary key, nombre_artista, biografia, genero_musical

CREATE TABLE Artistas (
	nombre_artista VARCHAR (50),
	biografia VARCHAR(500),
    genero_musical VARCHAR(20));

SELECT * 
FROM Artistas;

# Creamos la tabla Albumes 
-- Se incluye id_album, que es la primary key, titulo_album, año_lanzamiento
 
CREATE TABLE Albumes (
	id_album VARCHAR (100),
    titulo_album VARCHAR (75),
    año_lanzamiento YEAR);
    
SELECT *
FROM Albumes;

# Creamos la tabla Canciones (PENSAR SI PONER ID_CANCION)
-- Se incluye id_cancion, que es la primary key, titulo_cancion, reproducciones, id_album

CREATE TABLE Canciones (
	titulo_cancion VARCHAR (50) NOT NULL,
    reproducciones INT,
    id_album VARCHAR (75));
    
    SELECT *
    FROM Canciones;
    
# VAMOS A MODIFICAR TIPO DE DATO A NOT NULL EN LA TABLA ARTISTAS

ALTER TABLE Artistas
MODIFY COLUMN nombre_artista VARCHAR (50) NOT NULL;


# VAMOS A AÑADIR UNA NUEVA COLUMNA LLAMADA ID_ARTISTA A TABLA ARTISTAS

ALTER TABLE Artistas
ADD COLUMN id_artista INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE Artistas
ADD COLUMN oyentes INT;

ALTER TABLE Artistas
ADD COLUMN artistas_similares VARCHAR(200);

SELECT *
FROM Artistas;

# VAMOS A MODIFICAR TIPO DE DATO A NOT NULL Y PRIMARY KEY TABLA ALBUMES

ALTER TABLE Albumes
MODIFY COLUMN id_album VARCHAR(100) NOT NULL PRIMARY KEY;

SELECT *
FROM Albumes;

# VAMOS A AÑADIR COLUMNA ID_CANCION EN LA TABLA CANCIONES

ALTER TABLE Canciones
ADD COLUMN id_cancion INT PRIMARY KEY AUTO_INCREMENT;
 
SELECT * 
FROM Canciones;

-- VAMOS A AÑADIR FK
    
ALTER TABLE albumes
	ADD CONSTRAINT fk_artista
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista);
    
SELECT *
	FROM
-- ALBUMES FOREIGN KEY (artista_id) REFERENCES artistas(id)
-- CANCIONES FOREIGN KEY (album_id) REFERENCES albumes(id)