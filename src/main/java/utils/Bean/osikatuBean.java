package utils.Bean;

import java.time.LocalDate;

public class osikatuBean {
    private int osikatu_id;
    private LocalDate day;
    private int price;
    private String item;
    private int purchase;
    private  int osi_id;
    private int priority;
    private String memo;
    private int itemtype;

    public int getOsikatu_id() {
        return osikatu_id;
    }

    public void setOsikatu_id(int osikatu_id) {
        this.osikatu_id = osikatu_id;
    }

    public LocalDate getDay() {
        return day;
    }

    public void setDay(LocalDate day) {
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

    public osikatuBean(int osikatu_id, LocalDate day, int price, String item, int purchase, int osi_id, int priority, String memo, int itemtype) {
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
}
