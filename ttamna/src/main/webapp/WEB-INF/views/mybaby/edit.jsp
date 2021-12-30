<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
<form method="post" enctype="multipart/form-data">
	<div class="row">
	<input type="hidden" name="mybabyWriter" value="${sessionScope.uid}">
		<label>
			제목<input type="text" name="mybabyTitle" required class="form-input" value="${mybaby.mybabyTitle}">
		</label>
	</div>
	<div class="row">
		<label>
			파일<input type="file" multiple name="attach" class="form-input" accept="image/*" >
		</label>
	</div>
	<div class="row">
		<label>내용</label>
		<textarea rows="10" cols="50" name="mybabyContent">${mybaby.mybabyContent}</textarea>
	</div>
	
	
	<div class="row">
		<label>
			<input type="submit" value="등록">
			<a href="detail?mybabyNo=${mybaby.mybabyNo}">취소</a>
		</label>
	</div>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>