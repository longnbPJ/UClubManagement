INSERT INTO UserRole(UserRoleName) VALUES
('Admin'),('Lecturer'),('Student')

INSERT INTO RequestStatus(StatusName) VALUES
('Pending'), ('Approved'), ('Rejected')

INSERT INTO Semester(name, code, start_date, end_date)
VALUES 
('Fall 2024', 'FA2024', '2024-09-01', '2024-12-31'),
('Summer 2024', 'SU2024', '2024-05-01', '2024-08-31'),
('Spring 2025', 'SP2025', '2025-01-01', '2025-04-30');

-- Tạo 1 Admin
INSERT INTO Account (Password, Email, FullName, UserImgURL, UserDescription, UserRoleId)
VALUES (N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'admin@example.com', N'Nguyễn Văn A', NULL, N'Quản trị viên hệ thống', 1);

-- Tạo 2 Lecturer
INSERT INTO Account (Password, Email, FullName, UserImgURL, UserDescription, UserRoleId)
VALUES 
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'giangvien1@example.com', N'Trần Thị B', NULL, N'Giảng viên Khoa CNTT', 2),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'giangvien2@example.com', N'Phạm Văn C', NULL, N'Giảng viên Khoa Toán', 2);

-- Tạo 27 Student
INSERT INTO Account (Password, Email, FullName, UserImgURL, UserDescription, UserRoleId)
VALUES 
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'vciatdxt01@gmail.com', N'Lê Văn D', NULL, N'Sinh viên năm nhất', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien2@example.com', N'Hoàng Thị E', NULL, N'Sinh viên năm hai', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien3@example.com', N'Bùi Văn F', NULL, N'Sinh viên năm ba', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien4@example.com', N'Đặng Thị G', NULL, N'Sinh viên năm tư', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien5@example.com', N'Ngô Văn H', NULL, N'Sinh viên năm nhất', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien6@example.com', N'Dương Thị I', NULL, N'Sinh viên năm hai', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien7@example.com', N'Vũ Văn K', NULL, N'Sinh viên năm ba', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien8@example.com', N'Trịnh Thị L', NULL, N'Sinh viên năm tư', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien9@example.com', N'Mai Văn M', NULL, N'Sinh viên năm nhất', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien10@example.com', N'Tô Thị N', NULL, N'Sinh viên năm hai', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien11@example.com', N'Hà Văn O', NULL, N'Sinh viên năm ba', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien12@example.com', N'Lý Thị P', NULL, N'Sinh viên năm tư', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien13@example.com', N'Triệu Văn Q', NULL, N'Sinh viên năm nhất', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien14@example.com', N'Châu Thị R', NULL, N'Sinh viên năm hai', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien15@example.com', N'Đỗ Văn S', NULL, N'Sinh viên năm ba', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien16@example.com', N'Quách Thị T', NULL, N'Sinh viên năm tư', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien17@example.com', N'Lương Văn U', NULL, N'Sinh viên năm nhất', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien18@example.com', N'Thái Thị V', NULL, N'Sinh viên năm hai', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien19@example.com', N'Hồ Văn X', NULL, N'Sinh viên năm ba', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien20@example.com', N'Khổng Thị Y', NULL, N'Sinh viên năm tư', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien21@example.com', N'Tăng Văn Z', NULL, N'Sinh viên năm nhất', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien22@example.com', N'Trình Thị AA', NULL, N'Sinh viên năm hai', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien23@example.com', N'Nghiêm Văn BB', NULL, N'Sinh viên năm ba', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien24@example.com', N'Lục Thị CC', NULL, N'Sinh viên năm tư', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien25@example.com', N'Kiều Văn DD', NULL, N'Sinh viên năm nhất', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien26@example.com', N'Phùng Thị EE', NULL, N'Sinh viên năm hai', 3),
(N'b183D1EggC1DCZ3CaPJQSg==:w1WMDauzeoG4l1ceyiUUygfI90uU6G0KhMq+wYKFI9U=', N'sinhvien27@example.com', N'Thi Văn FF', NULL, N'Sinh viên năm ba', 3);


