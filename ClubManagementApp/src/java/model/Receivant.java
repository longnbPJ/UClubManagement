/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC ASUS
 */
public class Receivant {
    private Notification notification;
    private int noticationID;
    private int receiverID;
    private int isRead;

    public Receivant(Notification notification, int noticationID, int receiverID, int isRead) {
        this.notification = notification;
        this.noticationID = noticationID;
        this.receiverID = receiverID;
        this.isRead = isRead;
    }

    public int getNoticationID() {
        return noticationID;
    }

    public void setNoticationID(int noticationID) {
        this.noticationID = noticationID;
    }

    public Notification getNotification() {
        return notification;
    }

    public void setNotification(Notification notification) {
        this.notification = notification;
    }

    public int getReceiverID() {
        return receiverID;
    }

    public void setReceiverID(int receiverID) {
        this.receiverID = receiverID;
    }

    public int getIsRead() {
        return isRead;
    }

    public void setIsRead(int isRead) {
        this.isRead = isRead;
    }
    
    public String getReceiverIDS() {
        String receiverIDS = String.valueOf(receiverID);
        return receiverIDS;
    }
    
    
}
