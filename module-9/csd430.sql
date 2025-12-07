-- csd430.sql
-- Creates DB CSD430, user student1/pass, and table justin_movies_data with sample rows.
-- Safe to re-run (uses IF NOT EXISTS / DROP DATABASE IF EXISTS line is commented out).

-- Optional: start from a clean slate
-- DROP DATABASE IF EXISTS CSD430;

CREATE DATABASE IF NOT EXISTS CSD430
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

-- Create/ensure student user
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;

USE CSD430;

-- Create movies table named <studentfirstname>_movies_data
CREATE TABLE IF NOT EXISTS justin_movies_data (
  movie_id      INT AUTO_INCREMENT PRIMARY KEY,
  title         VARCHAR(100) NOT NULL,
  release_year  INT NOT NULL,
  genre         VARCHAR(30) NOT NULL,
  director      VARCHAR(60),
  runtime_min   SMALLINT,
  mpaa_rating   ENUM('G','PG','PG-13','R','NC-17','NR') DEFAULT 'NR',
  imdb_rating   DECIMAL(3,1) CHECK (imdb_rating >= 0.0 AND imdb_rating <= 10.0),
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Populate with at least 10 records
INSERT INTO justin_movies_data (title, release_year, genre, director, runtime_min, mpaa_rating, imdb_rating) VALUES
('The Dark Knight', 2008, 'Action', 'Christopher Nolan', 152, 'PG-13', 9.0),
('Inception', 2010, 'Sci-Fi', 'Christopher Nolan', 148, 'PG-13', 8.8),
('The Godfather', 1972, 'Crime', 'Francis Ford Coppola', 175, 'R', 9.2),
('Toy Story', 1995, 'Animation', 'John Lasseter', 81, 'G', 8.3),
('The Shawshank Redemption', 1994, 'Drama', 'Frank Darabont', 142, 'R', 9.3),
('Interstellar', 2014, 'Sci-Fi', 'Christopher Nolan', 169, 'PG-13', 8.6),
('Parasite', 2019, 'Thriller', 'Bong Joon-ho', 132, 'R', 8.5),
('Whiplash', 2014, 'Drama', 'Damien Chazelle', 106, 'R', 8.5),
('Spider-Man: Into the Spider-Verse', 2018, 'Animation', 'Bob Persichetti', 117, 'PG', 8.4),
('Gladiator', 2000, 'Action', 'Ridley Scott', 155, 'R', 8.5);

-- Quick verification queries (handy for screenshots)
-- SHOW DATABASES;
-- USE CSD430;
-- SHOW TABLES;
-- DESCRIBE justin_movies_data;
-- SELECT COUNT(*) AS total_rows FROM justin_movies_data;
-- SELECT * FROM justin_movies_data ORDER BY movie_id;
