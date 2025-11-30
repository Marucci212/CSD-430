<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.marucci.model.MovieBean" %>

<%
    request.setCharacterEncoding("UTF-8");

    String error = null;
    MovieBean updated = null;

    try {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String title    = request.getParameter("title");
        String director = request.getParameter("director");
        String genre    = request.getParameter("genre");
        String yearStr  = request.getParameter("year");
        String ratingStr= request.getParameter("rating");

        int year = 0;
        if (yearStr != null && yearStr.trim().length() > 0) {
            year = Integer.parseInt(yearStr.trim());
        }

        BigDecimal rating = null;
        if (ratingStr != null && ratingStr.trim().length() > 0) {
            rating = new BigDecimal(ratingStr.trim());
        }

        // Build bean and update
        MovieBean m = new MovieBean();
        m.setId(movieId);
        m.setTitle(title);
        m.setDirector(director);
        m.setGenre(genre);
        m.setYear(year);
        m.setRating(rating);

        MovieBean.updateMovie(m);
        updated = MovieBean.getMovieById(movieId);

    } catch (Exception e) {
        error = e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Updated Movie</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 10px; }
        table { border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #333; padding: 8px; }
        .error { color: #b00020; margin-top: 10px; }
        .nav { margin-top: 20px; }
    </style>
</head>
<body>
<h1>Updated Movie Record</h1>

<% if (error != null) { %>
    <p class="error">Error: <%= error %></p>
<% } else if (updated != null) { %>
    <table>
        <thead>
        <tr>
            <th>Field</th>
            <th>Type / Description</th>
            <th>Value</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>movie_id</td>
            <td>Primary key (auto-increment)</td>
            <td><%= updated.getId() %></td>
        </tr>
        <tr>
            <td>title</td>
            <td>Movie title</td>
            <td><%= updated.getTitle() %></td>
        </tr>
        <tr>
            <td>director</td>
            <td>Director name</td>
            <td><%= updated.getDirector() %></td>
        </tr>
        <tr>
            <td>genre</td>
            <td>Genre label</td>
            <td><%= updated.getGenre() %></td>
        </tr>
        <tr>
            <td>release_year</td>
            <td>Release year (YYYY)</td>
            <td><%= updated.getYear() %></td>
        </tr>
        <tr>
            <td>imdb_rating</td>
            <td>Rating (0.0 - 10.0)</td>
            <td><%= updated.getRating() %></td>
        </tr>
        <tr>
            <td>created_at</td>
            <td>Row creation timestamp</td>
            <td><%= updated.getCreatedAt() %></td>
        </tr>
        </tbody>
    </table>
<% } %>

<div class="nav">
    <p><a href="record.jsp">Update Another Movie</a></p>
    <p><a href="index.jsp">Return to Index</a></p>
</div>
</body>
</html>
