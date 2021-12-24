<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
<form method="post">
	<div class="row">
	<input type="hidden" name="donationWriter" value="${sessionScope.uid}">
		<label>
			제목<input type="text" name="donationTitle" required class="form-input">
		</label>
	</div>
	<div class="row">
		<label>
			후원금액<input type="text" name="donationPrice" required class="form-input">
		</label>
	</div>
	<div class="row">
		<label>
			내용<textarea class="form-input"  name="donationContent" style="min-height:200px;"></textarea>
		</label>
	</div>
	<div class="row">
		<label>
			<input type="submit" value="등록">
		</label>
	</div>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>