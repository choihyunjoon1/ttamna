<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

	$(function(){
		$(".delete").click(function(){
			$(this).prev().hide();
			$(this).hide();
			$(this).prev().attr("data-delete", "true");
		});
		
		$(".delete").click(function(e){
			e.preventDefault();
			if(confirm("삭제하시겠습니까?")){
				if($(this).prev().attr("data-delete")){
					var imgNo = $(this).attr("data-data");
					$.ajax({
						url : "${pageContext.request.contextPath}/donation/file/delete?imgNo="+imgNo,
						type : "get", 
						data : {
							imgNo : imgNo
						},
						success:function(resp){
							console.log("파일삭제성공")
						},
						error:function(e){
							console.log("에러")
						}
					});
				}
			} else {
				return false;
			}
		});
	});
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">
	<form method="post" enctype="multipart/form-data">
		<c:forEach var="donationDto" items="${donationDto}">
			<input type="hidden" name="donationNo" value="${donationDto.donationNo}" >
		<div class="input-group mb-3">
			<span class="input-group-text">작성자</span>
			<input type="text" value="${donationDto.donationWriter}" disabled aria-label="end" class="form-control">
		</div>
		<div class="input-group mb-3">
			<c:forEach var="imgNo" items="${imgDtoList}">
				<div class="col-6">
					<img src="donaimg?donationImgNo=${imgNo.donationImgNo}" style="width:100%">
					<a href="#" class="delete" data-data="${imgNo.donationImgNo}">삭제</a>
				</div>
			</c:forEach>
		</div>
		<div class="input-group mb-3">
			<span class="input-group-text">목표금액</span>
			<input type="number" name="donationTotalFund" value="${donationDto.donationTotalFund}" disabled aria-label="end" class="form-control" autocomplete="off" required>
		</div>
		<div class="input-group mb-3">
			<span class="input-group-text">제목</span>
			<input type="text" value="${donationDto.donationTitle}" class="form-control">
		</div>
		<div class="input-group mb-3">
			<span class="input-group-text">내용</span>
			<textarea name="donationContent" class="form-control" aria-label="With textarea" 
			 style="min-height:400px; resize:none;" required>${donationDto.donationContent}</textarea>
		</div>
		<div class="input-group mb-3">
			<input type="file" multiple name="attach" class="form-control" accept="image/*">
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
			<input type="submit" class="btn btn-primary" value="수정">
		</div>
		</c:forEach>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>