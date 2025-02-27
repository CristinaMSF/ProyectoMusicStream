-- digo que borre porque mi pc ya tiene creada una base de datos llamada asi(podeis hacerlo, borra lo anterior que esta ''mal'' y crea la nueva
 
 --  ON DELETE CASCADE en claves foráneas 
 -- Si un artista se elimina, sus álbumes y canciones también se eliminan automáticamente.
 
 -- DEFAULT 0 en oyentes y reproducciones
-- Si no se proporciona un valor, se establece en 0 por defecto.

DROP DATABASE IF EXISTS proyecto_music_stream;

-- y creo otra vez

CREATE DATABASE IF NOT EXISTS proyecto_music_stream;

USE proyecto_music_stream;

-- esta tabla esta igual:
CREATE TABLE Artistas (
    id_artista INT PRIMARY KEY AUTO_INCREMENT,
	nombre_artista VARCHAR (50) NOT NULL,
	biografia VARCHAR(500),
    oyentes INT DEFAULT 0, -- Si no se especifica, comienza en 0
    genero_musical VARCHAR(20),
    artistas_similares VARCHAR(200)  -- Puede mejorarse con una tabla aparte artistas_similares, ahora no es una relación normalizada
    );

-- esta tabla añado la Pk y la Fk, para ello he tenido que meter id_artista para la relacion
CREATE TABLE Albumes (
    id_album VARCHAR(50) PRIMARY KEY,
    titulo_album VARCHAR(75) NOT NULL,
    año_lanzamiento YEAR NOT NULL,
    id_artista INT NOT NULL,  -- Se agrega la columna para la relación con Artistas
    CONSTRAINT fk_albumes_artistas
        FOREIGN KEY (id_artista) REFERENCES artistas(id_artista) ON DELETE CASCADE
    );
    
-- añado la FK y tengo que crear id_album como columna para relacionarlas:    
CREATE TABLE Canciones (
	id_cancion INT PRIMARY KEY AUTO_INCREMENT,
    titulo_cancion VARCHAR(100) NOT NULL,
    reproducciones INT  DEFAULT 0,  -- Si no se especifica, empieza en 0
    id_album VARCHAR(100) NOT NULL,  -- Relación con Álbumes
    CONSTRAINT fk_canciones_albumes
        FOREIGN KEY (id_album) REFERENCES Albumes(id_album) ON DELETE CASCADE
   ); 
    
-- hemos creado esta tabla para relación muchos a muchos entre Artistas y Canciones: 
CREATE TABLE Artistas_en_Canciones (
    id_artista INT NOT NULL,
    id_cancion INT NOT NULL,
    PRIMARY KEY (id_artista, id_cancion),
    CONSTRAINT fk_artistas_en_canciones_artistas
        FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista) ON DELETE CASCADE,
    CONSTRAINT fk_artistas_en_canciones_canciones
        FOREIGN KEY (id_cancion) REFERENCES Canciones(id_cancion) ON DELETE CASCADE
    );
 
