<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">









<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">주문내역</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			
			<div class="col-9" style="width: 80%">
		
				<table class="table">
				<thead>
					<tr align="center">
						<th scope="col" >결제코드</th>
						<th scope="col">상품명</th>
						<th scope="col">가격</th>
						<th scope="col">구매일</th>
						<th scope="col">상태</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody >
					<c:forEach begin="0" end="9"  var="list" items="${list}">
						<c:if test="${list.memberId eq sessionScope.uid and list.payType ne '기부'}">
					<tr>
						<td>${list.tid}</td>
						<td>${list.itemName}</td>
						<td>${list.totalAmount}원</td>
						<td>${list.payTime}</td>
						<td>${list.status}</td>
						<td><a href="${pageContext.request.contextPath}/member/mypage/order_detail?payNo=${list.payNo}"><button class="btn btn-primary">상세보기</button></a></td>
					</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
				
			</div>
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>