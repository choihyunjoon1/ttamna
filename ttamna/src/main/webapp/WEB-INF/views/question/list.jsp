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
		loadData(page, size);
		page++;
	});
	
	//여러가지 방법이 있다
	//여기선 더보기 버튼을 강제1회 클릭(트리거)
	$(".more-btn").click();
	
	//이렇게 캡슐화를 하는데 이걸 중첩클래스라고한다
	function loadData(page, size){
		$.ajax({
			url : "${pageContext.request.contextPath}/question/more?",
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
					var memberId = resp[i].memberId;
					
					
					if(memberId == null){
						memberId = "탈퇴한 회원";
					}
					var divCol = "<div class='card border-primary text-dark bg-primary bg-opacity-10 mb-5 ms-2 ' style='width: 18rem;' onClick=location.href='${root}/question/detail?questionNo="+resp[i].questionNo+"'>"
						  + "<div class='card-body'>"
						  + "<h5 class='card-title'><strong class='title'>"+ resp[i].questionTitle +"</strong></h5>"
						  + "<div class='card-text'>"
						  + "상태 : "+resp[i].questionType
						  + "</div>"
						  + "<div class='card-text'>"
						  +  moment(resp[i].questionTime).format("YYYY-MM-DD")
						  +"</div>"
						  + "<div class='card-text'>"
						  +  "작성자 : "+memberId
						  +"</div>"
						  + "<div class='card-text d-grid gap-1 d-md-flex justify-content-md-end'>"
						  + "<a href='detail?questionNo="+resp[i].questionNo+"' class='btn btn-outline-primary'>" + "보기"
						  + "</a></div>"
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
	
	<div class="mt-5 mb-3"><h3>1:1 문의하기</h3>
	<c:if test="${uid!=null}">
		<div class="d-grid gap-1 d-md-flex justify-content-md-end">
			<a href="${root}/question/write" class="btn btn-outline-primary">문의 내용 작성</a>
		</div>
	</c:if>
	</div>
	
	
	<!-- 게시물 표시 위치 -->		
	<div class="row mt-3 mb-5 result">
		
	</div>
	
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>

	
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>