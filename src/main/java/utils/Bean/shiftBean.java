package utils.Bean;

import java.time.LocalDateTime;

public class shiftBean {
    private int shift_id;
    private LocalDateTime startdatetime;
    private LocalDateTime enddatetime;
    private int work_id;
    private int breaktime;
    private int wage;
    private String work_name;

    public shiftBean(int shift_id, LocalDateTime startdatetime, LocalDateTime enddatetime, int work_id, int breaktime, int wage) {
        this.shift_id = shift_id;
        this.startdatetime = startdatetime;
        this.enddatetime = enddatetime;
        this.work_id = work_id;
        this.breaktime = breaktime;
        this.wage = wage;
    }

    public int getShift_id() {
        return shift_id;
    }

    public void setShift_id(int shift_id) {
        this.shift_id = shift_id;
    }

    public LocalDateTime getStartdatetime() {
        return startdatetime;
    }

    public void setStartdatetime(LocalDateTime startdatetime) {
        this.startdatetime = startdatetime;
    }

    public LocalDateTime getEnddatetime() {
        return enddatetime;
    }

    public void setEnddatetime(LocalDateTime enddatetime) {
        this.enddatetime = enddatetime;
    }

    public int getWork_id() {
        return work_id;
    }

    public void setWork_id(int work_id) {
        this.work_id = work_id;
    }

    public int getBreaktime() {
        return breaktime;
    }

    public void setBreaktime(int breaktime) {
        this.breaktime = breaktime;
    }

    public int getWage() {
        return wage;
    }

    public void setWage(int wage) {
        this.wage = wage;
    }

    public void setWork_name(String work_name) {
        this.work_name = work_name;
    }

    public String getWork_name() {
        return work_name;
    }
}

