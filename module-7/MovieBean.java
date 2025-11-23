// Justin Marucci 
// Assignment 7
// 11-22-25


package moviedb;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieBean {

    // ----- Bean properties -----
    private int movieId;
    private String title;
    private int releaseYear;
    private String genre;
    private String director;
    private int runtimeMin;
    private String mpaaRating;
    private double imdbRating;

    // ----- Getters and setters -----
    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getReleaseYear() { return releaseYear; }
    public void setReleaseYear(int releaseYear) { this.releaseYear = releaseYear; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    public int getRuntimeMin() { return runtimeMin; }
    public void setRuntimeMin(int runtimeMin) { this.runtimeMin = runtimeMin; }

    public String getMpaaRating() { return mpaaRating; }
    public void setMpaaRating(String mpaaRating) { this.mpaaRating = mpaaRating; }

    public double getImdbRating() { return imdbRating; }
    public void setImdbRating(double imdbRating) { this.imdbRating = imdbRating; }

    // ----- Helper: get DB connection -----
    // Uses DB, user, and password from your csd430.sql.
    private Connection getConnection() throws Exception {
        String url  = "jdbc:mysql://localhost:3306/CSD430";
        String user = "student1";
        String pass = "pass";

        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }

    // ----- Insert a new row -----
    public void insert() throws Exception {
        String sql = "INSERT INTO justin_movies_data " +
                     "(title, release_year, genre, director, runtime_min, mpaa_rating, imdb_rating) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setInt(2, releaseYear);
            ps.setString(3, genre);
            ps.setString(4, director);
            ps.setInt(5, runtimeMin);
            ps.setString(6, mpaaRating);
            ps.setDouble(7, imdbRating);

            ps.executeUpdate();
        }
    }

    // ----- Read all rows into a list of MovieBean objects -----
    public static List<MovieBean> findAll() throws Exception {
        List<MovieBean> movies = new ArrayList<>();

        String url  = "jdbc:mysql://localhost:3306/CSD430";
        String user = "student1";
        String pass = "pass";

        Class.forName("com.mysql.cj.jdbc.Driver");

        String sql = "SELECT movie_id, title, release_year, genre, director, " +
                     "runtime_min, mpaa_rating, imdb_rating " +
                     "FROM justin_movies_data ORDER BY movie_id";

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                MovieBean m = new MovieBean();
                m.setMovieId(rs.getInt("movie_id"));
                m.setTitle(rs.getString("title"));
                m.setReleaseYear(rs.getInt("release_year"));
                m.setGenre(rs.getString("genre"));
                m.setDirector(rs.getString("director"));
                m.setRuntimeMin(rs.getInt("runtime_min"));
                m.setMpaaRating(rs.getString("mpaa_rating"));
                m.setImdbRating(rs.getDouble("imdb_rating"));
                movies.add(m);
            }
        }

        return movies;
    }
}
