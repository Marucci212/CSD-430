<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.marucci.model.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Movie</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1, h2 { margin-bottom: 10px; }
        label { display: block; margin-top: 8px; }
        input[type=text], input[type=number] { width: 250px; }
        select { width: 260px; }
        table { border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #333; padding: 8px; }
        .error { color: red; margin-top: 10px; }
        .nav { margin-top: 20px; }
    </style>
</head>
<body>
<h1>Update Existing Movie</h1>

<%
    // JSP Scriptlet: Load all movies for the dropdown
    List<MovieBean> movies = null;
    String loadError = null;

    try {
        movies = MovieBean.getAllMovies();
    } catch (Exception e) {
        loadError = "Error loading movies: " + e.getMessage();
    }

    // Determine if a movie has been selected from the dropdown
    String selectedId = request.getParameter("movieId");
    MovieBean selectedMovie = null;

    if (selectedId != null && !selectedId.trim().isEmpty()) {
        try {
            int id = Integer.parseInt(selectedId);
            selectedMovie = MovieBean.getMovieById(id);
        } catch (Exception e) {
            loadError = "Error loading selected movie: " + e.getMessage();
        }
    }
%>

<%-- Display any errors loading data --%>
<% if (loadError != null) { %>
    <p class="error"><%= loadError %></p>
<% } %>

<%-- Form 1: Dropdown list of key values (movie IDs) from the database --%>
<form method="get" action="record.jsp">
    <label for="movieId">Select Movie ID to Update:</label>
    <select name="movieId" id="movieId">
        <option value="">-- Select Movie ID --</option>
        <%
            if (movies != null) {
                for (MovieBean m : movies) {
        %>
        <option value="<%= m.getMovieId() %>"
                <%= (selectedMovie != null && m.getMovieId() == selectedMovie.getMovieId() ? "selected" : "") %>>
            <%= m.getMovieId() %>
        </option>
        <%
                }
            }
        %>
    </select>
    <br><br>
    <input type="submit" value="Load Record">
</form>

<hr>

<%-- Form 2: Display all fields as inputs (except key field, which is read-only) --%>
<%
    // Only show the update form if a record was successfully selected
    if (selectedMovie != null) {
%>
    <h2>Update Movie Details</h2>

    <form method="post" action="processupdate.jsp">
        <%-- Key field displayed but not editable; stored in hidden field for processing --%>
        <label>Movie ID (not editable):</label>
        <span><%= selectedMovie.getMovieId() %></span>
        <input type="hidden" name="movieId" value="<%= selectedMovie.getMovieId() %>">

        <%-- Remaining fields are editable input tags (minimum 5 fields total) --%>
        <label for="title">Title:</label>
        <input type="text" name="title" id="title"
               value="<%= selectedMovie.getTitle() %>" required>

        <label for="director">Director:</label>
        <input type="text" name="director" id="director"
               value="<%= selectedMovie.getDirector() %>" required>

        <label for="genre">Genre:</label>
        <input type="text" name="genre" id="genre"
               value="<%= selectedMovie.getGenre() %>" required>

        <label for="year">Year:</label>
        <input type="number" name="year" id="year"
               value="<%= selectedMovie.getYear() %>" required>

        <label for="rating">Rating:</label>
        <input type="text" name="rating" id="rating"
               value="<%= selectedMovie.getRating() %>" required>

        <br><br>
        <input type="submit" value="Save Changes">
    </form>
<%
    } // end if selectedMovie != null
%>

<div class="nav">
    <p><a href="index.jsp">Return to Index</a></p>
</div>

</body>
</html>

