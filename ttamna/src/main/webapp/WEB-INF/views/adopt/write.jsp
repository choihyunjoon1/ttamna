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
	textarea[name=adoptContent]{
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
			$("textarea[name=adoptContent]").val(origin);
		}
		
		$(".editor").on("input", function(){
			//copy
			copyText();
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">

	<div class="mt-5 mb-5"><h3>입양공고 등록</h3></div>
	<form method="post" enctype="multipart/form-data">
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">작성자</span>
		  <div class="form-control">${sessionScope.uid}</div>
		  <input type="hidden" name="adoptWriter" value="${sessionScope.uid}">
		</div>
		  <div>입양공고 시작 날짜는 게시글 작성일자와 동일하게 설정됩니다</div>
		<div class="input-group mb-3">
		  <span class="input-group-text">입양공고 종료날짜</span>
		  <input type="date" name="adoptEnd" aria-label="end" class="form-control" required>
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">제목</span>
		  <input type="text" name="adoptTitle" class="form-control" required aria-describedby="basic-addon1">
		</div>
		<div class="input-group mt-3 mb-3">
		  <span class="input-group-text" id="basic-addon4">입양동물의 종류</span>
		  <input type="text" name="adoptKind" class="form-control" required placeholder="예시- 개/믹스 고양이/코숏 " aria-describedby="basic-addon4">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon5">구조장소</span>
		  <input type="text" name="adoptPlace" class="form-control" required aria-describedby="basic-addon5">
		</div>
		<div class="input-group mb-3">
		  <input type="file" multiple name="attach" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text">내용</span>
		  <div class="editor form-control" contenteditable="true" placeholder="임시보호자와 연락할 수 있는 방법을 꼭 기재해 주세요"></div>
		  <textarea name="adoptContent" required></textarea>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
			<button type="submit" class="btn btn-primary">등록</button>
			<a type="button" href="${root}/adopt/" class="btn btn-outline-primary">목록</a>
			<button type="reset" class="btn btn-outline-secondary">초기화</button>
		</div>
	</form>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>