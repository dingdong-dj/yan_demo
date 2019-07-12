package com.yan.performance.dic.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 考核项目和项目经理
 */
public class PMainEmp implements Serializable {

    private String sysNo;

    private String projNo;//项目ID

    private String projName;//项目名

    private BigDecimal lastFee;//最终考核金额

    private String empNo;//项目经理编号

    private String empName;//项目经理名

    private String projNoee;

    public String getSysNo() {
        return sysNo;
    }

    public void setSysNo(String sysNo) {
        this.sysNo = sysNo;
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

    public BigDecimal getLastFee() {
        return lastFee;
    }

    public void setLastFee(BigDecimal lastFee) {
        this.lastFee = lastFee;
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

    @Override
    public String toString() {
        return "PMainEmp{" +
                "sysNo='" + sysNo + '\'' +
                ", projNo='" + projNo + '\'' +
                ", projName='" + projName + '\'' +
                ", lastFee=" + lastFee +
                ", empNo='" + empNo + '\'' +
                ", empName='" + empName + '\'' +
                '}';
    }
}