INSERT INTO StudentInfo (AccountID, StudentID, Major, Course)
VALUES 
(4, N'HE200001', N'Information Technology', N'K20'),
(5, N'HA200002', N'Software Engineering', N'K20'),
(6, N'SA200003', N'Information Systems', N'K20'),
(7, N'HE190004', N'Information Technology', N'K19'),
(8, N'HA190005', N'Computer Science', N'K19'),
(9, N'SA190006', N'Cybersecurity', N'K19'),
(10, N'HE180007', N'Software Engineering', N'K18'),
(11, N'HA180008', N'Information Systems', N'K18'),
(12, N'SA180009', N'Computer Science', N'K18'),
(13, N'HE170010', N'Cybersecurity', N'K17'),
(14, N'HA170011', N'Artificial Intelligence', N'K17'),
(15, N'SA170012', N'Computer Engineering', N'K17'),
(16, N'HE200013', N'Information Technology', N'K20'),
(17, N'HA200014', N'Software Engineering', N'K20'),
(18, N'SA200015', N'Information Systems', N'K20'),
(19, N'HE190016', N'Information Technology', N'K19'),
(20, N'HA190017', N'Computer Science', N'K19'),
(21, N'SA190018', N'Cybersecurity', N'K19'),
(22, N'HE180019', N'Software Engineering', N'K18'),
(23, N'HA180020', N'Information Systems', N'K18'),
(24, N'SA180021', N'Computer Science', N'K18'),
(25, N'HE170022', N'Cybersecurity', N'K17'),
(26, N'HA170023', N'Artificial Intelligence', N'K17'),
(27, N'SA170024', N'Computer Engineering', N'K17'),
(28, N'HE200025', N'Information Technology', N'K20'),
(29, N'HA200026', N'Software Engineering', N'K20'),
(30, N'SA200027', N'Information Systems', N'K20');

-- Thông báo từ Admin (AccountID = 1)
INSERT INTO Notification (SenderID, Link, Title, Message, CreatedAt, DeliveryMethod)
VALUES 
(1, N'/clubs/management', N'Quản lý CLB', N'Cập nhật mới về quy định quản lý CLB. Vui lòng kiểm tra!', DEFAULT, N'in-app'),
(1, N'/events/upcoming', N'Sự kiện sắp diễn ra', N'Bạn đã đăng ký sự kiện chưa? Đừng bỏ lỡ!', DEFAULT, N'in-app');

-- Thông báo từ một Lecturer bất kỳ (AccountID = 2)
INSERT INTO Notification (SenderID, Link, Title, Message, CreatedAt, DeliveryMethod)
VALUES 
(2, N'/clubs/meeting', N'Họp CLB', N'Họp CLB sẽ diễn ra vào ngày mai, nhớ tham gia nhé!', DEFAULT, N'in-app'),
(2, N'/clubs/new-member', N'Chào mừng thành viên mới', N'Chúng ta có thành viên mới! Hãy chào đón họ.', DEFAULT, N'in-app'),
(2, N'/events/registration', N'Đăng ký sự kiện', N'Sự kiện sắp tới đã mở đăng ký. Hãy nhanh tay!', DEFAULT, N'in-app'),
(2, N'/events/details', N'Thông tin sự kiện', N'Kiểm tra chi tiết sự kiện sắp tới tại đây.', DEFAULT, N'in-app'),
(2, N'/clubs/rules-update', N'Cập nhật nội quy CLB', N'Nội quy CLB vừa được cập nhật. Vui lòng xem xét.', DEFAULT, N'in-app'),
(2, N'/events/feedback', N'Góp ý sự kiện', N'Bạn có góp ý gì về sự kiện vừa qua không? Hãy chia sẻ!', DEFAULT, N'in-app'),
(2, N'/clubs/volunteer', N'Tình nguyện viên sự kiện', N'CLB cần tình nguyện viên cho sự kiện sắp tới!', DEFAULT, N'in-app'),
(2, N'/events/thank-you', N'Cảm ơn bạn đã tham gia sự kiện', N'Hy vọng bạn đã có khoảng thời gian vui vẻ!', DEFAULT, N'in-app');

-- Thêm dữ liệu vào bảng Receivant, gán ReceiverID = 4 cho tất cả các NotificationID đã tạo
INSERT INTO Receivant (NotificationID, ReceiverID, IsRead)
SELECT NotificationID, 4, 0 
FROM Notification
WHERE SenderID IN (1, 2);

