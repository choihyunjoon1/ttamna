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
			url : "${pageContext.request.contextPath}/mybaby/more",
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
					var memberId = resp[i].mybabyWriter;
					var imglocation = "";
					if(!resp[i].mybabyImgNo){
						imglocation = "<img src=${pageContext.request.contextPath}/resources/img/nonimage.png class=icon style=width:50%></a></span>";
					}else{
						imglocation = "<img src=mybabyImg?mybabyImgNo="+resp[i].mybabyImgNo+" class=icon style=width:50%></a></span>";
					}
					
					if(memberId == null){
						memberId = "탈퇴한 회원";
					}
					console.log("람깐만", resp.mybabyImgNo);
					var divCol = "<div class=page>"+
					"<span><a href=detail?mybabyNo="+resp[i].mybabyNo+">"+imglocation+
						"<br>"+
						"<span>"+memberId+"</span>" +
						"<br>"+
						"<span><a href=detail?mybabyNo="+resp[i].mybabyNo+">"+resp[i].mybabyTitle+"</a></span>" +
						"<br>"+
						"<span>"+resp[i].mybabyContent+"</span>" +
						"<br>"
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
		<c:if test="${uid != null }">
		<a href="write" class="btn btn-primary">작성하기</a>
		</c:if>
	</div>
	</div>
	<div class="row mt-3 result">
			
	</div>
	<div class="row mt-3">
		<div class="col mt-3">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	<!-- 검색창 -->
	<form method="post" >
		<div class="input-group">
			<div class="col-3 offset-2">
				<select name="column" class="form-select" required id="column">
				<c:choose>
					<c:when test="${column eq 'mybaby_title'}">
						<option value="">선택안함</option>
						<option value="mybaby_title" selected>제목</option>
						<option value="mybaby_writer">작성자</option>
						<option value="mybaby_content">내용</option>
					</c:when>
					<c:when test="${column eq 'mybaby_writer'}">
						<option value="">선택안함</option>
						<option value="mybaby_title">제목</option>
						<option value="mybaby_writer" selected>작성자</option>
						<option value="mybaby_content">내용</option>
					</c:when>
					<c:when test="${column eq 'mybaby_content'}">
						<option value="">선택안함</option>
						<option value="mybaby_title">제목</option>
						<option value="mybaby_writer">작성자</option>
						<option value="mybaby_content" selected>내용</option>
					</c:when>
					<c:otherwise>
						<option value="">선택안함</option>
						<option value="mybaby_title">제목</option>
						<option value="mybaby_writer">작성자</option>
						<option value="mybaby_content">내용</option>
					</c:otherwise>
				</c:choose>
				</select>
			</div>
			<div class="col-3">
				<input type="text" name="keyword" required class="form-control" value="${keyword}">
			</div>
			<div class="col-2">
				<input type="submit" value="검색" id="search" class="btn btn-primary">
			</div>
		</div>
	</form>
	
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>