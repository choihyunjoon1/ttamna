<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<%-- 기부게시판 더보기 에이잭스 js --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/donation-list.js"></script>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<div class="row mt-3">
	<div class="col">
		<a href="insert" class="btn btn-primary">기부신청</a>
	</div>
	</div>
	<div class="row mt-3 result">
			
	</div>
	<div class="row mt-3">
		<div class="col mt-3">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	
	<form method="post" >
		<div class="input-group">
			<div class="col-3 offset-2">
				<select name="column" class="form-select" required id="column">
				<c:choose>
					<c:when test="${column eq 'donation_title'}">
						<option value="">선택안함</option>
						<option value="donation_title" selected>제목</option>
						<option value="donation_writer">작성자</option>
						<option value="donation_content">내용</option>
					</c:when>
					<c:when test="${column eq 'donation_writer'}">
						<option value="">선택안함</option>
						<option value="donation_title">제목</option>
						<option value="donation_writer" selected>작성자</option>
						<option value="donation_content">내용</option>
					</c:when>
					<c:when test="${column eq 'donation_content'}">
						<option value="">선택안함</option>
						<option value="donation_title">제목</option>
						<option value="donation_writer">작성자</option>
						<option value="donation_content" selected>내용</option>
					</c:when>
					<c:otherwise>
						<option value="">선택안함</option>
						<option value="donation_title">제목</option>
						<option value="donation_writer">작성자</option>
						<option value="donation_content">내용</option>
					</c:otherwise>
				</c:choose>
				</select>
			</div>
			<div class="col-3">
				<input type="text" name="keyword" required class="form-control" value="${keyword}">
			</div>
			<div class="col-2">
				<input type="submit" value="검색" id="search" class="btn btn-primary">
			</div>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>