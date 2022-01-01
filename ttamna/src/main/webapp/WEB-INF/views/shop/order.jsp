<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--부트스트랩 cdn-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
<!--부트JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>  
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<h1>결제 정보 확인</h1>


<form method="post">
	<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
	<input type="hidden" name="item_name" value="${detail.shopNo}">
	<input type="hidden" name="quantity" value="1">
	<input type="hidden" name="total_amount" value="${detail.shopPrice}">
	
	<h3>상품명 : ${detail.shopGoods}</h3>
	<h3>수량 : 1</h3>
	<h3>결제금액 : ${detail.shopPrice}원</h3>
	<input type="submit" value="결제하기">
</form>














<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>