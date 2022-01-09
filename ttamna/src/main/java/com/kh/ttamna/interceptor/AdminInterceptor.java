package com.kh.ttamna.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

//관리자 등급만 접근할 수 있도록 하는 인터셉터
public class AdminInterceptor implements HandlerInterceptor{

	/*preHandle : 컨트롤러의 처리 메소드가 실행되기 직전 시점을 간섭*하는 메소드
	  - return true 일 경우 정상적인 진행 가능(허용)
	  - return false 일 경우 해당 요청은 진행 불가(차단)
	*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//세션에 저장된 등급을 확인
		String memberGrade = (String)request.getSession().getAttribute("grade");
		boolean isAdmin = memberGrade.contentEquals("관리자");
		if(isAdmin) {
			System.out.println("[Admin Interceptor] "+ memberGrade + " 등급. 접속 허용. " );
			return true;
		}else {
			System.out.println("[Admin Interceptor] "+ memberGrade + " 등급. 접속 차단. " );
			response.sendRedirect(request.getContextPath());
			return false;
		}
	}
}
