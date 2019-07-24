package com.yan.performance.appraise.model;

import java.io.Serializable;

public class Report implements Serializable {
    private String sysno;

    private String empNo;

    private String empName;

    private String sumAward;

    private String awardPay;

    public String getSysno() {
        return sysno;
    }

    public void setSysno(String sysno) {
        this.sysno = sysno;
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

    public String getSumAward() {
        return sumAward;
    }

    public void setSumAward(String sumAward) {
        this.sumAward = sumAward;
    }

    public String getAwardPay() {
        return awardPay;
    }

    public void setAwardPay(String awardPay) {
        this.awardPay = awardPay;
    }

    @Override
    public String toString() {
        return "Report{" +
                "sysno='" + sysno + '\'' +
                ", empNo='" + empNo + '\'' +
                ", empName='" + empName + '\'' +
                ", sumAward='" + sumAward + '\'' +
                ", awardPay='" + awardPay + '\'' +
                '}';
    }
}
