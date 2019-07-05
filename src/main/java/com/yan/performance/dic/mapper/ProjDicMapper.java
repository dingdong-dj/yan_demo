package com.yan.performance.dic.mapper;

import com.yan.performance.dic.model.ProjDic;

import java.util.List;

public interface ProjDicMapper {

    List<ProjDic> list();

    //检查该id是否存在
    int findCount(String projNo);

    //新增项目
    int insert(ProjDic projDic);

    int deleteProj(String[] ids);

    ProjDic selectByProjNo(String projNo);

    int update(ProjDic projDic);
}