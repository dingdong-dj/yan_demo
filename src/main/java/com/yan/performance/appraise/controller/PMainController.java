package com.yan.performance.appraise.controller;

import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;
import com.yan.performance.appraise.mapper.PMainMapper;
import com.yan.performance.appraise.model.PMain;
import com.yan.performance.dic.mapper.ProjDicMapper;
import com.yan.performance.dic.model.ProjDic;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.*;

@Controller
@RequestMapping("/appraise/project")
public class PMainController extends BaseController {

    @MapperInject(ProjDicMapper.class)
    private ProjDicMapper projDicMapper;

    @MapperInject(PMainMapper.class)
    private PMainMapper pMainMapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/appraise/projectAppManage";
    }

    @RequestMapping("/addOrEditPage")
    public String addOrEditPage() {
        return "performance/appraise/projectAppAdd";
    }

    @RequestMapping("save")
    @ResponseBody
    @Transactional
    public MsgModel save(PMain pMain){
        PMain pro = pMainMapper.isExsit(pMain);
        if(pro !=null){
            return this.resultMsg("1","保存失败,该考核项目已存在");
        }
        BigDecimal Ksumn = findKsumn(pMain.getProjNo());
        if(Ksumn == null){
            return this.resultMsg("1","保存失败");
        }
        pMain.setkSumn(Ksumn);
        try{
            pMainMapper.save(pMain);
            return this.resultMsg("0","保存成功");
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","保存失败");
        }
    }

    @RequestMapping("/list")
    @ResponseBody
    public PageModel<PMain> list(int offset, int limit, String search, String sort, String order){
        this.setDataSource("extendDataSource");
        this.offsetPage(offset, limit);
        List<PMain> list = pMainMapper.list();
        this.clearDataSource();
        return this.resultPage(list);
    }

    @RequestMapping("/find/all")
    @ResponseBody
    public Map<String, Object> allSysno(){
        Map<String, Object> result = new HashMap<>();
        List<String> list = new ArrayList<String>();
        try{
            list= pMainMapper.allSysno();
        }catch (Exception e){
            e.printStackTrace();
            result.put("msg", "考核编号获取失败");
            result.put("success", false);
            return result;
        }
       if(list != null && list.size()!=0){
           result.put("msg", "考核编号获取成功");
           result.put("success", true);
           result.put("list",list);
           result.put("sysno",findSysno(list));
           return result;
       }else {
           result.put("msg", "考核编号获取失败");
           result.put("success", false);
           return result;
       }
    }


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

    public String findSysno(List<String> list){
        String sysNo;
        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month =  (now.get(Calendar.MONTH) + 1);
        if(month <= 6){
            sysNo = (year-1)+"Q2";
        }else{
            sysNo = year+"Q1";
        }
        return sysNo;
    }
}
