package com.kh.ttamna.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

//로그인 상태일 때만 접근가능하도록 설정하는 인터셉터
public class LoginInterceptor implements HandlerInterceptor{
	
	/*preHandle : 컨트롤러의 처리 메소드가 실행되기 직전 시점을 간섭*하는 메소드
	  - return true 일 경우 정상적인 진행 가능(허용)
	  - return false 일 경우 해당 요청은 진행 불가(차단)
	*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String memberId = (String) request.getSession().getAttribute("uid");
		boolean isLogin = memberId != null;
		if(isLogin) {
			System.out.println("[Login Interceptor] 회원 확인. 접속 허용");
			return true;
		}else {
			System.out.println("[Login Interceptor] 비회원 접속 차단");
			response.sendRedirect(request.getContextPath()+"/member/login"); //리다이렉트처리
			//response.sendError(401);
			return false;
		}
		
	}

}
