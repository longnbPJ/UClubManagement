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
public class Notification {

    private int notificationID;
    private int senderID;
    private String link;
    private String title;
    private String message;
    private String createdAt;
    private String deliveryMethod;

    public Notification(int notificationID, int senderID, String link, String title, String message, String createdAt, String deliveryMethod) {
        this.notificationID = notificationID;
        this.senderID = senderID;
        this.link = link;
        this.title = title;
        this.message = message;
        this.createdAt = createdAt;
        this.deliveryMethod = deliveryMethod;
    }

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {
        this.notificationID = notificationID;
    }

    public int getSenderID() {
        return senderID;
    }

    public void setSenderID(int senderID) {
        this.senderID = senderID;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getDeliveryMethod() {
        return deliveryMethod;
    }

    public void setDeliveryMethod(String deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
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
