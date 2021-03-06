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

	<div class="mt-5 mb-3"><h3>입양공고 수정</h3></div>
	<div class="mb-5">
	아이의 입양이 완료되었을 경우에는 게시글의 제목을 [입양완료]로 수정해주시기 바랍니다
	</div>
	<form method="post" enctype="multipart/form-data">
	<c:forEach var="adoptDto" items="${list}">
	<input type="hidden" name="adoptNo" value="${adoptDto.adoptNo}">
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">작성자</span>
		  <input type="text" name="adoptWriter" value="${adoptDto.adoptWriter}" disabled aria-label="end" class="form-control">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">제목</span>
		  <input type="text" name="adoptTitle" value="${adoptDto.adoptTitle}" required class="form-control" aria-describedby="basic-addon1">
		</div>
		  <div>입양공고 시작 날짜는 변경할 수 없습니다</div>
		<div class="input-group mb-3">
		  <span class="input-group-text">입양공고 기간</span>
		  <input type="date" value="${adoptDto.adoptStart}" disabled aria-label="end" class="form-control">
		  <input type="date" name="adoptEnd" value="${adoptDto.adoptEnd}" required aria-label="end" class="form-control">
		</div>
		<div class="input-group mt-3 mb-3">
		  <span class="input-group-text" id="basic-addon4">입양동물의 종류</span>
		  <input type="text" name="adoptKind" value="${adoptDto.adoptKind}" required class="form-control" aria-describedby="basic-addon4">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon5">구조장소</span>
		  <input type="text" name="adoptPlace" value="${adoptDto.adoptPlace}" required class="form-control" aria-describedby="basic-addon5">
		</div>
		<div class="input-group mb-3">
		  <input type="file" multiple name="attach" accept="image/*" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
		  <button class="btn btn-outline-info upload" type="button" id="inputGroupFileAddon04">업로드</button>
		</div>
		<div class="input-group mb-3">
		<c:if test="${adoptImgList != null}">
			<c:forEach var="adoptImgDto" items="${adoptImgList}">
				<img src="adoptImg?adoptImgNo=${adoptImgDto.adoptImgNo}&adoptNo=${adoptImgDto.adoptNo}" style="width:30%;">
				<a href="dropImg?adoptImgNo=${adoptImgDto.adoptImgNo}&adoptNo=${adoptImgDto.adoptNo}" class="btn btn-outline-info" type="button">삭제</a>
			</c:forEach>
		 </c:if>
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text">내용</span>
		  <div class="editor form-control" contenteditable="true">${adoptDto.adoptContent}</div>
		  <textarea name="adoptContent">${adoptDto.adoptContent}</textarea>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
			<button type="submit" class="btn btn-primary">수정</button>
			<a type="button" href="${root}/adopt/" class="btn btn-outline-primary">목록</a>
			<button type="reset" class="btn btn-outline-secondary">초기화</button>
		</div>
	</c:forEach>
	</form>
	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>