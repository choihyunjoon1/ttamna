<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-400 container-center">
	<div class="row">
		<h3>회원가입 성공</h3>
	</div>
	<div class="row">
		<a href="${pageContext.request.contextPath }" >메인으로</a>
		<a href = "${pageContext.request.contextPath }/member/login">로그인하러가기</a>
	</div>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>