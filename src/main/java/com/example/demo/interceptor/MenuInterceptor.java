package com.example.demo.interceptor;


import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
/**
 * interceptor URLPattern(/,/area/**,/notice/**,/office/**)
 */
public class MenuInterceptor implements HandlerInterceptor {

	
	private static final Logger logger = LoggerFactory.getLogger(MenuInterceptor.class);
	
	/**
	 * get current user's menu(ex: home,area,notice,office) to set header's Nav active menu
	 * @param request, response
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info(request.getRequestURI());
		StringTokenizer tok =  new StringTokenizer(request.getRequestURI(), "/");
		
		String menu;
		if(!tok.hasMoreElements())
			menu = "home";
		else 
			menu = tok.nextToken();
		//where am i?
		
		
		if(menu.equals("admin")) {
			if(!tok.hasMoreElements())
				menu = "home";
			else 
				menu = tok.nextToken();		
		}
		//when page is admin
		
		request.setAttribute("menu",menu);
		
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
}
