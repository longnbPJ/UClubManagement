/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.Period;

/**
 *
 * @author PC ASUS
 */
public class Club {

    private int clubID;
    private int manager;
    private String establishDate;
    private int establishBy;
    private String createdAt;
    private ClubInfo clubInfo;

    public Club(int clubID, int manager, String establishDate, int establishBy, String createdAt, ClubInfo clubInfo) {
        this.clubID = clubID;
        this.manager = manager;
        this.establishDate = establishDate;
        this.establishBy = establishBy;
        this.createdAt = createdAt;
        this.clubInfo = clubInfo;
    }

    public Club(String createdAt) {
        this.createdAt = createdAt;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public int getManager() {
        return manager;
    }

    public void setManager(int manager) {
        this.manager = manager;
    }

    public String getEstablishDate() {
        return establishDate;
    }

    public void setEstablishDate(String establishDate) {
        this.establishDate = establishDate;
    }

    public int getEstablishBy() {
        return establishBy;
    }

    public void setEstablishBy(int establishBy) {
        this.establishBy = establishBy;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public ClubInfo getClubInfo() {
        return clubInfo;
    }

    public void setClubInfo(ClubInfo clubInfo) {
        this.clubInfo = clubInfo;
    }

    public int getClubYears() {
        // Chuyển đổi chuỗi thành đối tượng LocalDate
        LocalDate establishDate = LocalDate.parse(this.establishDate);

        // Lấy ngày hiện tại
        LocalDate currentDate = LocalDate.now();

        // Tính khoảng thời gian giữa hai ngày
        Period period = Period.between(establishDate, currentDate);
        
        // Nếu chỉ muốn lấy số năm (có thể có phần thập phân)
        double years = period.getYears()
                + (period.getMonths() / 12.0)
                + (period.getDays() / 365.0);
        System.out.printf("Số năm đã trôi qua: %.2f năm%n", years);
        return (int) years;
    }
}
