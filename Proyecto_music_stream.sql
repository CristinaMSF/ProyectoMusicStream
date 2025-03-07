-- digo que borre porque mi pc ya tiene creada una base de datos llamada asi(podeis hacerlo, borra lo anterior que esta ''mal'' y crea la nueva
 
 -- Un artista puede tener muchos álbumes, pero cada álbum pertenece a un único artista 

-- Un álbum puede contener muchas canciones, pero cada canción pertenece a un único álbum

-- resumen gráfico de las relaciones:
-- uno a muchos (1:N)
-- artistas → tiene muchos → albumes
-- albumes→ tiene muchas → canciones 
-- muchos a muchos (N:M)
-- artistas ↔️ Canciones 


-- Un artista puede estar en muchas canciones (como artista colaborador en canciones de otros).
-- Una canción puede tener múltiples artistas
 --  ON DELETE CASCADE en claves foráneas 
 -- Si un artista se elimina, sus álbumes y canciones también se eliminan automáticamente.
 
 -- DEFAULT 0 en oyentes y reproducciones
-- Si no se proporciona un valor, se establece en 0 por defecto.

DROP DATABASE IF EXISTS pproyecto_music_stream;

-- y creo otra vez

CREATE DATABASE IF NOT EXISTS pproyecto_music_stream;

USE pproyecto_music_stream;

-- esta tabla esta igual:
CREATE TABLE Artistas (
    id_artista INT PRIMARY KEY AUTO_INCREMENT,
	nombre_artista VARCHAR (50) NOT NULL,
	biografia VARCHAR(500),
    oyentes INT DEFAULT 0, -- Si no se especifica, comienza en 0
    genero_musical VARCHAR(20)
    );

-- esta tabla añado la Pk y la Fk, para ello he tenido que meter id_artista para la relacion
CREATE TABLE Albumes (
    id_album VARCHAR(100) PRIMARY KEY,
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
    
-- para almacenar relaciones de artistas similares
CREATE TABLE Artistas_Similares (
    id_artista INT NOT NULL,
    id_artista_similar INT NOT NULL,
    coincidencia FLOAT,
    PRIMARY KEY (id_artista, id_artista_similar),
    CONSTRAINT fk_artistas_similares_artista
        FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista) ON DELETE CASCADE,
    CONSTRAINT fk_artistas_similares_artista_similar
        FOREIGN KEY (id_artista_similar) REFERENCES Artistas(id_artista) ON DELETE CASCADE
);
USE pproyecto_music_stream; 
SELECT *
	FROM artistas;