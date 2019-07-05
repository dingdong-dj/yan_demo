package com.yan.performance.appraise.controller;

import com.yan.core.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/appraise/project")
public class ProjectAppraiseController extends BaseController {

    @RequestMapping("/init")
    public String init(){
        return "performance/appraise/projectAppManage";
    }

    @RequestMapping("/addOrEditPage")
    public String addOrEditPage() {
        return "performance/appraise/projectAppAdd";
    }
}
