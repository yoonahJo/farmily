package com.spring.farmily.interceptor;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;



@Component
public class CopyBodyFilter implements Filter {

  @Override
  public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain) 
  	throws IOException, ServletException {
    try {
    	System.out.println(">>>body read");
      ReadableRequestBodyWrapper wrapper = new ReadableRequestBodyWrapper((HttpServletRequest) request);
      wrapper.setAttribute("requestBody", wrapper.getRequestBody());
      chain.doFilter(wrapper, response);
    } catch (Exception e) {
      chain.doFilter(request, response);
    }
  }

}