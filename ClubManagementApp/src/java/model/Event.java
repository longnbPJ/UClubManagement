/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC ASUS
 */
public class Event {

    private int eventID;
    private String status;
    private ClubInfo clubInfo;
    private EventInfo eventInfo;

    public Event(int eventID, String status, ClubInfo clubInfo, EventInfo eventInfo) {
        this.eventID = eventID;
        this.status = status;
        this.clubInfo = clubInfo;
        this.eventInfo = eventInfo;
    }

    public Event(String status) {
        this.status = status;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

}
