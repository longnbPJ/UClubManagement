/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Semester;

/**
 *
 * @author PC ASUS
 */
public class SemesterDAO {
    public static Semester getThisSemester() {
        DBContext db = DBContext.getInstance();
        Semester sem = null;
        try {
            String sql = "Select * from Semester where id = dbo.fn_GetCurrentSemesterID()";
            PreparedStatement statement = db.getConnection().prepareStatement(sql); 
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                sem = new Semester(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date")
                );
            }
        } catch (Exception e) {
            return null;
        }
        return sem;
    }
}
