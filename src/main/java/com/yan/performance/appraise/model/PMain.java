package com.yan.performance.appraise.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 项目考核
 */
public class PMain implements Serializable {

    private String sysNo;//考核编号

    private String projNo;//项目ID

    private String projName;//项目名

    private String customId;//客户编号

    private String customName;//客户名

    private String checkYear;//考核年度

    private String checkDt;//考核周期 exp:2019-Q1Q2

    private BigDecimal backFee;//本季回款金额

    private BigDecimal validFee;//有效考核基准金额

    private BigDecimal kSumn;//绩效系数值 通过一个考核周期运算的结果储存

    private BigDecimal lastFee;//最终考核金额

    private String fillDt;//考核时间

    private String backDt;//回款时间

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

    public String getCheckYear() {
        return checkYear;
    }

    public void setCheckYear(String checkYear) {
        this.checkYear = checkYear;
    }

    public String getCheckDt() {
        return checkDt;
    }

    public void setCheckDt(String checkDt) {
        this.checkDt = checkDt;
    }

    public BigDecimal getBackFee() {
        return backFee;
    }

    public void setBackFee(BigDecimal backFee) {
        this.backFee = backFee;
    }

    public BigDecimal getValidFee() {
        return validFee;
    }

    public void setValidFee(BigDecimal validFee) {
        this.validFee = validFee;
    }

    public BigDecimal getkSumn() {
        return kSumn;
    }

    public void setkSumn(BigDecimal kSumn) {
        this.kSumn = kSumn;
    }

    public BigDecimal getLastFee() {
        return lastFee;
    }

    public void setLastFee(BigDecimal lastFee) {
        this.lastFee = lastFee;
    }

    public String getFillDt() {
        return fillDt;
    }

    public void setFillDt(String fillDt) {
        this.fillDt = fillDt;
    }

    public String getBackDt() {
        return backDt;
    }

    public void setBackDt(String backDt) {
        this.backDt = backDt;
    }

    @Override
    public String toString() {
        return "PMain{" +
                "sysNo='" + sysNo + '\'' +
                ", projNo='" + projNo + '\'' +
                ", projName='" + projName + '\'' +
                ", customId='" + customId + '\'' +
                ", customName='" + customName + '\'' +
                ", checkYear='" + checkYear + '\'' +
                ", checkDt='" + checkDt + '\'' +
                ", backFee=" + backFee +
                ", validFee=" + validFee +
                ", kSumn=" + kSumn +
                ", lastFee=" + lastFee +
                ", fillDt='" + fillDt + '\'' +
                ", backDt='" + backDt + '\'' +
                '}';
    }
}
