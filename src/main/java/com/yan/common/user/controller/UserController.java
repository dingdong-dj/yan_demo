package com.yan.common.user.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yan.common.user.model.*;
import com.yan.performance.dic.mapper.EmpDicMapper;
import com.yan.performance.dic.model.EmpDic;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yan.common.user.mapper.SysUserMapper;
import com.yan.common.user.mapper.UserRoleRelMapper;
import com.yan.core.annotation.MapperInject;
import com.yan.core.controller.BaseController;
import com.yan.core.model.MsgModel;
import com.yan.core.model.PageModel;

/**
 * 名称：UserController<br>
 *
 * 描述：用户管理模块<br>
 *
 * @author Yanzheng 严正<br>
 * 时间：<br>
 * 2017-09-07 15:43:05<br>
 * 版权：<br>
 * Copyright 2017 <a href="https://github.com/micyo202" target="_blank">https://github.com/micyo202</a>. All rights reserved.
 */
@Controller
@RequestMapping("/common/user")
public class UserController extends BaseController {

	@MapperInject(SysUserMapper.class)
	private SysUserMapper mapper;

	@MapperInject(EmpDicMapper.class)
	private EmpDicMapper empDicMapper;

	@RequestMapping("/manage")
	public String manage() {
		return "common/user/manage";
	}

	@RequestMapping("/password")
	public String password() {
		return "common/user/passwordChange";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@ResponseBody
	public PageModel<SysUser> list(int offset, int limit, String search, String sort, String order) {
		this.offsetPage(offset, limit);
		List<SysUser> list = mapper.selectByExample(null);
		return this.resultPage(list);
	}

	/**
	 * 用户对应角色保存方法<br>
	 *
	 * @param userId 用户Id
	 * @param roleStr 角色列表字符串
	 * @return MsgModel 消息模型
	 */
	@RequestMapping(value = "/roleSave", method = RequestMethod.POST)
	@ResponseBody
	public MsgModel roleSave(String userId, String roleStr) {
		List<String> roleIds = Arrays.asList(roleStr.split(","));
		UserRoleRelMapper mapper = this.getMapper(UserRoleRelMapper.class);

		// 先清除历史数据
		UserRoleRelExample example = new UserRoleRelExample();
		example.createCriteria().andUserIdEqualTo(userId);
		mapper.deleteByExample(example);

		// 添加
		for (String roleId : roleIds) {
			if (!this.isNull(roleId.trim())) {
				UserRoleRel userRoleRel = new UserRoleRel();
				userRoleRel.setRelId(this.getUUID());
				userRoleRel.setUserId(userId);
				userRoleRel.setRoleId(roleId);
				mapper.insertSelective(userRoleRel);
			}
		}
		return this.resultMsg("保存成功");
	}

	@RequestMapping("/upload")
	@ResponseBody
	public String upload(HttpServletRequest request) {
		List<String> fileNames = this.fileUpLoad(request);
		System.out.println(fileNames);
		return "success";
	}

	//打开增/改用户资料页
	@RequestMapping("/addOrEditPage")
	public String addOrEditPage(String userID, Model model) {
		SysUser sysUser = new SysUser();
		if(null == userID){
			model.addAttribute("sysUser",sysUser);
			model.addAttribute("flag","1");
			return "common/user/addOrEdit";
		}
		if(userID.equals("self")){
			//获取当前用户
			String userCode = SecurityUtils.getSubject().getPrincipals().toString();
			SysUserExample sysUserExample = new SysUserExample();
			SysUserExample.Criteria criteriaSysUser = sysUserExample.createCriteria();
			criteriaSysUser.andUserCodeEqualTo(userCode);
			sysUser = mapper.selectByExample(sysUserExample).get(0);
		}else if(!userID.equals("")){
			SysUserExample example = new SysUserExample();
			SysUserExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(userID);
			sysUser = mapper.selectByExample(example).get(0);
		}
		model.addAttribute("sysUser",sysUser);
		model.addAttribute("flag","0");

		return "common/user/addOrEdit";
	}

	@RequestMapping("/save")
	@ResponseBody
	@Transactional
	public MsgModel save(HttpServletRequest request){
		String userId = request.getParameter("userId");
		String userCode = request.getParameter("userCode");
		SysUser sysUser = new SysUser();
		List<SysUser> list = mapper.findByCode(userCode);
		if(list != null && list.size()>0){
			return this.resultMsg("1","该用账户名已存在");
		}
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		String userPhone = request.getParameter("userPhone");
		String userJoindate = request.getParameter("userJoindate");
		String userType = request.getParameter("userType");
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		try{
			Date date=simpleDateFormat.parse(userJoindate);
			sysUser.setUserId(userId);
			sysUser.setUserCode(userCode);
			sysUser.setUserName(userName);
			sysUser.setUserEmail(userEmail);
			sysUser.setUserPhone(userPhone);
			sysUser.setUserJoindate(date);
			sysUser.setUserType(userType);
			sysUser.setUserValid(true);
			sysUser.setUserPassword("123456");
			mapper.insert(sysUser);
			EmpDic empDic = new EmpDic();
			empDic.setEmpNo(userId);
			empDic.setEmpName(userName);
			empDicMapper.insert(empDic);
			return this.resultMsg("0","保存成功");
		}catch (Exception e){
			e.printStackTrace();
			return this.resultMsg("1","保存失败");
		}
	}


	@RequestMapping("/password/change")
	@ResponseBody
	@Transactional
	public MsgModel passwordChange(HttpServletRequest request){
		SysUser sysUser = new SysUser();
		//获取当前用户
		String userCode = SecurityUtils.getSubject().getPrincipals().toString();
		SysUserExample sysUserExample = new SysUserExample();
		SysUserExample.Criteria criteriaSysUser = sysUserExample.createCriteria();
		criteriaSysUser.andUserCodeEqualTo(userCode);
		sysUser = mapper.selectByExample(sysUserExample).get(0);
		String oldPd = request.getParameter("oldPd");
		if(oldPd ==null || !oldPd.equals(sysUser.getUserPassword())){
			return this.resultMsg("1","密码不正确");
		}
		sysUser.setUserPassword(request.getParameter("newPd"));
		try{
			mapper.updateByPrimaryKey(sysUser);
		}catch (Exception e){
			e.printStackTrace();
			return this.resultMsg("1","修改失败");
		}
		return this.resultMsg("0","修改成功");
	}


	@RequestMapping("/update")
	@ResponseBody
	@Transactional
	public MsgModel update(HttpServletRequest request){
		SysUserKey sysUserKey = new SysUserKey();
		sysUserKey.setUserId(request.getParameter("userId"));
		sysUserKey.setUserCode(request.getParameter("userCode"));
		SysUser sysUser = mapper.selectByPrimaryKey(sysUserKey);
		sysUser.setUserName(request.getParameter("userName"));
		sysUser.setUserEmail(request.getParameter("userEmail"));
		sysUser.setUserPhone(request.getParameter("userPhone"));

		try{
			mapper.updateByPrimaryKey(sysUser);
			return this.resultMsg("0","修改成功");
		}catch (Exception e){
			e.printStackTrace();
			return this.resultMsg("1","修改失败");
		}
	}
}
