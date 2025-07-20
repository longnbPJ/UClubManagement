/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.StudentInfo;

/**
 *
 * @author PC ASUS
 */
public class StudentInfoDAO {

    public static StudentInfo getStudentInfoByID(int ID) {
        DBContext db = DBContext.getInstance();
        StudentInfo studentInfo = null;
        try {
            String sql = """
                        select * from StudentInfo where AccountID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                studentInfo = new StudentInfo(
                        rs.getString("StudentID"),
                        rs.getString("Major"),
                        rs.getString("Course"),
                        rs.getInt("AccountID")
                );
            }

        } catch (Exception e) {
            return null;
        }
        return studentInfo;
    }

    public static boolean addStudentInfo(String email, String studentID, String major, String course) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        String sql = """
                     INSERT INTO StudentInfo (StudentID, Major, Course, AccountID)	
                     VALUES (?, ?, ?, (SELECT AccountID FROM Account WHERE Email = '?'))
                     """;
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, studentID);
            stmt.setString(2, major);
            stmt.setString(3, course);
            stmt.setString(4, email);
            n = stmt.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

}
