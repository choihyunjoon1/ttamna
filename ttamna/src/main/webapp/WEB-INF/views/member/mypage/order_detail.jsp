<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root}/resources/css/commons.css">



<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">상세내역</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			
			<div class="col-9" style="width: 80%">
				<h4>결제정보</h4>
				<ul>
					<li>주문번호 : ${payDto.tid}</li>
					<li>상품명 : ${payDto.itemName}</li>
					<li>총 결제금액 : ${payDto.totalAmount}원</li>
					<li>구매일 : ${payDto.payTime}</li>
					<li>거래상태 : ${payDto.status}</li>
				</ul>
				<hr>
			
			<h4>구매목록</h4>
			<table class="table">
				<thead>
					<tr>
						<th>상품명</th>
						<th>수량</th>
						<th>가격</th>
						<th></th>
					</tr>
				</thead>	
				<tbody>
					<c:forEach var="payDetailDto" items="${payDetailList}">
					<tr>
						<td><a href="${pageContext.request.contextPath}/shop/detail?shopNo=${payDetailDto.shopNo}">${payDetailDto.shopGoods}</a></td>
						<td>${payDetailDto.quantity}</td>
						<td>${payDetailDto.price}원</td>
						<td>
							<c:if test="${payDetailDto.status != '취소'}">
								<a href="cancel_part?payNo=${payDetailDto.payNo}&shopNo=${payDetailDto.shopNo}"><button class="btn btn-warning">취소</button></a>
							</c:if>
						</td>
					</tr>
					</c:forEach>	
				</tbody>
			</table>
			<hr>
			<c:if test="${payDto.status != '전체취소'}">
				<h3 align="right"><a href="cancel_all?payNo=${payDto.payNo}"><button class="btn btn-danger">전체 취소</button></a></h3>
			</c:if>

			</div>

		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>