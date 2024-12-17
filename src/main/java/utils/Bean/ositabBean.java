package utils.Bean;

public class ositabBean {
    private int ositag_id;
    private  int osi_id;
    private int tag_id;

    public ositabBean(int ositag_id, int osi_id, int tag_id) {
        this.ositag_id = ositag_id;
        this.osi_id = osi_id;
        this.tag_id = tag_id;
    }

    public int getOsitag_id() {
        return ositag_id;
    }

    public void setOsitag_id(int ositag_id) {
        this.ositag_id = ositag_id;
    }

    public int getOsi_id() {
        return osi_id;
    }

    public void setOsi_id(int osi_id) {
        this.osi_id = osi_id;
    }

    public int getTag_id() {
        return tag_id;
    }

    public void setTag_id(int tag_id) {
        this.tag_id = tag_id;
    }
}
