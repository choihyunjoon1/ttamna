<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<c:forEach var="donationDto" items='${donationDto}'>
		<div class="row">
		${donationDto.donationWriter}
		</div>
		<div class="row">
		�̹�������
		</div>
		<div class="row">
		�Ŀ��ݾ� : ${donationDto.donationPrice}��
		</div>
		<div class="row">
		<a href="edit?donationNo=${donationDto.donationNo}">����</a>
		<!-- ���Ŀ� �� â�� �ѹ� ����� Ȯ���� ������ ������ �ǰԲ� �ڵ� -->
		<a href="delete?donationNo=${donationDto.donationNo}">����</a>
		</div>
	</c:forEach>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>