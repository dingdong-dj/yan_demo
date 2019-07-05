package com.yan.performance.appraise.controller;

import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.performance.appraise.mapper.ProjectAppraiseMapper;
import com.yan.performance.appraise.model.ProjectAppraise;
import com.yan.performance.dic.mapper.ProjDicMapper;
import com.yan.performance.dic.model.ProjDic;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;

@Controller
@RequestMapping("/appraise/project")
public class ProjectAppraiseController extends BaseController {

    @MapperInject(ProjDicMapper.class)
    private ProjDicMapper projDicMapper;

    @MapperInject(ProjectAppraiseMapper.class)
    private ProjectAppraiseMapper projectAppraiseMapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/appraise/projectAppManage";
    }

    @RequestMapping("/addOrEditPage")
    public String addOrEditPage() {
        return "performance/appraise/projectAppAdd";
    }

//    @RequestMapping("save")
//    @ResponseBody
//    @Transactional
//    public MsgModel save(ProjectAppraise projectAppraise){
//        BigDecimal validFee = projectAppraise.getValidFee();
//        BigDecimal Ksumn = findKsumn(projectAppraise.getProjNo());
//        if(Ksumn == null){
//            return this.resultMsg("1","保存失败");
//        }
//        projectAppraise.setkSumn(Ksumn);
//
//        try{
//
//        }catch (Exception e){
//            e.printStackTrace();
//            return this.resultMsg("1","保存失败");
//        }
//    }


    public BigDecimal findKsumn(String projNo){
        ProjDic projDic;
        BigDecimal Ksumn =  BigDecimal.ZERO;;
        try{
            projDic = projDicMapper.selectByProjNo(projNo);
            Ksumn = Ksumn.add(projDic.getRatio1());
            Ksumn = Ksumn.add(projDic.getRatio2());
            Ksumn = Ksumn.add(projDic.getRatio3());
            Ksumn = Ksumn.add(projDic.getRatio4());
            Ksumn = Ksumn.add(projDic.getRatio5());
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
        return Ksumn;
    }
}
