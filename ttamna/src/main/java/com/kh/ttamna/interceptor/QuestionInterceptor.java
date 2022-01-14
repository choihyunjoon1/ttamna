package com.kh.ttamna.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.ttamna.entity.question.QuestionDto;
import com.kh.ttamna.repository.question.QuestionDao;

//보호소 등급이상만 접근을 허용하는 인터셉터
//예: 기부게시글 등록, 수정, 삭제
public class QuestionInterceptor implements HandlerInterceptor{
	
	/*preHandle : 컨트롤러의 처리 메소드가 실행되기 직전 시점을 간섭*하는 메소드
	  - return true 일 경우 정상적인 진행 가능(허용)
	  - return false 일 경우 해당 요청은 진행 불가(차단)
	*/
	@Autowired
	private QuestionDao questionDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler)
			throws Exception {
		//세션에 저장된 등급을 사용
		String memberGrade = (String)request.getSession().getAttribute("grade");
		String memberId = (String)request.getSession().getAttribute("uid");
		int questionNo = Integer.parseInt(request.getParameter("questionNo"));
		QuestionDto questionDto = questionDao.detail(questionNo);
		String writer = questionDto.getMemberId();
		//작성자가 세션에있는 아이디와 일치 or 관리자일경우
		boolean isValid = memberId.equals(writer) || memberGrade.equals("관리자");
		if(isValid) {
			return true;
		}else {
			response.sendRedirect(request.getContextPath());
			return false;
		}
	}

}
