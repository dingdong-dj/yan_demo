package com.yan.performance.week.model;

import java.io.Serializable;
import java.util.Date;

public class WeekLogDet implements Serializable {

    private String sysno;//系统编号

    private int lineId;//行号

    private String logType;//明细类别 log本周工作 plan下周计划

    private Date logDt;//日志日期

    private String logDesc;//工作记录或内容

    private String workType;//工作内容类别 requ需求 stat统计 other其他

    private String dealEmp;//处理人/录入人

    private String remarks;//备注

    private String result;//完成情况

    public String getSysno() {
        return sysno;
    }

    public void setSysno(String sysno) {
        this.sysno = sysno;
    }

    public int getLineId() {
        return lineId;
    }

    public void setLineId(int lineId) {
        this.lineId = lineId;
    }

    public String getLogType() {
        return logType;
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public Date getLogDt() {
        return logDt;
    }

    public void setLogDt(Date logDt) {
        this.logDt = logDt;
    }

    public String getLogDesc() {
        return logDesc;
    }

    public void setLogDesc(String logDesc) {
        this.logDesc = logDesc;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public String getDealEmp() {
        return dealEmp;
    }

    public void setDealEmp(String dealEmp) {
        this.dealEmp = dealEmp;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return "WeekLogDet{" +
                "sysno='" + sysno + '\'' +
                ", lineId=" + lineId +
                ", logType='" + logType + '\'' +
                ", logDt=" + logDt +
                ", logDesc='" + logDesc + '\'' +
                ", workType='" + workType + '\'' +
                ", dealEmp='" + dealEmp + '\'' +
                ", remarks='" + remarks + '\'' +
                ", result='" + result + '\'' +
                '}';
    }
}