-- Tạo 3 Club với đúng điều kiện
INSERT INTO Club (Manager, EstablishDate, EstablishBy)
VALUES 
(2, '2022-09-01', 4),  -- CLB 1: Quản lý bởi giảng viên (ID 2), thành lập bởi sinh viên (ID 4)
(3, '2023-01-15', 5),  -- CLB 2: Quản lý bởi giảng viên (ID 3), thành lập bởi sinh viên (ID 5)
(4, '2021-06-20', 6);  -- CLB 3: Quản lý bởi sinh viên (ID 4), thành lập bởi sinh viên khác (ID 6)

INSERT INTO ClubMember (AccountID, ClubID, ClubRole, ApprovedBy)
VALUES 
-- Manager của Club 1 là AccountID = 2
(2, 1, 'Manager', 1),  

-- Manager của Club 2 là AccountID = 3
(3, 2, 'Manager', 1),  

-- Manager của Club 3 là AccountID = 4
(4, 3, 'Manager', 1);

-- AccountID = 2 tham gia Club 2 và 3
INSERT INTO ClubMember (AccountID, ClubID, ClubRole, ApprovedBy)
VALUES 
(2, 2, 'Adviser', 3),  -- Club 2, được duyệt bởi Manager ID 3
(2, 3, 'Adviser', 4);  -- Club 3, được duyệt bởi Manager ID 4

-- AccountID = 3 tham gia Club 1 và 3
INSERT INTO ClubMember (AccountID, ClubID, ClubRole, ApprovedBy)
VALUES 
(3, 1, 'Adviser', 2),  -- Club 1, được duyệt bởi Manager ID 2
(3, 3, 'Adviser', 4);  -- Club 3, được duyệt bởi Manager ID 4


-- Người có ID = 4 tham gia Club 1 và Club 3
INSERT INTO ClubMember (AccountID, ClubID, ClubRole, ApprovedBy)
VALUES 
(4, 1, 'Member', 2)  -- Club 1, được duyệt bởi Manager ID 2

-- Các thành viên còn lại được chia đều vào các CLB, trừ AccountID = 1
INSERT INTO ClubMember (AccountID, ClubID, ClubRole, ApprovedBy)
VALUES
(5, 1, 'Member', 2),
(6, 2, 'Member', 3),
(7, 3, 'Member', 4),
(8, 1, 'Member', 2),
(9, 2, 'Member', 3),
(10, 3, 'Member', 4),
(11, 1, 'Member', 2),
(12, 2, 'Member', 3),
(13, 3, 'Member', 4),
(14, 1, 'Member', 2),
(15, 2, 'Member', 3),
(16, 3, 'Member', 4),
(17, 1, 'Member', 2),
(18, 2, 'Member', 3),
(19, 3, 'Member', 4),
(20, 1, 'Member', 2),
(21, 2, 'Member', 3),
(22, 3, 'Member', 4),
(23, 1, 'Member', 2),
(24, 2, 'Member', 3),
(25, 3, 'Member', 4),
(26, 1, 'Member', 2),
(27, 2, 'Member', 3),
(28, 3, 'Member', 4),
(29, 1, 'Member', 2),
(30, 2, 'Member', 3)

INSERT INTO Event (Status, ClubID) VALUES
('Upcoming', 1),    -- Sự kiện sắp tới của Club 1
('Ongoing', 2),     -- Sự kiện đang diễn ra của Club 2
('Finished', 3),    -- Sự kiện đã hoàn thành của Club 3
('Cancel', 1),      -- Sự kiện bị hủy của Club 1
('Upcoming', 2),    -- Sự kiện sắp tới của Club 2
('Finished', 3);    -- Sự kiện đã hoàn thành của Club 3

