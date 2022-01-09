<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>



<style>
	.total{
		width: 20%;
	}
	.sum{
		width: 20%;
		text-align: center;
	}
	.test{
		border: none;
	}
	input#checkAll{
		display: none;
	}
	
</style>

<script>
	$(function(){
		$(".btn-primary").click(function(){
//			e.preventdefault();
			//하나도 체크되지 않은 경우는 중지
			if($("input[name=shopNo]:checked").length == 0) return;

			//form을 임시로 만들어서 body에 추가(전송용)
			//<form action="test" method="post"></form>
			var form = $("<form>").attr("action", "${root}/shop/order/multibuy").attr("method", "post").addClass("send-form");
			$(".form-set").append(form);
			
			//모든 div를 돌면서 내부에 존재하는 checkbox와 수량을 조사한 뒤 체크된 항목에 대해서 번호와 수량을 별도의 form에 첨부
			var count = 0;
			$(".basket").each(function(){
				//this == 현재 반복중인 div
				var checkbox = $(this).find("input[name=shopNo]");
				var number = $(this).find("input[name=quantity]");
				console.log(checkbox);
				console.log(number);

				if(checkbox.prop("checked")){//체크박스가 체크된 경우
					//체크박스의 value가 상품번호이고 입력창의 숫자가 상품수량이므로 이 둘을 각각 별도의 form에 추가
					var shopNo = checkbox.val();
					var quantity = number.val();

					$("<input type='hidden' name='list["+count+"].shopNo'>").val(shopNo).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].quantity'>").val(quantity).appendTo(".send-form");
					count++;
					console.log(shopNo);			
					console.log(quantity);
				}
			});
			
			//전송
			form.submit();
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root}/resources/css/commons.css">

<body onload="calculateOrderPrice();">
<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">장바구니</h1>
			<span>${list}</span>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			<div class="form-set">
			
			</div>
			<div class="col-9">
			<c:choose>
				<c:when test="${list eq null}">
					<h4 align="center">장바구니에 담긴 상품이 없습니다</h4>
				</c:when>
				<c:otherwise>
						<div class="cart">
						<table class="table">
							<thead>
								<tr>
									<th></th>
									<th></th>
									<th>상품명</th>
									<th>가격</th>
									<th>수량</th>
									<th>합계</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<%-- 상품들의 금액을  --%>
							<c:set var="totalAmount" value="0"/>
							<c:forEach var="cartDto" items="${list}">
								<tr class="basket">
										<td><input type="checkbox" name="shopNo" value="${cartDto.shopNo}"></td>
										<td><img src="${root}/shop/img?shopImgNo=${cartDto.shopImgNo}" width="100px;" height="70px;"></td>
										<td><span><a href="${root}/shop/detail?shopNo=${cartDto.shopNo}">${cartDto.shopGoods}</a></span></td>
										<td><span class="price">${cartDto.shopPrice}</span>원</td>
										<td><input type="number" name="quantity"  value="${cartDto.cartCount}" onchange="calculateOrderPrice();" min="1" max="999">개</td>
										<td>${cartDto.cartCount * cartDto.shopPrice}원</td>
										<td><a href="${root}/member/mypage/my_basket/delete?cartNo=${cartDto.cartNo}"><button class="btn btn-danger">삭제</button></a>	</td>
								</tr>
								<c:set var="totalAmount" value="${totalAmount + (cartDto.cartCount * cartDto.shopPrice)}"></c:set>
							</c:forEach>						
							</tbody>
						</table>
						</div>
						<div>
							합계 : <span id="order-price"><c:out value="${totalAmount}"/></span>원
						</div>
				</c:otherwise>
				
</c:choose>
				<div>
					
					<a href="${root}/member/mypage/my_basket/deleteAll" class="btn btn-outline-danger">장바구니 비우기</a>
					<button class="btn btn-primary">구매하기</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>