<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<link ref="stylesheet" type="text/css" href="${root}/resources/css/commons.css">

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">주문내역</h1>
		</div>
	</div>
	<div class="container" style="width:100%;">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			
			<div class="col-9" style="width: 80%">
		
				<table class="table">
				<thead>
					<tr align="center">
						<th scope="col">구매일</th>
						<th scope="col">상품명</th>
						<th scope="col">가격</th>
						<th scope="col">상태</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody >
					<c:set var="list" value="${paginationVO.listOfMyOrder}"></c:set>
					<c:forEach var="list" items="${paginationVO.listOfMyOrder}">
						<c:if test="${list.memberId eq sessionScope.uid and list.payType ne '기부'}">
					<tr>
						<td>${list.payTime}</td>
						<td>${list.itemName}</td>
						<td>${list.totalAmount}원</td>
						<td>${list.status}</td>
						<td><a href="${pageContext.request.contextPath}/member/mypage/order_detail?payNo=${list.payNo}"><button class="btn btn-primary">상세보기</button></a></td>
					</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
				<!-- 페이지네이션 내비게이션 -->
				<nav aria-label="Page navigation example">
			  		<ul class="pagination justify-content-end">
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${paginationVO.isPreviousExist()}">
								<!-- 목록용 링크 -->
								<li class="page-item"><a class="page-link" href="my_order?page=${paginationVO.getPreviousBlock()}">Prev</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="#">Prev</a></li>
							</c:otherwise>
						</c:choose>
						
						<!-- 페이지 네비게이터 -->
						<c:forEach var="i" begin="${paginationVO.getStartBlock()}" end="${paginationVO.getRealLastBlock()}" step="1">
							<!-- 목록용 링크 -->
					    	<li class="page-item"><a class="page-link" href="my_order?page=${i}">${i}</a></li>
						</c:forEach>
				
						<!-- 다음 -->
						<c:choose>
							<c:when test="${paginationVO.isNextExist()}">
								<!-- 목록용 링크 -->
								<li class="page-item"><a class="page-link" href="my_order?page=${paginationVO.getNextBlock()}">Next</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="#">Next</a></li>
							</c:otherwise>
						</c:choose>
					 </ul>
				</nav>
			</div>
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>