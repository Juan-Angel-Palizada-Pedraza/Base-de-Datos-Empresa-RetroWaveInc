# Proyecto Final "Base dispositivo"
# Elaborado por: Juan Angel Palizada Pedraza
# Fecha: 08 de Noviembre de 2024

# Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS DispositivoWalkman;

USE DispositivoWalkman;

# Tabla: Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    ID_Usuario INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Usuario VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Contraseña_Hash VARCHAR(255) NOT NULL,
    Preferencias TEXT
);

# Tabla: Suscripciones y Servicios
CREATE TABLE IF NOT EXISTS Suscripciones (
    ID_Suscripcion INT PRIMARY KEY AUTO_INCREMENT,
    ID_Usuario INT,
    Nombre_Servicio VARCHAR(50) NOT NULL,
    Estado_Suscripcion ENUM('Activo', 'Expirado') NOT NULL,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);

# Tabla: Playlists
CREATE TABLE IF NOT EXISTS Playlists (
    ID_Playlist INT PRIMARY KEY AUTO_INCREMENT,
    ID_Usuario INT,
    Nombre_Playlist VARCHAR(100) NOT NULL,
    Fecha_Creación DATE NOT NULL,
    Tipo ENUM('Streaming', 'Local') NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);

# Tabla: Fuentes_Musica
CREATE TABLE IF NOT EXISTS Fuentes_Musica (
    ID_Fuente INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Fuente VARCHAR(50) NOT NULL,
    Tipo_Fuente ENUM('Streaming', 'Local') NOT NULL,
    URL_Streaming VARCHAR(255)
);

# Tabla: Canciones
CREATE TABLE IF NOT EXISTS Canciones (
    ID_Cancion INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(100) NOT NULL,
    Artista VARCHAR(100),
    Álbum VARCHAR(100),
    Duración INT NOT NULL,
    Formato ENUM('Casete', 'MP3', 'Streaming') NOT NULL,
    ID_Fuente INT,
    FOREIGN KEY (ID_Fuente) REFERENCES Fuentes_Musica(ID_Fuente)
);

# Tabla: Canciones_Playlist
CREATE TABLE IF NOT EXISTS Canciones_Playlist (
    ID_Playlist INT,
    ID_Cancion INT,
    Orden INT NOT NULL,
    PRIMARY KEY (ID_Playlist, ID_Cancion),
    FOREIGN KEY (ID_Playlist) REFERENCES Playlists(ID_Playlist),
    FOREIGN KEY (ID_Cancion) REFERENCES Canciones(ID_Cancion)
);

# Tabla: Configuración
CREATE TABLE IF NOT EXISTS Configuración (
    ID_Configuración INT PRIMARY KEY AUTO_INCREMENT,
    ID_Usuario INT,
    Brillo INT CHECK (Brillo BETWEEN 0 AND 100),
    Volumen INT CHECK (Volumen BETWEEN 0 AND 100),
    Modo_Ecualizador VARCHAR(50),
    Modo_Reproducción ENUM('Aleatorio', 'Repetición', 'Normal'),
    Idioma VARCHAR(20),
    Zona_Horaria VARCHAR(50),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);

# Tabla: Historial_Reproducción
CREATE TABLE IF NOT EXISTS Historial_Reproducción (
    ID_Historial INT PRIMARY KEY AUTO_INCREMENT,
    ID_Usuario INT,
    ID_Cancion INT,
    Fecha_Hora DATETIME NOT NULL,
    Duración_Reproducción INT NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
    FOREIGN KEY (ID_Cancion) REFERENCES Canciones(ID_Cancion)
);

# Tabla: Análisis de Uso
CREATE TABLE IF NOT EXISTS Analisis_Uso (
    ID_Analisis INT PRIMARY KEY AUTO_INCREMENT,
    ID_Usuario INT,
    Periodo_Analisis VARCHAR(50),
    Total_Reproducciones INT,
    Duración_Total INT,
    Fuente_Preferida VARCHAR(50),
    Genero_Preferido VARCHAR(50),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);

