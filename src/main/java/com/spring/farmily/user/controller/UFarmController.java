package com.spring.farmily.user.controller;



import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.farmily.chart.controller.FarmChartController;
import com.spring.farmily.user.model.UserVO;
import com.spring.farmily.user.model.farm.UserFarmService;


@Controller
@RequestMapping(value="/farm")
public class UFarmController {
	@Autowired
	private UserFarmService userService;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private FarmChartController farmChartController;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String index(Model model, HttpSession session) {
	   
	    String chartView = farmChartController.getMyChart(model, session);
	    return chartView;
	} //index에 차트띄우기
	
	@RequestMapping(value="/user/login", method=RequestMethod.GET)
	public String login() {
		return "/farm/user/login";
	}
	
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	public String login(UserVO vo, HttpSession session, Model model) {
		UserVO result = userService.getLogin(vo);
		System.out.println(result);
		if (result == null) {
			model.addAttribute("loginFailed","가입되지 않은 아이디 입니다.");			
			return null;
		}else {
			if(!passwordEncoder.matches(vo.getPassword(),result.getPassword())) {
				model.addAttribute("loginFailed","비밀번호가 일치하지 않습니다.");			
				return null;
			}else {
				session.setAttribute("id",result.getId());
				session.setAttribute("role", result.getRole());
				return "redirect:/farm";
			}
		}
	}
	
	@RequestMapping(value="/user/info", method=RequestMethod.GET)
	public String myinfo(HttpSession session, Model model) {
		String id = (String)session.getAttribute("id");
		UserVO vo = userService.getUser(id);
		model.addAttribute("user",vo);
		return "/farm/user/info";
	}
	@RequestMapping(value="/user/info", method=RequestMethod.POST)
	public String update(UserVO vo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserVO result = userService.getLogin(vo);
		if(!passwordEncoder.matches(vo.getPassword(),result.getPassword())) {
			System.out.println("비밀번호가 일치하지 않습니다.");
			response.getWriter().write("wrong");
			return null;
		}else {		
			String road = (String)request.getParameter("uroadAddress");
			String detail = (String)request.getParameter("udetailAddress");
			if(request.getParameter("udetailAddress").isEmpty()) {
				vo.setUaddress(road);
			}else {
				vo.setUaddress(road+","+detail);
			}
			String froad = (String)request.getParameter("froadAddress");
			String fdetail = (String)request.getParameter("fdetailAddress");
			if(request.getParameter("fdetailAddress").isEmpty()) {
				vo.setFaddress(froad);
			}else {
				vo.setFaddress(froad+","+fdetail);
			}try {
				userService.update(vo);
				response.getWriter().write("good");
				return null;

			}catch(Exception e){
				response.getWriter().write("fail");
				return null;
			}			
		}	
	}
	
	@RequestMapping(value="/user/changePwd", method=RequestMethod.GET)
	public String cheakPwd() {
		return "/farm/user/changePwd";
	}
	
	@RequestMapping(value="/user/changePwd", method=RequestMethod.POST)
	public String cheakPwd(UserVO vo , HttpServletResponse response) throws IOException {
		UserVO result = userService.getLogin(vo);
		if(!passwordEncoder.matches(vo.getPassword(),result.getPassword())) {
			response.getWriter().write("wrong");	
		return null;
		}else {
			try {
				changePwd(vo);
				response.getWriter().write("good");
				return null;
			}catch(Exception e) {
				response.getWriter().write("fail");
				return null;
			}
		}
	}
		
	private boolean changePwd(UserVO vo) {
		String encoderPwd = passwordEncoder.encode(vo.getNewpassword());
		vo.setPassword(encoderPwd);
		return userService.changePwd(vo);		
	}
	
	@RequestMapping(value="/user/leave", method=RequestMethod.GET)
	public String leave() {
		return "/farm/user/leave";		
	}
	
	@RequestMapping(value="/user/leave", method=RequestMethod.POST)
	public String leave(UserVO vo, HttpSession session, HttpServletResponse response) throws IOException {
		UserVO result = userService.getLogin(vo);
		if(!passwordEncoder.matches(vo.getPassword(),result.getPassword())){
			response.getWriter().write("wrong");
			return null;
		}else {	
			try {
				userService.leave(vo);
				response.getWriter().write("good");
				session.invalidate();	
				return null;
			}catch(Exception e) {
				System.out.println(e);
				response.getWriter().write("fail");
				return null;
			}
		}
	}
}
