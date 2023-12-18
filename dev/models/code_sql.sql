--- Create the DATABASE
CREATE DATABASE SongFusion;

--- Use the DATABASE
USE SongFusion;

--- Create the tables
-- Tabla USER
CREATE TABLE users (
    id_user BINARY(16) PRIMARY KEY DEFAULT UUID_TO_BIN(UUID()),
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    verification_token VARCHAR(255),
    is_verified BOOLEAN DEFAULT FALSE,
    authentication_token VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Inactive',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla SONGS
CREATE TABLE songs (
    id_song BINARY(16) PRIMARY KEY DEFAULT UUID_TO_BIN(UUID()),
    id_song_api VARCHAR(255),
    title_song VARCHAR(255) NOT NULL,
    eng_lyrics_song TEXT,
    esp_lyrics_song TEXT,
    images_song TEXT,
    artist_id BINARY(16),
    video_song VARCHAR(255),
    FOREIGN KEY (artist_id) REFERENCES artists(id_artist),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla ARTIST
CREATE TABLE artists (
    id_artist BINARY(16) PRIMARY KEY DEFAULT UUID_TO_BIN(UUID()),
    name_artist VARCHAR(255) NOT NULL,
    image_artist TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla SONGS_IMAGES
CREATE TABLE songs_images (
    id_images BINARY(16) PRIMARY KEY DEFAULT UUID_TO_BIN(UUID()),
    id_song BINARY(16),
    type_images VARCHAR(50) NOT NULL,
    path_images TEXT NOT NULL,
    FOREIGN KEY (id_song) REFERENCES songs(id_song),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

