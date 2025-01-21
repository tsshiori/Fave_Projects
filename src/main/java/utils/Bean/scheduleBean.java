package utils.Bean;

public class scheduleBean {
    private int log_id;
    private int amounthand;
    private int futurewage;

    public scheduleBean(int log_id, int amounthand, int futurewage) {
        this.log_id = log_id;
        this.amounthand = amounthand;
        this.futurewage = futurewage;
    }

    public int getLog_id() {
        return log_id;
    }

    public void setLog_id(int log_id) {
        this.log_id = log_id;
    }

    public int getAmounthand() {
        return amounthand;
    }

    public void setAmounthand(int amounthand) {
        this.amounthand = amounthand;
    }

    public int getFuturewage() {
        return futurewage;
    }

    public void setFuturewage(int futurewage) {
        this.futurewage = futurewage;
    }
}
