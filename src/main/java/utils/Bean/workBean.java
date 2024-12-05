package utils.Bean;

public class workBean {
    private int work_id;
    private int hourlywage;
    private String work;
    private  String log_id;

    public int getWork_id() {
        return work_id;
    }

    public void setWork_id(int work_id) {
        this.work_id = work_id;
    }

    public int getHourlywage() {
        return hourlywage;
    }

    public void setHourlywage(int hourlywage) {
        this.hourlywage = hourlywage;
    }

    public String getWork() {
        return work;
    }

    public void setWork(String work) {
        this.work = work;
    }

    public String getLog_id() {
        return log_id;
    }

    public void setLog_id(String log_id) {
        this.log_id = log_id;
    }

    public workBean(int work_id, int hourlywage, String work, String log_id) {
        this.work_id = work_id;
        this.hourlywage = hourlywage;
        this.work = work;
        this.log_id = log_id;
    }
}