<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-400 container-center ">
	<div class="align-self-center">
		<h3>JOIN SUCCESS!!</h3>
	</div>
	<div class='container'>
		<div class="d-grid gap-2">
			<a href="${pageContext.request.contextPath }"  class="btn btn-lg btn-primary" type="button">메인으로</a>
			<a href="${pageContext.request.contextPath }/member/login"  class="btn btn-lg btn-primary" type="button">로그인하러가기</a>
		</div>
	</div>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>