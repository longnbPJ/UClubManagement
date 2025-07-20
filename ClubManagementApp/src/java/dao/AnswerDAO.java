/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Answer;

/**
 *
 * @author admin
 */
public class AnswerDAO {

    // Lấy tất cả câu hỏi theo ClubID
    public static boolean createAnswer(int QuestionID, int AccountID, String content) {
        DBContext db = DBContext.getInstance();
        int n = 0;

        try {
            String sql = """
                      insert into Answer(QuestionID, AccountID, Content)
                      values(?,?,?)
                    """;

            // Chuẩn bị statement và gán tham số
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, QuestionID);
            statement.setInt(2, AccountID);
            statement.setString(3, content);
            n = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return n > 0;
    }

    public static Answer getAnswer(int AccountID, int QuestionID) {
        DBContext db = DBContext.getInstance();
        Answer answer = null;
        try {
            String sql = """
                          select Top 1 * from Answer
                          where QuestionID = ?
                          and AccountID = ?
                          order by AnswerID desc
                    """;

            // Chuẩn bị statement và gán tham số
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, QuestionID);
            statement.setInt(2, AccountID);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                answer = new Answer(
                        rs.getInt("AnswerID"),
                        rs.getInt("QuestionID"),
                        rs.getInt("AccountID"),
                        rs.getString("Content"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return answer;
    }
}