# ---------------------- Inserción de datos a cada tabla ----------------------

# Inserción en Tabla: Usuarios
INSERT INTO Usuarios (Nombre_Usuario, Email, Contraseña_Hash, Preferencias)
VALUES 
('Carlos Morales', 'carlos.morales@gmail.com', 'hashed_password_123', 'Rock clásico, listas personalizadas'),
('María López', 'maria.lopez@yahoo.com', 'hashed_password_456', 'Pop, streaming de Spotify');

# Inserción en Tabla: Suscripciones
INSERT INTO Suscripciones (ID_Usuario, Nombre_Servicio, Estado_Suscripcion, Fecha_Inicio, Fecha_Fin)
VALUES
(1, 'Deezer', 'Activo', '2024-10-10', '2025-10-10'),
(2, 'YouTube Music', 'Activo', '2024-11-01', '2025-11-01'),
(1, 'Tidal', 'Activo', '2024-09-01', '2025-09-01'),
(2, 'Amazon Music', 'Expirado', '2023-10-01', '2024-10-01'),
(1, 'Spotify Free', 'Expirado', '2023-10-01', '2024-10-01');

# Inserción en Tabla: Playlist
INSERT INTO Playlists (ID_Usuario, Nombre_Playlist, Fecha_Creación, Tipo)
VALUES
(1, 'Favoritas del mes', '2024-11-01', 'Local'),
(2, 'Hits Actuales', '2024-11-05', 'Streaming');

# Inserción en Tabla: Fuente_Musica
INSERT INTO Fuentes_Musica (Nombre_Fuente, Tipo_Fuente, URL_Streaming)
VALUES
('Tidal', 'Streaming', 'https://tidal.com'),
('YouTube Music', 'Streaming', 'https://music.youtube.com'),
('Deezer', 'Streaming', 'https://deezer.com'),
('Amazon Music', 'Streaming', 'https://music.amazon.com'),
('Casetes Locales', 'Local', NULL);

# Inserción en Tabla: Canciones
INSERT INTO Canciones (Titulo, Artista, Álbum, Duración, Formato, ID_Fuente) 
VALUES 
('Self Care', 'Mac Miller', 'Swimming', 312, 'Streaming', 1),
('Blue World', 'Mac Miller', 'Circles', 260, 'Streaming', 1),
('Dang!', 'Mac Miller ft. Anderson .Paak', 'The Divine Feminine', 307, 'Streaming', 1),
('Awful Things', 'Lil Peep ft. Lil Tracy', 'Come Over When You’re Sober', 237, 'Streaming', 2),
('Save That Shit', 'Lil Peep', 'Come Over When You’re Sober', 229, 'Streaming', 2),
('Benz Truck', 'Lil Peep', 'Come Over When You’re Sober', 193, 'Streaming', 2),
('Man on the Moon', 'Kid Cudi', 'Man on the Moon', 210, 'Streaming', 1),
('Pursuit of Happiness', 'Kid Cudi', 'Man on the Moon', 298, 'Streaming', 1),
('Erase Me', 'Kid Cudi ft. Kanye West', 'Man on the Moon II', 246, 'Streaming', 1),
('Stronger', 'Kanye West', 'Graduation', 312, 'Streaming', 1),
('Runaway', 'Kanye West ft. Pusha T', 'My Beautiful Dark Twisted Fantasy', 548, 'Streaming', 1),
('Power', 'Kanye West', 'My Beautiful Dark Twisted Fantasy', 292, 'Streaming', 1),
('Imagine', 'John Lennon', 'Imagine', 183, 'Casete', NULL),
('Hotel California', 'Eagles', 'Hotel California', 390, 'Streaming', NULL), 
('Smells Like Teen Spirit', 'Nirvana', 'Nevermind', 301, 'Streaming', NULL),
('Blinding Lights', 'The Weeknd', 'After Hours', 200, 'Streaming', 3),
('Levitating', 'Dua Lipa', 'Future Nostalgia', 203, 'Streaming', 3);

