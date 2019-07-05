package com.yan.performance.appraise.controller;

import com.yan.core.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/appraise/people")
public class PeopleAppraiseController extends BaseController {

    @RequestMapping("/init")
    public String init(){
        return "performance/appraise/peopleAppManage";
    }

}
