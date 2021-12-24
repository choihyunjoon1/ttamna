<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<div class="row mt-3">
		<c:forEach var="donationDto" items="${list}">
			<div class="col-3">
				<span>${donationDto.donationNo}번글</span>
				<br>
				이미지
				<br>
				<span>${donationDto.donationWriter}</span>
				<br>
				<span><a href="detail?donationNo=${donationDto.donationNo}">${donationDto.donationTitle}</a></span>
				<br>
				<span>${donationDto.donationContent}</span>
				<br>
				<span>${donationDto.donationPrice}</span>
				<br>
			</div>
		</c:forEach>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>