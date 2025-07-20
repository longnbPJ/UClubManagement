/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Notification;

/**
 *
 * @author admin
 */
public class NotificationDAO {

    public static Notification getNotificationByID(int notificationID) {
        DBContext db = DBContext.getInstance();
        Notification notification = null;
        try {
            String sql = """
                        SELECT NotificationID
                                , SenderID
                                , Link
                                , Title
                                , Message
                                , CreatedAt
                                , DeliveryMethod
                        FROM Notification
                        WHERE NotificationID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, notificationID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                notification = new Notification(
                        rs.getInt("NotificationID"),
                        rs.getInt("SenderID"),
                        rs.getString("Link"),
                        rs.getString("Title"),
                        rs.getString("Message"),
                        rs.getString("CreatedAt"),
                        rs.getString("DeliveryMethod")
                );
            }
        } catch (Exception e) {
            return null;
        }
        return notification;
    }

    public static boolean createNoti(int SenderID, String link, String title, String message, String deliveryMethod) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                          insert into Notification(SenderID, Link, Title, Message, DeliveryMethod)
                          values(?,?,?,?,?)
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, SenderID);
            statement.setString(2, link);
            statement.setString(3, title);
            statement.setString(4, message);
            statement.setString(5, deliveryMethod);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

}
