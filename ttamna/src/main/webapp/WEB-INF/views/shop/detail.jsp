<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<!--부트스트랩 cdn-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
<!--부트JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>    
    
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


<style>
	.oneline{
		float: left;
		padding: 5px;
	}
</style>

<script>
$(function(){
	var login = $("input[name=memberId]").val();
	if(login == ''){
	$(".oneline").slideUp();		
	}
	
	
	
	// 결제 관련
	$("input[name=cartCount]").on("blur", function(){
        var cartCount = $(this).val();
        $(this).attr("value", cartCount);
        console.log($(this).attr("value"));
    });
	
	$("#buy").click(function(e){	
		if($("input[name=cartCount]").val() == ''){
			alert("수량을 입력해주세요");
			return;
		}
		
		if(window.confirm('해당 상품을 구매하시겠습니까?')){
				var form = $("<form>").attr("action", "order/multibuy").attr("method", "post").addClass("send-form");
				$("body").append(form);
	
				var shopNo = $("#shopNo").val();
				var memberId = $("input[name=memberId]").val();
				var shopGoods = $("input[name=shopGoods]").val();
				var shopPrice = $("input[name=shopPrice]").val();
				var shopImgNo = $("input[name=shopImgNo]").val();
				var cartCount = $("input[name=cartCount]").val()
				
				
				$("<input type='hidden' name='list[0].shopNo'>").val(shopNo).appendTo(".send-form");
				$("<input type='hidden' name='memberId'>").val(memberId).appendTo(".send-form");
				$("<input type='hidden' name='shopGoods'>").val(shopGoods).appendTo(".send-form");
				$("<input type='hidden' name='shopPrice'>").val(shopPrice).appendTo(".send-form");
				$("<input type='hidden' name='shopImgNo'>").val(shopImgNo).appendTo(".send-form");
				$("<input type='hidden' name='list[0].quantity'>").val(cartCount).appendTo(".send-form");
				//전송
				form.submit();
				return true;
		}else{
			return false;
		}
		
	});
	
	$("#add-cart").click(function(e){
//		e.preventDefault();
		
			var shopNo = $("#shopNo").val();
			var memberId = $("input[name=memberId]").val();
			var shopGoods = $("input[name=shopGoods]").val();
			var shopPrice = $("input[name=shopPrice]").val();
			var shopImgNo = $("input[name=shopImgNo]").val();
			var cartCount = $("input[name=cartCount]").val()
		
		
		// 수량 미선택시
		if(cartCount == ''){
			alert("수량을 입력해주세요");
			return;
		}
		
		if(window.confirm('장바구니로 이동하시겠습니까?')){
			// 즉석 form
			var form = $("<form>").attr("action", "${root}/member/detail/addcart").attr("method", "post").addClass("send-form");
			$("body").append(form);
			
			
			// form에 첨부할 값
			$("<input type='hidden' name='shopNo'>").val(shopNo).appendTo(".send-form");
			$("<input type='hidden' name='memberId'>").val(memberId).appendTo(".send-form");
			$("<input type='hidden' name='shopGoods'>").val(shopGoods).appendTo(".send-form");
			$("<input type='hidden' name='shopPrice'>").val(shopPrice).appendTo(".send-form");
			$("<input type='hidden' name='shopImgNo'>").val(shopImgNo).appendTo(".send-form");
			$("<input type='hidden' name='cartCount'>").val(cartCount).appendTo(".send-form");
			//전송
			form.submit();
			return true;
		} else{
			
			console.log(cartCount);
			
			$.ajax({
				url : "${root}/member/detail/addcart",
				type : "post", 
				data : {
					shopNo : shopNo,
					memberId : memberId,
					shopGoods : shopGoods,
					shopPrice : shopPrice,
					shopImgNo : shopImgNo,
					cartCount : cartCount
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

<script>
//삭제 버튼을 누르면 알림창 띄우기
$(function(){
	
	$(".delete-btn").click(function(){
		var choice = window.confirm("해당 게시글을 삭제 하시겠습니까?");
		if(choice){//확인을 누르면 삭제 처리
			location.href="${root}/shop/delete?shopNo=${detail.shopNo}";
			
		}else{ //취소를 누르면 현재페이지 리로드
			location.reload();
		}
	});
});
</script>


<script>

</script>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">

	<div class="container-500 container-center">
		<div class="card mb-5">
		  <div class="card-header d-grid gap-2 justify-content-center mt-2">	
		    <h3> ${detail.shopTitle}</h3>
		  </div>
		  <div class="card-body d-grid gap-2 justify-content-md-end">
		    <h6 class="card-subtitle text-muted">
		     작성자 : ${detail.memberId}   조회수 : ${detail.shopRead} 작성일 : ${detail.shopTime}
		    </h6>
		  </div>

			<div class="card-body d-grid gap-2">
					<img class="mx-auto" src="img?shopImgNo=${shopImgDto.shopImgNo}" style="width:60%;">
			</div>
			
			
		  <ul class="list-group list-group-flush">
		  <li class="list-group-item text-muted">
		  	<!-- 결제시 필요한 데이터 -->
		  		<div class="oneline">
				  	<input type="number" name="cartCount" placeholder="수량을 입력해주세요" class="center form-control" required>
				  	<input type="hidden" name="shopNo" value="${detail.shopNo}" id="shopNo">
					<input type="hidden" name="memberId" value="${sessionScope.uid}">
					<input type="hidden" name="shopGoods" value="${detail.shopGoods}">
					<input type="hidden" name="shopPrice" value="${detail.shopPrice}">
					<input type="hidden" name="shopImgNo" value="${shopImgDto.shopImgNo}">
		  		</div>
			  	<div class="oneline">
				  	<button class="btn btn-primary" id="buy">구매하기</button>
			  	</div>
				<div class="oneline">
					<button class="btn btn-warning" id="add-cart">장바구니에 담기</button>
				</div>
		  </li>
		    <li class="list-group-item text-muted">상품명 :  ${detail.shopGoods}</li>
		    <li class="list-group-item text-muted">판매가 :  ${detail.shopPrice}원</li>
		    <li class="list-group-item text-muted">남은 수량 :  ${detail.shopCount}</li>
		  </ul>
		  <div class="card-body">
		    <p class="card-text">${detail.shopContent}</p>
		  </div>
		  <div class="card-footer text-muted">
			<!-- 작성자 또는 관리자에게만 수정 삭제 버튼 보여주기 -->
			<c:set var="valid" value="${grade == '관리자' or uid == detail.memberId}"></c:set>
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a type="button" href="${root}/shop/" class="btn btn-outline-primary">목록</a>
			<c:if test="${valid}">
				<a href="${root}/shop/edit?shopNo=${detail.shopNo}" type="button" class="btn btn-outline-warning">수정</a>
				<button type="button" class="btn btn-outline-secondary delete-btn">삭제</button>
			</c:if>	
			</div>
		  </div>
		</div>
	</div>
</div>

<!-- 댓글 자리 -->
	<!-- 댓글목록 표시 위치 -->		
	<div class="row mt-3 mb-5 result"></div>

	<!-- 댓글 입력창 -->    
    <div class="col-12">
        <form action="${root}/shop_reply/insert" method="post">
           <input type="hidden" name="shopNo"value="${shopNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
 
            댓글 쓰기
            <textarea class="form-control" name="shopReplyContent"></textarea> 
            
        <div class="right">
            <input type="submit" class="reply btn btn-primary" value="등록">
        </div>
	</form>
          
 </div>




	<!-- 댓글 더보기 버튼 -->
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>