package utils.Bean;
import java.time.LocalDate;

public class faveBean {
    private int osi_id;
    private String img;
    private String name;
    private LocalDate birthday;
    private String osimemo;
    private String log_id;
    private int cate_id;

    public int getOsi_id() {
        return osi_id;
    }

    public void setOsi_id(int osi_id) {
        this.osi_id = osi_id;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }

    public String getOsimemo() {
        return osimemo;
    }

    public void setOsimemo(String osimemo) {
        this.osimemo = osimemo;
    }

    public String getLog_id() {
        return log_id;
    }

    public void setLog_id(String log_id) {
        this.log_id = log_id;
    }

    public int getCate_id() {
        return cate_id;
    }

    public void setCate_id(int cate_id) {
        this.cate_id = cate_id;
    }

    public faveBean(int osi_id, String img, String name, LocalDate birthday, String osimemo, String log_id, int cate_id) {
        this.osi_id = osi_id;
        this.img = img;
        this.name = name;
        this.birthday = birthday;
        this.osimemo = osimemo;
        this.log_id = log_id;
        this.cate_id = cate_id;
    }
}
