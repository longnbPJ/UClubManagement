/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.EventInfo;
import java.sql.Date;

/**
 *
 * @author PC ASUS
 */
public class EventInfoDAO {

    public static EventInfo getEventInfoByID(int ID) {
        DBContext db = DBContext.getInstance();
        EventInfo eventInfo = null;
        try {
            String sql = """
                        SELECT 
                              EventInfoID,
                              EventID,
                              RequestID,
                              EventName,
                              EventDate,
                              EventLocation,
                              CONVERT(VARCHAR(8), EventTime, 108) AS EventTime,
                              EventDesc,
                              EventImgURL
                        FROM EventInfo 
                        Where EventInfoID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                eventInfo = new EventInfo(
                        rs.getInt("EventInfoID"),
                        rs.getInt("EventID"),
                        rs.getInt("RequestID"),
                        rs.getString("EventName"),
                        rs.getString("EventDate"),
                        rs.getString("EventLocation"),
                        rs.getString("EventTime"),
                        rs.getString("EventDesc"),
                        rs.getString("EventImgURL")
                );
            }

        } catch (Exception e) {
            return new EventInfo(e.getMessage());
        }
        return eventInfo;
    }

    public static boolean addEventInfoIntoEvent(int EventInfoID, int EventID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                        update EventInfo 
                        set EventID = ?
                        where EventInfoID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, EventID);
            statement.setInt(2, EventInfoID);
            n = statement.executeUpdate();

        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static boolean createEventInfo(EventInfo eventInfo) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                          Insert into EventInfo(RequestID, EventName, EventDate, EventLocation, EventTime, EventDesc, EventImgURL)
                          values((Select Top 1 RequestID fROM Request order by RequestID desc), ?,?,?,?,?,?)""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, eventInfo.getEventName());
            statement.setDate(2, Date.valueOf(eventInfo.getEventDate()));
            statement.setString(3, eventInfo.getEventLocation());
            statement.setString(4, eventInfo.getEventTime());
            statement.setString(5, eventInfo.getEventDesc());
            statement.setString(6, eventInfo.getEventImgURL());
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static boolean updateEventInfo(String EventName, String EventLocation, String EventTime, String EventDesc, String EventDate, String EventImgURL, int eventID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                            update EventInfo 
                            set EventName = ?,
                            EventDate = ?,
                            EventLocation = ?,
                            EventTime = ?,
                            EventDesc = ?,
                            EventImgURL = ?
                            where EventID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, EventName);
            statement.setDate(2, Date.valueOf(EventDate));
            statement.setString(3, EventLocation);
            statement.setString(4, EventTime);
            statement.setString(5, EventDesc);
            statement.setString(6, EventImgURL);
            statement.setInt(7, eventID);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

}
