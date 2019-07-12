package com.yan.performance.appraise.mapper;

import com.yan.performance.appraise.model.PAward;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface PAwardMapper {

    //根据考核编号查询员工绩效
    List<PAward> findBySysno(String sysno);

    //
    List<String> allSysno();

    //是否存在检查
    PAward isExsit(PAward pAward);

    //保存插入
    int insert(PAward pAward);

    //查询当前考核编号项目下 员工的总绩效
    BigDecimal sumFee(@Param("sysNo") String sysNo, @Param("projNo") String projNo);

    int deletePAward(@Param("sysNo") String sysno, @Param("projNo") String projNo,@Param("empNo") String empNo);

    List<PAward> find(@Param("sysNo") String sysno, @Param("projNo") String projNo,@Param("empNo") String empNo);

    List<PAward> all();

    int update(PAward pAward);
}
