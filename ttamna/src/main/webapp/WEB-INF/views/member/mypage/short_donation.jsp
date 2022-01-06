<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$(".new-browser").click(function(){
			var tid = $(this).parent().siblings(".tid").text();
			console.log(tid);
			open("${pageContext.request.contextPath}/donation/kakao/search?tid="+tid, '', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=700, height=730');
		});
		$(".new-browser-auto").click(function(){
			var sid = $(this).parent().siblings(".sid").text();
			console.log(sid);
			open("${pageContext.request.contextPath}/donation/kakao/auto/search?sid="+sid, '', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=700, height=730');
		});
	});
</script>
<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">SHORT DONATION LIST</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			<div class="col-8" style="width:80%;">
				<!-- 단건결제 영역 -->
				<table class="table table-hover">
					<thead>
						<tr>
							<th>결제코드</th>
							<th>기부유형</th>
							<th>기부금액</th>
							<th>결제상태</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:set var = "list" value="${paginationVO.listOfShortPay }"></c:set>
						<c:forEach var="paymentDto" items="${list}">
						<c:if test="${paymentDto.memberId eq sessionScope.uid and paymentDto.payType eq '기부'}">
						<tr onClick="location.href='#'">
							<td class="tid">${paymentDto.tid}</td>
							<td class="item-name">${paymentDto.itemName}</td>
							<td class="total-amount">${paymentDto.totalAmount}원</td>
							<td class="status">${paymentDto.status}</td>
							<td>
								<a class="new-browser">조회</a>
								<c:if test="${paymentDto.status ne '전체취소'}">
									<a href="${pageContext.request.contextPath}/donation/kakao/cancel?tid=${paymentDto.tid}&amount=${paymentDto.totalAmount}&payNo=${paymentDto.payNo}">취소</a>
								</c:if>
							</td>
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
								<li class="page-item"><a class="page-link" href="short_donation?page=${paginationVO.getPreviousBlock()}">Prev</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="#">Prev</a></li>
							</c:otherwise>
						</c:choose>
						
						<!-- 페이지 네비게이터 -->
						<c:forEach var="i" begin="${payList.getStartBlock()}" end="${paginationVO.getRealLastBlock()}" step="1">
							<!-- 목록용 링크 -->
					    	<li class="page-item"><a class="page-link" href="short_donation?page=${i}">${i}</a></li>
						</c:forEach>
				
						<!-- 다음 -->
						<c:choose>
							<c:when test="${paginationVO.isNextExist()}">
								<!-- 목록용 링크 -->
								<li class="page-item"><a class="page-link" href="short_donation?page=${paginationVO.getNextBlock()}">Next</a></li>
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