# Inserción en Tabla: Canciones_Playlist
INSERT INTO Canciones_Playlist (ID_Playlist, ID_Cancion, Orden)
VALUES
(1, 1, 1),  -- "Self Care" en la Playlist 1
(1, 2, 2),  -- "Blue World" en la Playlist 1
(1, 3, 3),  -- "Dang!" en la Playlist 1
(2, 4, 1),  -- "Awful Things" en la Playlist 2
(2, 5, 2),  -- "Save That Shit" en la Playlist 2
(2, 6, 3),  -- "Benz Truck" en la Playlist 2
(2, 7, 4),  -- "Man on the Moon" en la Playlist 2
(2, 8, 5),  -- "Pursuit of Happiness" en la Playlist 2
(2, 9, 6),  -- "Erase Me" en la Playlist 2
(2, 10, 7),  -- "Stronger" en la Playlist 2
(2, 11, 8),  -- "Runaway" en la Playlist 2
(2, 12, 9),  -- "Power" en la Playlist 2
(2, 13, 10), -- "Imagine" en la Playlist 2
(2, 14, 11), -- "Hotel California" en la Playlist 2
(2, 15, 12), -- "Smells Like Teen Spirit" en la Playlist 2
(2, 16, 13), -- "Blinding Lights" en la Playlist 2
(2, 17, 14); -- "Levitating" en la Playlist 2

# Inserción en Tabla: Configuración
INSERT INTO Configuración (ID_Usuario, Brillo, Volumen, Modo_Ecualizador, Modo_Reproducción, Idioma, Zona_Horaria)
VALUES
(1, 75, 80, 'Normal', 'Aleatorio', 'Español', 'UTC-6'),  -- Configuración para Carlos Morales
(2, 65, 70, 'Rock', 'Repetición', 'Español', 'UTC-6');  -- Configuración para María López

# Inserción en Tabla: Historial_Reproducción
INSERT INTO Historial_Reproducción (ID_Usuario, ID_Cancion, Fecha_Hora, Duración_Reproducción)
VALUES
(1, 1, '2024-11-15 10:00:00', 312), -- Self Care por Mac Miller
(1, 7, '2024-11-15 11:00:00', 210), -- Man on the moon por Kid Cudi
(2, 10, '2024-11-15 12:30:00', 312), -- Stronger por Kanye West
(2, 14, '2024-11-15 14:00:00', 390), -- Hotel California por Eagles
(1, 16, '2024-11-15 15:30:00', 200); -- Blinding Lights por The Weeknd

# Inserción en Tabla: Analisis_Uso
INSERT INTO Analisis_Uso (ID_Usuario, Periodo_Analisis, Total_Reproducciones, Duración_Total, Fuente_Preferida, Genero_Preferido)
VALUES
(1, 'Octubre 2024', 20, 7100, 'Spotify', 'Rap'),
(2, 'Octubre 2024', 15, 3950, 'Apple Music', 'Rock');

# ---------------------- Consultas a la base de datos ----------------------

# Canciones por Playlist
# Recupera todas las canciones asociadas a una playlist específica, organizadas por el orden de reproducción:
SELECT p.Nombre_Playlist, c.Titulo, c.Artista, cp.Orden 
FROM Playlists p 
JOIN Canciones_Playlist cp ON p.ID_Playlist = cp.ID_Playlist 
JOIN Canciones c ON cp.ID_Cancion = c.ID_Cancion 
WHERE p.ID_Usuario = 1 
ORDER BY cp.Orden ASC;

# Historial de Reproducción
# Muestra las canciones reproducidas por un usuario en un rango de fechas:
SELECT u.Nombre_Usuario, c.Titulo, hr.Fecha_Hora, hr.Duración_Reproducción 
FROM Usuarios u 
JOIN Historial_Reproducción hr ON u.ID_Usuario = hr.ID_Usuario 
JOIN Canciones c ON hr.ID_Cancion = c.ID_Cancion 
WHERE u.ID_Usuario = 1 AND hr.Fecha_Hora BETWEEN '2024-11-01 00:00:00' AND '2024-11-30 23:59:59';
