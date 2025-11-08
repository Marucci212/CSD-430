/*
 * File: Feedback.java
 * Author: Justin Marucci
 * Course: CSD-430 Module 4
 * Date: 11/05/2025
 * Description:
 *   JavaBean (Serializable) to hold restaurant feedback data.
 *   Contains at least 6 fields, getters/setters, and a serialVersionUID.
 */

package com.marucci.model;

import java.io.Serializable;

public class Feedback implements Serializable {

    private static final long serialVersionUID = 1L;

    // --- Minimum 5 fields (we'll use 6) ---
    private String customerName;
    private String customerEmail;
    private String visitDate;       // keep as String for simple JSP display (e.g., "2025-10-29")
    private int rating;             // 1–5
    private String favoriteItem;
    private String comments;

    // Optional: overall record/row description (helps meet “field/record descriptions” requirement)
    private String recordDescription;

    public Feedback() {
        // no-arg constructor required for JavaBeans
    }

    // --- Getters/Setters ---
    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }
    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getVisitDate() {
        return visitDate;
    }
    public void setVisitDate(String visitDate) {
        this.visitDate = visitDate;
    }

    public int getRating() {
        return rating;
    }
    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getFavoriteItem() {
        return favoriteItem;
    }
    public void setFavoriteItem(String favoriteItem) {
        this.favoriteItem = favoriteItem;
    }

    public String getComments() {
        return comments;
    }
    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getRecordDescription() {
        return recordDescription;
    }
    public void setRecordDescription(String recordDescription) {
        this.recordDescription = recordDescription;
    }
}
