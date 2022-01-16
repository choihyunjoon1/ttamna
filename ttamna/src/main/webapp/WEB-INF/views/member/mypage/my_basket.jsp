<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>


<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- 금액 계산 스크립트 -->
<script>
//상품 * 수량 = 금액
function calculateOrderPrice() {
	// 테이블 바디와 tr 탐색
    var tbody = document.getElementById("cartBody");
    var rows = tbody.getElementsByTagName("tr");

    for (var i=0; i<rows.length; i++) {
        // tr를 순서대로 하나씩 가져오기
        var tr = rows[i];

        // tr에서 가격이 표시된 td 가져오기 tr로부터 n번째
        var priceTd = tr.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling;

        // 가격표시된 td다음에 있는 구매수량이 표시된 td가져오기
        var qtyTd = priceTd.nextElementSibling;

        // 구매가격(가격*구매수량)을 표시할 td 가져오기
        var orderPriceTd = qtyTd.nextElementSibling;
        
        // td에서 가격 가져오기
        var price = parseInt(priceTd.textContent);

        // td에서 구매수량 가져오기
        var qty = qtyTd.firstElementChild.value == "" ? 0 : parseInt(qtyTd.firstElementChild.value) ;

        // 구매가격 계산하기
        var orderPrice = price * qty;

        // 구매가격 표시 td에 구매가격 넣기
        orderPriceTd.textContent = orderPrice + "원";

    }
    // 총합계 계산하는 함수 실행시키기
    calculateTotalPrice();
}


// 위에서 계산한 상품들의 모든 가격을 합산
function calculateTotalPrice() {

    var span = document.getElementById("order-price");

    // tbody를 찾는다.
    var tbody = document.getElementById("cartBody");

    // tbody안의 모든 tr을 찾는다.
    var rows = tbody.getElementsByTagName("tr");

    // 주문가격의 합계를 저장할 변수 만든다.
    var total = 0;

    // tr을 순서대로 하나씩 뽑아내서 주문가격을 가져오자.
    for (var i=0; i<rows.length; i++) {

        var tr = rows[i];

        // 주문가격이 있는 td 찾기
        var priceTd = tr.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling;

        // 주문가격 가져오기
        var price = parseInt(priceTd.textContent);

        // 합계에 누적시키기
        total += price;

    }

    // 합계가 표시되는 span의 텍스트켄텐츠 변경하기
    span.textContent = total;            
}        
</script>

<!-- 수량 검사 스크립트 -->
<script type='text/javascript' src="${root}/resources/js/mybasket.js"></script>

<script>
$(function(){
	$(".btn-outline-danger").click(function(){
		var choice = window.confirm("장바구니를 비우시겠습니까?");
		if(choice){
			location.href="${root}/member/mypage/my_basket/deleteAll";
			location.reload();
		}else{
			return;
		}
	});
});
	
</script>


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
	a:link{
		text-decoration: none;
	}
	a:visited {
	text-decoration: none;
	}
	a:hover {
	text-decoration: none;
	}
	.btn-danger{
		width: 58px;
		height: 38px;
	}
	.right{
	text-align: right;
	margin-right: 70px;
	}
</style>

