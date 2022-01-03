<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="admin" value="${grade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">

	<div class="mt-5 mb-5"><h3>입양공고 상세</h3></div>
	<c:if test="${param.success != null}">
		<div class=" mb-3"><h6>입양공고 수정 완료</h6></div>
	</c:if>
	<c:if test="${param.invalid != null}">
		<div class=" mb-3"><h6>수정 권한이 없습니다</h6></div>
	</c:if>	
	
	<div class="mt-5 mb-5">
		<div>${adoptDto.adoptTitle}</div>
		<div>${adoptDto.adoptRead}</div>
		<div>${adoptDto.adoptWriter}</div>
		<div>${adoptDto.adoptTime}</div>
		<div>${adoptDto.adoptStart} ~ ${adoptDto.adoptEnd}</div>
		<div>${adoptDto.adoptKind}</div>
		<div>${adoptDto.adoptPlace}</div>
		<div>${adoptDto.adoptContent}</div>
	</div>
	
	<!-- 작성자 또는 관리자에게만 수정 삭제 버튼 보여주기 -->
	<c:if test="${uid eq adoptDto.adoptWriter or admin }">
	<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
		<a href="${root}/adopt/edit?adoptNo=${adoptDto.adoptNo}" type="button" class="btn btn-outline-primary">수정</a>
		<a href="${root}/adopt/delete?adoptNo=${adoptDto.adoptNo}"type="button" class="btn btn-outline-secondary">삭제</a>
	</div>
	</c:if>	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>