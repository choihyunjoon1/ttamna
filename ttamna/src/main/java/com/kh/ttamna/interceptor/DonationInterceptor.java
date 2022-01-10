package com.kh.ttamna.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class DonationInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String grade = (String)request.getSession().getAttribute("grade");
		boolean isPass = grade.equals("관리자") || grade.equals("보호소");
		
		return isPass;
	}
}
