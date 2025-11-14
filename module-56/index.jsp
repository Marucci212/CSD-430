<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>CSD430 – Module Hub</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    header { display:flex; justify-content:space-between; align-items:baseline; }
    h1 { margin: 0; }
    small { color:#555; }
    ul { line-height:1.8; }
    a { text-decoration:none; }
    a:hover { text-decoration:underline; }
    code { background:#f6f8fa; padding:2px 6px; border-radius:4px; }
  </style>
</head>
<body>
  <header>
    <h1>CSD430 – Justin Marucci</h1>
    <small>DB: <code>CSD430</code> • User: <code>student1</code> • Table: <code>justin_movies_data</code></small>
  </header>
  <hr/>
  <h2>Module Links</h2>
  <ul>
    <li><a href="view.jsp">Module 5/6 – View Movies Data (Read)</a></li>
    <li><a href="create.jsp">Create (coming soon)</a></li>
    <li><a href="update.jsp">Update (coming soon)</a></li>
    <li><a href="delete.jsp">Delete (coming soon)</a></li>
  </ul>
  <p>
    This <code>index.jsp</code> is the required hub linking to each module’s CRUD deliverables.
    For this module, use <a href="view.jsp">View Movies Data</a> to verify the inserted records.
  </p>
</body>
</html>
