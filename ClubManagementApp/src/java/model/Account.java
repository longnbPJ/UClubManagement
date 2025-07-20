/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC ASUS
 */
public class Account {

    private int accountID;
    private String fullname;
    private String password;
    private String email;
    private int userRoleID;
    private String userImgURL;
    private String description;
    private StudentInfo studentInfo;

    public Account(int accountID, String fullname, String password, String email, int userRoleID, String userImgURL, String description, StudentInfo studentInfo) {
        this.accountID = accountID;
        this.fullname = fullname;
        this.password = password;
        this.email = email;
        this.userRoleID = userRoleID;
        this.userImgURL = userImgURL;
        this.description = description;
        this.studentInfo = studentInfo;
    }

    public Account(String fullname, String password, String email, int userRoleID, String userImgURL, String description, StudentInfo studentInfo) {
        this.fullname = fullname;
        this.password = password;
        this.email = email;
        this.userRoleID = userRoleID;
        this.userImgURL = userImgURL;
        this.description = description;
        this.studentInfo = studentInfo;
    }

    public Account() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getUserRoleID() {
        return userRoleID;
    }

    public void setUserRoleID(int userRoleID) {
        this.userRoleID = userRoleID;
    }

    public String getUserImgURL() {
        return userImgURL;
    }

    public void setUserImgURL(String userImgURL) {
        this.userImgURL = userImgURL;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public StudentInfo getStudentInfo() {
        return studentInfo;
    }

    public void setStudentInfo(StudentInfo studentInfo) {
        this.studentInfo = studentInfo;
    }

}
