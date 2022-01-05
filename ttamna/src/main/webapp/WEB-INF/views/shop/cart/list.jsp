<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-latest.js"></script>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<c:choose>
	<c:when test="${list eq null}">
		<h1 align="center">장바구니에 담긴 상품이 없습니다</h1>
	</c:when>
	<c:otherwise>
		<h1 align="center">장바구니</h1>
	<form action="${pageContext.request.contextPath}/shop/order/multibuy" method="post">
		<c:forEach var="cartDto" items="${list}">
			<div class="cart">
				<input type="checkbox" name="shopNo" value="${cartDto.shopNo}">
				<a href="${pageContext.request.contextPath}/shop/detail?shopNo=${cartDto.shopNo}">
				<img src="${pageContext.request.contextPath}/shop/img?shopImgNo=${cartDto.shopImgNo}" width="200px" height="150px">	${cartDto.shopGoods}</a>	
			</div>
		</c:forEach>
		<input type="submit" class="btn btn-primary" value="구매하기">
	</form>	
	</c:otherwise>
</c:choose>










<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>