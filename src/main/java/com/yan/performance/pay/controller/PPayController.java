package com.yan.performance.pay.controller;


import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;
import com.yan.performance.pay.mapper.PPayMapper;
import com.yan.performance.pay.model.PPay;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/pay/roll")
public class PPayController extends BaseController {

    @MapperInject(PPayMapper.class)
    private PPayMapper pPayMapper;

    @RequestMapping("/init")
    public String init(){
        return "performance/pay/payManage";
    }

    @RequestMapping("/addOrEditPage")
    public String addOrEditPage() {
        return "performance/pay/payAdd";
    }

    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public PageModel<PPay> list(int offset, int limit, String search, String sort, String order, String checkDt){
        this.offsetPage(offset, limit);
        List<PPay> list = new ArrayList<PPay>();
        try{
            list =pPayMapper.list(checkDt);
        }catch (Exception e){
            e.printStackTrace();
        }
        return this.resultPage(list);
    }

    @RequestMapping("save")
    @ResponseBody
    @Transactional
    public MsgModel save(PPay pPay){
        String payNo = pPay.getCheckDt()+pPay.getEmpNo()+pPay.getPayType();

        List<PPay> list = pPayMapper.findByNo(payNo);
        if(list != null && list.size()>0 ){
            return this.resultMsg("1","该周期下人员已发放");
        }
        try{
            pPay.setPayNo(payNo);
            pPayMapper.insert(pPay);
            return this.resultMsg("0","保存成功");
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","保存失败");
        }

    }

    @RequestMapping("/deletes")
    @ResponseBody
    @Transactional
    public MsgModel delete(String payNo){
        try{
            pPayMapper.delete(payNo);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","删除失败");
        }
        return this.resultMsg("0","删除成功");
    }

    @RequestMapping("/update")
    @ResponseBody
    @Transactional
    public MsgModel update(PPay pPay){
        try{
            pPayMapper.update(pPay);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","修改成功");
    }

}
