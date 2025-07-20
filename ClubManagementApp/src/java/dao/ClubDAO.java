/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Club;
import model.ClubInfo;

/**
 *
 * @author PC ASUS
 */
public class ClubDAO {

    public static ArrayList<Club> getClubs() {
        DBContext db = DBContext.getInstance();
        ArrayList<Club> clubs = new ArrayList<>();
        try {
            String sql = """
                        Select 
                        *
                        FROM	
                        	Club c left join ClubInfo ci 
                        	on c.ClubID = ci.ClubID
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Club club = new Club(
                        rs.getInt("ClubID"),
                        rs.getInt("Manager"),
                        rs.getString("EstablishDate"),
                        rs.getInt("EstablishBy"),
                        rs.getString("CreatedAt"),
                        ClubInfoDAO.getClubInfoByID(rs.getInt("ClubInfoID"))
                );
                clubs.add(club);
            }
        } catch (Exception e) {
            return null;
        }
        return clubs;
    }

    public static int createClub(int accountID, String establishDate) {
        DBContext db = DBContext.getInstance();
        int clubID = 0;
        try {
            // Sử dụng OUTPUT clause để lấy ID vừa insert
            String sql = "INSERT INTO Club(Manager, EstablishDate, EstablishBy) OUTPUT INSERTED.ClubID VALUES (?, ?, ?)";

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, accountID);
            statement.setString(2, establishDate);
            statement.setInt(3, accountID);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                clubID = rs.getInt(1); // hoặc rs.getInt("ID") tùy vào cấu trúc bảng của bạn
                return clubID;
            }
        } catch (SQLException e) {
            return 0;
        }
        return 0;
    }

    public static Club getClubByID(int ID) {
        DBContext db = DBContext.getInstance();
        Club club = null;
        try {
            String sql = """
                        select * from Club where ClubID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                club = new Club(
                        rs.getInt("ClubID"),
                        rs.getInt("Manager"),
                        rs.getString("EstablishDate"),
                        rs.getInt("EstablishBy"),
                        rs.getString("CreatedAt"),
                        ClubInfoDAO.getClubInfoByClubID(rs.getInt("ClubID")));
            }

        } catch (Exception e) {
            return new Club(e.getMessage());
        }
        return club;
    }

    public static boolean changeManager(int newManagerID, int clubID) {
        DBContext db = DBContext.getInstance();
        PreparedStatement statement1 = null;

        try {
            String sql1 = """
                        Update Club
                        Set Manager = ?
                        Where ClubID = ? 
                         """;

            statement1 = db.getConnection().prepareStatement(sql1);
            statement1.setInt(1, newManagerID);
            statement1.setInt(2, clubID);
            int rows1 = statement1.executeUpdate();

            return rows1 > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public static void main(String[] args) {
        int ClubId = createClub(4, "");
        System.out.println(ClubId);
    }

    public static int convertClubID(String clubIDS) {
        int clubID = 0;
        try {
            clubID = Integer.parseInt(clubIDS);
        } catch (Exception e) {
        }
        return clubID;
    }
}
