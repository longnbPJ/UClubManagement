/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.EventParticipant;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Account;

/**
 *
 * @author admin
 */
public class EventParticipantDAO {

    public static ArrayList<EventParticipant> getEventParticipants() {
        DBContext db = DBContext.getInstance();
        ArrayList<EventParticipant> eventParticipants = new ArrayList<>();
        try {
            String sql = """
                            SELECT *
                            FROM EventParticipant 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                EventParticipant eventParticipant = new EventParticipant(
                        EventDAO.getEventByID(rs.getInt("EventID")),
                        AccountDAO.getAccountByID(rs.getInt("AccountID")),
                        rs.getString("EventRole"),
                        rs.getString("Status")
                );
                eventParticipants.add(eventParticipant);
            }
        } catch (Exception e) {
            return null;
        }
        return eventParticipants;
    }

    public static ArrayList<EventParticipant> getEventParticipantsByID(int ID) {
        DBContext db = DBContext.getInstance();
        ArrayList<EventParticipant> eventParticipants = new ArrayList<>();
        try {
            String sql = """
                            SELECT *
                            FROM EventParticipant 
                            where AccountID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                EventParticipant eventParticipant = new EventParticipant(
                        EventDAO.getEventByID(rs.getInt("EventID")),
                        AccountDAO.getAccountByID(rs.getInt("AccountID")),
                        rs.getString("EventRole"),
                        rs.getString("Status")
                );
                eventParticipants.add(eventParticipant);
            }
        } catch (Exception e) {
            return null;
        }
        return eventParticipants;
    }

    public static int countParticipantsThisSemester(int clubID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                            Select 
                            	COUNT(ep.AccountID) as numberOfParticipants
                            FROM
                            	EventParticipant ep 
                            	left join
                            	EventInfo ei on ep.EventID = ei.EventID
                            	left join
                            	Event e on e.EventID = ei.EventID
                            WHERE
                            	e.ClubID = ?
                            	and ei.EventDate 
                            	between (Select start_date from Semester where id = dbo.fn_GetCurrentSemesterID()) 
                            	and (Select end_date from Semester where id = dbo.fn_GetCurrentSemesterID())
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubID);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                n = rs.getInt("numberOfParticipants");
            }
        } catch (Exception e) {
            return n;
        }
        return n;
    }

    public static boolean joinAccountToEventParticipant(int eventID, int accountID, String eventRole, String status) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        EventParticipant eventParticipant = null;
        try {
            String sql = """
            insert into EventParticipant(EventID,AccountID,EventRole,Status)
            values (?, ?, ?, ?)
            """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, eventID);
            statment.setInt(2, accountID);
            statment.setString(3, eventRole);
            statment.setString(4, status);

            rs = statment.executeUpdate(); // (5)

        } catch (Exception e) {
            return false;
        }
        return rs > 0;
    }

    public static boolean joinEventParticipant(String eventID, int accountID) {
        boolean isJoin = false;
        for (EventParticipant eventParticipant : getEventParticipants()) {
            if (eventParticipant.getEvent().getEventID() == Integer.parseInt(eventID)
                    && eventParticipant.getAccount().getAccountID() == accountID) {
                isJoin = true;
            }
        }
        return isJoin;
    }
}
