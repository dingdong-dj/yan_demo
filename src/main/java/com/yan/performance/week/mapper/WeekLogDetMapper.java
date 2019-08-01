package com.yan.performance.week.mapper;

import com.yan.performance.week.model.WeekLogDet;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WeekLogDetMapper {

    int create(WeekLogDet weekLogDet);

    int delete(@Param("sysno") String sysno);

    List<WeekLogDet> findById(@Param("sysno") String sysno);
}
