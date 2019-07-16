package com.yan.performance.pay.mapper;

import com.yan.performance.pay.model.PPay;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PPayMapper {

    List<PPay> list(@Param("checkDt") String checkDt);

    List<PPay> findByNo(String payNo);

    int insert(PPay pPay);

    int delete(String payNo);

    int update(PPay pPay);
}
