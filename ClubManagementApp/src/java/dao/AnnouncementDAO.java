/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Announcement;

/**
 *
 * @author admin
 */
public class AnnouncementDAO {

    public static ArrayList<Announcement> getAnnouncements() {
        DBContext db = DBContext.getInstance();
        ArrayList<Announcement> announcements = new ArrayList<>();
        try {
            String sql = """
                        SELECT
                            AnnouncementID,
                            ClubID,
                            CreatedAt,
                            CreatedBy,
                            Title,
                            Content
                        FROM
                            Announcement
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Announcement announcement = new Announcement(
                        rs.getInt("AnnouncementID"),
                        rs.getInt("ClubID"),
                        rs.getString("CreatedAt"),
                        rs.getInt("CreatedBy"),
                        rs.getString("Title"),
                        rs.getString("Content")
                );
                announcements.add(announcement);
            }
        } catch (Exception e) {
            return null; // Trả về null nếu có lỗi
        }
        return announcements;
    }

    public static ArrayList<Announcement> getAnnouncementsByClubId(String clubID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Announcement> announcements = new ArrayList<>();
        try {
            int clubIDI = Integer.parseInt(clubID);
            // Câu truy vấn SQL: Lấy các thông báo có ClubID khớp với clubId và sắp xếp theo CreatedAt giảm dần
            String sql = """
                    SELECT
                        AnnouncementID,
                        ClubID,
                        CreatedAt,
                        CreatedBy,
                        Title,
                        Content
                    FROM
                        Announcement
                    WHERE
                        ClubID = ?
                    ORDER BY
                        CreatedAt DESC
                    """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            // Đặt tham số ClubID vào câu truy vấn
            statement.setInt(1, clubIDI); // clubId là kiểu int
            ResultSet rs = statement.executeQuery();

            // Ánh xạ dữ liệu từ ResultSet vào danh sách Announcement
            while (rs.next()) {
                Announcement announcement = new Announcement(
                        rs.getInt("AnnouncementID"),
                        rs.getInt("ClubID"),
                        rs.getString("CreatedAt"),
                        rs.getInt("CreatedBy"),
                        rs.getString("Title"),
                        rs.getString("Content")
                );
                announcements.add(announcement);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi
            return null; // Trả về null nếu có lỗi
        }
        return announcements;
    }

    public static boolean createAnnouncement(int clubID, int id, String title, String content) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                        insert into Announcement(ClubID, CreatedBy, Title, Content)
                        values(?,?,?,?)
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubID);
            statement.setInt(2, id);
            statement.setString(3, title);
            statement.setString(4, content);
            n = statement.executeUpdate();
            
        } catch (Exception e) {
            return false; // Trả về null nếu có lỗi
        }
        return n > 0;
    }
}
