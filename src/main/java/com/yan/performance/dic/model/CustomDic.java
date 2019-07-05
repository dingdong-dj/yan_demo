package com.yan.performance.dic.model;

import java.io.Serializable;

/**
 * 客户字典
 */
public class CustomDic implements Serializable {

    private String customId; //客户编号

    private String customName;//客户名称

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
        return "CustomDic{" +
                "customId='" + customId + '\'' +
                ", customName='" + customName + '\'' +
                '}';
    }
}
