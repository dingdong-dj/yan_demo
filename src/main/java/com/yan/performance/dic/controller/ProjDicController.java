package com.yan.performance.dic.controller;

import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;
import com.yan.performance.dic.mapper.ProjDicMapper;
import com.yan.performance.dic.model.ProjDic;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/dic/proj")
public class ProjDicController extends BaseController {
    @MapperInject(ProjDicMapper.class)
    private ProjDicMapper projDicMapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/dic/projDicManage";
    }

    @RequestMapping("/list")
    @ResponseBody
    public PageModel<ProjDic> list(int offset, int limit, String search, String sort, String order){
        this.setDataSource("extendDataSource");
        this.offsetPage(offset, limit);
        List<ProjDic> list = projDicMapper.list();
        this.clearDataSource();
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
}
