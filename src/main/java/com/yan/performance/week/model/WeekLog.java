package com.yan.performance.week.model;

import java.io.Serializable;
import java.util.Date;

public class WeekLog implements Serializable {

    private String sysno;//系统编号

    private String weekNo;//周号

    private Date fillDt;//录入时间

    private String fillEmp;//录入人编号

    private String titleName;//周报主题

    private String sumText;//本周总结

    public String getSysno() {
        return sysno;
    }

    public void setSysno(String sysno) {
        this.sysno = sysno;
    }


    public String getWeekNo() {
        return weekNo;
    }

    public void setWeekNo(String weekNo) {
        this.weekNo = weekNo;
    }

    public Date getFillDt() {
        return fillDt;
    }

    public void setFillDt(Date fillDt) {
        this.fillDt = fillDt;
    }

    public String getFillEmp() {
        return fillEmp;
    }

    public void setFillEmp(String fillEmp) {
        this.fillEmp = fillEmp;
    }

    public String getTitleName() {
        return titleName;
    }

    public void setTitleName(String titleName) {
        this.titleName = titleName;
    }

    public String getSumText() {
        return sumText;
    }

    public void setSumText(String sumText) {
        this.sumText = sumText;
    }

    @Override
    public String toString() {
        return "WeekLog{" +
                "sysno='" + sysno + '\'' +
                ", weekNo='" + weekNo + '\'' +
                ", fillDt=" + fillDt +
                ", fillEmp='" + fillEmp + '\'' +
                ", titleName='" + titleName + '\'' +
                ", sumText='" + sumText + '\'' +
                '}';
    }
}
