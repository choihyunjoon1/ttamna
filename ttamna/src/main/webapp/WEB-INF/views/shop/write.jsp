<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	.editor.img{
		width: 30%;
	}
	textarea[name=shopContent]{
		width:1px;
		height:1px;
		resize:none;
		
		position:fixed;
		top:0;
		left:-5px;
	}
		img{
		max-width: 600px;
	}
</style>

<script>
	$(function(){
		// 에디터
		function copyText(){
			var origin = $(".editor").html();
			$("textarea[name=shopContent]").val(origin);
		}
		
		$(".editor").on("input", function(){
			//copy
			copyText();
		});
		
		// 수량체크
		$("input[name=shopCount]").on("change", function(){
			var goodsCount = $("input[name=shopCount]").val();
			if(goodsCount == "" || goodsCount < 1){
				alert("올바른 수량을 입력해주세요");
			}
		});
		
	});
</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">

	<div class="mt-5 mb-5"><h3>상품 등록</h3></div>

	<form method="post" enctype="multipart/form-data">
		 <input type="hidden" name="memberId" value="${uid}">
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">제목</span>
		  <input type="text" name="shopTitle" class="form-control" required aria-describedby="basic-addon1">
		</div>
		<div class="input-group mb-3">
		  <input type="file" multiple name="attach"class="form-control" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">상품명</span>
		  <input type="text" name="shopGoods" class="form-control" required aria-describedby="basic-addon1">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">판매가</span>
		  <input type="number" name="shopPrice" class="form-control" required aria-describedby="basic-addon1" min="0">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="basic-addon1">수량</span>
		  <input type="number" name="shopCount" class="form-control" required aria-describedby="basic-addon1" min="1">
		</div>
		<div class="input-group mb-3">
		  <span class="input-group-text">내용</span>
		  <div class="editor form-control" contenteditable="true"></div>
		  <textarea name="shopContent"></textarea>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
			<button type="submit" class="btn btn-primary">등록</button>
			<a type="button" href="${root}/shop/" class="btn btn-outline-primary">취소</a>
		</div>
	</form>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>