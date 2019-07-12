package com.yan.performance.appraise.mapper;

import com.yan.performance.appraise.model.PMain;
import com.yan.performance.dic.model.PMainEmp;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface PMainMapper {

    //检查考核项目是否存在
    PMain isExsit(PMain PMain);

    //保存
    int save(PMain PMain);

    //获取list
    List<PMain> list();

    //获取所有考核编号
    List<String> allSysno();

    //根据考核编号查询考核项目
    List<PMain> findBySysno(String sysno);

    //更新
    int update(PMain pMain);

    //删除
    int deletePMain(@Param("sysno") String sysno, @Param("projNo") String projNo);

    //根据考核编号和项目编号查询考核项目
    List<PMain> find(@Param("sysno") String sysno, @Param("projNo") String projNo);

    List<PMainEmp> findByEmp(@Param("empNo") String empNo,@Param("empName") String empName);

}
