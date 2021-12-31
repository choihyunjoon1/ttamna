<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>${list}</h1>

<c:choose>
	<c:when test="${list eq null}">
		<h1>장바구니에 담긴 상품이 없습니다</h1>
	</c:when>
	<c:otherwise>
<c:forEach var="cartDto" items="${list}">
	<h1>${cartDto.shopNo}</h1>
	<h1><img src="${pageContext.request.contextPath}/shop/img?shopImgNo=${cartDto.shopImgNo}"></h1>
</c:forEach>
	</c:otherwise>
</c:choose>









<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>