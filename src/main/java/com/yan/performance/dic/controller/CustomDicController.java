package com.yan.performance.dic.controller;

import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;
import com.yan.performance.dic.mapper.CustomDicMapper;
import com.yan.performance.dic.model.CustomDic;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dic/custom")
public class CustomDicController extends BaseController {
    @MapperInject(CustomDicMapper.class)
    private CustomDicMapper customDicMapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/dic/customDicManage";
    }

    @RequestMapping("/list")
    @ResponseBody
    public PageModel<CustomDic> list(int offset, int limit, String search, String sort, String order){
        this.offsetPage(offset, limit);
        List<CustomDic> list;
        if(search !=null && !"".equals(search)){
            String searchCode = "%"+search+"%";
            list = customDicMapper.listBysearch(searchCode);
        }else{
            list = customDicMapper.list();
        }
        return this.resultPage(list);
    }

    @RequestMapping("/save")
    @ResponseBody
    @Transactional
    public MsgModel save(CustomDic customDic){
        String customId = customDic.getCustomId();
        int status = customDicMapper.findCount(customId);
        if (status != 0){
            return this.resultMsg("1",customId+"该编号已存在");
        }
        try{
            customDicMapper.insert(customDic);
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
            customDicMapper.deleteCustoms(ids);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","删除失败");
        }
        return this.resultMsg("0","删除成功");
    }

    @RequestMapping("/update")
    @ResponseBody
    @Transactional
    public MsgModel update(CustomDic customDic){
        int status = customDicMapper.updateName(customDic);
        if(status == 0){
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","修改成功");
    }

    @RequestMapping("/find/all")
    @ResponseBody
    public Map<String, Object> findAll(){
        Map<String, Object> result = new HashMap<>();
        try{
            List<CustomDic> list = customDicMapper.list();
            result.put("msg", "客户信息获取成功");
            result.put("success", true);
            result.put("customList", list);
            return result;
        }catch (Exception e ){
            e.printStackTrace();
            result.put("msg", "客户信息获取失败");
            result.put("success", false);
            return result;
        }

    }
}
