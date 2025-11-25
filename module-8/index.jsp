<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Project - Home</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 10px; }
        p { margin-bottom: 15px; }
        ul { list-style-type: none; padding: 0; }
        li { margin-bottom: 8px; }
        a.button {
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            border: 1px solid #333;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<h1>Movie Project - Index</h1>

<p>Select an action below:</p>

<ul>
    <%-- Link to page that adds a new record (from previous project parts) --%>
    <li><a href="addRecord.jsp">Add New Movie</a></li>

    <%-- Link to the update record page for Project Part 3 --%>
    <li><a href="record.jsp" class="button">Update Existing Movie</a></li>
</ul>

</body>
</html>

