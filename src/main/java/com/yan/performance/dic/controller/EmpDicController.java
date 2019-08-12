package com.yan.performance.dic.controller;

import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;
import com.yan.performance.dic.mapper.EmpDicMapper;
import com.yan.performance.dic.model.EmpDic;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.lang.Integer.parseInt;

@Controller
@RequestMapping("/dic/emp")
public class EmpDicController extends BaseController {

    @MapperInject(EmpDicMapper.class)
    private EmpDicMapper empMapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/dic/empDicManage";
    }

    @RequestMapping("/add/page")
    public String addPage(Model model){
        model.addAttribute("flag","1");
        return "common/user/addOrEdit";
    }

    @RequestMapping("/list")
    @ResponseBody
    public PageModel<EmpDic> list(int offset, int limit, String search, String sort, String order){
        this.offsetPage(offset, limit);
        List<EmpDic> list;
        if(search !=null && !"".equals(search)){
            String searchCode = "%"+search+"%";
            list = empMapper.listBysearch(searchCode);
        }else{
            list = empMapper.list();
        }
        return this.resultPage(list);
    }

    @RequestMapping("/find/all")
    @ResponseBody
    public Map<String, Object> findAll(){
        Map<String, Object> result = new HashMap<>();
        try{
            List<EmpDic> list = empMapper.list();
            result.put("msg", "员工信息获取成功");
            result.put("success", true);
            result.put("empList", list);
            return result;
        }catch (Exception e ){
            e.printStackTrace();
            result.put("msg", "员工信息获取失败");
            result.put("success", false);
            return result;
        }

    }

    @RequestMapping("/save")
    @ResponseBody
    @Transactional
    public MsgModel save(EmpDic empDic){
        String empNo = empDic.getEmpNo();
        int status = empMapper.findCount(empNo);
        if (status != 0){
            return this.resultMsg("1",empNo+"该编号已存在");
        }
        try{
            empMapper.insert(empDic);
            return this.resultMsg("0","保存成功");
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","保存失败");
        }
    }

    @RequestMapping("/deletes")
    @ResponseBody
    @Transactional
    public MsgModel delete(String[] ids){
        try{
            empMapper.deleteEmpNos(ids);
        }catch (Exception e){
            return this.resultMsg("1","删除失败");
        }
        return this.resultMsg("0","删除成功");
    }

    @RequestMapping("/update")
    @ResponseBody
    @Transactional
    public MsgModel update(EmpDic empDic){
        int status = empMapper.updateName(empDic);
        if(status == 0){
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","修改成功");
    }

    @RequestMapping("/auto/id")
    @ResponseBody
    public Map<String, Object> autoId(){
        Map<String, Object> result = new HashMap<>();
        String id = empMapper.autoId();
        String userId;
        if(id == null || "".equals(id)){
            userId = "00001";
        }else{
            userId = String.format("%05d",parseInt(id));
        }
        result.put("userId", userId);
        result.put("success", true);
        return result;

    }
}
