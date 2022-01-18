<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$(".new-browser-auto").click(function(){
			var sid = $(this).parent().siblings(".sid").text();
			open("${pageContext.request.contextPath}/donation/kakao/auto/search?sid="+sid, '', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=700, height=730');
		});
		$(".auto-fund-inactive").click(function(){
			if(confirm("정기기부를 중단하시겠습니까?")){
				return true;
			} else {
				return false;
			}
		});
		
		var price = parseInt($(".total-amount").text());
		var payTimes = parseInt($(".pay-times").text());
		console.log(price);
		console.log(payTimes);
		
		$("#price-result").text(price * payTimes+"원");
	});
</script>
<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">DONATION LIST</h1>
		</div>
	</div>
	<div class="container" style="width:100%;">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			<div class="col-8" style="width:80%;">
				
				<!-- 정기결제 영역 -->
				<table class="table table-hover">
					<thead>
						<tr>
							<th>결제코드</th>
							<th>기부중인게시판번호</th>
							<th>기부금액</th>
							<th>최초기부일</th>
							<th>기부회차</th>
							<th>상태</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="list" value="${paginationVO.listOfAutopay }"></c:set>
						<c:forEach var="autopayDto" items="${list}">
						<tr onClick="location.href='#'">
							<td class="sid">${autopayDto.autoSid}</td>
							<td>${autopayDto.donationNo}</td>
							<td class="total-amount">${autopayDto.autoTotalAmount}원</td>
							<td>${autopayDto.firstPaymentDate}</td>
							<td class="pay-times">${autopayDto.payTimes}회차</td>
							<td>${autopayDto.autoStatus}</td>
							<td>
								<a class="new-browser-auto btn btn-success">조회</a>
								<c:if test="${autopayDto.autoStatus eq '결제'}">
									<a class="auto-fund-inactive btn btn-danger"
									href="${root}/donation/kakao/auto/inactive?sid=${autopayDto.autoSid}">중지</a>
								</c:if>
							</td>
						</tr>
						</c:forEach>
						<tr>
							<td colspan="7">
								지금까지 기부한 정기 기부 금액 : <span id="price-result"></span>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 페이지네이션 내비게이션 -->
				<nav aria-label="Page navigation example">
			  		<ul class="pagination justify-content-end">
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${paginationVO.isPreviousExist()}">
								<!-- 목록용 링크 -->
								<li class="page-item"><a class="page-link" href="my_donation?page=${paginationVO.getPreviousBlock()}">Prev</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="#">Prev</a></li>
							</c:otherwise>
						</c:choose>
						
						<!-- 페이지 네비게이터 -->
						<c:forEach var="i" begin="${paginationVO.getStartBlock()}" end="${paginationVO.getRealLastBlock()}" step="1">
							<!-- 목록용 링크 -->
					    	<li class="page-item"><a class="page-link" href="my_donation?page=${i}">${i}</a></li>
						</c:forEach>
				
						<!-- 다음 -->
						<c:choose>
							<c:when test="${paginationVO.isNextExist()}">
								<!-- 목록용 링크 -->
								<li class="page-item"><a class="page-link" href="my_donation?page=${paginationVO.getNextBlock()}">Next</a></li>
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