package utils.Bean;

public class userBean {
    private String log_id;
    private String password;
    private String nick;
    private int regimg;
    private  int amounthand;
    private  int living;
    private int saiosi;
    private  int mainwork;

    public String getLog_id() {
        return log_id;
    }

    public void setLog_id(String log_id) {
        this.log_id = log_id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }

    public int getRegimg() {
        return regimg;
    }

    public void setRegimg(int regimg) {
        this.regimg = regimg;
    }

    public int getAmounthand() {
        return amounthand;
    }

    public void setAmounthand(int amounthand) {
        this.amounthand = amounthand;
    }

    public int getLiving() {
        return living;
    }

    public void setLiving(int living) {
        this.living = living;
    }

    public int getSaiosi() {
        return saiosi;
    }

    public void setSaiosi(int saiosi) {
        this.saiosi = saiosi;
    }

    public int getMainwork() {
        return mainwork;
    }

    public void setMainwork(int mainwork) {
        this.mainwork = mainwork;
    }

    public userBean(String log_id, String password, String nick, int regimg, int amounthand, int living, int saiosi, int mainwork) {
        this.log_id = log_id;
        this.password = password;
        this.nick = nick;
        this.regimg = regimg;
        this.amounthand = amounthand;
        this.living = living;
        this.saiosi = saiosi;
        this.mainwork = mainwork;
    }
}
