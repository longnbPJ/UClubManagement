/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC ASUS
 */
public class Report {
    private int reportID;
    private int accountID;
    private int clubID;
    private Semester semester;
    private int memberQuantity;
    private int memberChanges;
    private String eventSummary;
    private String createdAt;
    private float participationStats;

    public Report(int reportID, int accountID, int clubID, Semester semester, int memberQuantity, int memberChanges, String eventSummary, String createdAt, float participationStats) {
        this.reportID = reportID;
        this.accountID = accountID;
        this.clubID = clubID;
        this.semester = semester;
        this.memberQuantity = memberQuantity;
        this.memberChanges = memberChanges;
        this.eventSummary = eventSummary;
        this.createdAt = createdAt;
        this.participationStats = participationStats;
    }

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public Semester getSemester() {
        return semester;
    }

    public void setSemester(Semester semester) {
        this.semester = semester;
    }

    public int getMemberQuantity() {
        return memberQuantity;
    }

    public void setMemberQuantity(int memberQuantity) {
        this.memberQuantity = memberQuantity;
    }

    public int getMemberChanges() {
        return memberChanges;
    }

    public void setMemberChanges(int memberChanges) {
        this.memberChanges = memberChanges;
    }

    public String getEventSummary() {
        return eventSummary;
    }

    public void setEventSummary(String eventSummary) {
        this.eventSummary = eventSummary;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public float getParticipationStats() {
        return participationStats;
    }

    public void setParticipationStats(float participationStats) {
        this.participationStats = participationStats;
    }
}
