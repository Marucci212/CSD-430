<%-- 
  File: feedback.jsp
  Author: Justin Marucci
  Course: CSD-430 Module 4
  Date: 11/05/2025
  Description:
    Creates and populates a Feedback JavaBean using scriptlets only.
    All HTML is placed outside of scriptlets.
    Displays data in a formatted HTML table with titles and descriptions.
--%>

<%@ page import="com.marucci.model.Feedback" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    // --- Scriptlet: create and populate the bean ---

    // Option A) Populate from request parameters if present (keeps it flexible)
    String pName = request.getParameter("customerName");
    String pEmail = request.getParameter("customerEmail");
    String pDate = request.getParameter("visitDate");
    String pRating = request.getParameter("rating");
    String pFav = request.getParameter("favoriteItem");
    String pComments = request.getParameter("comments");

    Feedback fb = new Feedback();

    // Fallback sample data (based on Module 2 “Restaurant Feedback”) if params are missing
    fb.setCustomerName( (pName != null && !pName.isEmpty()) ? pName : "Alex Customer" );
    fb.setCustomerEmail( (pEmail != null && !pEmail.isEmpty()) ? pEmail : "alex@example.com" );
    fb.setVisitDate( (pDate != null && !pDate.isEmpty()) ? pDate : "2025-10-29" );
    fb.setRating( (pRating != null && !pRating.isEmpty()) ? Integer.parseInt(pRating) : 5 );
    fb.setFavoriteItem( (pFav != null && !pFav.isEmpty()) ? pFav : "Margherita Pizza" );
    fb.setComments( (pComments != null && !pComments.isEmpty()) ? pComments : "Great service and fresh ingredients." );

    // Record description helps satisfy “field and record descriptions”
    fb.setRecordDescription("Single feedback record captured from a restaurant visit.");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>CSD-430 Module 4 — JavaBean Display (Restaurant Feedback)</title>
  <link rel="stylesheet" href="styles.css">
  <style>
    /* (Optional) Inline in case you skip styles.css */
    body { font-family: Arial, Helvetica, sans-serif; margin: 2rem; }
    h1 { margin-bottom: 0.2rem; }
    .subtitle { color: #555; margin-top: 0; }
    table { border-collapse: collapse; width: 720px; max-width: 100%; }
    th, td { border: 1px solid #ccc; padding: 8px 10px; vertical-align: top; }
    th { text-align: left; background: #f5f5f5; width: 220px; }
    caption { caption-side: top; text-align: left; font-weight: bold; margin-bottom: 0.5rem; }
    .notes { margin-top: 1rem; color: #444; }
    .desc-list { margin: 0.5rem 0 1rem; padding-left: 1rem; }
  </style>
</head>
<body>

  <h1>Restaurant Feedback — JavaBean Display</h1>
  <p class="subtitle">
    Course: CSD-430 (Module 4) • Author: Justin Marucci • Date: 11/05/2025
  </p>

  <!-- Overall data description -->
  <p>
    <strong>Overall Data Description:</strong>
    This page demonstrates using a <em>Serializable JavaBean</em> to hold feedback data and a JSP (with scriptlets) to gather data from the bean and display it in a table.
  </p>

  <!-- Field descriptions (meets “field descriptions” requirement) -->
  <ul class="desc-list">
    <li><strong>Customer Name</strong> — Full name of the guest leaving feedback.</li>
    <li><strong>Email</strong> — Contact email for follow-up.</li>
    <li><strong>Visit Date</strong> — Date of the restaurant visit (YYYY-MM-DD).</li>
    <li><strong>Rating</strong> — Overall experience rating (1–5).</li>
    <li><strong>Favorite Item</strong> — Menu item enjoyed most during the visit.</li>
    <li><strong>Comments</strong> — Additional notes from the guest.</li>
  </ul>

  <table>
    <caption>Feedback Record</caption>
    <tbody>
      <tr>
        <th>Record Description</th>
        <td><%= fb.getRecordDescription() %></td>
      </tr>
      <tr>
        <th>Customer Name</th>
        <td><%= fb.getCustomerName() %></td>
      </tr>
      <tr>
        <th>Email</th>
        <td><%= fb.getCustomerEmail() %></td>
      </tr>
      <tr>
        <th>Visit Date</th>
        <td><%= fb.getVisitDate() %></td>
      </tr>
      <tr>
        <th>Rating (1–5)</th>
        <td><%= fb.getRating() %></td>
      </tr>
      <tr>
        <th>Favorite Item</th>
        <td><%= fb.getFavoriteItem() %></td>
      </tr>
      <tr>
        <th>Comments</th>
        <td><%= fb.getComments() %></td>
      </tr>
    </tbody>
  </table>

  <div class="notes">
    <strong>Note:</strong> You can also POST values to this JSP using fields named
    <code>customerName</code>, <code>customerEmail</code>, <code>visitDate</code>,
    <code>rating</code>, <code>favoriteItem</code>, and <code>comments</code>. If not provided, sample data is shown.
  </div>

</body>
</html>
