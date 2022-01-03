<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">

	<div class="mt-5 mb-5"><h3>입양공고 상세</h3></div>
	
	<div class="mt-5 mb-5">
		<div>${adoptDto.adoptTitle}</div>
		<div>${adoptDto.adoptRead}</div>
		<div>${adoptDto.adoptWriter}</div>
		<div>${adoptDto.adoptTime}</div>
		<div>${adoptDto.adoptStart} ~ ${adoptDto.adoptEnd}</div>
		<div>${adoptDto.adoptType}</div>
		<div>${adoptDto.adoptPlace}</div>
		<div>${adoptDto.adoptContent}</div>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>