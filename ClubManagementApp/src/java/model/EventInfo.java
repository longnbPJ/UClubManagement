/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC ASUS
 */
public class EventInfo {
    private int eventInfoID;
    private int eventID;
    private int requestID;
    private String eventName;
    private String eventDate;
    private String eventLocation;
    private String eventTime;
    private String eventDesc;
    private String eventImgURL;

    public EventInfo(int eventInfoID, int eventID, int requestID, String eventName, String eventDate, String eventLocation, String eventTime, String eventDesc, String eventImgURL) {
        this.eventInfoID = eventInfoID;
        this.eventID = eventID;
        this.requestID = requestID;
        this.eventName = eventName;
        this.eventDate = eventDate;
        this.eventLocation = eventLocation;
        this.eventTime = eventTime;
        this.eventDesc = eventDesc;
        this.eventImgURL = eventImgURL;
    }
    
    

    public EventInfo(String eventName) {
        this.eventName = eventName;
    }

    public int getEventInfoID() {
        return eventInfoID;
    }

    public void setEventInfoID(int eventInfoID) {
        this.eventInfoID = eventInfoID;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventDate() {
        return eventDate;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public String getEventTime() {
        return eventTime;
    }

    public void setEventTime(String eventTime) {
        this.eventTime = eventTime;
    }

    public String getEventDesc() {
        return eventDesc;
    }

    public void setEventDesc(String eventDesc) {
        this.eventDesc = eventDesc;
    }

    public String getEventImgURL() {
        return eventImgURL;
    }

    public void setEventImgURL(String eventImgURL) {
        this.eventImgURL = eventImgURL;
    }
    
}
