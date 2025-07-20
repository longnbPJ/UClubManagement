/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.SQLException;
import model.ClubMember;

/**
 *
 * @author PC ASUS
 */
public class ClubMemberDAO {

    public static ArrayList<ClubMember> getClubMembers() {
        DBContext db = DBContext.getInstance();
        ArrayList<ClubMember> members = new ArrayList<>();
        try {
            String sql = """
                        select
                        *
                        From
                        	ClubMember cm
                        	left join
                        	Account a on cm.AccountID = a.AccountID
                        	left join
                        	Club c on cm.ClubID = c.ClubID
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ClubMember clubMember = new ClubMember(
                        AccountDAO.getAccountByID(rs.getInt("AccountID")),
                        ClubInfoDAO.getClubInfoByClubID(rs.getInt("ClubID")),
                        rs.getString("ClubRole"),
                        rs.getString("JoinDate"),
                        rs.getInt("ApprovedBy")
                );
                members.add(clubMember);
            }

        } catch (Exception e) {
            return null;
        }
        return members;
    }

    public static boolean createClubMember(int accountID, int clubID, String role, int approvedBy) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                        insert into ClubMember(AccountID, ClubID, ClubRole, ApprovedBy)
                        values(?,?,?,?)
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, accountID);
            statement.setInt(2, clubID);
            statement.setString(3, role);
            statement.setInt(4, approvedBy);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static boolean changeManager(int newManagerID, int clubID) {
        Connection conn = DBContext.getInstance().getConnection();
        PreparedStatement statement1 = null;
        PreparedStatement statement2 = null;
        try {
            if (conn == null) {
                System.out.println("Lỗi kết nối DB: " + DBContext.getInstance().getErr());
                return false;
            }

            String sql1 = """
                        Update ClubMember
                        Set ClubRole = 'Member'
                        Where ClubRole = 'Manager'
                        and ClubID = ? 
                         """;

            String sql2 = """
                        Update ClubMember
                        Set ClubRole = 'Manager'
                        Where AccountID = ?
                        and ClubID = ? 
                         """;

            statement1 = conn.prepareStatement(sql1);
            statement1.setInt(1, clubID);
            int rows1 = statement1.executeUpdate();

            statement2 = conn.prepareStatement(sql2);
            statement2.setInt(1, newManagerID);
            statement2.setInt(2, clubID);
            int rows2 = statement2.executeUpdate();

            if (rows1 > 0 && rows2 > 0) {
                conn.commit(); // Commit nếu cả hai update thành công
                return true;
            } else {
                conn.rollback(); // Rollback nếu một trong hai update thất bại
                return false;
            }
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (statement1 != null) {
                    statement1.close();
                }
                if (statement2 != null) {
                    statement2.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true); // Bật lại AutoCommit
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static int countMembersByClubID(String clubID) {
        DBContext db = DBContext.getInstance();
        int memberCount = 0;

        try {
            int clubIDI = Integer.parseInt(clubID);
            String sql = """
                    SELECT COUNT(AccountID) as memberCount 
                    FROM ClubMember 
                    WHERE ClubID = ?
                    """;

            // Chuẩn bị statement và gán tham số trước khi thực thi
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubIDI);

            // Thực thi truy vấn
            ResultSet rs = statement.executeQuery();

            // Lấy kết quả (chỉ cần 1 dòng)
            if (rs.next()) {
                memberCount = rs.getInt("memberCount");
            }

            // Đóng tài nguyên
            rs.close();
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Ghi log lỗi để debug
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error counting members", e);
        }

        return memberCount;
    }

    public static boolean isUserInClub(String accountID, String clubID) {
        DBContext db = DBContext.getInstance();
        boolean isMember = false;

        try {
            // Chuyển đổi String thành int
            int accountIDI = Integer.parseInt(accountID);
            int clubIDI = Integer.parseInt(clubID);

            String sql = """
                SELECT COUNT(*) as memberCount 
                FROM ClubMember 
                WHERE AccountID = ? 
                AND ClubID = ?
                """;

            // Chuẩn bị statement và gán tham số trước khi thực thi
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, accountIDI);
            statement.setInt(2, clubIDI);

            // Thực thi truy vấn
            ResultSet rs = statement.executeQuery();

            // Kiểm tra kết quả (nếu có ít nhất 1 dòng, nghĩa là người dùng thuộc club)
            if (rs.next()) {
                int memberCount = rs.getInt("memberCount");
                isMember = (memberCount > 0);
            }

            // Đóng tài nguyên
            rs.close();
            statement.close();

        } catch (NumberFormatException e) {
            // Xử lý nếu accountID hoặc clubID không thể chuyển thành int
            e.printStackTrace();
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Invalid ID format", e);
        } catch (Exception e) {
            // Xử lý các lỗi khác (kết nối DB, truy vấn, v.v.)
            e.printStackTrace();
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error checking user membership", e);
        }

        return isMember;
    }

    public static String getUserClubRole(String accountID, String clubID) {
        DBContext db = DBContext.getInstance();
        String clubRole = null;

        try {
            // Chuyển đổi String thành int
            int accountIDI = Integer.parseInt(accountID);
            int clubIDI = Integer.parseInt(clubID);

            String sql = """
                SELECT ClubRole 
                FROM ClubMember 
                WHERE AccountID = ? 
                AND ClubID = ?
                """;

            // Chuẩn bị statement và gán tham số trước khi thực thi
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, accountIDI);
            statement.setInt(2, clubIDI);

            // Thực thi truy vấn
            ResultSet rs = statement.executeQuery();

            // Kiểm tra kết quả (nếu có bản ghi, lấy ClubRole)
            if (rs.next()) {
                clubRole = rs.getString("ClubRole");
            }

            // Đóng tài nguyên
            rs.close();
            statement.close();

        } catch (NumberFormatException e) {
            // Xử lý nếu accountID hoặc clubID không thể chuyển thành int
            e.printStackTrace();
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Invalid ID format", e);
        } catch (Exception e) {
            // Xử lý các lỗi khác (kết nối DB, truy vấn, v.v.)
            e.printStackTrace();
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error retrieving club role", e);
        }

        return clubRole;
    }

    public static void updateUserClubRole(String accountID, String clubID, String newRole) {
        DBContext db = DBContext.getInstance();

        try {
            // Chuyển đổi String thành int
            int accountIDI = Integer.parseInt(accountID);
            int clubIDI = Integer.parseInt(clubID);

            String sql = """
            UPDATE ClubMember 
            SET ClubRole = ? 
            WHERE AccountID = ? 
            AND ClubID = ?
            """;

            // Chuẩn bị statement và gán tham số trước khi thực thi
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, newRole); // Gán vai trò mới
            statement.setInt(2, accountIDI); // Gán AccountID
            statement.setInt(3, clubIDI);   // Gán ClubID

            // Thực thi cập nhật
            int rowsAffected = statement.executeUpdate();

            // Đóng tài nguyên
            statement.close();

        } catch (NumberFormatException e) {
            // Xử lý nếu accountID hoặc clubID không thể chuyển thành int
            e.printStackTrace();
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Invalid ID format", e);
        } catch (Exception e) {
            // Xử lý các lỗi khác (kết nối DB, truy vấn, v.v.)
            e.printStackTrace();
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error updating club role", e);
        }
    }

    public static ClubMember getMember(String memberID, String clubID) {
        DBContext db = DBContext.getInstance();
        ClubMember clubMember = null;
        try {
            int memberIDI = Integer.parseInt(memberID);
            int clubIDI = Integer.parseInt(clubID);

            String sql = """
                        select
                            *
                        From
                            ClubMember cm
                            left join
                            Account a on cm.AccountID = a.AccountID
                            left join
                            Club c on cm.ClubID = c.ClubID
                        where a.AccountID = ? and cm.clubID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, memberIDI);
            statement.setInt(2, clubIDI);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                clubMember = new ClubMember(
                        AccountDAO.getAccountByID(rs.getInt("AccountID")),
                        ClubInfoDAO.getClubInfoByID(rs.getInt("ClubID")),
                        rs.getString("ClubRole"),
                        rs.getString("JoinDate"),
                        rs.getInt("ApprovedBy")
                );
            }

        } catch (Exception e) {
            return null;
        }
        return clubMember;
    }

}
