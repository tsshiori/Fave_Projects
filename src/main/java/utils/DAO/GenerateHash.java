package utils.DAO;

import org.mindrot.jbcrypt.BCrypt;

public class GenerateHash {
    static public String getHashPw(String password, String salt) {
        String hashedPassword = BCrypt.hashpw(password, salt);
        return hashedPassword;
    }

    static public String getSalt() {
        return BCrypt.gensalt(); // ランダムな文字列作成
    }

    static public boolean checkPassword(String planePassword, String hashedPassword) {
        return BCrypt.checkpw(planePassword, hashedPassword);
    }

}