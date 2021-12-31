<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<c:choose>
	<c:when test="${list eq null}">
		<h1 align="center">장바구니에 담긴 상품이 없습니다</h1>
	</c:when>
	<c:otherwise>
<c:forEach var="cartDto" items="${list}">
		<h1 align="center">장바구니</h1>
	<div class="row">
		<input type="checkbox" name="shopNo" value="${cartDto.shopNo}">
		<a href="${pageContext.request.contextPath}/shop/detail?shopNo=${cartDto.shopNo}">
		<img src="${pageContext.request.contextPath}/shop/img?shopImgNo=${cartDto.shopImgNo}">	${cartDto.shopGoods}</a>	
	</div>

	<button class="btn btn-primary">구매하기</button>
</c:forEach>
	</c:otherwise>
</c:choose>









<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>