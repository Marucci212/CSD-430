<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 
  Assignment: Dynamic HTML page using JSP Scriptlets
  Topic: Movies I’ve Enjoyed Watching (Grouped by Genre)
  Notes:
   - All HTML tags are outside of scriptlets.
   - Java code (data + grouping logic) is inside scriptlets.
   - External CSS is linked (styles.css).
--%>
<%
    // ====== Java code (Scriptlet): data model + sample data ======
    // A simple Movie "record" with 4 fields (Title, Director, Year, Genre)
    class Movie {
        String title;
        String director;
        int year;
        String genre;
        Movie(String title, String director, int year, String genre) {
            this.title = title;
            this.director = director;
            this.year = year;
            this.genre = genre;
        }
    }

    java.util.List<Movie> movies = new java.util.ArrayList<>();
    movies.add(new Movie("The Lord of the Rings: The Fellowship of the Ring", "Peter Jackson", 2001, "Fantasy"));
    movies.add(new Movie("The Lord of the Rings: The Return of the King", "Peter Jackson", 2003, "Fantasy"));
    movies.add(new Movie("Dune", "Denis Villeneuve", 2021, "Science Fiction"));
    movies.add(new Movie("Inception", "Christopher Nolan", 2010, "Science Fiction"));
    movies.add(new Movie("The Shawshank Redemption", "Frank Darabont", 1994, "Drama"));
    movies.add(new Movie("Forrest Gump", "Robert Zemeckis", 1994, "Drama"));

    // Sort by Genre, then Title so we can render grouped sections
    movies.sort((a, b) -> {
        int g = a.genre.compareToIgnoreCase(b.genre);
        return (g != 0) ? g : a.title.compareToIgnoreCase(b.title);
    });

    // Metadata for the page
    String pageTitle = "Movies I’ve Enjoyed (Grouped by Genre)";
    String overallDescription = "This page shows a list of movies I’ve enjoyed watching. The movies are grouped by genre and displayed in a formatted HTML table generated dynamically using JSP Scriptlets.";
    String fieldDescription = "Fields: Title (movie name), Director (filmmaker), Year (release year), Genre (category).";
    int recordCount = movies.size();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><%= pageTitle %></title>
  <link rel="stylesheet" href="styles.css"/>
</head>
<body>
  <header class="container">
    <h1><%= pageTitle %></h1>
    <p class="lead"><%= overallDescription %></p>
  </header>

  <section class="container">
    <h2>Dataset Overview</h2>
    <ul class="meta">
      <li><strong>Total Records:</strong> <%= recordCount %></li>
      <li><strong>Record &amp; Field Descriptions:</strong> <%= fieldDescription %></li>
    </ul>
  </section>

  <section class="container">
    <h2>Movies Table (Dynamic, Grouped by Genre)</h2>

    <table class="data-table">
      <thead>
        <tr>
          <th scope="col">Title</th>
          <th scope="col">Director</th>
          <th scope="col">Year</th>
          <th scope="col">Genre</th>
        </tr>
      </thead>
      <tbody>
      <%
          // ====== Java code (Scriptlet): grouping logic while rendering rows ======
          String currentGenre = null;
          for (Movie m : movies) {
              if (currentGenre == null || !currentGenre.equalsIgnoreCase(m.genre)) {
                  currentGenre = m.genre;
      %>
                <!-- Group Header Row (HTML outside scriptlets) -->
                <tr class="group-row">
                  <td colspan="4">Genre: <strong><%= currentGenre %></strong></td>
                </tr>
      <%
              }
      %>
            <!-- Data Row (HTML outside scriptlets) -->
            <tr>
              <td><%= m.title %></td>
              <td><%= m.director %></td>
              <td><%= m.year %></td>
              <td><%= m.genre %></td>
            </tr>
      <%
          } // end for
      %>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="4" class="footnote">
            Generated dynamically with JSP Scriptlets. All HTML tags are outside scriptlet blocks.
          </td>
        </tr>
      </tfoot>
    </table>
  </section>

  <section class="container">
    <h2>Notes &amp; Documentation</h2>
    <ol class="notes">
      <li>Java data (records) and control flow live inside <code>&lt;% ... %&gt;</code> scriptlets.</li>
      <li>All HTML markup (table, headers, rows) is written outside scriptlets.</li>
      <li>An external stylesheet (<code>styles.css</code>) is used to style the page.</li>
      <li>Records are grouped into topical categories by Genre, with group header rows.</li>
      <li>At least 5 records and 3+ fields are included.</li>
    </ol>
  </section>
</body>
</html>
