package com.yan.performance.dic.controller;

import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;
import com.yan.performance.appraise.mapper.PMainMapper;
import com.yan.performance.appraise.model.PMain;
import com.yan.performance.dic.mapper.ProjDicMapper;
import com.yan.performance.dic.model.CustomDic;
import com.yan.performance.dic.model.ProjDic;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dic/proj")
public class ProjDicController extends BaseController {
    @MapperInject(ProjDicMapper.class)
    private ProjDicMapper projDicMapper;

    @MapperInject(PMainMapper.class)
    private PMainMapper pMainMapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/dic/projDicManage";
    }

    @RequestMapping("/list")
    @ResponseBody
    public PageModel<ProjDic> list(int offset, int limit, String search, String sort, String order){
        this.offsetPage(offset, limit);
        List<ProjDic> list = projDicMapper.list();
        return this.resultPage(list);
    }

    @RequestMapping("/addOrEditPage")
    public String addOrEditPage() {
        return "performance/dic/addOrEdit";
    }

    @RequestMapping("save")
    @ResponseBody
    @Transactional
    public MsgModel save(ProjDic projDic){
        String projNo = projDic.getProjNo();
        int status = projDicMapper.findCount(projNo);
        if(status != 0){
            return this.resultMsg("1",projNo+"该编号已存在");
        }
        try{
            projDicMapper.insert(projDic);
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
        for(String id :ids){
           List<PMain> list = pMainMapper.findByProj(id);
           if(list != null && list.size()>0){
               return this.resultMsg("1","删除失败！项目"+id +"已存在考核项目不能删除,请先删除考核项中项目");
           }
        }
        try{
            projDicMapper.deleteProj(ids);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","删除失败");
        }
        return this.resultMsg("0","删除成功");
    }

    @RequestMapping("/find/one")
    public String findByNo(String projNo,Model model){
        ProjDic projDic = new ProjDic();
        if(projNo != null && !"".equals(projNo)){
            projDic = projDicMapper.selectByProjNo(projNo);
        }
        model.addAttribute("projDic",projDic);
        return "performance/dic/addOrEdit";
    }

    @RequestMapping("/look/one")
    public String lookByNo(String projNo,Model model){
        ProjDic projDic = new ProjDic();
        if(projNo != null && !"".equals(projNo)){
            projDic = projDicMapper.selectByProjNo(projNo);
        }
        model.addAttribute("projDic",projDic);
        return "performance/dic/projDetail";
    }

    @RequestMapping("/find/custom")
    @ResponseBody
    public Map<String, Object> findCustom(String projNo){
        ProjDic projDic = new ProjDic();
        CustomDic customDic = new CustomDic();
        Map<String, Object> result = new HashMap<>();
        if(projNo != null && !"".equals(projNo)){
            projDic = projDicMapper.selectByProjNo(projNo);
        }
        if(projDic != null){
            customDic.setCustomId(projDic.getCustomId());
            customDic.setCustomName(projDic.getCustomName());
            result.put("success", true);
            result.put("custom", customDic);
            return result;
        }
        result.put("success", false);
        result.put("custom", customDic);
        return result;
    }

    @RequestMapping("update")
    @ResponseBody
    @Transactional
    public MsgModel update(ProjDic projDic){
        try{
            projDicMapper.update(projDic);
        }catch (Exception e){
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","修改成功");
    }

    @RequestMapping("isUsed")
    @ResponseBody
    @Transactional
    public MsgModel isUsed(String projNo){

        List<PMain> list = pMainMapper.findByProj(projNo);
        if(list == null || list.size() == 0){
            return this.resultMsg("0","可修改");
        }else{
            return this.resultMsg("1","SORRY!该项目已存在绩效考核，无法修改！");
        }
    }

    @RequestMapping("/edit/flag")
    @ResponseBody
    @Transactional
    public MsgModel updateFlag(String projNo, String statusFlag){
        try{
            projDicMapper.modifyFlag(projNo,statusFlag);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","修改完成");
    }

    //注意: 之后可能要加条件
    @RequestMapping("/find/all")
    @ResponseBody
    public Map<String, Object> findAll(){
        Map<String, Object> result = new HashMap<>();
        try{
            List<ProjDic> list = projDicMapper.list();
            result.put("msg", "项目信息获取成功");
            result.put("success", true);
            result.put("projList", list);
            return result;
        }catch (Exception e ){
            e.printStackTrace();
            result.put("msg", "项目信息获取失败");
            result.put("success", false);
            return result;
        }

    }
}
