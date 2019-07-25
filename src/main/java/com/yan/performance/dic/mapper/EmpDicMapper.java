package com.yan.performance.dic.mapper;

import com.yan.performance.dic.model.EmpDic;

import java.util.List;

public interface EmpDicMapper {

    //查询列表
    List<EmpDic> list();

    //检查该id是否存在
    int findCount(String empNo);

    //新增员工
    int insert(EmpDic empDic);

//    void deleteEmpDic(EmpDic empDic);
    //删除员工
    int deleteEmpNos(String[] ids);

    //编辑修改员工姓名
    int updateName(EmpDic empDic);

    String autoId();
}
