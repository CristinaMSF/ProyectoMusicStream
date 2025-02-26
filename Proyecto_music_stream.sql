-- digo que borre porque mi pc ya tiene creada una base de datos llamada asi(podeis hacerlo, borra lo anterior que esta ''mal'' y crea la nueva

DROP DATABASE IF EXISTS proyecto_music_stream;

-- y creo otra vez

CREATE DATABASE IF NOT EXISTS proyecto_music_stream;

USE proyecto_music_stream;

-- esta tabla esta igual:
CREATE TABLE Artistas (
    id_artista INT PRIMARY KEY AUTO_INCREMENT,
	nombre_artista VARCHAR (50) NOT NULL,
	biografia VARCHAR(500),
    oyentes INT,
    genero_musical VARCHAR(20),
    artistas_similares VARCHAR(200)
    );

-- esta tabla añado la Pk y la Fk, para ello he tenido que meter id_artista para la relacion
CREATE TABLE Albumes (
    id_album VARCHAR(100) PRIMARY KEY,
    titulo_album VARCHAR(75),
    año_lanzamiento YEAR,
    id_artista INT,  -- Se agrega la columna para la relación
    CONSTRAINT fk_albumes
        FOREIGN KEY (id_artista) REFERENCES artistas(id_artista)
    );
    
-- añado la FK y tengo que crear id_album como columna para relacionarlas:    
CREATE TABLE Canciones (
	id_cancion INT PRIMARY KEY AUTO_INCREMENT,
    titulo_cancion VARCHAR(100),
    reproducciones INT,
    id_album VARCHAR(100),
    CONSTRAINT fk_canciones_albumes
        FOREIGN KEY (id_album) REFERENCES Albumes(id_album)
   ); 
    
-- hemos creado esta tabla para poder relacionar tablas: 
CREATE TABLE Artistas_en_Canciones (
    id_artista INT,
    id_cancion INT,
    PRIMARY KEY (id_artista, id_cancion),
    CONSTRAINT fk_artistas_en_canciones_artistas
        FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista),
    CONSTRAINT fk_artistas_en_canciones_canciones
        FOREIGN KEY (id_cancion) REFERENCES Canciones(id_cancion)
    );
    