INSERT INTO EventParticipant (EventID, AccountID, EventRole, Status) VALUES
(1, 4, 'Holder', 'Participated'),
(1, 5, 'Guest', 'Participated'),
(1, 6, 'Guest', 'Participated'),
(2, 7, 'Holder', 'Participated'),
(2, 8, 'Guest', 'Participated'),
(2, 9, 'Guest', 'Not Participated'), -- Bản ghi đầu tiên có trạng thái 'Not Participated'
(3, 10, 'Holder', 'Participated'),
(3, 11, 'Guest', 'Participated'),
(3, 12, 'Guest', 'Participated'),
(4, 13, 'Holder', 'Participated'),
(4, 14, 'Guest', 'Participated'),
(4, 15, 'Guest', 'Participated'),
(5, 16, 'Holder', 'Participated'),
(5, 17, 'Guest', 'Participated'),
(5, 18, 'Guest', 'Not Participated'), -- Bản ghi thứ hai có trạng thái 'Not Participated'
(6, 19, 'Holder', 'Participated'),
(6, 20, 'Guest', 'Participated'),
(6, 21, 'Guest', 'Participated'),
(6, 22, 'Holder', 'Participated'),
(6, 23, 'Guest', 'Participated'),
(1, 24, 'Guest', 'Participated'),
(2, 25, 'Holder', 'Participated'),
(3, 26, 'Guest', 'Participated'),
(4, 27, 'Guest', 'Participated'),
(5, 28, 'Holder', 'Participated'),
(6, 29, 'Guest', 'Participated'),
(1, 30, 'Guest', 'Participated');

INSERT INTO Question (ClubID, AccountID, Content) VALUES
(1, 4, N'Bạn có thể giới thiệu ngắn gọn về bản thân không?'),
(1, 5, N'Lý do bạn muốn tham gia câu lạc bộ này là gì?'),
(1, 6, N'Bạn có kinh nghiệm gì liên quan đến hoạt động của câu lạc bộ không?');

INSERT INTO Answer (QuestionID, AccountID, Content) VALUES
-- Người trả lời 1 (AccountID = 7)
(1, 7, N'Tôi là Phạm Thị D, 20 tuổi, đang học ngành Văn học.'),
(2, 7, N'Tôi muốn tham gia để học hỏi thêm về văn hóa và kết nối bạn bè.'),
(3, 7, N'Tôi đã từng tham gia một số sự kiện văn hóa địa phương.'),

-- Người trả lời 2 (AccountID = 8)
(1, 9, N'Tôi là Trần Văn E, 21 tuổi, chuyên ngành Sử học.'),
(2, 9, N'Tôi yêu thích văn hóa và muốn đóng góp cho câu lạc bộ.'),
(3, 9, N'Tôi có kinh nghiệm tổ chức một buổi triển lãm nhỏ.'),

-- Người trả lời 3 (AccountID = 9)
(1, 10, N'Tôi là Lê Thị F, 19 tuổi, học ngành Ngôn ngữ.'),
(2, 10, N'Tôi muốn tham gia để phát triển kỹ năng giao tiếp.'),
(3, 10, N'Tôi đã từng tham gia một nhóm văn nghệ ở trường.');

INSERT INTO Announcement (ClubID, CreatedBy, Title, Content) VALUES
(1, 2, N'Thông báo họp mặt đầu năm', N'Chào các thành viên, câu lạc bộ sẽ tổ chức buổi họp mặt đầu năm vào ngày 15/03/2025 tại phòng A101. Mọi người vui lòng có mặt đúng giờ!'),
(1, 2, N'Tuyển thành viên mới', N'Câu lạc bộ Văn hóa đang tuyển thành viên mới cho năm 2025. Các bạn quan tâm vui lòng đăng ký trước ngày 20/03/2025.'),
(1, 2, N'Sự kiện giao lưu văn hóa', N'Chúng ta sẽ tổ chức sự kiện giao lưu văn hóa vào ngày 25/03/2025 tại hội trường lớn. Mời các thành viên tham gia và đóng góp ý tưởng!'),
(1, 2, N'Nhắc nhở nộp báo cáo hoạt động', N'Các nhóm trưởng vui lòng nộp báo cáo hoạt động tháng 3 trước ngày 10/03/2025. Cảm ơn mọi người!');

INSERT INTO Report (AccountID, ClubID, SemesterID, MemberQuantity, MemberChanges, EventSummary, ParticipationStats) VALUES
-- 3 báo cáo cho ClubID = 1
(1, 1, 1, 15, 2, N'Đã tổ chức 2 sự kiện văn hóa với sự tham gia của 12 thành viên.', 0.80),
(1, 1, 2, 17, 1, N'Tổ chức hội thảo về văn học với 15 thành viên tham gia.', 0.88),
(1, 1, 3, 18, 0, N'Hoạt động giao lưu thành công với 16 thành viên tham gia.', 0.89),

-- 1 báo cáo cho ClubID = 2
(1, 2, 2, 10, 1, N'Tổ chức buổi thảo luận về khoa học với 8 thành viên tham gia.', 0.75),

