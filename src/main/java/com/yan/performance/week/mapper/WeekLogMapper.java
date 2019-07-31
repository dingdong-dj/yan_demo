package com.yan.performance.week.mapper;

import com.yan.performance.week.model.WeekLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WeekLogMapper {
    int create(WeekLog weekLog);

    List<WeekLog> findById(@Param("sysno") String sysno);

    int update(WeekLog weekLog);

    List<WeekLog> list();

    int delete(@Param("sysno") String sysno);
}
