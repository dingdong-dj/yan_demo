package com.yan.performance.appraise.mapper;

import com.yan.performance.appraise.model.PMain;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PMainMapper {

    PMain isExsit(PMain PMain);

    int save(PMain PMain);

    List<PMain> list();

    List<String> allSysno();

    List<PMain> findBySysno(String sysno);

    int update(PMain pMain);

    int deletePMain(@Param("sysno") String sysno, @Param("projNo") String projNo);

    List<PMain> find(@Param("sysno") String sysno, @Param("projNo") String projNo);
}
