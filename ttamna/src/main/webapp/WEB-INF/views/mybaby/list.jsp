<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- JavaScript 날짜 포맷 CDN -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
$(function(){
	var page = 1;
	var size = 12;
	
	
	$(".more-btn").click(function(){
		var column = $("#column option:selected").val();
        var keyword = $("input[name=keyword]").val();
		loadData(page, size, column, keyword);
		page++;
	});
	
	//여러가지 방법이 있다
	//여기선 더보기 버튼을 강제1회 클릭(트리거)
	$(".more-btn").click();
	
	//이렇게 캡슐화를 하는데 이걸 중첩클래스라고한다
	function loadData(page, size, column, keyword){
		$.ajax({
			url : "${pageContext.request.contextPath}/mybaby/more?column="+column+"&keyword="+keyword,
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
					if(resp[i].mybabyImgNo==0){
						imgLocation = "<img src='${pageContext.request.contextPath}/resources/img/nonimage.png' class='icon' style='width:100%;height:15rem;'>";
					}else{
						imgLocation = "<img src=mybabyImg?mybabyImgNo="+resp[i].mybabyImgNo+" class=icon style='width:100%;height:15rem;'>";
					}
					
					if(memberId == null){
						memberId = "탈퇴한 회원";
					}
					var replyCount = "";
					if(resp[i].mybabyReply < 1){
						replyCount = "";
					}else{
						replyCount = "["+resp[i].mybabyReply+"]";
					}
					
					var divCol = "<div class='card border-primary text-dark bg-primary bg-opacity-10 mb-5 ms-2 ' style='width: 18rem;' onClick=location.href='${root}/mybaby/detail?mybabyNo="+resp[i].mybabyNo+"'>"
					  + imgLocation
					  + "<div class='card-body'>"
					  + "<h5 class='card-title'><strong class='title'>" + resp[i].mybabyTitle+replyCount +"</strong></h5>"
					  + "<div class='card-text'>"
					  +  moment(resp[i].mybabyTime).format("YYYY-MM-DD")
					  + "</div>"
					  + "<div class='card-text'>"
					  + "좋아요 : "+resp[i].mybabyLikeCount +"개"
					  +	 "</div>"
					  + "<div class='card-text'>"
					  + "작성자 : "+memberId 
					  +	 "</div>"
					  + "</div></div>";
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


<div class="container-900 container-center mt-5 mb-5">
	
	<div class="mt-5 mb-3"><h3>내새끼 자랑 좋아요 BEST!</h3>
	<c:if test="${uid!=null }">
		<div class="d-grid gap-1 d-md-flex justify-content-md-end">
			<a href="${root}/mybaby/write" class="btn btn-outline-primary">자랑글 쓰기</a>
		</div>
	</c:if>
	</div>
	
	<!-- 좋아요 순으로 표시된 게시글 -->
	<div class="row mt-3 mb-5 resultBest">
		<c:forEach var="mybabyLikeDto" items="${likeBest }">
			<div class="card border-primary text-dark bg-primary bg-opacity-10 mb-5 ms-2 " style="width: 18rem;" onClick="location.href='${root}/mybaby/detail?mybabyNo=${mybabyLikeDto.mybabyNo}' ">
			<c:set var="imgLocation" >
				<c:choose>
					<c:when test="${mybabyLikeDto.mybabyImgNo == 0}">
						<img src="${pageContext.request.contextPath }/resources/img/nonimage.png" class="icon"  style='width:100%;height:15rem;'>
					</c:when>
					<c:otherwise>
						<img src="mybabyImg?mybabyImgNo=${mybabyLikeDto.mybabyImgNo}" class="icon"  style='width:100%;height:15rem;'>
					</c:otherwise>
				</c:choose>
			</c:set>
			${imgLocation}
			<div class='card-body'>
					<c:set var = "replyCount">
						<c:choose>
							<c:when test="${mybabyLikeDto.mybabyReply==null}">
								""
							</c:when>
							<c:otherwise>
								[${mybabyLikeDto.mybabyReply}]
							</c:otherwise>
						</c:choose>
					</c:set>
			<h5 class='card-title'><strong class='title'> ${mybabyLikeDto.mybabyTitle }  ${replyCount } </strong></h5>
			<div class='card-text'>
			작성일 : ${mybabyLikeDto.mybabyTime.substring(0,10)}
			</div>
			<div class='card-text'>
			좋아요 : ${mybabyLikeDto.mybabyLikeCount }개
			</div>
			<div class='card-text'>
					<c:set var="memberId">
						<c:choose>
							<c:when test="${mybabyLikeDto.mybabyWriter==null }">
								"탈퇴한회원입니다"
							</c:when>
							<c:otherwise>
								${mybabyLikeDto.mybabyWriter }
							</c:otherwise>
						</c:choose>
					</c:set>
			작성자 : ${memberId }
			</div>
			</div></div>
		</c:forEach>
		
	</div>
	<!-- 게시물 표시 위치 -->		
	<div class="mt-5 mb-3"><h3>내새끼 자랑글</h3></div>
	<div class="row mt-3 mb-5 result">
		
	</div>
	
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	
	<div class="container-900">
		<!-- 내새끼 등록버튼은 로그인 회원만 사용할 수 있다 -->
				<!-- 검색창 -->
				<form method="post">
					<div class="input-group justify-content-center">
						<div class="col-2">
							<select name="column" class="form-select form-select-sm" required id="column">
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
						<div class="input-group input-group-sm mb-3" style="width:30%">
							<input type="text" name="keyword" required class="form-control" value="${keyword}">
							<input type="submit" value="search" id="search" class="btn btn-dark btn-sm">
						</div>
					</div>			
				</form>
		</div>
	
	<!-- 검색 목록일 경우 전체 목록으로 돌아가기 버튼 보여주기 -->
	<c:if test="${param.column != null }">
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<a href="${root}/mybaby/" type="button" class="justify-content-md btn btn-primary">Back To List</a>
		</div>
	</div>
	</c:if>
	
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>