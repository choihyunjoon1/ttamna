<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">
	<div class="mt-5 mb-5"><h3>기부 신청 하기</h3></div>
	
	<form method="post" enctype="multipart/form-data">
		<div class="input-group mb-3">
			<span class="input-group-text">작성자</span>
			<input type="hidden" name="donationWriter" value="${uid}" >
			<input type="text"  value="${sessionScope.uid}" disabled aria-label="end" class="form-control">
		</div>
		<div class="input-group mb-3">
			<span class="input-group-text">목표금액</span>
			<input type="number" name="donationTotalFund" aria-label="end" class="form-control" autocomplete="off" required min="100000">
		</div>
		<div class="input-group mb-3">
			<span class="input-group-text">제목</span>
			<input type="text" name="donationTitle" aria-label="end" class="form-control" autocomplete="off" required>
		</div>
		<div class="input-group mb-3">
			<span class="input-group-text">내용</span>
			<textarea name="donationContent" class="form-control" aria-label="With textarea" 
			placeholder="사진과 관련있는 내용만 작성해주세요!" style="min-height:400px; resize:none;" required></textarea>
		</div>
		<div class="input-group mb-3">
			<input type="file" multiple name="attach" class="form-control" accept="image/*">
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
			<input type="submit" class="btn btn-primary" value="등록">
			<a type="button" href="${root}/ttamna/donation/" class="btn btn-outline-primary">목록</a>
			<button type="reset" class="btn btn-outline-secondary">초기화</button>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>