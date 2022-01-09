<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>    

<style>
	.row{
		display: flex;
	}
	a:link{
		text-decoration: none;
	}
	a:visited {
	text-decoration: none;
	}
	a:hover {
	text-decoration: none;
}

</style>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-900 container-center mt-5 mb-5">
<h1 align="center">결제가 완료되었습니다.</h1>



	<!-- 글 목록이 찍히는 영역 -->
	<div class="row  mt-3 mb-5 justify-content-center">
		<img src="${root}/resources/img/gamsa.gif" style="width: 60%;">
	</div>
	<div class="row  mt-5 mb-5">
		<div class="col-md-4 center">
			<a href="${root}/member/mypage/my_order"><img src="${root}/resources/img/order.png"></a>
			<h2><a href="${root}/member/mypage/my_order">주문내역</a></h2>
		</div>
		<div class=" col-md-4 center">
			<a href="${root}"><img src="${root}/resources/img/gohome.png"></a>
			<h2><a href="${root}">홈으로</a></h2>
		</div>
		<div class=" col-md-4 center">
			<a href="${root}/shop/"><img src="${root}/resources/img/shop.png"></a>
			<h2><a href="${root}/shop/">다른 상품 보기</a></h2>
		</div>
	</div>
		
	
				
				
				
	
</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>