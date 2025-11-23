<%@ page import="java.util.List" %>
<%@ page import="moviedb.MovieBean" %>

<%
    // display.jsp
    // Handles inserting a new movie and displaying all movies.

    request.setCharacterEncoding("UTF-8");

    String message = "";

    // If the user submitted the form, insert a new record
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String title        = request.getParameter("title");
        String releaseYearS = request.getParameter("releaseYear");
        String genre        = request.getParameter("genre");
        String director     = request.getParameter("director");
        String runtimeMinS  = request.getParameter("runtimeMin");
        String mpaaRating   = request.getParameter("mpaaRating");
        String imdbRatingS  = request.getParameter("imdbRating");

        if (title != null && title.trim().length() > 0) {
            try {
                int releaseYear = Integer.parseInt(releaseYearS);
                int runtimeMin  = Integer.parseInt(runtimeMinS);
                double imdbRating = Double.parseDouble(imdbRatingS);

                MovieBean movie = new MovieBean();
                movie.setTitle(title.trim());
                movie.setReleaseYear(releaseYear);
                movie.setGenre(genre.trim());
                movie.setDirector(director.trim());
                movie.setRuntimeMin(runtimeMin);
                movie.setMpaaRating(mpaaRating);
                movie.setImdbRating(imdbRating);

                movie.insert();

                message = "Movie added successfully.";
            } catch (Exception ex) {
                message = "Error adding movie: " + ex.getMessage();
            }
        } else {
            message = "Title is required.";
        }
    }

    // Always load the current list of movies
    List<MovieBean> movies = null;
    try {
        movies = MovieBean.findAll();
    } catch (Exception ex) {
        message = "Error loading movies: " + ex.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie Database - Add and View Movies</title>
    
    <style>
        body { font-family: Arial, sans-serif; }
        h1, h2 { margin-bottom: 0.25rem; }
        table { border-collapse: collapse; width: 100%; margin-top: 1rem; }
        th, td { border: 1px solid #ccc; padding: 0.5rem; text-align: left; }
        thead { background-color: #f0f0f0; }
        .message { margin-top: 0.5rem; font-weight: bold; }
        .form-container { margin-top: 1rem; padding: 0.5rem; border: 1px solid #ccc; }
        label { display: inline-block; width: 140px; }
        .field-row { margin-bottom: 0.4rem; }
    </style>
</head>
<body>

<h1>Justin&rsquo;s Movie Database</h1>
<p>This page lets you add a new movie to the <code>justin_movies_data</code> table
   and view all existing records stored in the database.</p>

<% if (message != null && message.length() > 0) { %>
    <p class="message"><%= message %></p>
<% } %>

<div class="form-container">
    <h2>Add a New Movie</h2>
    <p>Enter the movie details below. The primary key (<code>movie_id</code>) is added automatically.</p>

    <form method="post" action="display.jsp">
        <div class="field-row">
            <label for="title">Title:</label>
            <input type="text" name="title" id="title" required>
        </div>

        <div class="field-row">
            <label for="releaseYear">Release Year:</label>
            <input type="number" name="releaseYear" id="releaseYear" required>
        </div>

        <div class="field-row">
            <label for="genre">Genre:</label>
            <input type="text" name="genre" id="genre" required>
        </div>

        <div class="field-row">
            <label for="director">Director:</label>
            <input type="text" name="director" id="director">
        </div>

        <div class="field-row">
            <label for="runtimeMin">Runtime (minutes):</label>
            <input type="number" name="runtimeMin" id="runtimeMin" required>
        </div>

        <div class="field-row">
            <label for="mpaaRating">MPAA Rating:</label>
            <select name="mpaaRating" id="mpaaRating">
                <option value="G">G</option>
                <option value="PG">PG</option>
                <option value="PG-13">PG-13</option>
                <option value="R">R</option>
                <option value="NC-17">NC-17</option>
                <option value="NR" selected>NR</option>
            </select>
        </div>

        <div class="field-row">
            <label for="imdbRating">IMDb Rating (0.0 - 10.0):</label>
            <input type="text" name="imdbRating" id="imdbRating" required>
        </div>

        <div class="field-row">
            <input type="submit" value="Add Movie">
        </div>
    </form>
</div>

<h2>All Movies in the Database</h2>
<p>The table below shows all records stored in the <code>justin_movies_data</code> table.</p>

<table>
    <thead>
        <tr>
            <th>Movie ID</th>
            <th>Title</th>
            <th>Release Year</th>
            <th>Genre</th>
            <th>Director</th>
            <th>Runtime (min)</th>
            <th>MPAA Rating</th>
            <th>IMDb Rating</th>
        </tr>
    </thead>
    <tbody>
    <%
        if (movies != null) {
            for (MovieBean m : movies) {
    %>
        <tr>
            <td><%= m.getMovieId() %></td>
            <td><%= m.getTitle() %></td>
            <td><%= m.getReleaseYear() %></td>
            <td><%= m.getGenre() %></td>
            <td><%= m.getDirector() %></td>
            <td><%= m.getRuntimeMin() %></td>
            <td><%= m.getMpaaRating() %></td>
            <td><%= m.getImdbRating() %></td>
        </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

<p><a href="index.jsp">Back to Index</a></p>

</body>
</html>
