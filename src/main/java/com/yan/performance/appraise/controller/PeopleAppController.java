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
import com.yan.performance.appraise.model.Report;
import com.yan.performance.appraise.model.ReportDetail;
import com.yan.performance.dic.mapper.ProjDicMapper;
import com.yan.performance.dic.model.PMainEmp;
import com.yan.performance.dic.model.ProjDic;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.poi.hssf.usermodel.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
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
        List<PMain> pMains = pMainMapper.find(strs[0],strs[1]);
        List<PAward> pAwardList = pAwardMapper.bysysnoAndProjno(strs[0],strs[1]);
        BigDecimal sumAward = BigDecimal.ZERO;
        //该考核项目已分配的绩效
        for(PAward pAward :pAwardList){
            sumAward = sumAward.add(pAward.getAward());
        }
        model.addAttribute("lastFee",pMains.get(0).getLastFee());
        model.addAttribute("sumAward",sumAward);
        model.addAttribute("sysno",strs[0]);
        model.addAttribute("projNo",strs[1]);
        model.addAttribute("projName",strs[2]);
        if(strs.length  == 3){
            return "performance/appraise/peopleAddOrEdit";
        }else{
            String empNo = strs[3];
            List<PAward> list = pAwardMapper.find(strs[0],strs[1],strs[3]);
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

    @RequestMapping("/{id}/examine")
    public String examine(@PathVariable String id,Model model){
        String[] strs=id.split(",");
        if(strs.length  == 3){
            model.addAttribute("sysno",strs[0]);
            model.addAttribute("projNo",strs[1]);
            model.addAttribute("projName",strs[2]);
        }else{
            model.addAttribute("sysno",id);
        }

        return "performance/appraise/empExamineEdit";
    }

    @RequestMapping("/examine/tree")
    @ResponseBody
    public Map<String, Object> examineTree(){
        Map<String, Object> result = new HashMap<>();
        List<PMain> list = new ArrayList<>();
        List<String> sysnoList = new ArrayList<>();
        try{
            sysnoList = pMainMapper.allSysno();
            list = pMainMapper.list();
        }catch (Exception e){
            e.printStackTrace();
            result.put("msg", "获取失败");
            result.put("success", false);
            return result;
        }
        result.put("success", true);
        result.put("list",list);
        result.put("sysno",sysnoList);
        return result;
    }

    @RequestMapping("/examine/list")
    @ResponseBody
    public PageModel<PAward> list(int offset, int limit, String search, String sort, String order, String sysno, String projNo){
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

    @RequestMapping("/examine/edit")
    @ResponseBody
    @Transactional
    public MsgModel updateFlag(PAward pAward){
        try{
            pAwardMapper.update(pAward);
        }catch (Exception e){
            e.printStackTrace();
            return this.resultMsg("1","修改失败");
        }
        return this.resultMsg("0","修改完成");
    }

    @RequestMapping("/report")
    public String report(){
        return "/performance/appraise/report";
    }

    @RequestMapping("/report/list")
    @ResponseBody
    public PageModel<Report> reportList(int offset, int limit, String search, String sort, String order, String sysno){
        this.offsetPage(offset, limit);
        List<Report> list = new ArrayList<Report>();
        try{
            list = pAwardMapper.findReport(sysno);
        }catch (Exception e){
            e.printStackTrace();
        }
        PageModel<Report> pageModel = this.resultPage(list);
        return pageModel;
    }

    @RequestMapping("/report/detail")
    @ResponseBody
    public PageModel<ReportDetail> reportDetailList(int offset, int limit, String search, String sort, String order, String sysno,String empNo){
        this.offsetPage(offset, limit);
        List<ReportDetail> list = new ArrayList<ReportDetail>();
        try{
            list = pAwardMapper.reportDetail(sysno,empNo);
        }catch (Exception e){
            e.printStackTrace();
        }
        PageModel<ReportDetail> pageModel = this.resultPage(list);
        return pageModel;
    }

    @RequestMapping("/examine/allpub")
    @ResponseBody
    @Transactional
    public Map<String, Object> allPub(String sysno) throws Exception{
        Map<String, Object> result =new HashMap<>();
        try{
            pAwardMapper.allPub(sysno);
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            return result;
        }
        result.put("success",true);
        return result;
    }

    @RequestMapping("/expertExcel")
    @ResponseBody
    @Transactional
    public void exprotExcel(String sysno, HttpServletRequest request, HttpServletResponse resp)throws Exception{
        try {
            if (null == request || null == resp) {
                return;
            }
            List<Report> list = new ArrayList<Report>();
            list = pAwardMapper.findReport(sysno);
            exportExcel(list,sysno,request, resp);
//            List<RabiesCodeFormDoc> listContent;
//            Map<String, Object> condition = new HashMap<>();
//            listContent = statisticsMapper.rabiesCodeD(condition);
//            //生成Excel文件
//            rabiesCodeExportExcel(request, resp, listContent);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("msg", "导出 EXCEL 文件异常，请重试");
        }
    }

    public void exportExcel(List<Report> reports,String sysno,HttpServletRequest request, HttpServletResponse resp) throws Exception{

        request.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/x-download");

        String fileName = sysno+ "华为众邦绩效.xls";
        fileName = URLEncoder.encode(fileName, "UTF-8");
        resp.addHeader("Content-Disposition", "attachment;filename=" + fileName);
        List<Report> list = reports;
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet(sysno+"业绩考核");
        sheet.setDefaultRowHeight((short) (256));
        sheet.setColumnWidth(0, 20 * 160);
        sheet.setColumnWidth(1, 30 * 160);
        sheet.setColumnWidth(2, 20 * 160);
        sheet.setColumnWidth(3, 20 * 160);
        HSSFFont font = wb.createFont();
        font.setFontName("宋体");
        font.setFontHeightInPoints((short) 11);

        HSSFRow row = sheet.createRow(0);
        sheet.createRow(1);
        sheet.createRow(2);

        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        style.setWrapText(true);//设置自动换行

        HSSFCell cell = row.createCell(0);
        cell.setCellValue("序号");
        cell.setCellStyle(style);
        cell = row.createCell(1);
        cell.setCellValue("员工姓名");
        cell.setCellStyle(style);
        cell = row.createCell(2);
        cell.setCellValue("绩效奖金");
        cell.setCellStyle(style);
        cell = row.createCell(3);
        cell.setCellValue("已发放金额");
        cell.setCellStyle(style);

        for(int i = 0; i<list.size();i++){
            HSSFRow rowSub = sheet.createRow(i + 1);
            HSSFCell cellSub = rowSub.createCell(0);
            cellSub.setCellValue(i+1);
            cellSub.setCellStyle(style);
            cellSub = rowSub.createCell(1);
            cellSub.setCellValue(list.get(i).getEmpName());
            cellSub.setCellStyle(style);
            cellSub = rowSub.createCell(2);
            cellSub.setCellValue(list.get(i).getSumAward());
            cell.setCellStyle(style);
            cellSub = rowSub.createCell(3);
            cellSub.setCellValue(list.get(i).getAwardPay() == null?"0":list.get(i).getAwardPay());
            cell.setCellStyle(style);
        }
        try{
            OutputStream out = resp.getOutputStream();
            wb.write(out);
            out.close();
        }catch (Exception e){
            e.printStackTrace();
            throw e;
        }
    }

}
