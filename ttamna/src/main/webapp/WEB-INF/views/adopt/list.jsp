<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="insertGrade" value="${grade == '관리자' or '보호소'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

</script>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-800 container-center mt-5 mb-5">
	
	<div class="mt-5 mb-2"><h3>입양공고</h3></div>
	
	<div class="row">
	
	<!-- 입양공고 등록버튼은 관리자와 보호소 등급만 사용할 수 있다 -->
	<c:if test="${insertGrade}">
		<div class="col">
			<a href="#" class="btn btn-outline-primary">입양공고 등록</a>
		</div>
	</c:if>
	
	</div>
	<div class="row mt-3 mb-5 result">
			
	</div>
	
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>