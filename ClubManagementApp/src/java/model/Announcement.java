/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author PC ASUS
 */
public class Announcement {

    private int announcementID;
    private int clubID;
    private String createdAt;
    private int createdBy;
    private String title;
    private String content;

    public Announcement(int announcementID, int clubID, String createdAt, int createdBy, String title, String content) {
        this.announcementID = announcementID;
        this.clubID = clubID;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
        this.title = title;
        this.content = content;
    }

    public int getAnnouncementID() {
        return announcementID;
    }

    public void setAnnouncementID(int announcementID) {
        this.announcementID = announcementID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() throws ParseException {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        // Định dạng đầu ra chỉ có giờ và phút
        SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy");

        // Chuyển đổi chuỗi thành Date
        Date date = inputFormat.parse(createdAt.split(" ")[0]);
        return outputFormat.format(date);
    }

    public String getTime() {
        if (createdAt != null && createdAt.contains(" ")) {
            String[] parts = createdAt.split(" "); // Tách chuỗi thành mảng
            String timePart = parts[1]; // Lấy phần tử thứ hai (giờ)
            return timePart.substring(0, 5); // Lấy "HH:mm"
        }
        return ""; // Trả về chuỗi rỗng nếu không hợp lệ
    }

}
