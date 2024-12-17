package utils.Bean;

public class categoryBean {
    private int cate_id;

    private String category;
    private String log_id;

    public categoryBean(int cate_id, String category, String log_id) {
        this.cate_id = cate_id;
        this.category = category;
        this.log_id = log_id;
    }

    public int getCate_id() {
        return cate_id;
    }

    public void setCate_id(int cate_id) {
        this.cate_id = cate_id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getLog_id() {
        return log_id;
    }

    public void setLog_id(String log_id) {
        this.log_id = log_id;
    }
}
