<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    java.time.ZonedDateTime now = java.time.ZonedDateTime.now();
    String user = request.getParameter("user");
    if (user == null || user.isBlank()) user = "Guest";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Hello JSP</title>
  <style>
    body { font-family: -apple-system, system-ui, Segoe UI, Roboto, Arial, sans-serif; margin: 2rem; }
    h1 { color: #007acc; }
    p { font-size: 1.1rem; }
    .ok { color: #0a7a0a; font-weight: 600; }
  </style>
</head>
<body>
  <h1>Hello, <%= user %>!</h1>
  <p class="ok">✅ JSP is working correctly on <%= now %></p>
  <p>Try adding <code>?user=YourName</code> at the end of the URL!</p>
  <hr>
  <p>This page contains both Java code and HTML tags as required for the assignment.</p>
</body>
</html>
