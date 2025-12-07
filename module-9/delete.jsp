<%@ page import="java.util.List, java.util.LinkedHashMap" %>
<%@ page import="com.marucci.model.MovieBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Movie Records - Project Part 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 10px; }
        h2 { margin-top: 25px; }
        p  { margin-bottom: 10px; }
        table { border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #333; padding: 6px 10px; text-align: left; }
        th { background-color: #f0f0f0; }
        .error { color: #b00000; font-weight: bold; }
        .info  { color: #0066aa; }
        .btn   { padding: 6px 12px; }
    </style>
</head>
<body>

<%
    // Get all movies and key menu for initial display
    List<MovieBean> movies = null;
    LinkedHashMap<Integer, String> keyMenu = null;
    String errorMessage = null;

    try {
        movies  = MovieBean.getAllMovies();
        keyMenu = MovieBean.fetchKeyMenu();
    } catch (Exception e) {
        errorMessage = "Error loading movie data: " + e.getMessage();
    }
%>

<h1>Movie Project - Delete Records (Part 4)</h1>

<p>
    This page shows <strong>all movie records</strong> in the database and
    provides a dropdown list of the <strong>key field (movie_id)</strong>.
    Select a key and submit the form to delete that record.
</p>

<p class="info">
    Fields displayed: Movie ID (primary key), Title, Director, Genre,
    Release Year, Runtime (minutes), and IMDB Rating.
</p>

<% if (errorMessage != null) { %>
    <p class="error"><%= errorMessage %></p>
<% } %>

<h2>Current Movies in Database</h2>

<table>
    <thead>
        <tr>
            <th>Movie ID (Key)</th>
            <th>Title</th>
            <th>Director</th>
            <th>Genre</th>
            <th>Release Year</th>
            <th>Runtime (Minutes)</th>
            <th>IMDB Rating</th>
        </tr>
    </thead>
    <tbody>
    <%
        // If there are records, display one row per movie.
        if (movies != null && !movies.isEmpty()) {
            for (MovieBean m : movies) {
    %>
        <tr>
            <td><%= m.getId() %></td>
            <td><%= m.getTitle() %></td>
            <td><%= m.getDirector() %></td>
            <td><%= m.getGenre() %></td>
            <td><%= m.getYear() %></td>
            <td><%= m.getMinutes() %></td>
            <td><%= m.getRating() %></td>
        </tr>
    <%
            }
        } else {
            // For the initial page we show a message row if there are no movies at all
    %>
        <tr>
            <td colspan="7">There are currently no movie records in the database.</td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>

<h2>Delete a Movie by Key</h2>

<form action="processdelete.jsp" method="post">
    <label for="movieId">
        Select the <strong>Movie ID (key)</strong> to delete:
    </label>
    <br/>

    <select name="movieId" id="movieId">
        <%
            if (keyMenu != null && !keyMenu.isEmpty()) {
                for (Integer key : keyMenu.keySet()) {
                    String title = keyMenu.get(key);
        %>
            <option value="<%= key %>">
                <%= key %> - <%= title %>
            </option>
        <%
                }
            } else {
        %>
            <option disabled>No keys available (no records to delete)</option>
        <%
            }
        %>
    </select>

    <br/><br/>
    <input type="submit" value="Delete Selected Movie" class="btn" />
</form>

<p>
    <a href="index.jsp">Return to Main Index</a>
</p>

</body>
</html>
