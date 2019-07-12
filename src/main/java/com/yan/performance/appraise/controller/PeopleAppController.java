package com.yan.performance.appraise.controller;

import com.yan.common.user.mapper.SysUserMapper;
import com.yan.common.user.model.SysUser;
import com.yan.common.user.model.SysUserExample;
import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.performance.appraise.mapper.PAwardMapper;
import com.yan.performance.appraise.mapper.PMainMapper;
import com.yan.performance.appraise.model.PAward;
import com.yan.performance.appraise.model.PMain;
import com.yan.performance.dic.mapper.ProjDicMapper;
import com.yan.performance.dic.model.PMainEmp;
import com.yan.performance.dic.model.ProjDic;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 人员考核
 */
@Controller
@RequestMapping("/appraise/peoman")
public class PeopleAppController extends BaseController {

    @MapperInject(PAwardMapper.class)
    private PAwardMapper pAwardMapper;

    @MapperInject(PMainMapper.class)
    private PMainMapper pMainMapper;

    @MapperInject(SysUserMapper.class)
    private SysUserMapper mapper;

    @MapperInject(ProjDicMapper.class)
    private ProjDicMapper projDicMapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/appraise/peopleManage";
    }

    @RequestMapping("/tree")
    @ResponseBody
    public Map<String, Object> tree() {

        Map<String, Object> result = new HashMap<>();
        SysUser sysUser = new SysUser();
        //获取当前用户
        String userCode = SecurityUtils.getSubject().getPrincipals().toString();
        SysUserExample sysUserExample = new SysUserExample();
        SysUserExample.Criteria criteriaSysUser = sysUserExample.createCriteria();
        criteriaSysUser.andUserCodeEqualTo(userCode);
        sysUser = mapper.selectByExample(sysUserExample).get(0);
        List<PMainEmp> list = new ArrayList<>();
        List<String> sysnoList = new ArrayList<>();
        List<PAward> pAwardList = new ArrayList<>();
        try{
            sysnoList = pMainMapper.allSysno();
//            list = projDicMapper.findByEmp(sysUser.getUserId(),sysUser.getUserName());
            list = pMainMapper.findByEmp(sysUser.getUserId(),sysUser.getUserName());
            pAwardList = pAwardMapper.all();
        }catch (Exception e){
            e.printStackTrace();
            result.put("msg", "获取失败");
            result.put("success", false);
            return result;
        }
        result.put("success", true);
        result.put("list",list);
        result.put("sysno",sysnoList);
        result.put("palist",pAwardList);
        return result;
    }

    @RequestMapping("/{id}/edit")
    public String edit(@PathVariable String id, Model model) {

        String[] strs=id.split(",");
        if(strs.length  == 3){
            model.addAttribute("sysno",strs[0]);
            model.addAttribute("projNo",strs[1]);
            model.addAttribute("projName",strs[2]);
            return "performance/appraise/peopleAddOrEdit";
        }else{
            String empNo = strs[3];
            List<PAward> list = pAwardMapper.find(strs[0],strs[1],strs[3]);
            model.addAttribute("sysno",strs[0]);
            model.addAttribute("projNo",strs[1]);
            model.addAttribute("projName",strs[2]);
            model.addAttribute("pAward",list.get(0));
            return "performance/appraise/peopleAddOrEdit";
        }

    }


    @RequestMapping("/{id}/list")
    public String list(@PathVariable String id,Model model){
        String[] strs=id.split(",");
        if(strs.length  == 3){
            model.addAttribute("sysno",strs[0]);
            model.addAttribute("projNo",strs[1]);
        }else{
            model.addAttribute("sysno",id);
        }

        return "performance/appraise/peopleAppManage";
    }

}
