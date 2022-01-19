<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!-- JQeury CDN -->
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

	<div class="mt-5 mb-5"><h3>입양전 필독 작성</h3></div>
	<form method="post" enctype="multipart/form-data">
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">작성자</span>
		  <div class="form-control">${sessionScope.uid}</div>
		  <input type="hidden" name="noticeWriter" value="${sessionScope.uid}">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">제목</span>
		  <input type="text" name="noticeTitle" class="form-control" required aria-describedby="basic-addon1">
		</div>
		<div class="input-group mb-3">
		  <input type="file" multiple name="attach" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
		</div>
		<div class="input-group mb-3" style="min-height:500px;">
		  <span class="input-group-text">내용</span>
		  <div class="editor form-control" contenteditable="true"></div>
		  <textarea name="noticeContent" required></textarea>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
			<button type="submit" class="btn btn-primary">등록</button>
			<a type="button" href="${root}/notice/" class="btn btn-outline-primary">목록</a>
			<button type="reset" class="btn btn-outline-secondary">초기화</button>
		</div>
	</form>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>