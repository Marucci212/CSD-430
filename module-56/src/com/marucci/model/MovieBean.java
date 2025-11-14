package com.marucci.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.*;
import java.util.LinkedHashMap;

/**
 * MovieBean - JavaBean used to retrieve a single movie record from MySQL.
 * Requirements this bean supports:
 * - Implements java.io.Serializable
 * - Loads a record by unique key (id)
 * - Provides a helper to fetch a dropdown menu (id -> title) for JSP
 *
 * NOTE: DB user/perm are configured in SQL (GRANT on CSD430.* to student1/pass).
 * This bean only uses those credentials; it does not alter permissions.
 */
public class MovieBean implements Serializable {
    private static final long serialVersionUID = 1L;

    // --- DB connection settings (adjust host/port if needed) ---
    private static final String URL  = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "student1";
    private static final String PASS = "pass";

    // --- Bean fields (≥5 fields) ---
    private int id;
    private String title;
    private String releaseYear;
    private String genre;
    private BigDecimal rating;
    private int minutes;
    private Timestamp createdAt;

    // --- Getters/Setters (JavaBean pattern) ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getReleaseYear() { return releaseYear; }
    public void setReleaseYear(String releaseYear) { this.releaseYear = releaseYear; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public BigDecimal getRating() { return rating; }
    public void setRating(BigDecimal rating) { this.rating = rating; }

    public int getMinutes() { return minutes; }
    public void setMinutes(int minutes) { this.minutes = minutes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    /**
     * Loads a single movie row by primary key id and populates the bean fields.
     * @param keyId unique primary key from table justin_movies_data
     * @throws Exception when no row found or on SQL errors
     */
    public void loadById(int keyId) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = "SELECT id, title, release_year, genre, rating, minutes, created_at " +
                     "FROM justin_movies_data WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, keyId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    throw new Exception("No record found for id=" + keyId);
                }
                this.id = rs.getInt("id");
                this.title = rs.getString("title");
                this.releaseYear = rs.getString("release_year");
                this.genre = rs.getString("genre");
                this.rating = rs.getBigDecimal("rating");
                this.minutes = rs.getInt("minutes");
                this.createdAt = rs.getTimestamp("created_at");
            }
        }
    }

    /**
     * Helper used by the JSP dropdown to list available keys.
     * Returns a LinkedHashMap preserving insert order: id -> title
     */
    public static LinkedHashMap<Integer, String> fetchKeyMenu() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = "SELECT id, title FROM justin_movies_data ORDER BY id";
        LinkedHashMap<Integer, String> menu = new LinkedHashMap<>();
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                menu.put(rs.getInt("id"), rs.getString("title"));
            }
        }
        return menu;
    }
}
