package com.yan.performance.appraise.mapper;

import com.yan.performance.appraise.model.PMain;

import java.util.List;

public interface PMainMapper {

    PMain isExsit(PMain PMain);

    int save(PMain PMain);

    List<PMain> list();

    List<String> allSysno();
}
