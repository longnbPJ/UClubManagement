/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Receivant;

/**
 *
 * @author admin
 */
public class ReceivantDAO {

    public static ArrayList<Receivant> getReceivants() {
        DBContext db = DBContext.getInstance();
        ArrayList<Receivant> receivants = new ArrayList<>();
        try {
            String sql = """
                        SELECT NotificationID
                                ,ReceiverID
                                ,IsRead
                        FROM Receivant
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Receivant receivant = new Receivant(
                        NotificationDAO.getNotificationByID(rs.getInt("NotificationID")),
                        rs.getInt("NotificationID"),
                        rs.getInt("ReceiverID"),
                        rs.getInt("IsRead")
                );
                receivants.add(receivant);
            }

        } catch (Exception e) {
            return null;
        }
        return receivants;
    }

    public static int getNumberOfNoti(int id) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                          Select COUNT(NotificationID) as 'numberOfNoti'
                          From Receivant 
                          where ReceiverID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("numberOfNoti");
            }
        } catch (Exception e) {
            return -1;
        }
        return -1;
    }

    public static int getNumberOfNotiNotRead(int id) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                          Select COUNT(NotificationID) as 'numberOfNoti'
                          From Receivant 
                          where ReceiverID = ?  
                          and IsRead = 0 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("numberOfNoti");
            }

        } catch (Exception e) {
            return -1;
        }
        return -1;
    }

    public static boolean createReceivant(int ReceivantID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                            insert into Receivant(NotificationID, ReceiverID, IsRead) 
                            values ((Select top 1 NotificationID from Notification order by NotificationID desc), ?, ?)
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ReceivantID);
            statement.setInt(2, 0);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static boolean checkNoti(int notiID, int ReceiverID, int isRead) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                              update Receivant
                              set IsRead = ?
                              where NotificationID = ?
                              and ReceiverID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, isRead);
            statement.setInt(2, notiID);
            statement.setInt(3, ReceiverID);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

//    public static void main(String[] args) {
//        for (Receivant receivant : ReceivantDAO.getReceivants()) {
//            System.out.println("4".equals(receivant.getReceiverIDS()));
//        } 
//    }
}
