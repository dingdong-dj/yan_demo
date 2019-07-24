package com.yan.performance.appraise.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class ReportDetail implements Serializable {
    private String sysno;

    private String projNo;

    private String projName;

    private BigDecimal award;

    private String empNo;

    private String empName;

    private String remarks;

    private String customId;

    private String customName;

    public String getSysno() {
        return sysno;
    }

    public void setSysno(String sysno) {
        this.sysno = sysno;
    }

    public String getProjNo() {
        return projNo;
    }

    public void setProjNo(String projNo) {
        this.projNo = projNo;
    }

    public String getProjName() {
        return projName;
    }

    public void setProjName(String projName) {
        this.projName = projName;
    }

    public BigDecimal getAward() {
        return award;
    }

    public void setAward(BigDecimal award) {
        this.award = award;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getCustomId() {
        return customId;
    }

    public void setCustomId(String customId) {
        this.customId = customId;
    }

    public String getCustomName() {
        return customName;
    }

    public void setCustomName(String customName) {
        this.customName = customName;
    }

    @Override
    public String toString() {
        return "ReportDetail{" +
                "sysno='" + sysno + '\'' +
                ", projNo='" + projNo + '\'' +
                ", projName='" + projName + '\'' +
                ", award=" + award +
                ", empNo='" + empNo + '\'' +
                ", empName='" + empName + '\'' +
                ", remarks='" + remarks + '\'' +
                ", customId='" + customId + '\'' +
                ", customName='" + customName + '\'' +
                '}';
    }
}
