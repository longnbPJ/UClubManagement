/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package security;

/**
 *
 * @author PC ASUS
 */
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtils {

    // Constants for password generation
    private static final String LOWERCASE = "abcdefghijklmnopqrstuvwxyz";
    private static final String UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL = "!@#$%^&*()-_=+";
    private static final String ALL_CHARS = LOWERCASE + UPPERCASE + DIGITS + SPECIAL;

    /**
     * Tạo mật khẩu ngẫu nhiên với độ dài xác định
     *
     * @param length Độ dài mật khẩu mong muốn
     * @return Mật khẩu ngẫu nhiên
     */
    public static String generateRandomPassword(int length) {
        if (length < 4) {
            throw new IllegalArgumentException("Độ dài mật khẩu phải từ 4 trở lên");
        }

        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(length);

        // Đảm bảo mật khẩu có ít nhất 1 ký tự từ mỗi loại
        password.append(LOWERCASE.charAt(random.nextInt(LOWERCASE.length())));
        password.append(UPPERCASE.charAt(random.nextInt(UPPERCASE.length())));
        password.append(DIGITS.charAt(random.nextInt(DIGITS.length())));
        password.append(SPECIAL.charAt(random.nextInt(SPECIAL.length())));

        // Thêm các ký tự ngẫu nhiên cho đến khi đủ độ dài
        for (int i = 4; i < length; i++) {
            password.append(ALL_CHARS.charAt(random.nextInt(ALL_CHARS.length())));
        }

        // Trộn các ký tự
        char[] passwordArray = password.toString().toCharArray();
        for (int i = 0; i < passwordArray.length; i++) {
            int randomIndex = random.nextInt(passwordArray.length);
            char temp = passwordArray[i];
            passwordArray[i] = passwordArray[randomIndex];
            passwordArray[randomIndex] = temp;
        }

        return new String(passwordArray);
    }

    /**
     * Mã hóa mật khẩu sử dụng SHA-256 với salt
     *
     * @param password Mật khẩu cần mã hóa
     * @return Object chứa salt và mật khẩu đã mã hóa
     */
    public static HashedPassword hashPassword(String password) {
        try {
            // Tạo salt ngẫu nhiên
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);

            // Tạo MessageDigest với SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);

            // Mã hóa mật khẩu với salt
            byte[] hashedPassword = md.digest(password.getBytes(StandardCharsets.UTF_8));

            // Chuyển salt và hashedPassword thành Base64 để lưu trữ
            String saltBase64 = Base64.getEncoder().encodeToString(salt);
            String passwordBase64 = Base64.getEncoder().encodeToString(hashedPassword);

            return new HashedPassword(saltBase64, passwordBase64);

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi khi mã hóa mật khẩu", e);
        }
    }

    /**
     * Xác minh mật khẩu
     *
     * @param password Mật khẩu cần kiểm tra
     * @param hashedPassword Đối tượng chứa salt và mật khẩu đã mã hóa
     * @return true nếu mật khẩu khớp, false nếu không khớp
     */
    public static boolean verifyPassword(String password, HashedPassword hashedPassword) {
        try {
            // Lấy salt từ chuỗi Base64
            byte[] salt = Base64.getDecoder().decode(hashedPassword.getSalt());

            // Mã hóa lại mật khẩu với salt đã lưu
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);

            byte[] hashedInputPassword = md.digest(password.getBytes(StandardCharsets.UTF_8));
            String hashedInputPasswordBase64 = Base64.getEncoder().encodeToString(hashedInputPassword);

            // So sánh với mật khẩu đã lưu
            return hashedInputPasswordBase64.equals(hashedPassword.getHash());

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi khi xác minh mật khẩu", e);
        }
    }

    /**
     * Class để lưu trữ thông tin mật khẩu đã hash và salt
     */
    public static class HashedPassword {

        private String salt;
        private String hash;

        public HashedPassword(String salt, String hash) {
            this.salt = salt;
            this.hash = hash;
        }

        public String getSalt() {
            return salt;
        }

        public String getHash() {
            return hash;
        }

        @Override
        public String toString() {
            return salt + ":" + hash;
        }

        /**
         * Tạo đối tượng HashedPassword từ chuỗi đã được serialize
         */
        public static HashedPassword fromString(String stored) {
            String[] parts = stored.split(":");
            if (parts.length != 2) {
                throw new IllegalArgumentException("Chuỗi mật khẩu không hợp lệ");
            }
            return new HashedPassword(parts[0], parts[1]);
        }
    }

    // Ví dụ sử dụng
    public static void main(String[] args) {
        // Tạo mật khẩu ngẫu nhiên 6 ký tự
        String randomPassword = generateRandomPassword(6);
        System.out.println("Mật khẩu ngẫu nhiên: " + randomPassword);

        // Mật khẩu cần mã hóa
        String password = "123456";

        // Mã hóa mật khẩu
        HashedPassword hashedPassword = hashPassword(password);
        System.out.println("Mật khẩu đã mã hóa: " + hashedPassword);

        // Lưu chuỗi này vào database
        String storedPassword = hashedPassword.toString();
        System.out.println("Chuỗi lưu vào database: " + storedPassword);

        // Khi người dùng đăng nhập, lấy từ database và kiểm tra
        HashedPassword retrievedPassword = HashedPassword.fromString(storedPassword);
        boolean passwordMatches = verifyPassword(password, retrievedPassword);
        System.out.println("Mật khẩu có khớp không: " + passwordMatches);

        // Kiểm tra với mật khẩu sai
        boolean wrongPassword = verifyPassword("saimatkhau", retrievedPassword);
        System.out.println("Mật khẩu sai có khớp không: " + wrongPassword);
    }
}
