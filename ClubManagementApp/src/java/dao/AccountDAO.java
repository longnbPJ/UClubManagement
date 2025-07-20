/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import emailService.EmailSender;
import jakarta.mail.MessagingException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Account;
import security.PasswordUtils;

/**
 *
 * @author PC ASUS
 */
public class AccountDAO {

    public static ArrayList<Account> getAccounts() {
        DBContext db = DBContext.getInstance();
        ArrayList<Account> accounts = new ArrayList<>();
        try {
            String sql = """
                        Select 
                         	a.Fullname,
                         	a.Email,
                         	a.UserRoleID,
                         	s.StudentID,
                         	s.Major,
                         	s.Course,
                         	a.AccountID,
                         	a.Password,
                         	a.UserDescription,
                         	a.UserImgURL,
                         	a.UserRoleID
                         FROM
                         	Account a left join StudentInfo s 
                         	on a.AccountID = s.AccountID
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Account account = new Account(
                        rs.getInt("AccountID"),
                        rs.getString("Fullname"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("UserRoleID"),
                        rs.getString("UserImgURL"),
                        rs.getString("UserDescription"),
                        StudentInfoDAO.getStudentInfoByID(rs.getInt("AccountID"))
                );
                accounts.add(account);
            }
        } catch (Exception e) {
            return null;
        }
        return accounts;
    }

    public static Account getAccountByEmailAndPassword(String email, String password) {
        DBContext db = DBContext.getInstance();
        Account account = null;
        try {
            String sql = """
                        SELECT *
                        FROM Account
                        WHERE
                        	Email = ?
                        	and Password = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                account = new Account(
                        rs.getInt("AccountID"),
                        rs.getString("FullName"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("UserRoleID"),
                        rs.getString("UserImgURL"),
                        rs.getString("UserDescription"),
                        StudentInfoDAO.getStudentInfoByID(rs.getInt("AccountID"))
                );
            }

        } catch (Exception e) {
            return null;
        }
        return account;
    }

    public static Account getAccountByID(int ID) {
        DBContext db = DBContext.getInstance();
        Account account = null;
        try {
            String sql = """
                        select * from Account where AccountID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                account = new Account(
                        rs.getInt("AccountID"),
                        rs.getString("FullName"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("UserRoleID"),
                        rs.getString("UserImgURL"),
                        rs.getString("UserDescription"),
                        StudentInfoDAO.getStudentInfoByID(ID));
            }

        } catch (Exception e) {
            return null;
        }
        return account;
    }

    public static Account getAccountByEmail(String email) {
        DBContext db = DBContext.getInstance();
        Account account = null;
        try {
            String sql = """
                        select * from Account where Email = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                account = new Account(
                        rs.getInt("AccountID"),
                        rs.getString("FullName"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("UserRoleID"),
                        rs.getString("UserImgURL"),
                        rs.getString("UserDescription"),
                        StudentInfoDAO.getStudentInfoByID(rs.getInt("AccountID")));
            }
        } catch (Exception e) {
            return null;
        }
        return account;
    }

    public static String getRoleAccount(int userRoleID) {
        if (userRoleID == 1) {
            return "Admin";
        } else if (userRoleID == 2) {
            return "Lecturer";
        } else if (userRoleID == 3) {
            return "Student";
        } else {
            return null;
        }
    }

    public static boolean addStudents(String fullname, String email, String studentID, String major, String course) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        String password = PasswordUtils.generateRandomPassword(6);
        String sql = """  
                            BEGIN TRANSACTION;
                            BEGIN TRY
                                DECLARE @InsertedID TABLE (ID INT);
                                                                
                                -- Thêm vào bảng Account và lấy ID vừa thêm
                                INSERT INTO Account(Fullname, Email, UserRoleID, Password)  
                                OUTPUT INSERTED.AccountID INTO @InsertedID  
                                VALUES (?, ?, ?, ?);
                                                                
                                -- Thêm vào bảng StudentInfo
                                INSERT INTO StudentInfo(AccountID, StudentID, Major, Course)  
                                VALUES ((SELECT ID FROM @InsertedID), ?, ?, ?);
                                                                
                                COMMIT TRANSACTION;
                            END TRY
                            BEGIN CATCH
                                ROLLBACK TRANSACTION;
                                THROW;
                            END CATCH 
                 """;
        try {
            EmailSender sender = new EmailSender("taidoyasuovn@gmail.com", "iskgxsvvdisasllq");
            sender.sendEmail(email, "RESET PASSWORD", "Your new password: " + password + ". Please change your password.");

            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            // Thiết lập tham số cho bảng Account
            stmt.setString(1, fullname);
            stmt.setString(2, email);
            stmt.setInt(3, 3);
            stmt.setString(4, PasswordUtils.hashPassword(password).toString());

            // Thiết lập tham số cho bảng StudentInfo
            stmt.setString(5, studentID);
            stmt.setString(6, major);
            stmt.setString(7, course);

            n = stmt.executeUpdate();
        } catch (MessagingException | SQLException e) {
            e.printStackTrace(); // In ra lỗi để dễ debug
            return false;
        }
        return n > 0;
    }

    public static boolean addAccount(String fullname, String email, int roleID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        String password = PasswordUtils.generateRandomPassword(6);
        String sql = """
                    INSERT INTO Account(Fullname, Email, UserRoleID, Password)  
                    VALUES (?, ?, ?, ?); 
                     """;
        try {
            EmailSender sender = new EmailSender("taidoyasuovn@gmail.com", "iskgxsvvdisasllq");
            sender.sendEmail(email, "RESET PASSWORD", "Your new password: " + password + ". Please change your password.");

            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, fullname);
            stmt.setString(2, email);
            stmt.setInt(3, roleID);
            stmt.setString(4, PasswordUtils.hashPassword(password).toString());
            n = stmt.executeUpdate();
        } catch (MessagingException | SQLException e) {
            e.printStackTrace(); // In ra lỗi để dễ debug
            return false;
        }
        return n > 0;
    }

    public static boolean changePassword(String password, int ID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        String sql = """
                    Update Account
                    set Password = ?
                    where AccountID = ?
                     """;
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, password);
            stmt.setInt(2, ID);
            n = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi để dễ debug
            return false;
        }
        return n > 0;
    }
}
