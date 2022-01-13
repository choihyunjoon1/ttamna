<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	

<div class="container-800 container-center mt-5 mb-5 border px-5">
	<div class="mt-5 mb-5" align="center">
		<img src="${root}/resources/img/동물의집.png" style="width:200px;">
		<img src="${root}/resources/img/티어하임영어.png" style="width:200px;">
	</div>
	<div class="mb-5"  align="center">
		<img src="${root}/resources/img/티어하임소개.jpg" style="width:70%;">
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>