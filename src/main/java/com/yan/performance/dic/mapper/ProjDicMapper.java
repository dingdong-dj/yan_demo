package com.yan.performance.dic.mapper;

import com.yan.performance.dic.model.ProjDic;
import org.apache.ibatis.annotations.Param;

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

    List<ProjDic> findByEmp(@Param("empNo") String empNo, @Param("empName") String empName);

    int modifyFlag(@Param("projNo") String projNo, @Param("statusFlag") String statusFlag);

    List<ProjDic> listBysearch(String searchCode);
}
