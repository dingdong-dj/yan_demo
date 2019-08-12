package com.yan.performance.dic.mapper;

import com.yan.performance.dic.model.CustomDic;

import java.util.List;

public interface CustomDicMapper {

    //查询列表
    List<CustomDic> list();

    //检查该id是否存在
    int findCount(String customId);

    //新增客户
    int insert(CustomDic customDic);

    //删除客户
    int deleteCustoms(String[] ids);

    //编辑修改客户名称姓名
    int updateName(CustomDic customDic);

    List<CustomDic> listBysearch(String searchCode);
}
