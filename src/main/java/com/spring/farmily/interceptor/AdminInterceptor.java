package com.spring.farmily.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter {
    
    private static final Logger logger = LoggerFactory.getLogger(AdminInterceptor.class);
    static final String[] EXCLUDE_URL_LIST = {"/Login"};

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        String reqUrl = request.getRequestURL().toString();
        HttpSession session = request.getSession(); 
        if (session == null) {
            logger.info("세션이 존재하지 않습니다.");
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        String userId = (String) session.getAttribute("id");
       logger.info("세션 ID: " + userId);
        for (String target : EXCLUDE_URL_LIST) {
            if (reqUrl.indexOf(target) > -1) {
                return true;
            }
        }

        if (userId == null || userId.trim().equals("")) {
            logger.info(">> 인터셉터 캐치! userId가 null입니다...");
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/admin/Login");
            return false;
        } else {
        	 char role = (char) session.getAttribute("role");
             logger.info("세션 ROLE: " + role);
			if(!(role=='A')) {			
				session.setAttribute("Auth", "로그인 하신 아이디는 관리자 계정이 아니므로<br>관리자 페이지 이용이 불가합니다.");
			System.out.println(">>admin Interceptor catch!!! has no authority..");
			response.sendRedirect(request.getContextPath() + "/");
			return false;
            }
        }

        return true;
    }
}
