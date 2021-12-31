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
		
		$("input[type=submit]").click(function(e){
			if(confirm("수정하시겠습니까?")){
				$("img").each(function(index, item){
					console.log($(item).attr("data-delete"));
					if($(item).attr("data-delete")){
						var imgNo = $(item).next().attr("data-data");
						
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
				});
			} else {
				return false;
			}
		});
	});
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
<form method="post">
	<c:forEach var="donationDto" items='${donationDto}'>
		<div class="row">
		<input type="hidden" name="donationNo" value="${donationDto.donationNo}" >
		</div>
		<div class="row">
		${donationDto.donationWriter}
		</div>
		<div class="row">
		<label>
			제목<input type="text" name="donationTitle" value="${donationDto.donationTitle}" required class="form-input">
		</label>
		</div>
		<div class="row">
			<c:forEach var="imgNo" items="${imgDtoList}">
				<div class="col-6">
					<img src="donaimg?donationImgNo=${imgNo.donationImgNo}">
					<a href="#" class="delete" data-data="${imgNo.donationImgNo}">삭제</a>
				</div>
			</c:forEach>
		</div>
		<div class="row">
		<label>
			내용<input type="text" name="donationContent" value="${donationDto.donationContent}" required class="form-input">
		</label>
		</div>
		<div class="row">
		목표 후원금액 : ${donationDto.donationTotalFund}원
		</div>
		<div class="row">
		<a href="edit?donationNo=${donationDto.donationNo}">수정</a>
		<!-- 추후에 얼럿 창을 한번 띄워서 확인을 누르면 삭제가 되게끔 코드 -->
		<a href="delete?donationNo=${donationDto.donationNo}">삭제</a>
		</div>
		<div class="row">
			<input type="submit"  value=" 수정하기" class="form-btn">
		</div>
	</c:forEach>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>