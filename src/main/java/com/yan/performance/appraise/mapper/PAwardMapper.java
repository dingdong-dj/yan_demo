package com.yan.performance.appraise.mapper;

import com.yan.performance.appraise.model.PAward;
import com.yan.performance.appraise.model.Report;
import com.yan.performance.appraise.model.ReportDetail;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface PAwardMapper {

    //根据考核编号查询员工绩效
    List<PAward> findBySysno(@Param("sysno") String sysno);

    List<PAward> findBySysnoName(@Param("sysno") String sysno, @Param("distEmp")String distEmp);

    //获取所有考核编号
    List<String> allSysno();

    //是否存在检查
    PAward isExsit(PAward pAward);

    //保存插入
    int insert(PAward pAward);

    //查询当前考核编号项目下 员工的总绩效
    BigDecimal sumFee(@Param("sysNo") String sysNo, @Param("projNo") String projNo);

    //删除人员考核
    int deletePAward(@Param("sysNo") String sysno, @Param("projNo") String projNo,@Param("empNo") String empNo);

    //查询人员考核
    List<PAward> find(@Param("sysNo") String sysno, @Param("projNo") String projNo,@Param("empNo") String empNo);

    //查询所有人员考核
    List<PAward> all();

    //修改人员考核
    int update(PAward pAward);

    //根据考核周期和项目查询人员考核计算已考核金额
    List<PAward> bysysnoAndProjno(@Param("sysNo") String sysno, @Param("projNo") String projNo);

    List<PAward> bysysnoAndProjnoName(@Param("sysNo") String sysno, @Param("projNo") String projNo,@Param("distEmp")String distEmp);

    //查询当前用户可公布的绩效
    List<PAward> personalList(@Param("sysNo") String sysNo,@Param("empNo") String empNo);

    //查询所有员工可公布绩效
    List<PAward> findAllPub(@Param("sysNo") String sysno);

    List<Report> findReport(@Param("sysno") String sysno);

    List<ReportDetail> reportDetail(@Param("sysno") String sysno,@Param("empNo") String empNo);

    //一键发布
    int allPub(@Param("sysNo") String sysno);

    //查询项目是否已分配；
    List<PAward> findByProjNo(@Param("projNo")String projNo);
}
