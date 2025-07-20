/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.ClubInfo;

/**
 *
 * @author PC ASUS
 */
public class ClubInfoDAO {

    public static ClubInfo getClubInfoByID(int ID) {
        DBContext db = DBContext.getInstance();
        ClubInfo clubInfo = null;
        try {
            String sql = """
                        select * from ClubInfo where ClubInfoID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                clubInfo = new ClubInfo(
                        rs.getInt("ClubInfoID"),
                        rs.getInt("ClubID"),
                        rs.getInt("RequestID"),
                        rs.getString("ClubName"),
                        rs.getString("ClubImgUrl"),
                        rs.getString("ClubDesc"),
                        rs.getString("EstablishDate")
                );
            }

        } catch (Exception e) {
            return null;
        }
        return clubInfo;
    }

    public static ClubInfo getClubInfoByClubID(int ID) {
        DBContext db = DBContext.getInstance();
        ClubInfo clubInfo = null;
        try {
            String sql = """
                        select * from ClubInfo where ClubID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                clubInfo = new ClubInfo(
                        rs.getInt("ClubInfoID"),
                        rs.getInt("ClubID"),
                        rs.getInt("RequestID"),
                        rs.getString("ClubName"),
                        rs.getString("ClubImgUrl"),
                        rs.getString("ClubDesc"),
                        rs.getString("EstablishDate")
                );
            }

        } catch (Exception e) {
            return null;
        }
        return clubInfo;
    }

    public static boolean addClubInfoToClub(int ClubInfoID, int ClubID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                        update ClubInfo 
                        set ClubID = ?
                        where ClubInfoID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ClubID);
            statement.setInt(2, ClubInfoID);
            n = statement.executeUpdate();

        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static boolean createClubInfo(ClubInfo clubInfo) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        ClubInfo newC = new ClubInfo(0, 0, 7, "new", "new", "new", "2025-03-04");
        try {
            String sql = """
                            insert into ClubInfo(RequestID, ClubName, ClubImgURL, ClubDesc, EstablishDate)
                            values((Select Top 1 RequestID fROM Request order by RequestID desc), ?,?,?,?)""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, clubInfo.getClubName());
            statement.setString(2, clubInfo.getClubImgUrl());
            statement.setString(3, clubInfo.getClubDesc());
            statement.setDate(4, Date.valueOf(clubInfo.getEstablishDate()));
            n = statement.executeUpdate();
        } catch (SQLException e) {
            return false;
        }
        return n > 0;
    }
    
        public static boolean updateClubInfo(int ClubID, String ClubName, String ImgURL, String ClubDesc) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                              Update ClubInfo
                              set ClubName = ?,
                              ClubImgURL = ?,
                              ClubDesc = ?
                              where ClubID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ClubName);
            statement.setString(2, ImgURL);
            statement.setString(3, ClubDesc);
            statement.setInt(4, ClubID);
            n = statement.executeUpdate();
        } catch (SQLException e) {
            return false;
        }
        return n > 0;
    }
    
//    public static void main(String[] args) {
//        System.out.println(createClubInfo());
//    }
}
