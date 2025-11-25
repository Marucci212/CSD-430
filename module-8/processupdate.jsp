<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.marucci.model.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <title>Updated Movie</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 15px; }
        table { border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #333; padding: 8px; }
        .error { color: red; margin-top: 10px; }
        .nav { margin-top: 20px; }
    </style>
</head>
<body>
<h1>Movie Record Updated</h1>

<%
    // JSP Scriptlet: Read form parameters and update the database via the JavaBean
    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("movieId");
    String title = request.getParameter("title");
    String director = request.getParameter("director");
    String genre = request.getParameter("genre");
    String yearParam = request.getParameter("year");
    String rating = request.getParameter("rating");

    MovieBean updated = null;
    String updateError = null;

    try {
        int movieId = Integer.parseInt(idParam);
        int year = Integer.parseInt(yearParam);

        // Create and populate the bean with the updated values
        MovieBean movie = new MovieBean();
        movie.setMovieId(movieId);
        movie.setTitle(title);
        movie.setDirector(director);
        movie.setGenre(genre);
        movie.setYear(year);
        movie.setRating(rating);

        // Call the JavaBean method to update the record in the database
        MovieBean.updateMovie(movie);

        // Retrieve the updated record to display to the user
        updated = MovieBean.getMovieById(movieId);

    } catch (Exception e) {
        updateError = "Error updating movie: " + e.getMessage();
    }
%>

<%-- Show any update errors --%>
<% if (updateError != null) { %>
    <p class="error"><%= updateError %></p>
<% } %>

<%-- Display the updated record in a table format with table headers --%>
<% if (updated != null) { %>
    <table>
        <thead>
        <tr>
            <th>Movie ID</th>
            <th>Title</th>
            <th>Director</th>
            <th>Genre</th>
            <th>Year</th>
            <th>Rating</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><%= updated.getMovieId() %></td>
            <td><%= updated.getTitle() %></td>
            <td><%= updated.getDirector() %></td>
            <td><%= updated.getGenre() %></td>
            <td><%= updated.getYear() %></td>
            <td><%= updated.getRating() %></td>
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