<script>
	$(function(){
		
		$("input[name=quantity]").on("input", function(){
			var shopCount = parsInt("${cartDto.shopCount}");
			console.log(shopCount);
			var inputCount = $("input[name=quantity]").val();
			if(inputCount > shopCount){
				alert("남아있는 수량보다 많습니다");
				location.reload();
			}
		});
		
		$(".btn-primary").click(function(){
//			e.preventdefault();
			//하나도 체크되지 않은 경우는 중지
			if($("input[name=shopNo]:checked").length == 0) return;
			//form을 임시로 만들어서 body에 추가(전송용)
			//<form action="test" method="post"></form>
			var form = $("<form>").attr("action", "${root}/shop/order").attr("method", "post").addClass("send-form");
			$("body").append(form);
			
			//모든 div를 돌면서 내부에 존재하는 checkbox와 수량을 조사한 뒤 체크된 항목에 대해서 번호와 수량을 별도의 form에 첨부
			var count = 0;
			$(".basket").each(function(){
				//this == 현재 반복중인 div
				var checkbox = $(this).find("input[name=shopNo]");
				var number = $(this).find("input[name=quantity]");
				var uid = $(this).find("input[name=memberId]");
				var name = $(this).find("input[name=shopGoods]");
				var price =$(this).find("input[name=shopPrice]");
				var imgNo = $(this).find("input[name=shopImgNo]");
				console.log(checkbox);

				if(checkbox.prop("checked")){//체크박스가 체크된 경우
					//체크박스의 value가 상품번호이고 입력창의 숫자가 상품수량이므로 이 둘을 각각 별도의 form에 추가
					var shopNo = checkbox.val();
					var quantity = number.val();
					var memberId = uid.val();
					var shopGoods = name.val();
					var shopPrice = price.val();
					var shopImgNo = imgNo.val();
					
					$("<input type='hidden' name='list["+count+"].shopNo'>").val(shopNo).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].memberId'>").val(memberId).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].shopGoods'>").val(shopGoods).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].shopPrice'>").val(shopPrice).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].shopImgNo'>").val(shopImgNo).appendTo(".send-form");
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
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">

<body onload="calculateOrderPrice();">
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
			<input type="hidden" name="shopCount" value="${cartDto.shopCount}">
			<div class="col-10">
				<c:choose>
							<c:when test="${list eq null}">
								<h4 align="center">장바구니에 담긴 상품이 없습니다</h4>
							</c:when>
						<c:otherwise>	
						<table class="table">
							<thead>
								<tr>
									<th></th>
									<th></th>
									<th>상품명</th>
									<th>가격</th>
									<th>재고</th>
									<th>수량</th>
									<th>합계</th>
									<th></th>
								</tr>
							</thead>
							
							
							<tbody  id="cartBody">
							<%-- 상품들의 금액을 합산해서 저장 --%>
							<c:set var="totalAmount" value="0"/>
							<c:if test="${list ne null}">
							<c:forEach var="cartDto" items="${list}">
								<tr class="basket">
										<td><input type="hidden" name="memberId" value="${sessionScope.uid}"><input type="checkbox" name="shopNo" value="${cartDto.shopNo}"></td>
							  			<td><input type="hidden" name="shopImgNo" value="${cartDto.shopImgNo}"><img src="${root}/shop/img?shopImgNo=${cartDto.shopImgNo}" width="100px;"></td>
										<c:choose>
											<c:when test="${cartDto.shopNo ne null}">
												<td><input type="hidden" name="shopGoods" value="${cartDto.shopGoods}"><span><a href="${root}/shop/detail?shopNo=${cartDto.shopNo}">${cartDto.shopGoods}</a></span></td>
											</c:when>
											<c:otherwise>
												<td><input type="hidden" name="shopGoods" value="${cartDto.shopGoods}"><span>${cartDto.shopGoods}</span></td>
											</c:otherwise>
										</c:choose>
										<td><input type="hidden" name="shopPrice" value="${cartDto.shopPrice}"><span class="price">${cartDto.shopPrice}</span>원</td>
										<td style="width: 10%;"><input type="number" name="quantity"  value="${cartDto.cartCount}" onchange="calculateOrderPrice();" min="1" max="999">개</td>
										<td>${cartDto.cartCount * cartDto.shopPrice}원</td>
										<td><a href="${root}/member/mypage/my_basket/delete?cartNo=${cartDto.cartNo}"><button class="btn btn-danger">삭제</button></a>	</td>
								</tr>
								<c:set var="totalAmount" value="${totalAmount + (cartDto.cartCount * cartDto.shopPrice)}"></c:set>
							</c:forEach>	
							</c:if>	
							</tbody>
						</table>
							</c:otherwise>
							</c:choose>
						<div class="right">
							합계 : <span id="order-price"><c:out value="${totalAmount}"/></span>원
						</div>
				
			
				<div>
					<input type="checkbox" id="checkAll">
					<label for="checkAll" class="btn btn-outline-info">모두선택</label>
					<button class="btn btn-primary">구매하기</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>