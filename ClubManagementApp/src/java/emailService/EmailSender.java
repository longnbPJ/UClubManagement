package emailService;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailSender {

    private final String username;
    private final String password;

    public EmailSender(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public void sendEmail(String to, String subject, String content) throws MessagingException {
        // Cấu hình thuộc tính
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Tạo session với xác thực
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            // Thiết lập nội dung
            message.setText(content);

            // Gửi email
            Transport.send(message);

            System.out.println("Email đã được gửi thành công!");

        } catch (MessagingException e) {
            throw new MessagingException("Không thể gửi email: " + e.getMessage(), e);
        }
    }

//    // Gửi email với HTML content
//    public void sendHtmlEmail(String to, String subject, String htmlContent) throws MessagingException {
//        Properties props = new Properties();
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.starttls.enable", "true");
//        props.put("mail.smtp.host", "smtp.gmail.com");
//        props.put("mail.smtp.port", "587");
//
//        Session session = Session.getInstance(props, new Authenticator() {
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(username, password);
//            }
//        });
//
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(username));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//            message.setSubject(subject);
//
//            // Thiết lập nội dung HTML
//            message.setContent(htmlContent, "text/html; charset=utf-8");
//
//            Transport.send(message);
//
//            System.out.println("Email HTML đã được gửi thành công!");
//
//        } catch (MessagingException e) {
//            throw new MessagingException("Không thể gửi email HTML: " + e.getMessage(), e);
//        }
//    }
//
//    // Gửi email với file đính kèm
//    public void sendEmailWithAttachment(String to, String subject, String content,
//            String filePath) throws MessagingException {
//        Properties props = new Properties();
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.starttls.enable", "true");
//        props.put("mail.smtp.host", "smtp.gmail.com");
//        props.put("mail.smtp.port", "587");
//
//        Session session = Session.getInstance(props, new Authenticator() {
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(username, password);
//            }
//        });
//
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(username));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//            message.setSubject(subject);
//
//            // Tạo phần nội dung
//            BodyPart messageBodyPart = new MimeBodyPart();
//            messageBodyPart.setText(content);
//
//            // Tạo multipart message
//            Multipart multipart = new MimeMultipart();
//            multipart.addBodyPart(messageBodyPart);
//
//            // Thêm file đính kèm
//            messageBodyPart = new MimeBodyPart();
//            try {
//                jakarta.activation.DataSource source = new jakarta.activation.FileDataSource(filePath);
//                messageBodyPart.setDataHandler(new jakarta.activation.DataHandler(source));
//                messageBodyPart.setFileName(new java.io.File(filePath).getName());
//                multipart.addBodyPart(messageBodyPart);
//            } catch (Exception e) {
//                throw new MessagingException("Lỗi khi đính kèm file: " + e.getMessage(), e);
//            }
//
//            message.setContent(multipart);
//
//            Transport.send(message);
//
//            System.out.println("Email với file đính kèm đã được gửi thành công!");
//
//        } catch (MessagingException e) {
//            throw new MessagingException("Không thể gửi email có đính kèm: " + e.getMessage(), e);
//        }
//    }
}
