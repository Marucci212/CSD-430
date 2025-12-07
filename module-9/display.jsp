<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.marucci.model.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Selected Movie – Details</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    h1 { margin-bottom: .25rem; }
    small { color: #555; }
    table { border-collapse: collapse; width: 100%; max-width: 820px; margin-top: 1rem; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    thead th { background: #f2f2f2; }
    .desc { background:#f6f8fa; padding:12px; border-radius:8px; max-width:820px; }
    a { text-decoration:none; }
    a:hover { text-decoration:underline; }
    .error { color:#b00020; }
  </style>
</head>
<body>
  <h1>Movie Record</h1>
  <small>Table: <code>justin_movies_data</code> • Display of all fields for the selected key</small>
  <div class="desc">
    <strong>Description:</strong> This page uses a <em>JavaBean</em> to load one record by its unique key (primary key id)
    and displays all fields in a table with headings in the <code>&lt;thead&gt;</code> section.
  </div>
  <p><a href="select.jsp">&larr; Choose another record</a> • <a href="index.jsp">Back to Index</a></p>

<%
  String idParam = request.getParameter("id");
  MovieBean bean = new MovieBean();
  String error = null;
  try {
      if (idParam == null) throw new Exception("Missing id parameter.");
      int id = Integer.parseInt(idParam);
      bean.loadById(id);
  } catch (Exception e) {
      error = e.getMessage();
  }
%>

<% if (error != null) { %>
  <p class="error">Error: <%= error %></p>
<% } else { %>
  <table>
    <thead>
      <tr>
        <th>Field</th>
        <th>Description</th>
        <th>Value</th>
      </tr>
    </thead>
    <tbody>
      <tr><td>id</td><td>Primary key (auto-increment)</td><td><%= bean.getId() %></td></tr>
      <tr><td>title</td><td>Movie title</td><td><%= bean.getTitle() %></td></tr>
      <tr><td>release_year</td><td>Release year (YYYY)</td><td><%= bean.getReleaseYear() %></td></tr>
      <tr><td>genre</td><td>Genre label</td><td><%= bean.getGenre() %></td></tr>
      <tr><td>rating</td><td>User/critic rating (0–10)</td><td><%= bean.getRating() %></td></tr>
      <tr><td>minutes</td><td>Runtime in minutes</td><td><%= bean.getMinutes() %></td></tr>
      <tr><td>created_at</td><td>Row creation timestamp</td><td><%= bean.getCreatedAt() %></td></tr>
    </tbody>
  </table>
<% } %>
</body>
</html>
