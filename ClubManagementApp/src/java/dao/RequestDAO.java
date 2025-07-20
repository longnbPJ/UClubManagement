/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Request;

/**
 *
 * @author PC ASUS
 */
public class RequestDAO {

    String error;

    public static ArrayList<Request> getRequests() {
        DBContext db = DBContext.getInstance();
        ArrayList<Request> requests = new ArrayList<>();
        try {
            String sql = """
                        select
                            *
                        from
                            Request r 
                            left join
                            Account a
                            on r.AccountID = a.AccountID
                            left join
                            ClubInfo c
                            on r.RequestID = c.RequestID
                            left join
                            EventInfo e
                            on e.RequestID = r.RequestID
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Request request = new Request(
                        rs.getInt("RequestID"),
                        AccountDAO.getAccountByID(rs.getInt("AccountID")),
                        ClubDAO.getClubByID(rs.getInt("ClubID")),
                        ClubInfoDAO.getClubInfoByID(rs.getInt("ClubInfoID")),
                        EventInfoDAO.getEventInfoByID(rs.getInt("EventInfoID")),
                        rs.getInt("StatusID"),
                        rs.getString("Type"),
                        rs.getString("CreatedAt")
                );
                requests.add(request);
            }
        } catch (Exception e) {
            requests.add(new Request(e.getMessage()));
            return requests;
        }
        return requests;
    }

    public static Request getRequestByID(int ID) {
        DBContext db = DBContext.getInstance();
        Request request = null;
        try {
            String sql = """
        select
            *
        from
            Request r 
            left join
            Account a
            on r.AccountID = a.AccountID
            left join
            ClubInfo c
            on r.RequestID = c.RequestID
            left join
            EventInfo e
            on e.RequestID = r.RequestID
        where r.RequestID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                request = new Request(
                        rs.getInt("RequestID"),
                        AccountDAO.getAccountByID(rs.getInt("AccountID")),
                        ClubDAO.getClubByID(rs.getInt("ClubID")),
                        ClubInfoDAO.getClubInfoByID(rs.getInt("ClubInfoID")),
                        EventInfoDAO.getEventInfoByID(rs.getInt("EventInfoID")),
                        rs.getInt("StatusID"),
                        rs.getString("Type"),
                        rs.getString("CreatedAt")
                );
            }
        } catch (Exception e) {
//            new Request(e.getMessage())
            return null;
        }
        return request;
    }

    public static boolean approveRequest(int requestID, int isApproved) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                         update Request
                         set StatusID = ?
                         where RequestID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, isApproved);
            statement.setInt(2, requestID);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static boolean createRequest(int AccountID, int ClubID, String type, int StatusID) {
        DBContext db = DBContext.getInstance();
        int n = 0;
        try {
            String sql = """
                         insert into Request(AccountID, ClubID, Type, StatusID) 
                         values(?,?,?,?)
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, AccountID);
            if (ClubID != 0) {
                statement.setInt(2, ClubID);
            } else {
                statement.setNull(2, java.sql.Types.VARCHAR);
            }
            statement.setString(3, type);
            statement.setInt(4, StatusID);
            n = statement.executeUpdate();
        } catch (Exception e) {
            return false;
        }
        return n > 0;
    }

    public static boolean hasJoinRequest(int AccountID, int ClubID, String type, int StatusID) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                        Select
                         	*
                         From
                         	request
                         where
                         	AccountID = ?
                         	and ClubID = ? 
                         	and Type = ?
                         	and StatusID = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, AccountID);
            statement.setInt(2, ClubID);
            statement.setString(3, type);
            statement.setInt(4, StatusID);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    public static ArrayList<Request> getJoinRequestsByClubID(int ClubID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Request> requests = new ArrayList<>();
        try {
            String sql = """
                                                select
                                                    *
                                                from
                                                    Request
                                                where 
                                                    ClubID = ?
                                                    and Type = 'Join Club'
                                                    and StatusID = 1
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ClubID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Request request = new Request(
                        rs.getInt("RequestID"),
                        AccountDAO.getAccountByID(rs.getInt("AccountID")),
                        ClubDAO.getClubByID(rs.getInt("ClubID")),
                        null,
                        null,
                        rs.getInt("StatusID"),
                        rs.getString("Type"),
                        rs.getString("CreatedAt")
                );
                requests.add(request);
            }
        } catch (Exception e) {
            requests.add(new Request(e.getMessage()));
            return requests;
        }
        return requests;
    }

    public static void main(String[] args) {
        System.out.println(getJoinRequestsByClubID(1).get(0).getAccount().getStudentInfo());
    }
}
