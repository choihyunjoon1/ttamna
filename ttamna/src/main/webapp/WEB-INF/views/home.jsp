<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   

<style>
.img-fit {
	width: 80%;
  	object-fit: cover;
}
#main-img{
	text-align: center;
}
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div id="main-img">
		<img class="img-fit" src="${root}/resources/img/img1.jpg">
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>