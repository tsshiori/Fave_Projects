package utils.Bean;

public class tagBean {
    private int tag_id;
    private int cate_id;
    private  String tag;

    public int getTag_id() {
        return tag_id;
    }

    public void setTag_id(int tag_id) {
        this.tag_id = tag_id;
    }

    public int getCate_id() {
        return cate_id;
    }

    public void setCate_id(int cate_id) {
        this.cate_id = cate_id;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public tagBean(int tag_id, int cate_id, String tag) {
        this.tag_id = tag_id;
        this.cate_id = cate_id;
        this.tag = tag;
    }
}
