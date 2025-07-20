/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PC ASUS
 */
public class UserRole {
    private int userRoleID;
    private String userRoleName;

    public UserRole(int userRoleID, String userName) {
        this.userRoleID = userRoleID;
        this.userRoleName = userName;
    }

    public int getUserRoleID() {
        return userRoleID;
    }

    public void setUserRoleID(int userRoleID) {
        this.userRoleID = userRoleID;
    }

    public String getUserRoleName() {
        return userRoleName;
    }

    public void setUserName(String userName) {
        this.userRoleName = userName;
    }
}
