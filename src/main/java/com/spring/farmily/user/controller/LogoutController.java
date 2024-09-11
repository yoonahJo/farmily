package com.spring.farmily.user.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LogoutController {
	@RequestMapping(value = "/user/logout", method = RequestMethod.POST)
	public String logout(HttpSession session, HttpServletResponse response) {
		session.removeAttribute("id");
		session.invalidate();
		
		return "redirect:/";
		
//		response.setHeader("Pragma", "No-Cache");
//        response.setHeader("Cache-Control", "No-Cache");
//        response.setDateHeader("Expires", 0);
	}
}
