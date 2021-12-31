<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>결제 정보 확인</h1>


<form method="post">
	<input type="hidden" name="item_name" value="티어하임">
	<input type="hidden" name="quantity" value="1">
	<input type="hidden" name="total_amount" value="18000">
	
	<h3>상품명 : 티어하임</h3>
	<h3>수량 : 1</h3>
	<h3>결제금액 : 18000원</h3>
	<input type="submit" value="결제하기">
</form>














<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>