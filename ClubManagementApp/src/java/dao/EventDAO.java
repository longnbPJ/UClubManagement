/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Event;

/**
 *
 * @author admin
 */
public class EventDAO {

    public static ArrayList<Event> getEvents() {
        DBContext db = DBContext.getInstance();
        ArrayList<Event> events = new ArrayList<>();
        try {
            String sql = """
                         SELECT 
                         	  e.EventID, 
                         	  e.Status, 
                         	  e.ClubID, 
                                ef.EventInfoID,
                                ef.RequestID,
                                ef.EventName,
                                ef.EventDate,
                                ef.EventLocation,
                                CONVERT(VARCHAR(8), ef.EventTime, 108) AS EventTime, 
                                ef.EventDesc,
                                ef.EventImgURL
                         FROM Event e
                         LEFT JOIN EventInfo ef ON e.EventID = ef.EventID;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("EventID"),
                        rs.getString("Status"),
                        ClubInfoDAO.getClubInfoByID(rs.getInt("ClubID")),
                        EventInfoDAO.getEventInfoByID(rs.getInt("EventInfoID"))
                );

                events.add(event);
            }
        } catch (Exception e) {
            return null;
        }
        return events;
    }

    public static Event getEventByID(int ID) {
        DBContext db = DBContext.getInstance();
        Event event = null;
        try {
            String sql = """
                        SELECT 
                             e.EventID, 
                             e.Status, 
                             e.ClubID, 
                             ef.EventInfoID,
                             ef.RequestID,
                             ef.EventName,
                             ef.EventDate,
                             ef.EventLocation,
                             CONVERT(VARCHAR(8), ef.EventTime, 108) AS EventTime, 
                             ef.EventDesc,
                             ef.EventImgURL
                         FROM Event e
                         LEFT JOIN EventInfo ef ON e.EventID = ef.EventID
                         where e.EventID = ?""";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                event = new Event(
                        rs.getInt("EventID"),
                        rs.getString("Status"),
                        ClubInfoDAO.getClubInfoByID(rs.getInt("ClubID")),
                        EventInfoDAO.getEventInfoByID(rs.getInt("EventInfoID"))
                );
            }

        } catch (Exception e) {
            return new Event(e.getMessage());
        }
        return event;
    }

    public static int createEvent(int clubID) {
        DBContext db = DBContext.getInstance();
        int eventID = 0;
        try {
            // Sử dụng OUTPUT clause để lấy ID vừa insert
            String sql = "INSERT INTO Event(Status, ClubID) OUTPUT INSERTED.EventID VALUES ('Upcoming', ?)";

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubID);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                eventID = rs.getInt(1); // hoặc rs.getInt("ID") tùy vào cấu trúc bảng của bạn
                return eventID;
            }
        } catch (SQLException e) {
            return 0;
        }
        return 0;
    }

    public static int countEventsByClubID(String clubID) {
        DBContext db = DBContext.getInstance();
        int eventCount = 0;

        try {
            int clubIDI = Integer.parseInt(clubID);
            String sql = """
                    SELECT COUNT(EventID) as eventCount 
                    FROM [Event] 
                    WHERE ClubID = ?
                    """;

            // Chuẩn bị statement và gán tham số trước khi thực thi
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubIDI);

            // Thực thi truy vấn
            ResultSet rs = statement.executeQuery();

            // Lấy kết quả (chỉ cần 1 dòng)
            if (rs.next()) {
                eventCount = rs.getInt("eventCount");
            }

            // Đóng tài nguyên
            rs.close();
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Ghi log lỗi để debug
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error counting events", e);
        }

        return eventCount;
    }

    public static int countEventsByClubIDThisSemester(String clubID) {
        DBContext db = DBContext.getInstance();
        int eventCount = 0;

        try {
            int clubIDI = Integer.parseInt(clubID);
            String sql = """
                    SELECT COUNT(e.EventID) as eventCount 
                    FROM 
                    	Event e
                    	left join
                    	EventInfo ei 
                    	on e.EventID = ei.EventID
                    WHERE ClubID = ?
                    	and ei.EventDate 
                    	between (Select start_date from Semester where id = dbo.fn_GetCurrentSemesterID()) 
                    	and (Select end_date from Semester where id = dbo.fn_GetCurrentSemesterID())
                    """;

            // Chuẩn bị statement và gán tham số trước khi thực thi
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubIDI);

            // Thực thi truy vấn
            ResultSet rs = statement.executeQuery();

            // Lấy kết quả (chỉ cần 1 dòng)
            if (rs.next()) {
                eventCount = rs.getInt("eventCount");
            }

            // Đóng tài nguyên
            rs.close();
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Ghi log lỗi để debug
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error counting events", e);
        }

        return eventCount;
    }

    public static int countEventsThisSemesterByStatus(String status) {
        DBContext db = DBContext.getInstance();
        int eventCount = 0;

        try {
            String sql = """
                      SELECT COUNT(e.EventID) as eventCount 
                                        FROM 
                                        	Event e
                                        	left join
                                        	EventInfo ei 
                                        	on e.EventID = ei.EventID
                                        WHERE e.Status = ?
                                        	and ei.EventDate 
                                        	between (Select start_date from Semester where id = dbo.fn_GetCurrentSemesterID()) 
                                        	and (Select end_date from Semester where id = dbo.fn_GetCurrentSemesterID())
                    """;

            // Chuẩn bị statement và gán tham số trước khi thực thi
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, status);

            // Thực thi truy vấn
            ResultSet rs = statement.executeQuery();

            // Lấy kết quả (chỉ cần 1 dòng)
            if (rs.next()) {
                eventCount = rs.getInt("eventCount");
            }

            // Đóng tài nguyên
            rs.close();
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Ghi log lỗi để debug
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error counting events", e);
        }

        return eventCount;
    }

    public static ArrayList<Event> getEventsByIDs(int clubID, int accountID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Event> events = new ArrayList<>();
        try {
            String sql = """
                        SELECT e.EventID, e.ClubID, ei.EventInfoID, e.Status, ei.RequestID, ei.EventName, ei.EventDate, ei.EventLocation, ei.EventDesc, ei.EventImgURL, ep.AccountID, ep.EventRole
                        FROM 
                        	Event e
                        	left join EventInfo ei on e.EventID = ei.EventID
                        	right join EventParticipant ep on e.EventID = ep.EventID
                        WHERE 
                        	ei.EventDate 
                        	between (Select start_date from Semester where id = dbo.fn_GetCurrentSemesterID())
                        	and (Select end_date from Semester where id = dbo.fn_GetCurrentSemesterID())
                        	and e.ClubID = ?
                        	and ep.AccountID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubID);
            statement.setInt(2, accountID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("ClubID"),
                        rs.getString("Status"),
                        ClubInfoDAO.getClubInfoByClubID(rs.getInt("ClubID")),
                        EventInfoDAO.getEventInfoByID(rs.getInt("EventInfoID"))
                );
                events.add(event);
            }
        } catch (Exception e) {
            return null;
        }
        return events;
    }
}
