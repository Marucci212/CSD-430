<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.marucci.model.MovieBean" %>

<%
    request.setCharacterEncoding("UTF-8");

    String movieIdParam = request.getParameter("movieId");
    List<MovieBean> movies = null;
    MovieBean selectedMovie = null;
    String error = null;

    try {
        movies = MovieBean.getAllMovies();
        if (movieIdParam != null && movieIdParam.trim().length() > 0) {
            int id = Integer.parseInt(movieIdParam);
            selectedMovie = MovieBean.getMovieById(id);
        }
    } catch (Exception e) {
        error = e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Movie</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1, h2 { margin-bottom: 10px; }
        label { display: block; margin-top: 8px; }
        input[type=text], input[type=number] { width: 260px; }
        select { width: 280px; }
        .error { color: #b00020; margin-top: 10px; }
        .nav { margin-top: 20px; }
    </style>
</head>
<body>
<h1>Update Existing Movie</h1>

<% if (error != null) { %>
    <p class="error">Error: <%= error %></p>
<% } %>

<h2>Step 1: Choose a Movie</h2>
<form method="get" action="record.jsp">
    <label for="movieId">Movie (by key):</label>
    <select name="movieId" id="movieId">
        <option value="">-- Select a Movie --</option>
        <%
            if (movies != null) {
                for (MovieBean m : movies) {
                    int id = m.getId();
                    boolean selected = (selectedMovie != null && id == selectedMovie.getId());
        %>
                    <option value="<%= id %>" <%= selected ? "selected" : "" %>>
                        <%= id %> - <%= m.getTitle() %>
                    </option>
        <%
                }
            }
        %>
    </select>
    <br><br>
    <input type="submit" value="Load Movie">
</form>

<% if (selectedMovie != null) { %>
    <h2>Step 2: Edit Movie Fields</h2>
    <form method="post" action="processupdate.jsp">
        <!-- Non-updateable key field -->
        <p>
            <strong>Movie ID (key):</strong>
            <span><%= selectedMovie.getId() %></span>
            <input type="hidden" name="movieId" value="<%= selectedMovie.getId() %>">
        </p>

        <label>Title:
            <input type="text" name="title" value="<%= selectedMovie.getTitle() %>">
        </label>

        <label>Director:
            <input type="text" name="director" value="<%= selectedMovie.getDirector() %>">
        </label>

        <label>Genre:
            <input type="text" name="genre" value="<%= selectedMovie.getGenre() %>">
        </label>

        <label>Year:
            <input type="number" name="year" value="<%= selectedMovie.getYear() %>">
        </label>

        <label>IMDB Rating (0.0–10.0):
            <input type="text" name="rating" value="<%= selectedMovie.getRating() %>">
        </label>

        <br><br>
        <input type="submit" value="Save Changes">
    </form>
<% } %>

<div class="nav">
    <p><a href="index.jsp">Return to Index</a></p>
</div>
</body>
</html>
