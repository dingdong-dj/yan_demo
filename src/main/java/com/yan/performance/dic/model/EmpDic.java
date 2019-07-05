package com.yan.performance.dic.model;

import java.io.Serializable;

/**
 * 员工子典
 */
public class EmpDic implements Serializable {

    private String empNo; //员工编号

    private String empName;//员工姓名

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
        return "EmpDic{" +
                "empNo='" + empNo + '\'' +
                ", empName='" + empName + '\'' +
                '}';
    }
}
