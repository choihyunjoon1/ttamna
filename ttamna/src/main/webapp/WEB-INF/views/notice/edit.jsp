<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<style>
	.editor{
		box-sizing:border-box;
		width:100%;
		border:none;
		min-height: 100px;
	}
	textarea[name=noticeContent]{
		width:1px;
		height:1px;
		resize:none;
		position:fixed;
		top:0;
		left:-5px;
	}
</style>
<script>
	$(function(){
		function copyText(){
			var origin = $(".editor").html();
			$("textarea[name=noticeContent]").val(origin);
		}
		
		$(".editor").on("input", function(){
			//copy
			copyText();
		});
	});
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">

	<div class="mt-5 mb-3"><h3>입양전 필독 수정</h3></div>
	<form method="post" enctype="multipart/form-data">
	<c:forEach var="noticeDto" items="${list}">
	<input type="hidden" name="noticeNo" value="${noticeDto.noticeNo}">
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">작성자</span>
		  <input type="text" name="noticeWriter" value="${noticeDto.noticeWriter}" disabled aria-label="end" class="form-control">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">제목</span>
		  <input type="text" name="noticeTitle" value="${noticeDto.noticeTitle}" required class="form-control" aria-describedby="basic-addon1">
		</div>
		<div class="input-group mb-3">
		  <input type="file" multiple name="attach" accept="image/*" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
		  <button class="btn btn-outline-info upload" type="button" id="inputGroupFileAddon04">업로드</button>
		</div>
		<div class="input-group mb-3">
		<c:if test="${noticeImgList != null}">
			<c:forEach var="noticeImgDto" items="${noticeImgList}">
				<img src="noticeImg?noticeImgNo=${noticeImgDto.noticeImgNo}&noticeNo=${noticeImgDto.noticeNo}" style="width:30%;">
				<a href="dropImg?noticeImgNo=${noticeImgDto.noticeImgNo}&noticeNo=${noticeImgDto.noticeNo}" class="btn btn-outline-info" type="button">삭제</a>
			</c:forEach>
		 </c:if>
		</div>
		<div class="input-group mb-3" style="min-height:500px;">
		  <span class="input-group-text">내용</span>
		  <div class="editor form-control" contenteditable="true">${noticeDto.noticeContent}</div>
		  <textarea name="noticeContent">${noticeDto.noticeContent}</textarea>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
			<button type="submit" class="btn btn-primary">수정</button>
			<a type="button" href="${root}/notice/" class="btn btn-outline-primary">목록</a>
			<button type="reset" class="btn btn-outline-secondary">초기화</button>
		</div>
	</c:forEach>
	</form>
	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>