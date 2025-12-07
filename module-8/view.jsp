<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>justin_movies_data – Viewer</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    h1 { margin-bottom: 0.25rem; }
    small { color:#555; }
    table { border-collapse: collapse; width: 100%; margin-top: 1rem; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background: #f2f2f2; }
    .notice { background: #f6f8fa; padding: 8px 12px; border-radius: 6px; }
    a { text-decoration:none; }
    a:hover { text-decoration:underline; }
  </style>
</head>
<body>
  <h1>Movies Data</h1>
  <small>Table: <code>justin_movies_data</code> • Database: <code>CSD430</code></small>
  <div class="notice">
    Tip: If you see a driver error, make sure the MySQL Connector/J JAR is on Tomcat's classpath (e.g., drop it into <code>tomcat/lib</code>).
  </div>
  <p><a href="index.jsp">&larr; Back to Index</a></p>

<%
  String url = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
  String user = "student1";
  String pass = "pass";
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;

  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection(url, user, pass);
      ps = conn.prepareStatement("SELECT id, title, release_year, genre, rating, minutes, created_at FROM justin_movies_data ORDER BY id");
      rs = ps.executeQuery();
%>
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Year</th>
        <th>Genre</th>
        <th>Rating</th>
        <th>Minutes</th>
        <th>Created</th>
      </tr>
    </thead>
    <tbody>
<%
      boolean any = false;
      while (rs.next()) {
          any = true;
%>
      <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("release_year") %></td>
        <td><%= rs.getString("genre") %></td>
        <td><%= rs.getBigDecimal("rating") %></td>
        <td><%= rs.getInt("minutes") %></td>
        <td><%= rs.getTimestamp("created_at") %></td>
      </tr>
<%
      }
      if (!any) {
%>
      <tr><td colspan="7">No rows found. Insert data first.</td></tr>
<%
      }
  } catch (Exception e) {
%>
    <p style="color:#b00020;">Error: <%= e.getMessage() %></p>
<%
  } finally {
      try { if (rs != null) rs.close(); } catch (Exception ignore) {}
      try { if (ps != null) ps.close(); } catch (Exception ignore) {}
      try { if (conn != null) conn.close(); } catch (Exception ignore) {}
  }
%>
    </tbody>
  </table>
</body>
</html>
