<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">

<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">DONATION LIST</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			
			<div class="col-7">
				<table class="table">
					<thead>
						<tr>
							<th>기부유형</th>
							<th>기부중인게시판번호</th>
							<th>기부금액</th>
							<th>최초기부일</th>
							<th>기부회차</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="autopayDto" items="${autoDonationList}">
						<tr>
							<td>정기기부</td>
							<td>${autopayDto.donationNo}</td>
							<td>${autopayDto.autoTotalAmount}원</td>
							<td>${autopayDto.firstPaymentDate}</td>
							<td>${autopayDto.payTimes}회차</td>
							<td><a href="${pageContext.request.contextPath}/donation/kakao/auto/search?sid=${autopayDto.autoSid}">조회</a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>