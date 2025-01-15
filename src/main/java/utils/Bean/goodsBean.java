package utils.Bean;

import java.sql.Date;

public class goodsBean {
    private int osikatu_id;
    private java.sql.Date day;
    private int price;
    private String item;
    private int purchase;
    private int osi_id;
    private int priority;
    private String memo;
    private int itemtype;

    public goodsBean(int osikatu_id, Date day, int price, String item, int purchase, int osi_id, int priority, String memo, int itemtype) {
        this.osikatu_id = osikatu_id;
        this.day = day;
        this.price = price;
        this.item = item;
        this.purchase = purchase;
        this.osi_id = osi_id;
        this.priority = priority;
        this.memo = memo;
        this.itemtype = itemtype;
    }

    public int getOsikatu_id() {
        return osikatu_id;
    }

    public void setOsikatu_id(int osikatuId) {
        this.osikatu_id = osikatuId;
    }

    public Date getDay() {
        return day;
    }

    public void setDay(Date day) {
        this.day = day;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public int getPurchase() {
        return purchase;
    }

    public void setPurchase(int purchase) {
        this.purchase = purchase;
    }

    public int getOsi_id() {
        return osi_id;
    }

    public void setOsi_id(int osi_id) {
        this.osi_id = osi_id;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public int getItemtype() {
        return itemtype;
    }

    public void setItemtype(int itemtype) {
        this.itemtype = itemtype;
    }
}
