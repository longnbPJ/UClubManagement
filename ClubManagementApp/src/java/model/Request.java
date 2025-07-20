/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author PC ASUS
 */
public class Request {

    private int requestID;
    private Account account;
    private Club club;
    private ClubInfo clubInfo;
    private EventInfo eventInfo;
    private int statusID;
    private String type;
    private String createdAt;

    public Request(int requestID, Account account, Club club, ClubInfo clubInfo, EventInfo eventInfo, int statusID, String type, String createdAt) {
        this.requestID = requestID;
        this.account = account;
        this.club = club;
        this.clubInfo = clubInfo;
        this.eventInfo = eventInfo;
        this.statusID = statusID;
        this.type = type;
        this.createdAt = createdAt;
    }

    public Request(String type) {
        this.type = type;
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Club getClub() {
        return club;
    }

    public void setClub(Club club) {
        this.club = club;
    }

    public ClubInfo getClubInfo() {
        return clubInfo;
    }

    public void setClubInfo(ClubInfo clubInfo) {
        this.clubInfo = clubInfo;
    }

    public EventInfo getEventInfo() {
        return eventInfo;
    }

    public void setEventInfo(EventInfo eventInfo) {
        this.eventInfo = eventInfo;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getDate() throws ParseException {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        // Định dạng đầu ra chỉ có giờ và phút
        SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy");

        // Chuyển đổi chuỗi thành Date
        Date date = inputFormat.parse(createdAt.split(" ")[0]);
        return outputFormat.format(date);
    }

    public String getTime() throws ParseException {
        SimpleDateFormat inputFormat = new SimpleDateFormat("HH:mm:ss.SSS");
        // Định dạng đầu ra chỉ có giờ và phút
        SimpleDateFormat outputFormat = new SimpleDateFormat("HH:mm");

        // Chuyển đổi chuỗi thành Date
        Date time = inputFormat.parse(createdAt.split(" ")[1]);
        return outputFormat.format(time);
    }
}
