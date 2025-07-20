/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Report;
import model.Semester;

/**
 *
 * @author PC ASUS
 */
public class ReportDAO {

    public static Report getReportByClubID(int ClubID) {
        DBContext db = DBContext.getInstance();
        Report report = null;
        try {
            String sql = """
                        Select 
                        	*
                        FROM
                        	Report r left join Semester s on r.SemesterID = s.id
                        where ClubID = ?
                        and SemesterID = dbo.fn_GetCurrentSemesterID()
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ClubID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                report = new Report(
                        rs.getInt("ReportID"),
                        rs.getInt("AccountID"),
                        rs.getInt("ClubID"),
                        new Semester(
                                rs.getInt("SemesterID"),
                                rs.getString("name"),
                                rs.getString("code"),
                                rs.getDate("start_date"),
                                rs.getDate("end_date")
                        ),
                        rs.getInt("MemberQuantity"),
                        rs.getInt("MemberChanges"),
                        rs.getString("EventSummary"),
                        rs.getString("CreatedAt"),
                        rs.getFloat("ParticipationStats")
                );
            }
        } catch (Exception e) {
            return null;
        }
        return report;
    }

    public static int getMemberQuantityLastSem(String clubID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            int clubIDI = Integer.parseInt(clubID);
            String sql = """
                    Select 
                    	MemberQuantity
                    From 
                    	Report
                    where
                    	ClubID = ?
                    	and SemesterID = dbo.fn_GetCurrentSemesterID() - 1
                    """;

            // Chuẩn bị statement và gán tham số trước khi thực thi
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubIDI);

            // Thực thi truy vấn
            ResultSet rs = statement.executeQuery();

            // Lấy kết quả (chỉ cần 1 dòng)
            if (rs.next()) {
                n = rs.getInt("MemberQuantity");
            } else {
                n = 0;
            }
            // Đóng tài nguyên
            rs.close();
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Ghi log lỗi để debug
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error counting events", e);
        }
        return n;
    }

    public static boolean createNewReport(int AccountID, int ClubID, int MemberQuantity, int MemberChanges, String EventSummary, double Ps) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                         Insert into Report(AccountID, ClubID, EventSummary, MemberChanges, MemberQuantity, ParticipationStats, SemesterID)
                         values(?,?,?,?,?,?,dbo.fn_GetCurrentSemesterID())
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, AccountID);
            statement.setInt(2, ClubID);
            statement.setString(3, EventSummary);
            statement.setInt(4, MemberChanges);
            statement.setInt(5, MemberQuantity);
            statement.setDouble(6, Ps);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static boolean editReport(int reportID, String eventSummary) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                         Update Report
                         set EventSummary = ?
                         where ReportID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, eventSummary);
            statement.setInt(2, reportID);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static void main(String[] args) {
        Report r = getReportByClubID(1);
        System.out.println(r);
    }
}
