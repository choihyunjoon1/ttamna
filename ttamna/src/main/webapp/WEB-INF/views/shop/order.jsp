<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>



<!--부트스트랩 cdn-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
<!--부트JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>  
 <!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script> 

<!-- 주소 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${root}/resources/js/address.js"></script>

<script>
	$(function(){
		$(".btn-primary").click(function(e){
//	e.preventDefault();		
			//form을 임시로 만들어서 body에 추가(전송용)
			//<form action="test" method="post"></form>
			var form = $("<form>").attr("action", "${root}/shop/order/multibuy").attr("method", "post").addClass("send-form");
			$("body").append(form);
			
			var count = 0;
			
			var irum = $("input[name=memberName]").val();
			var jeonhwa = $("input[name=memberPhone]").val();
			var upyeon = $("input[name=postcode").val();
			var gibon = $("input[name=address]").val();
			var juso = $("input[name=detailAddress]").val();
			
			$(".basket").each(function(){
				//this == 현재 반복중인 태그
				var number = $(this).find("input[name=shopNo]");
				var stock = $(this).find("input[name=quantity]");
				console.log(number);
				console.log(count);
				
					var shopNo = number.val();
					var quantity = stock.val();
					$("<input type='hidden' name='list["+count+"].shopNo'>").val(shopNo).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].quantity'>").val(quantity).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].memberName'>").val(irum).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].memberPhone'>").val(jeonhwa).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].postcode'>").val(upyeon).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].address'>").val(gibon).appendTo(".send-form");
					$("<input type='hidden' name='list["+count+"].detailAddress'>").val(juso).appendTo(".send-form");
					
					count++;
					console.log(shopNo);			
					console.log(quantity);
			});
			
			//전송
			form.submit();
		});
	});
</script> 
    
<style>
	a:link{
			text-decoration: none;
		}
		a:visited {
		text-decoration: none;
		}
		a:hover {
		text-decoration: none;
		}
		#total-amount{
			text-align: right;
		}
		.inline{
			float: left;
			width: 50%;
			padding: 5px;
		}
</style>
  
 
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">
	<span>${root}</span>
	<div class="mt-5 mb-5"><h3>구매 확인</h3></div>

		 <input type="hidden" name="memberId" value="${uid}">
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">받으실 분</span>
		  <input type="text" name="memberName" class="form-control" required aria-describedby="basic-addon1" disabled value="${memberDto.memberName}">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">연락처</span>
		  <input type="text" name="memberPhone" class="form-control" required aria-describedby="basic-addon1" min="0" disabled value="${memberDto.memberPhone}">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">우편번호</span>
		  <input type="text" class="form-control input-phone"  name="postcode" aria-describedby="button-addon-postcode" value="${memberDto.postcode}">
			<button class="address-btn btn btn-outline-primary" type="button" id="button-addon-postcode">우편번호 찾기</button>
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">기본주소</span>
		  <input type="text" class="form-control" name="address" value="${memberDto.address }">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">상세주소</span>
		  <input type="text" class="form-control" name="detailAddress"  value="${memberDto.detailAddress}">
		</div>
		<table class="table">
							<thead>
								<tr>
									<th></th>
									<th>상품명</th>
									<th>가격</th>
									<th>수량</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="totalAmount" value="0"/>
							<c:forEach var="cartDto" items="${list}">
								<tr class="basket">
										<td></td>
							  			<td><input type="hidden" name="shopNo" value="${cartDto.shopNo}"><a href="${root}/shop/detail?shopNo=${cartDto.shopNo}"><img src="${root}/shop/img?shopImgNo=${cartDto.shopImgNo}" width="100px;"></a></td>
										<td><span><a href="${root}/shop/detail?shopNo=${cartDto.shopNo}">${cartDto.shopGoods}</a></span></td>
										<td><span class="price">${cartDto.shopPrice}</span>원</td>
										<td style="width: 10%;"><input type="hidden" name="quantity"  value="${cartDto.cartCount}">${cartDto.cartCount}개</td>
										<td>${cartDto.cartCount * cartDto.shopPrice}원</td>
								</tr>
								<c:set var="totalAmount" value="${totalAmount + (cartDto.cartCount * cartDto.shopPrice)}"></c:set>
							</c:forEach>	
							</tbody>
						</table>
						<div id="total-amount">
							합계 : <span id="order-price"><c:out value="${totalAmount}"/></span>원
						</div>
						<hr>
							<div class="inline">
								<a type="button" href="${root}/shop/" class="btn btn-outline-secondary form-btn">취소</a>
							</div>
							<div class="inline">
								<button class="btn btn-primary form-btn">결제하기</button>
							</div>
			
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>