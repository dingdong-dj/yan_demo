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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.*;

import static java.math.BigDecimal.ROUND_HALF_UP;

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
        ProjDic projDic = projDicMapper.selectByProjNo(pMain.getProjNo());
        BigDecimal leftFee = projDic.getLeftFee();
        leftFee = leftFee.subtract(pMain.getBackFee());
        projDic.setLeftFee(leftFee);
        if(leftFee.compareTo(BigDecimal.ZERO)  == 1){
            projDic.setBackFlag("paying");
        }else{
            projDic.setBackFlag("payed");
        }
        if(pro !=null){
            return this.resultMsg("1","保存失败,该考核项目已存在");
        }
        BigDecimal Ksumn = findKsumn(pMain.getProjNo());
        if(Ksumn == null){
            return this.resultMsg("1","保存失败");
        }
        Ksumn = Ksumn.multiply(BigDecimal.valueOf(0.1));
        pMain.setkSumn(Ksumn.multiply(pMain.getValidFee()));
        try{
            pMainMapper.save(pMain);
            countLastFee(pMain.getSysNo());
            projDicMapper.update(projDic);
            return this.resultMsg("0","保存成功");
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","保存失败");
        }
    }

    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public PageModel<PMain> list(int offset, int limit, String search, String sort, String order,String sysno,Model model){
        if(sysno == null || "".equals(sysno)||"null".equals(sysno)){
            sysno = findSysno();
        }
        this.offsetPage(offset, limit);
        List<PMain> list = new ArrayList<PMain>();
        try{
            list = pMainMapper.findBySysno(sysno);
        }catch (Exception e){
            e.printStackTrace();
        }
        model.addAttribute("sumAll","assas");
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
           result.put("sysno",findSysno());
           return result;
       }else {
           result.put("msg", "暂无考核编号");
           result.put("success", false);
           return result;
       }
    }

    @RequestMapping("/find/projects")
    @ResponseBody
    public Map<String, Object> allProjects(String sysno){
        Map<String, Object> result = new HashMap<>();
        List<PMain> list = new ArrayList<PMain>();
        try{
            list= pMainMapper.findBySysno(sysno);
        }catch (Exception e){
            e.printStackTrace();
            result.put("msg", "考核项目获取失败");
            result.put("success", false);
            return result;
        }
        if(list != null && list.size()!=0){
            result.put("msg", "考核项目获取成功");
            result.put("success", true);
            result.put("list",list);
            return result;
        }else {
            result.put("msg", "考核项目获取失败");
            result.put("success", false);
            return result;
        }
    }

    @RequestMapping("/deletes")
    @ResponseBody
    @Transactional
    public MsgModel delete(String sysno,String projNo){
        ProjDic projDic = projDicMapper.selectByProjNo(projNo);
        BigDecimal lastFee = projDic.getLeftFee();
        List<PMain> list = pMainMapper.find(sysno,projNo);
        lastFee = lastFee.add(list.get(0).getBackFee());
        projDic.setLeftFee(lastFee);
        try{
            pMainMapper.deletePMain(sysno,projNo);
            countLastFee(sysno);
            projDicMapper.update(projDic);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","删除失败");
        }
        return this.resultMsg("0","删除成功");
    }

    @RequestMapping("/find/one")
    public String findByNo( String sysno,String projNo,Model model){
        List<PMain> list = new ArrayList<>();
        if(projNo != null && !"".equals(projNo) && sysno != null && !"".equals(sysno)){
            list = pMainMapper.find(sysno,projNo);
        }
        model.addAttribute("PMain",list.get(0));
        return "performance/appraise/projectAppAdd";
    }

    @RequestMapping("/content")
    @ResponseBody
    public Map<String ,Object> content(String sysno){
        List<PMain> pMains = pMainMapper.findBySysno(sysno);
        BigDecimal sumBackFee = BigDecimal.ZERO;
        BigDecimal sumVaildFee = BigDecimal.ZERO;
        BigDecimal sumLastFee = BigDecimal.ZERO;
        BigDecimal sumKsum = BigDecimal.ZERO;
        for(PMain pMain :pMains){
            sumBackFee = sumBackFee.add(pMain.getBackFee());
            sumVaildFee = sumVaildFee.add(pMain.getValidFee());
            sumLastFee =sumLastFee.add(pMain.getLastFee());
            sumKsum = sumKsum.add(pMain.getkSumn());
        }
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("success",true);
        map.put("sumBackFee",sumBackFee);
        map.put("sumVaildFee",sumVaildFee);
        map.put("sumLastFee",sumLastFee);
        map.put("sumKsum",sumKsum);
        return map;
    }

    @RequestMapping("/update")
    @ResponseBody
    @Transactional
    public MsgModel update(PMain pMain){
        Boolean needModify = true;
        List<PMain> list = pMainMapper.find(pMain.getSysNo(),pMain.getProjNo());
        ProjDic projDic = projDicMapper.selectByProjNo(pMain.getProjNo());
        BigDecimal leftFee = projDic.getLeftFee();
        if(pMain.getBackFee().compareTo(list.get(0).getBackFee()) == 0){
            needModify = false;
        }
        if(needModify){
            leftFee = leftFee.add(list.get(0).getBackFee());
            leftFee = leftFee.subtract(pMain.getBackFee());
            projDic.setLeftFee(leftFee);
            if(leftFee.compareTo(BigDecimal.ZERO) == 1){
                projDic.setBackFlag("paying");
            }else{
                projDic.setBackFlag("payed");
            }
        }
        try{
            BigDecimal Ksumn = findKsumn(pMain.getProjNo());
            if(Ksumn == null){
                return this.resultMsg("1","修改失败");
            }
            Ksumn = Ksumn.multiply(BigDecimal.valueOf(0.1));
            pMain.setkSumn(Ksumn.multiply(pMain.getValidFee()));
            pMainMapper.update(pMain);
            countLastFee(pMain.getSysNo());
            projDicMapper.update(projDic);
        }catch (Exception e){
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","修改成功");
    }


    @RequestMapping("/refresh")
    @ResponseBody
    @Transactional
    public MsgModel refresh(String sysno){
        try{
            List<PMain> list = pMainMapper.findBySysno(sysno);
            for(PMain pMain :list){
                BigDecimal Ksumn = findKsumn(pMain.getProjNo());
                Ksumn = Ksumn.multiply(BigDecimal.valueOf(0.1));
                pMain.setkSumn(Ksumn.multiply(pMain.getValidFee()));
                pMainMapper.update(pMain);
            }
            countLastFee(sysno);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","刷新成功");
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
            BigDecimal bd8 = new BigDecimal("100");
            Ksumn = Ksumn.divide(bd8);
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
        return Ksumn;
    }

    public String findSysno(){
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

    public BigDecimal count(List<PMain> pMains){
        BigDecimal feeSum =  BigDecimal.ZERO;
        BigDecimal kSum =  BigDecimal.ZERO;
        for(PMain pMain :pMains){
            feeSum = feeSum.add(pMain.getValidFee());
            kSum = kSum.add(pMain.getkSumn());
        }
        BigDecimal pavg = feeSum.divide(kSum,4,ROUND_HALF_UP);
        return pavg;
    }

    public void countLastFee(String sysno){
        List<PMain> list = new ArrayList<PMain>();
        try{
            list = pMainMapper.findBySysno(sysno);
            if(list != null && list.size() >0){
                BigDecimal pavg = count(list);
                pavg = pavg.multiply(BigDecimal.valueOf(0.1));
                for(PMain pMain :list){
                    pMain.setLastFee(pavg.multiply(pMain.getkSumn()));
                    pMainMapper.update(pMain);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