-- 1 báo cáo cho ClubID = 3
(1, 3, 2, 12, 2, N'Tổ chức sự kiện thể thao với 10 thành viên tham gia.', 0.83);


INSERT INTO Request (AccountID, ClubID, Type, StatusID) VALUES
-- Các yêu cầu liên quan đến câu lạc bộ (có ClubID)
(7, 1, 'Join Club', 1),  -- Pending
(9, 1, 'Join Club', 1),  -- Pending
(10, 1, 'Join Club', 1),  -- Pending

(3, 2, 'Create Event', 1), -- Pending
(2, 1, 'Create Event', 1), -- Pending
(4, 3, 'Create Event', 1),  -- Pending

-- Các yêu cầu không liên quan trực tiếp đến câu lạc bộ hiện tại (ClubID = NULL)
(11, NULL, 'Create Club', 1);  -- Pending

INSERT INTO EventInfo (EventID, RequestID, EventName, EventDate, EventLocation, EventTime, EventDesc, EventImgURL) VALUES
-- 3 bản ghi liên kết với EventID
(1, NULL, N'Sự kiện văn hóa sắp tới', '2025-03-15', N'Phòng A101', '14:00', N'Buổi giao lưu văn hóa với các thành viên mới.', N'https://example.com/event1.jpg'),
(2, NULL, N'Sự kiện khoa học đang diễn ra', '2025-03-06', N'Hội trường B', '10:00', N'Thảo luận về các chủ đề khoa học mới nhất.', N'https://example.com/event2.jpg'),
(4, NULL, N'Sự kiện thể thao', '2025-03-10', N'Phòng A102', '15:00', N'Sự kiện thể thao mới.', N'https://example.com/event4.jpg'),

-- 3 bản ghi liên kết với RequestID
(NULL, 4, N'Đề xuất sự kiện mới', '2025-03-20', N'Phòng C101', '09:00:00', N'Đề xuất tổ chức sự kiện âm nhạc mới.', N'https://example.com/request7.jpg'),
(NULL, 5, N'Đề xuất sự kiện thể thao', '2025-03-25', N'Sân vận động', '13:00:00', N'Đề xuất tổ chức giải đấu bóng đá.', N'https://example.com/request9.jpg'),
(NULL, 6, N'Đề xuất sự kiện văn học mới', '2025-03-25', N'Sân vận động', '13:00:00', N'Đề xuất thành lập câu lạc bộ nghệ thuật.', N'https://example.com/request10.jpg'),
(3, NULL, N'Sự kiện nghệ thuật đã hoàn thành', '2025-03-18', N'Phòng C303', '18:00:00', N'Triển lãm nghệ thuật của các thành viên Club 3.', N'https://example.com/event3.jpg'),
(5, NULL, N'Sự kiện giao lưu sắp tới', '2025-03-25', N'Hội trường D', '09:00:00', N'Giao lưu giữa các thành viên Club 2.', N'https://example.com/event5.jpg'),
(6, NULL, N'Sự kiện tổng kết đã hoàn thành', '2025-03-19', N'Phòng E505', '16:00:00', N'Tổng kết hoạt động của Club 3 trong năm.', N'https://example.com/event6.jpg');

INSERT INTO ClubInfo (ClubID, RequestID, ClubName, ClubImgURL, ClubDesc, EstablishDate) VALUES
(1, NULL, N'Câu lạc bộ Văn hóa', N'https://example.com/club1.jpg', N'Câu lạc bộ Văn hóa, nơi tổ chức các sự kiện giao lưu và khám phá văn hóa truyền thống.', '2022-09-01'),
(2, NULL, N'Câu lạc bộ Khoa học', N'https://example.com/club2.jpg', N'Câu lạc bộ Khoa học, tập trung vào nghiên cứu và thảo luận các chủ đề khoa học hiện đại.', '2023-01-15'),
(3, NULL, N'Câu lạc bộ Thể thao', N'https://example.com/club3.jpg', N'Câu lạc bộ Thể thao, tổ chức các giải đấu và hoạt động thể thao cho sinh viên.', '2021-06-20'),
(NULL, 7, N'Câu lạc bộ Mới', N'https://example.com/club4.jpg', N'Câu lạc bộ mới được đề xuất, đang chờ phê duyệt.', '2025-03-15');