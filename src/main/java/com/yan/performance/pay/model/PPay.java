package com.yan.performance.pay.model;

import java.io.Serializable;

/**
 * 绩效发放表
 */
public class PPay implements Serializable {

    private String payNo;

    private String empNo;

    private String empName;

    private String checkDt;

    private String payFee;

    private String payType;

    private String payDt;

    public String getPayNo() {
        return payNo;
    }

    public void setPayNo(String payNo) {
        this.payNo = payNo;
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

    public String getCheckDt() {
        return checkDt;
    }

    public void setCheckDt(String checkDt) {
        this.checkDt = checkDt;
    }

    public String getPayFee() {
        return payFee;
    }

    public void setPayFee(String payFee) {
        this.payFee = payFee;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getPayDt() {
        return payDt;
    }

    public void setPayDt(String payDt) {
        this.payDt = payDt;
    }

    @Override
    public String toString() {
        return "PPay{" +
                "payNo='" + payNo + '\'' +
                ", empNo='" + empNo + '\'' +
                ", empName='" + empName + '\'' +
                ", checkDt='" + checkDt + '\'' +
                ", payFee='" + payFee + '\'' +
                ", payType='" + payType + '\'' +
                ", payDt='" + payDt + '\'' +
                '}';
    }
}
