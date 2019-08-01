package com.yan.performance.week.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yan.common.user.mapper.SysUserMapper;
import com.yan.common.user.model.SysUser;
import com.yan.common.user.model.SysUserExample;
import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;
import com.yan.performance.week.mapper.WeekLogDetMapper;
import com.yan.performance.week.mapper.WeekLogMapper;
import com.yan.performance.week.model.WeekLog;
import com.yan.performance.week.model.WeekLogDet;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


@Controller
@RequestMapping("/week/log")
public class WeekLogController extends BaseController {

    @MapperInject(SysUserMapper.class)
    private SysUserMapper mapper;

    @MapperInject(WeekLogMapper.class)
    private WeekLogMapper weekLogMapper;

    @MapperInject(WeekLogDetMapper.class)
    private WeekLogDetMapper weekLogDetMapper;



    @RequestMapping("/init")
    public String init(){
        return "performance/week/weekLogManage";
    }


    @RequestMapping("/addPage")
    public String addPage(){
        return "performance/week/addOrEditWeekLog";
    }

    @RequestMapping("/delPage")
    public String delPage(String sysno, Model model){
        List<WeekLog> logList =  weekLogMapper.findById(sysno);
        if(logList !=null && logList.size() != 0){
            model.addAttribute("wkLog",logList.get(0));
        }
        model.addAttribute("sysno",sysno);
        return "performance/week/addOrEditWeekLog";
    }


    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public Map<String, Object> createOrUpdate(HttpServletRequest request) throws Exception {
        Map<String, Object> mapE = new HashMap<>();
        SysUser sysUser = findUser();
        String sysno = request.getParameter("sysno");
        WeekLog weekLog = new WeekLog();
        String weekNo = request.getParameter("weekNo");
        String titleName = request.getParameter("titleName");
        String sumText = request.getParameter("sumText");
        String fillEmp = request.getParameter("fillEmp");
        weekLog.setFillEmp(sysUser.getUserName());
        weekLog.setSumText(sumText);
        weekLog.setWeekNo(weekNo);
        weekLog.setTitleName(titleName);
        Date date = new Date();
        weekLog.setFillDt(date);
        String ListString = request.getParameter("wkLogDet");
        JSONArray logDetList = JSONArray.parseArray(ListString);
        try{
            if(null != sysno && !sysno.equals("")){
                weekLog.setFillEmp(fillEmp);
                weekLog.setSysno(sysno);
                weekLogMapper.delete(sysno);
                weekLogMapper.create(weekLog);
                weekLogDetMapper.delete(sysno);
            }else{
                sysno = this.getUUID();
                weekLog.setSysno(sysno);
                weekLogMapper.create(weekLog);
            }
            for(int i = 0; i < logDetList.size(); i++){
                JSONObject logDetLine = logDetList.getJSONObject(i);
                WeekLogDet weekLogDet = JSON.parseObject(logDetLine.toString(),WeekLogDet.class);
                weekLogDet.setSysno(sysno);
                weekLogDetMapper.create(weekLogDet);
            }
        }catch (Exception e){
            e.printStackTrace();
            mapE.put("success", false);
            mapE.put("msg", "保存失败");
            return mapE;
        }
        mapE.put("success", true);
        mapE.put("msg", "保存成功");
        return mapE;
    }

    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public PageModel<WeekLog> list(int offset, int limit, String search, String sort, String order){
        this.offsetPage(offset, limit);
        List<WeekLog> list = new ArrayList<WeekLog>();
        try{
            list =weekLogMapper.list();
        }catch (Exception e){
            e.printStackTrace();
        }
        return this.resultPage(list);
    }

    @RequestMapping("/detail/list")
    @ResponseBody
    public Map<String ,Object> detailList(String sysno){
        Map<String, Object> mapE = new HashMap<>();
        List<WeekLogDet> weekLogDetList = new ArrayList<WeekLogDet>();
        try{
            weekLogDetList = weekLogDetMapper.findById(sysno);
        }catch (Exception e){
            e.printStackTrace();
            mapE.put("success",false);
            mapE.put("msg","查询失败");
        }
        mapE.put("success",true);
        mapE.put("detList",weekLogDetList);
        return mapE;
    }

    @RequestMapping("/delete")
    @ResponseBody
    @Transactional
    public MsgModel delete(String sysno){
        try{
            weekLogMapper.delete(sysno);
            weekLogDetMapper.delete(sysno);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","删除失败");
        }
        return this.resultMsg("0","删除成功");
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
}
