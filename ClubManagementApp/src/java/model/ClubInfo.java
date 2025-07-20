/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC ASUS
 */
public class ClubInfo {

    private int clubInfoID;
    private int clubID;
    private int requestID;
    private String clubName;
    private String clubImgUrl;
    private String clubDesc;
    private String establishDate;

    public ClubInfo(int clubInfoID, int clubID, int requestID, String clubName, String clubImgUrl, String clubDesc, String establishDate) {
        this.clubInfoID = clubInfoID;
        this.clubID = clubID;
        this.requestID = requestID;
        this.clubName = clubName;
        this.clubImgUrl = clubImgUrl;
        this.clubDesc = clubDesc;
        this.establishDate = establishDate;
    }

    public ClubInfo(String clubName) {
        this.clubName = clubName;
    }

    public int getClubInfoID() {
        return clubInfoID;
    }

    public void setClubInfoID(int clubInfoID) {
        this.clubInfoID = clubInfoID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getClubImgUrl() {
        return clubImgUrl;
    }

    public void setClubImgUrl(String clubImgUrl) {
        this.clubImgUrl = clubImgUrl;
    }

    public String getClubDesc() {
        return clubDesc;
    }

    public void setClubDesc(String clubDesc) {
        this.clubDesc = clubDesc;
    }

    public String getEstablishDate() {
        return establishDate;
    }

    public void setEstablishDate(String establishDate) {
        this.establishDate = establishDate;
    }

}
