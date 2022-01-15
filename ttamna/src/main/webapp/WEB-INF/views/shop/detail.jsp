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
	.carousel-item{
		margin-left: 20%;
		margin-bottom: 10%;
	}
		img{
		max-width: 450px;
	}
</style>
<script>
	$(function(){
		var slideCard = $(".carousel-inner").children();
		console.log(slideCard);
		$(slideCard[0]).addClass("active");
	});
</script>

<script>
$(function(){
			
	// 비회원일경우 기능 접근 차단
	var login = $("input[name=memberId]").val();
	if(login == ''){
	$(".oneline").hide(); // 구매칸
	$(".deny").hide();	// 댓글칸
	}
	
	// 결제 관련
	$("input[name=cartCount]").on("blur", function(){
        var cartCount = $(this).val();
        $(this).attr("value", cartCount);
        console.log($(this).attr("value"));
    });
	
	// 수량이 없다면?
	var stock = $("input[name=shopCount]").val();
	if(stock == 0){
		$(".oneline").hide();
	}
	
	
	$("#buy").click(function(e){	
		
		var shopNo = $("#shopNo").val();
		var memberId = $("input[name=memberId]").val();
		var shopGoods = $("input[name=shopGoods]").val();
		var shopPrice = $("input[name=shopPrice]").val();
		var shopImgNo = $("input[name=shopImgNo]").val();
		var cartCount = $("input[name=cartCount]").val()
		
		if($("input[name=cartCount]").val() == '' || $("input[name=cartCount]").val() < 1){
			alert("올바른 수량을 입력해주세요");
			return;
		}
		
		if(window.confirm('해당 상품을 구매하시겠습니까?')){
				var form = $("<form>").attr("action", "order").attr("method", "post").addClass("send-form");
				$("body").append(form);
	
				
				
				$("<input type='hidden' name='list[0].shopNo'>").val(shopNo).appendTo(".send-form");
				$("<input type='hidden' name='list[0].memberId'>").val(memberId).appendTo(".send-form");
				$("<input type='hidden' name='list[0].shopGoods'>").val(shopGoods).appendTo(".send-form");
				$("<input type='hidden' name='list[0].shopPrice'>").val(shopPrice).appendTo(".send-form");
				$("<input type='hidden' name='list[0].shopImgNo'>").val(shopImgNo).appendTo(".send-form");
				$("<input type='hidden' name='list[0].quantity'>").val(cartCount).appendTo(".send-form");
			
				
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
		if(cartCount == '' || cartCount < 1){
			alert("올바른 수량을 입력해주세요");
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
	
	//댓글 목록 더보기 ajax
	var uid = "${sessionScope.uid}";
	var grade="${sessionScope.grade}";
	var page = 1;	
	var size = 12;
	var shopNo = parseInt($("#shopNo").val());
	//더보기 버튼 클릭시 이벤트 발생
	$(".more-btn").click(function(){
		loadList(page, size);
		page++;
	});
	
	//강제 1회 클릭
	$(".more-btn").click();
	
	function loadList(pageValue, sizeValue){
		$.ajax({
			url : "${pageContext.request.contextPath}/shop_reply/more",	
			type : "post",
			data : {
				page : pageValue,
				size : sizeValue,
				shopNo : shopNo
			},
			dataType : "json",
			success:function(resp){
				console.log("댓글 더보기 성공", resp);
				
				//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
				if(resp.length < size){
					$(".more-btn").remove();
				}
			
				for(var i=0 ; i < resp.length ; i++){
				
				//삭제 버튼을 작성자만 볼 수 있도록 처리
				var deleteBtn;
				if(uid == resp[i].memberId || grade=='관리자'){
					deleteBtn = "<div class='right'>"+"<a href='${pageContext.request.contextPath}/shop_reply/delete?shopReplyNo="+resp[i].shopReplyNo+"&shopNo="+resp[i].shopNo+"' class='delete-button reply btn btn-secondary'>삭제하기</a>"+"</div>";
				}else{
					deleteBtn = "";	
				}
				if(resp[i].memberId == null){
					resp[i].memberId = "탈퇴한 회원입니다";
				}
				
				//시간형식 포멧 
				var date = new Date(resp[i].shopReplyTime);
				
				
				
				var divCol = "<div class='card border-primary mb-3' style='width: 966px; padding: 0px;'>" 
					+"<div class='card-header id-font'>"+ resp[i].memberId
					+"<div class='right' style='font-size:13px;'>"+date.getFullYear()+"년"+date.getMonth()+1+"월"+date.getDate()+"일"+date.getHours()+"시"+date.getMinutes()+"분" +"</div>"
					+"</div>"
					+"<div class='card-body'>"
					+"<p class='card-text'>"+ resp[i].shopReplyContent+"</p>"
					+ "</div>"
					+deleteBtn
					+ "</div>";
						
						
					$(".result").append(divCol);
					
				}
				
				
				
				
				
			},
			error:function(e){
				console.log("댓글 더보기 실패", e);
			}
		});
	}
	
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
			
			<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
			  <div class="carousel-inner">
			  	<c:forEach var="shopImgDto" items="${shopImgDto}">
				<div class="carousel-item">
					<img class="mx-auto" src="img?shopImgNo=${shopImgDto.shopImgNo}" style="width:60%;">
				</div>
				</c:forEach>
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
				<c:forEach var="shopImgDto" items="${shopImgDto}">
				<div class="carousel-item">
					<img class="mx-auto" src="img?shopImgNo=${shopImgDto.shopImgNo}" style="width:60%;">
				</div>
				</c:forEach>
			</div>
			
			
		  <ul class="list-group list-group-flush">
		  <li class="list-group-item text-muted">
		  	<!-- 결제시 필요한 데이터 -->
		  		<div class="oneline">
				  	<input type="number" min="1" name="cartCount" placeholder="수량을 입력해주세요" class="center form-control" required>
				  	<input type="hidden" name="shopNo" value="${detail.shopNo}" id="shopNo">
					<input type="hidden" name="memberId" value="${sessionScope.uid}">
					<input type="hidden" name="shopGoods" value="${detail.shopGoods}">
					<input type="hidden" name="shopPrice" value="${detail.shopPrice}">
					<input type="hidden" name="shopImgNo" value="${shopImgDto[0].shopImgNo}">
					<input type="hidden" name="shopCount" value="${detail.shopCount}">
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
    <div class="col-12 deny">
        <form action="${root}/shop_reply/insert" method="post">
           <input type="hidden" name="shopNo"value="${shopNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
 
            <i class="bi bi-chat-left-text"> 
	 			댓글 쓰기
		 		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-left-text" viewBox="0 0 16 16">
				  <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
				  <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
				</svg>
	 		</i>
            <textarea class="form-control" name="shopReplyContent"></textarea> 
            
        <div class="right">
            <input type="submit" class="reply btn btn-primary" value="등록">
        </div>
	</form>
          
 </div>




	<!-- 댓글 더보기 버튼 -->
	<div class="row mt-3 mb-5">
		<div class="col mt-3 deny">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>