package com.kh.ttamna.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

//보호소 등급이상만 접근을 허용하는 인터셉터
//예: 기부게시글 등록, 수정, 삭제
public class GradeInterceptor implements HandlerInterceptor{
	
	/*preHandle : 컨트롤러의 처리 메소드가 실행되기 직전 시점을 간섭*하는 메소드
	  - return true 일 경우 정상적인 진행 가능(허용)
	  - return false 일 경우 해당 요청은 진행 불가(차단)
	*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//세션에 저장된 등급을 사용
		String memberGrade = (String)request.getSession().getAttribute("grade");
		//등급이 보호소 또는 관리자일 경우만 유효하다
		boolean isValid = memberGrade.equals("보호소") || memberGrade.equals("관리자");
		if(isValid) {
			System.out.println("[Grade Interceptor] " + memberGrade + " 등급. 접속 허용. " );
			return true;
		}else {
			System.out.println("[Grade Interceptor] " + memberGrade + " 등급. 접속 차단. " );
			response.sendRedirect(request.getContextPath()+"/donation/");
			return false;
		}
	}

}
