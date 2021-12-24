<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-400 container-center ">
	<div class="row">
		<h3>회원가입 성공</h3>
	</div>
	<div class="row">
		<div class="col">
			<a href="${pageContext.request.contextPath}" class="btn btn-lg btn-primary" tabindex="-1" role="button" aria-disabled="true">메인으로</a>
		</div>
		<div class="col">
			<a href="${pageContext.request.contextPath}/member/login" class="btn btn-lg btn-primary" tabindex="-1" role="button" aria-disabled="true">로그인하러가기</a>
			
		</div>
	</div>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>