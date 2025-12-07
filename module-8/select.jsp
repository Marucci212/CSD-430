<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="com.marucci.model.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Select a Movie (CSD430)</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    h1 { margin-bottom: .25rem; }
    small { color: #555; }
    form, .card { max-width: 720px; }
    .card { background:#f6f8fa; padding:16px; border-radius:8px; }
    label { display:block; margin: 12px 0 6px; }
    select, button { padding:8px; }
    a { text-decoration:none; }
    a:hover { text-decoration:underline; }
  </style>
</head>
<body>
  <h1>Movies – Key Selector</h1>
  <small>Database: <code>CSD430</code> • Table: <code>justin_movies_data</code></small>
  <p>This page initializes with a dropdown of all primary keys from the database. Choose a key to view the full record.</p>

<%
  // Build the dropdown using the JavaBean helper
  LinkedHashMap<Integer, String> menu = null;
  String error = null;
  try {
      menu = MovieBean.fetchKeyMenu();
  } catch (Exception e) {
      error = e.getMessage();
  }
%>

  <div class="card">
    <form method="get" action="display.jsp">
      <label for="id">Select Movie (by ID – Title)</label>
      <select id="id" name="id" required>
        <option value="" disabled selected>-- choose a movie --</option>
<%
        if (menu != null) {
            for (Integer key : menu.keySet()) {
                String title = menu.get(key);
%>
        <option value="<%= key %>"><%= key %> — <%= title %></option>
<%
            }
        }
%>
      </select>
      <div style="margin-top:12px;">
        <button type="submit">Show Record</button>
        <a style="margin-left:12px;" href="index.jsp">Back to Index</a>
      </div>
    </form>
    <div style="color:#b00020; margin-top:8px;"><%= (error != null ? "Error: " + error : "") %></div>
  </div>
</body>
</html>
