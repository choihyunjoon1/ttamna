<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){
	var page = 1;
	var size = 12;
	
	$(".more-btn").click(function(){
		loadData(page, size);
		page++;
	});
	
	//여러가지 방법이 있다
	//여기선 더보기 버튼을 강제1회 클릭(트리거)
	$(".more-btn").click();
	
	//이렇게 캡슐화를 하는데 이걸 중첩클래스라고한다
	function loadData(page, size){
		$.ajax({
			url : "${pageContext.request.contextPath}/donation/more",
			type : "get",
			data : {
				page : page,
				size : size
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
	
				//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
				if(resp.length < size){
					$(".more-btn").remove();
				}
				
				//데이터 출력
				for(var i=0; i < resp.length; i++){
					var divCol = "<div class=page>"+
						"<span>"+resp[i].donationNo+"</span>" +
						"<br>"+
						"<span>"+resp[i].donationWriter+"</span>" +
						"<br>"+
						"<span><a href=detail?donationNo="+resp[i].donationNo+">"+resp[i].donationTitle+"</a></span>" +
						"<br>"+
						"<span>"+resp[i].donationContent+"</span>" +
						"<br>"+
						"<span>"+resp[i].donationNowFund+"원</span>" +
						"<br>"+
						"<span>"+resp[i].donationTotalFund+"원</span>" +
					+"</div>";
					$(".result").append(divCol);
					$(".page").addClass("col-3 mt-3");
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
});
</script>



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
	
	<div class="row mt-3">
		<div class="col mt-3">
			<form method="post" action="search">
				<select name="column" class="form-input form-inline" required>
					<option value="">선택안함</option>
					<option value="donation_title">제목</option>
					<option value="donation_writer">작성자</option>
					<option value="donation_content">내용</option>
				</select>
				<input type="text" name="keyword" required class="form-input form-inline">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>