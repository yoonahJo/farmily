package com.spring.farmily.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;



public class FarmInterceptor extends HandlerInterceptorAdapter {
	static final String[] EXCLUDE_URL_LIST = {"/login"};
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String reqUrl = request.getRequestURL().toString();

		for ( String target : EXCLUDE_URL_LIST){
			if (reqUrl.indexOf(target) >-1){
			return true;
			}
		}

		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("id");
		
		if (userId == null || userId.trim().equals("")){
			System.out.println(">>Farmer Interceptor catch!!! userId is null..");
			session.invalidate();
			response.sendRedirect(request.getContextPath() + "/farm/user/login");
			return false;
		}else {
			char role = (char)session.getAttribute("role");
			if(!(role=='F')) {			
				session.setAttribute("Auth", "로그인 하신 아이디는 농부 회원이 아니므로<br>농부 로그인이 불가합니다.");
			System.out.println(">>Farmer Interceptor catch!!! has no authority..");
			response.sendRedirect(request.getContextPath() + "/");
			return false;
			}
		}
		return true;
		}
}	

