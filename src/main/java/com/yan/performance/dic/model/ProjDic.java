package com.yan.performance.dic.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 项目字典
 */
public class ProjDic implements Serializable {

    private String projNo;//项目编号

    private String projName;//项目名称

    private BigDecimal totalFee;//总金额

    private BigDecimal leftFee;//应收尾款

    private String statusFlag;//项目状态  立项  招标  已签合同  实施中  已完成（验收）  维护期

    private String contractDt;//合同签订时间

    private String projStart;//项目开始时间

    private String projEnd;//项目结束时间

    private String remarks;//备注

    private String customId;//客户编号

    private String customName;//客户名

    private String empNo;//项目经理编号

    private String empName;//项目经理名

    private BigDecimal ratio1;//系数1

    private BigDecimal ratio2;//系数2

    private BigDecimal ratio3;//系数3

    private BigDecimal ratio4;//系数4

    private BigDecimal ratio5;//系数5

    private String payInfo;//付款方式

    private String backFlag;//回款标记  未回款 部分回款  回款完成

    private String nextBackDt;//下次回款日期

    private String nextBackFee;//下次回款金额

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

    public BigDecimal getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(BigDecimal totalFee) {
        this.totalFee = totalFee;
    }

    public BigDecimal getLeftFee() {
        return leftFee;
    }

    public void setLeftFee(BigDecimal leftFee) {
        this.leftFee = leftFee;
    }

    public String getStatusFlag() {
        return statusFlag;
    }

    public void setStatusFlag(String statusFlag) {
        this.statusFlag = statusFlag;
    }

    public String getContractDt() {
        return contractDt;
    }

    public void setContractDt(String contractDt) {
        this.contractDt = contractDt;
    }

    public String getProjStart() {
        return projStart;
    }

    public void setProjStart(String projStart) {
        this.projStart = projStart;
    }

    public String getProjEnd() {
        return projEnd;
    }

    public void setProjEnd(String projEnd) {
        this.projEnd = projEnd;
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

    public BigDecimal getRatio1() {
        return ratio1;
    }

    public void setRatio1(BigDecimal ratio1) {
        this.ratio1 = ratio1;
    }

    public BigDecimal getRatio2() {
        return ratio2;
    }

    public void setRatio2(BigDecimal ratio2) {
        this.ratio2 = ratio2;
    }

    public BigDecimal getRatio3() {
        return ratio3;
    }

    public void setRatio3(BigDecimal ratio3) {
        this.ratio3 = ratio3;
    }

    public BigDecimal getRatio4() {
        return ratio4;
    }

    public void setRatio4(BigDecimal ratio4) {
        this.ratio4 = ratio4;
    }

    public BigDecimal getRatio5() {
        return ratio5;
    }

    public void setRatio5(BigDecimal ratio5) {
        this.ratio5 = ratio5;
    }

    public String getPayInfo() {
        return payInfo;
    }

    public void setPayInfo(String payInfo) {
        this.payInfo = payInfo;
    }

    public String getBackFlag() {
        return backFlag;
    }

    public void setBackFlag(String backFlag) {
        this.backFlag = backFlag;
    }

    public String getNextBackDt() {
        return nextBackDt;
    }

    public void setNextBackDt(String nextBackDt) {
        this.nextBackDt = nextBackDt;
    }

    public String getNextBackFee() {
        return nextBackFee;
    }

    public void setNextBackFee(String nextBackFee) {
        this.nextBackFee = nextBackFee;
    }

    @Override
    public String toString() {
        return "ProjDic{" +
                "projNo='" + projNo + '\'' +
                ", projName='" + projName + '\'' +
                ", totalFee=" + totalFee +
                ", leftFee=" + leftFee +
                ", statusFlag='" + statusFlag + '\'' +
                ", contractDt='" + contractDt + '\'' +
                ", projStart='" + projStart + '\'' +
                ", projEnd='" + projEnd + '\'' +
                ", remarks='" + remarks + '\'' +
                ", customId='" + customId + '\'' +
                ", customName='" + customName + '\'' +
                ", empNo='" + empNo + '\'' +
                ", empName='" + empName + '\'' +
                ", ratio1=" + ratio1 +
                ", ratio2=" + ratio2 +
                ", ratio3=" + ratio3 +
                ", ratio4=" + ratio4 +
                ", ratio5=" + ratio5 +
                ", payInfo='" + payInfo + '\'' +
                ", backFlag='" + backFlag + '\'' +
                ", nextBackDt='" + nextBackDt + '\'' +
                ", nextBackFee='" + nextBackFee + '\'' +
                '}';
    }
}
