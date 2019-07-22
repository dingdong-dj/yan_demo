package com.yan.performance.appraise.controller;

import com.yan.common.user.mapper.SysUserMapper;
import com.yan.common.user.model.SysUser;
import com.yan.common.user.model.SysUserExample;
import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;
import com.yan.performance.appraise.mapper.PAwardMapper;
import com.yan.performance.appraise.mapper.PMainMapper;
import com.yan.performance.appraise.model.PAward;
import com.yan.performance.appraise.model.PMain;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.*;

/**
 * 人员绩效查看
 */
@Controller
@RequestMapping("/appraise/people")
public class PAwardController extends BaseController {

    @MapperInject(PAwardMapper.class)
    private PAwardMapper pAwardMapper;

    @MapperInject(PMainMapper.class)
    private PMainMapper pMainMapper;

    @MapperInject(SysUserMapper.class)
    private SysUserMapper mapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/appraise/peopleAppManage";
    }


    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public PageModel<PAward> list(int offset, int limit, String search, String sort, String order, String sysno,String projNo){
        if(sysno == null || "".equals(sysno)||"null".equals(sysno)){
            sysno = findSysno();
        }
        this.offsetPage(offset, limit);
        List<PAward> list = new ArrayList<PAward>();
        try{
            if(projNo == null || "".equals(projNo)){
                list = pAwardMapper.findBySysno(sysno);
            }else {
                list = pAwardMapper.bysysnoAndProjno(sysno,projNo);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return this.resultPage(list);
    }

    @RequestMapping("save")
    @ResponseBody
    @Transactional
    public MsgModel save(PAward pAward){
        PAward pro = pAwardMapper.isExsit(pAward);
        if(pro !=null){
            return this.resultMsg("1","保存失败,该考核人员已存在");
        }
        BigDecimal sumFee = sumFee(pAward);
        if(sumFee != null){
            sumFee = sumFee.add(pAward.getAward());
        }else{
            sumFee = pAward.getAward();
        }
        List<PMain> list = pMainMapper.find(pAward.getSysNo(),pAward.getProjNo());
        if(list == null || list.size() == 0){
            return this.resultMsg("1","保存失败,该考核编号下项目不存在");
        }
        if(sumFee.compareTo(list.get(0).getLastFee()) == 1){
            return this.resultMsg("1","保存失败,该项目下人员绩效超出，请检查");
        }
        SysUser sysUser = findUser();
        pAward.setDistEmp(sysUser.getUserName());
        try{
            pAwardMapper.insert(pAward);
            return this.resultMsg("0","保存成功");
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","保存失败");
        }
    }

    @RequestMapping("update")
    @ResponseBody
    @Transactional
    public MsgModel update(PAward pAward){
        List<PAward> pAwardList = pAwardMapper.find(pAward.getSysNo(),pAward.getProjNo(),pAward.getEmpNo());
        PAward old = pAwardList.get(0);
        BigDecimal sumFee = sumFee(old);
        sumFee = sumFee.subtract(old.getAward());
        sumFee = sumFee.add(pAward.getAward());
        List<PMain> list = pMainMapper.find(pAward.getSysNo(),pAward.getProjNo());
        if(list == null || list.size() == 0){
            return this.resultMsg("1","修改失败,该考核编号下项目不存在");
        }
        if(sumFee.compareTo(list.get(0).getLastFee()) == 1){
            return this.resultMsg("1","修改失败,该项目下人员绩效超出，请检查");
        }
        SysUser sysUser = findUser();
        pAward.setDistEmp(sysUser.getUserName());
        try{
            pAwardMapper.update(pAward);
        }catch (Exception e){
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","修改成功");
    }

    @RequestMapping("/deletes")
    @ResponseBody
    @Transactional
    public MsgModel delete(String sysno,String projNo,String empNo){
        try{
            pAwardMapper.deletePAward(sysno,projNo,empNo);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","删除失败");
        }
        return this.resultMsg("0","删除成功");
    }


    @RequestMapping("/personal")
    public String person(){
        return "performance/appraise/personalManage";
    }

    @RequestMapping(value = "/personal/list",method = RequestMethod.POST)
    @ResponseBody
    public PageModel<PAward> personalList(int offset, int limit, String search, String sort, String order, String sysno,String flag){
        SysUser sysUser = findUser();
        this.offsetPage(offset, limit);
        List<PAward> list = new ArrayList<PAward>();
        try{
            if("0".equals(flag)){
                list = pAwardMapper.findBySysno(sysno);
            }else{
                list = pAwardMapper.personalList(sysno,sysUser.getUserId());
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return this.resultPage(list);
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

    public SysUser findUser(){
        SysUser sysUser = new SysUser();
        //获取当前用户
        String userCode = SecurityUtils.getSubject().getPrincipals().toString();
        SysUserExample sysUserExample = new SysUserExample();
        SysUserExample.Criteria criteriaSysUser = sysUserExample.createCriteria();
        criteriaSysUser.andUserCodeEqualTo(userCode);
        sysUser = mapper.selectByExample(sysUserExample).get(0);
        return sysUser;
    }

    public BigDecimal sumFee(PAward pAward){
        BigDecimal sumFee = BigDecimal.ZERO;
        sumFee = pAwardMapper.sumFee(pAward.getSysNo(),pAward.getProjNo());
        return sumFee;
    }
}
