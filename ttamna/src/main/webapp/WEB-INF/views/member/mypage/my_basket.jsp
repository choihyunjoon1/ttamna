<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function(){
		$(".btn-primary").click(function(){
			//하나도 체크되지 않은 경우는 중지
			if($("input[name=shopNo]:checked").length == 0) return;
			
			//form을 임시로 만들어서 body에 추가(전송용)
			//<form action="test" method="post"></form>
			var form = $("<form>").attr("action", "${pageContext.request.contextPath}/shop/order/multibuy").attr("method", "post").addClass("send-form");
			$("body").append(form);
			
			//모든 div를 돌면서 내부에 존재하는 checkbox와 수량을 조사한 뒤 체크된 항목에 대해서 번호와 수량을 별도의 form에 첨부
			var count = 0;
			$(".cart").each(function(){
				//this == 현재 반복중인 div
				var checkbox = $(this).find("input[name=shopNo]");
				var number = $(this).find("input[name=quantity]");
				console.log(checkbox);				
				
				if(checkbox.prop("checked")){//체크박스가 체크된 경우
					//체크박스의 value가 상품번호이고 입력창의 숫자가 상품수량이므로 이 둘을 각각 별도의 form에 추가
					var shopNo = checkbox.val();
					var quantity = number.val();
					console.log(shopNo);
//					var quantity = number.val();
					
//					$("<input type='hidden' name='shopNo'>").val(shopNo).appendTo(".send-form");
//					$("<input type='hidden' name='quantity'>").val(quantity).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].shopNo'>").val(shopNo).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].quantity'>").val(quantity).appendTo(".send-form");
					console.log(shopNo);
//					$("<input type='hidden' name='list["+count+"].quantity'>").val(quantity).appendTo(".send-form");
					count++;
				}
			});
			
			//전송
			form.submit();
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">


<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			
			<div class="col-8">
			<c:choose>
	<c:when test="${list eq null}">
		<h4 align="center">장바구니에 담긴 상품이 없습니다</h4>
	</c:when>
	<c:otherwise>
		<c:forEach var="cartDto" items="${list}">
			<div class="cart">
						<input type="checkbox" name="shopNo" value="${cartDto.shopNo}">	
						<input type="number" name="quantity">
						<img src="${pageContext.request.contextPath}/shop/img?shopImgNo=${cartDto.shopImgNo}" width="100px;" height="70px;">
						<span>${cartDto.shopGoods}</span>
						<a href="my_basket/delete?cartNo=${cartDto.cartNo}"><button class="btn btn-danger">삭제</button></a>		
			</div>
		</c:forEach>
		<button class="btn btn-primary">구매하기</button>
	</c:otherwise>
</c:choose>
		
			</div>
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>