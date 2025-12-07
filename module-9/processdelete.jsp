<%@ page import="java.util.List, java.util.LinkedHashMap" %>
<%@ page import="com.marucci.model.MovieBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Movie Records - Result</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 10px; }
        h2 { margin-top: 25px; }
        p  { margin-bottom: 10px; }
        table { border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #333; padding: 6px 10px; text-align: left; }
        th { background-color: #f0f0f0; }
        .error   { color: #b00000; font-weight: bold; }
        .success { color: #008800; font-weight: bold; }
        .info    { color: #0066aa; }
        .btn     { padding: 6px 12px; }
    </style>
</head>
<body>

<%
    String message      = null;
    String errorMessage = null;

    String idParam = request.getParameter("movieId");

    if (idParam != null && idParam.trim().length() > 0) {
        try {
            int idToDelete = Integer.parseInt(idParam.trim());

            // Delete the selected movie
            MovieBean.deleteMovie(idToDelete);

            message = "Movie record with ID " + idToDelete + " has been deleted.";
        } catch (NumberFormatException nfe) {
            errorMessage = "Invalid key value. Please select a valid Movie ID.";
        } catch (Exception e) {
            errorMessage = "Error deleting record: " + e.getMessage();
        }
    } else {
        errorMessage = "No Movie ID was selected for deletion.";
    }

    // After the delete, always reload the remaining records and key menu
    List<MovieBean> movies = null;
    LinkedHashMap<Integer, String> keyMenu = null;

    try {
        movies  = MovieBean.getAllMovies();
        keyMenu = MovieBean.fetchKeyMenu();
    } catch (Exception e) {
        if (errorMessage == null) {
            errorMessage = "Error reloading movie data: " + e.getMessage();
        }
    }
%>

<h1>Movie Project - Delete Records (Result)</h1>

<% if (message != null) { %>
    <p class="success"><%= message %></p>
<% } %>

<% if (errorMessage != null) { %>
    <p class="error"><%= errorMessage %></p>
<% } %>

<p class="info">
    The table below shows all <strong>remaining movie records</strong> after the delete
    operation. If no records remain, the table will appear with only the header row,
    as required by the assignment.
</p>

<h2>Remaining Movies in Database</h2>

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
        // IMPORTANT for the assignment:
        // When no records remain, we do NOT render any data rows.
        // That means the table appears "empty" except for the thead row.
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
        }
    %>
    </tbody>
</table>

<h2>Delete Another Movie</h2>

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
            <option disabled>No keys remaining (no records to delete)</option>
        <%
            }
        %>
    </select>

    <br/><br/>
    <input type="submit" value="Delete Selected Movie" class="btn" />
</form>

<p>
    <a href="delete.jsp">Back to Initial Delete Page</a> |
    <a href="index.jsp">Return to Main Index</a>
</p>

</body>
</html>
