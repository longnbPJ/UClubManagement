/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import model.Question;

/**
 *
 * @author admin
 */
public class QuestionDAO {

    // Lấy tất cả câu hỏi theo ClubID
    public static ArrayList<Question> getQuestionsByClubID(String clubID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Question> questions = new ArrayList<>();

        try {
            // Chuyển đổi String thành int
            int clubIDI = Integer.parseInt(clubID);

            String sql = """
                    SELECT QuestionID, ClubID, AccountID, Content 
                    FROM Question 
                    WHERE ClubID = ?
                    """;

            // Chuẩn bị statement và gán tham số
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, clubIDI);

            // Thực thi truy vấn
            ResultSet rs = statement.executeQuery();

            // Duyệt qua kết quả và tạo danh sách câu hỏi
            while (rs.next()) {
                int questionID = rs.getInt("QuestionID");
                int clubIDFromDB = rs.getInt("ClubID");
                int accountID = rs.getInt("AccountID");
                String content = rs.getString("Content");

                Question question = new Question(questionID, clubIDFromDB, accountID, content);
                questions.add(question);
            }

            // Đóng tài nguyên
            rs.close();
            statement.close();

        } catch (NumberFormatException e) {
            // Xử lý nếu clubID không thể chuyển thành int
            e.printStackTrace();
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Invalid ClubID format", e);
        } catch (Exception e) {
            // Xử lý các lỗi khác (kết nối DB, truy vấn, v.v.)
            e.printStackTrace();
            // Có thể ném lại ngoại lệ nếu cần: throw new RuntimeException("Error retrieving questions", e);
        }

        return questions;
    }
    
    
}
