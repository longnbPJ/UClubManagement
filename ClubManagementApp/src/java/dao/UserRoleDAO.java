/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.UserRole;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author PC ASUS
 */
public class UserRoleDAO {
    public static ArrayList<UserRole> getUserRoles() {
        DBContext db = DBContext.getInstance();
        ArrayList<UserRole> roles = new ArrayList<>();
        try {
            String sql = "Select * from UserRole";
            PreparedStatement statement = db.getConnection().prepareStatement(sql); 
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                UserRole role = new UserRole(
                        rs.getInt("UserRoleID"),
                        rs.getString("UserRoleName")
                );
                roles.add(role);
            }
        } catch (Exception e) {
            return null;
        }
        return roles;
    }
}
