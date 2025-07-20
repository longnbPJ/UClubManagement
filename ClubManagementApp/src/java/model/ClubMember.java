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
public class ClubMember {

    private Account account;
    private ClubInfo clubInfo;
    private String clubRole;
    private String joinDate;
    private int approvedBy;

    public ClubMember(Account account, ClubInfo clubInfo, String clubRole, String joinDate, int approvedBy) {
        this.account = account;
        this.clubInfo = clubInfo;
        this.clubRole = clubRole;
        this.joinDate = joinDate;
        this.approvedBy = approvedBy;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public ClubInfo getClubInfo() {
        return clubInfo;
    }

    public void setClubInfo(ClubInfo clubInfo) {
        this.clubInfo = clubInfo;
    }

    public String getClubRole() {
        return clubRole;
    }

    public void setClubRole(String clubRole) {
        this.clubRole = clubRole;
    }

    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }

    public int getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(int approvedBy) {
        this.approvedBy = approvedBy;
    }

    public String getDate() throws ParseException {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        // Định dạng đầu ra chỉ có giờ và phút
        SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy");

        // Chuyển đổi chuỗi thành Date
        Date date = inputFormat.parse(joinDate.split(" ")[0]);
        return outputFormat.format(date);
    }

    public String getTime() {
        if (joinDate != null && joinDate.contains(" ")) {
            String[] parts = joinDate.split(" "); // Tách chuỗi thành mảng
            String timePart = parts[1]; // Lấy phần tử thứ hai (giờ)
            return timePart.substring(0, 5); // Lấy "HH:mm"
        }
        return ""; // Trả về chuỗi rỗng nếu không hợp lệ
    }
}
