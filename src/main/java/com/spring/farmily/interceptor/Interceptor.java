package com.spring.farmily.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class Interceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(Interceptor.class);
	
	static final String[] EXCLUDE_URL_LIST = {
		"/img", "/login", "/join", "/checkId", "/oauth/login", "/naver/login", "/naverConn"
	};
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		String reqUrl = request.getRequestURL().toString();
		String query = request.getQueryString();
		String preRequest = reqUrl +"?" +query;		
		/** 로그인 체크 제외 리스트 */
		for(String target : EXCLUDE_URL_LIST) {
			if(reqUrl.indexOf(target) > -1) {
				return true;
			}
		}
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("id");
		
		if (userId == null || userId.trim().equals("")){
			logger.info(">>Interceptor catch!!! userId is null..");
			logger.info("request URL = " + reqUrl);
			 if (request.getHeader("X-Requested-With") != null &&
					 request.getHeader("X-Requested-With").equals("XMLHttpRequest")) {
				 	 String reqBody = (String) request.getAttribute("requestBody");
				 	 session.setAttribute("reqBody", reqBody);
				 	 session.setAttribute("reqUrl", reqUrl);
				 	 System.out.println("reqbody: " + reqBody);
				 	 System.out.println("requrl: " + reqUrl);
			         response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			         response.getWriter().write("{\"redirect\": \"" + request.getContextPath() + "/login\"}");
			         return false;
			     } else {
			    	 if(request.getQueryString()!=null) {
			    		 session.setAttribute("reqUrl", preRequest);					 				    	
			    	 }else {
				 	 session.setAttribute("reqUrl", reqUrl);
			    	 }
			    	logger.info(">>redicet login page");
			    	System.out.println(">> interceptor catch! id null...");
			         response.sendRedirect(request.getContextPath() + "/login");
			         return false;
			    }
			}
				return true;
	}
}