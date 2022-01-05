<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--부트스트랩 cdn-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
<!--부트JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>    
    
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
	.center{
		width: 60%;
	}
</style>
<script>
$(function(){
	$("#add-cart").click(function(e){
		if(window.confirm('장바구니로 이동하시겠습니까?')){
			return true;
		} else{
			var shopNo = $("#shopNo").val();
			var memberId = $("input[name=memberId]").val();
			var shopGoods = $("input[name=shopGoods]").val();
			var shopPrice = $("input[name=shopPrice]").val();
			var shopImgNo = $("input[name=shopImgNo]").val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/member/mypage/my_basket",
				type : "post", 
				data : {
					shopNo : shopNo,
					memberId : memberId,
					shopGoods : shopGoods,
					shopPrice : shopPrice,
					shopImgNo : shopImgNo
				},
				success:function(resp){
					console.log("성공");
				},
				error:function(e){
					console.log("실패");
				}
			});
			return false;
		}
	});
});
</script>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<div class="row" align="center">
	<span>${detail.shopTitle}</span>
</div>
<hr>
<div class="row">
	<span>상품명 : ${detail.shopGoods}</span>
</div>
<hr>
<div class="row">
	<span>판매가 : ${detail.shopPrice}원</span>
</div>
<hr>
<div class="row">
	<span>남은 수량 : ${detail.shopCount}</span>
</div>
<hr>
<div class="row">
	<span>조회수 : ${detail.shopRead}</span>
</div>
<hr>
<form action="order/multibuy" method="post">
	<div class="mt-3" align="center">
		<input type="hidden" name="shopNo" value="${detail.shopNo}">
<!-- 	<input type="hidden" name="partner_user_id" value="${sessionScope.uid}"> -->	
		<input type="hidden" name="item_name" value="${detail.shopGoods}">
		<input type="hidden" name="total_amount" value="${detail.shopPrice}">
		<button class="btn btn-info center">구매하기</button>
	</div>	
</form>
<form action="${pageContext.request.contextPath}/member/detail/addcart" method="post" >
	<div class="mt-3" align="center">
		<input type="hidden" name="shopNo" value="${detail.shopNo}" id="shopNo">
		<input type="hidden" name="memberId" value="${sessionScope.uid}">
		<input type="hidden" name="shopGoods" value="${detail.shopGoods}">
		<input type="hidden" name="shopPrice" value="${detail.shopPrice}">
		<input type="hidden" name="shopImgNo" value="${shopImgDto.shopImgNo}">	
		<button class="btn btn-warning center" id="add-cart">장바구니에 담기</button>
	</div>
</form>
<br><br>
<div class="row">
	<c:choose>
		<c:when test="${shopImgDto == null}">
		<div>
			<img src="https://cdn.discordapp.com/attachments/565845740543410197/925011110959124551/211586d6bf04ce85.jpg" align="middle">
		</div>
			<span>${detail.shopContent}</span>
		</c:when>
		<c:otherwise>
				<img src="img?shopImgNo=${shopImgDto.shopImgNo}"width="80%">
			<div class="row">
				<span>${detail.shopContent}</span>		
			</div>
		</c:otherwise>
	</c:choose>
</div>
<a href="edit?shopNo=${detail.shopNo}" class="btn btn-info">수정</a>
<a href="delete?shopNo=${detail.shopNo}"  class="btn btn-danger">삭제</a>
<a href="list" class="btn btn-outline-dark">목록으로</a>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>