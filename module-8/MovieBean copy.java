package com.marucci.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

public class MovieBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // DB connection settings (match csd430 copy.sql)
    private static final String URL  = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "student1";
    private static final String PASS = "pass";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    // Fields – map directly to justin_movies_data columns
    // movie_id, title, release_year, genre, director, runtime_min, imdb_rating, created_at
    private int id;                    // movie_id
    private String title;              // title
    private String director;           // director
    private String genre;              // genre
    private int year;                  // release_year
    private BigDecimal rating;         // imdb_rating (0.0–10.0)
    private int minutes;               // runtime_min
    private Timestamp createdAt;       // created_at

    // ===== Getters / setters =====
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    // Alias for convenience (if any JSP uses getMovieId/setMovieId)
    public int getMovieId() {
        return id;
    }
    public void setMovieId(int movieId) {
        this.id = movieId;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getDirector() {
        return director;
    }
    public void setDirector(String director) {
        this.director = director;
    }

    public String getGenre() {
        return genre;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }

    // Store year as int, but support both int and String-style getters/setters
    public int getYear() {
        return year;
    }
    public void setYear(int year) {
        this.year = year;
    }

    // For any older JSPs using releaseYear as String
    public String getReleaseYear() {
        return Integer.toString(year);
    }
    public void setReleaseYear(String releaseYear) {
        try {
            this.year = Integer.parseInt(releaseYear);
        } catch (NumberFormatException e) {
            this.year = 0;
        }
    }

    public BigDecimal getRating() {
        return rating;
    }
    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public int getMinutes() {
        return minutes;
    }
    public void setMinutes(int minutes) {
        this.minutes = minutes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // ===== Instance helper to load a single record by key =====
    public void loadById(int keyId) throws Exception {
        String sql = "SELECT movie_id, title, director, genre, release_year, " +
                     "runtime_min, imdb_rating, created_at " +
                     "FROM justin_movies_data WHERE movie_id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, keyId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    this.id        = rs.getInt("movie_id");
                    this.title     = rs.getString("title");
                    this.director  = rs.getString("director");
                    this.genre     = rs.getString("genre");
                    this.year      = rs.getInt("release_year");
                    this.minutes   = rs.getInt("runtime_min");
                    this.rating    = rs.getBigDecimal("imdb_rating");
                    this.createdAt = rs.getTimestamp("created_at");
                } else {
                    throw new Exception("Movie with id " + keyId + " not found.");
                }
            }
        }
    }

    // ===== Static helpers used by your JSPs =====

    // Used by record.jsp for dropdown and for Part 2 pages
    public static List<MovieBean> getAllMovies() throws Exception {
        List<MovieBean> movies = new ArrayList<>();

        String sql = "SELECT movie_id, title, director, genre, release_year, " +
                     "runtime_min, imdb_rating, created_at " +
                     "FROM justin_movies_data ORDER BY movie_id";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                MovieBean m = new MovieBean();
                m.id        = rs.getInt("movie_id");
                m.title     = rs.getString("title");
                m.director  = rs.getString("director");
                m.genre     = rs.getString("genre");
                m.year      = rs.getInt("release_year");
                m.minutes   = rs.getInt("runtime_min");
                m.rating    = rs.getBigDecimal("imdb_rating");
                m.createdAt = rs.getTimestamp("created_at");
                movies.add(m);
            }
        }

        return movies;
    }

    // Used by record.jsp & processupdate.jsp
    public static MovieBean getMovieById(int id) throws Exception {
        MovieBean m = new MovieBean();
        m.loadById(id);
        return m;
    }

    // Used by processupdate.jsp to update the selected movie
    public static void updateMovie(MovieBean movie) throws Exception {
        String sql = "UPDATE justin_movies_data " +
                     "SET title = ?, director = ?, genre = ?, " +
                     "    release_year = ?, imdb_rating = ? " +
                     "WHERE movie_id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movie.getTitle());
            ps.setString(2, movie.getDirector());
            ps.setString(3, movie.getGenre());
            ps.setInt(4, movie.getYear());
            ps.setBigDecimal(5, movie.getRating());
            ps.setInt(6, movie.getId());

            ps.executeUpdate();
        }
    }

    // Used by select/display pages (if you want a simple id->title dropdown)
    public static LinkedHashMap<Integer, String> fetchKeyMenu() throws Exception {
        LinkedHashMap<Integer, String> menu = new LinkedHashMap<>();

        String sql = "SELECT movie_id, title FROM justin_movies_data ORDER BY movie_id";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int key   = rs.getInt("movie_id");
                String t  = rs.getString("title");
                menu.put(key, t);
            }
        }

        return menu;
    }
}

