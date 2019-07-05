package com.yan.performance.appraise.model;

import java.math.BigDecimal;

/**
 * 人员考核表
 */
public class PeopleAppraise {

    private String sysNo;//考核编号

    private String projNo;//项目ID

    private String projName;//项目名

    private String empNo;//员工编号

    private String empName;//员工姓名

    private String checkDt;//考核周期

    private BigDecimal award;//绩效奖金

    private String remarks;//备注说明

    private String distDt;//分配时间

    private String distEmp;//分配人

    private String checkFlag;//审核状态

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

    public BigDecimal getAward() {
        return award;
    }

    public void setAward(BigDecimal award) {
        this.award = award;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getDistDt() {
        return distDt;
    }

    public void setDistDt(String distDt) {
        this.distDt = distDt;
    }

    public String getDistEmp() {
        return distEmp;
    }

    public void setDistEmp(String distEmp) {
        this.distEmp = distEmp;
    }

    public String getCheckFlag() {
        return checkFlag;
    }

    public void setCheckFlag(String checkFlag) {
        this.checkFlag = checkFlag;
    }

    @Override
    public String toString() {
        return "PeopleAppraise{" +
                "sysNo='" + sysNo + '\'' +
                ", projNo='" + projNo + '\'' +
                ", projName='" + projName + '\'' +
                ", empNo='" + empNo + '\'' +
                ", empName='" + empName + '\'' +
                ", checkDt='" + checkDt + '\'' +
                ", award=" + award +
                ", remarks='" + remarks + '\'' +
                ", distDt='" + distDt + '\'' +
                ", distEmp='" + distEmp + '\'' +
                ", checkFlag='" + checkFlag + '\'' +
                '}';
    }
}
