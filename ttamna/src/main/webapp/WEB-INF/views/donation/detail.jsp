<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
	$(function(){
		
		$(".agree").click(function(){
			var isAgree = confirm("*정기기부 안내* 정기기부는 시작 날짜에 관계없이 매달 10일 자동결제가 진행됩니다 이점 유의하시기 바랍니다.");
			if(isAgree){
				if(!$(this).prev().val()){
					alert("기부 금액을 입력해주세요.");
					return false;
				}
				return true;
			}else{
				return false;
			}
		});
		
	
		//댓글 목록 더보기 ajax
		var uid = "${sessionScope.uid}";
		var page = 1;	
		var size = 12;
		var donationNo = $(".donation-no").val();
		//더보기 버튼 클릭시 이벤트 발생
		$(".more-btn").click(function(){
			loadList(page, size);
			page++;
		});
		
		//강제 1회 클릭
		$(".more-btn").click();
		
		function loadList(pageValue, sizeValue){
			$.ajax({
				url : "${pageContext.request.contextPath}/donation_reply/more",	
				type : "post",
				data : {
					page : pageValue,
					size : sizeValue,
					donationNo : donationNo
				},
				dataType : "json",
				success:function(resp){
					console.log("댓글 더보기 성공", resp);
					
					//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
					if(resp.length < size){
						$(".more-btn").remove();
					}
				
					for(var i=0 ; i < resp.length ; i++){
					
					//삭제 버튼을 작성자만 볼 수 있도록 처리
					var deleteBtn;
					if(uid == resp[i].memberId){
						deleteBtn = "<a href='${pageContext.request.contextPath}/donation_reply/delete?donationReplyNo="+resp[i].donationReplyNo+"&donationNo="+resp[i].donationNo+"' class='reply btn btn-secondary'>삭제하기</a>";
					}else{
						deleteBtn = "";	
					}
							var divCol = "<div>"+ resp[i].donationReplyNo+"</div>"
											+"<div>"+ resp[i].memberId+"</div>"
											+"<div>"+ resp[i].donationReplyTime+"</div>"
											+"<div>"+ resp[i].donationReplyContent+"</div>"
											+deleteBtn
				                            +"<div> ------------------------------------------------------------------</div>";

							
						$(".result").append(divCol);
						
					}
					
				},
				error:function(e){
					console.log("댓글 더보기 실패", e);
				}
			});
		}
	});
	

	
</script>
<style>
		.reply{
		margin-top:10px;
		margin-bottom:5px;
		}
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:forEach var="donationDto" items="${donationDto}">
<div class="container-500 container-center">
	<div class="card mb-5">
		<%-- 제목 영역 --%>
		<div class="card-header d-grid gap-2 justify-content-center mt-2">
			<h3>${donationDto.donationTitle}</h3>
		</div>
		<%-- 제목 아래 작성시간과 작성자 영역 --%>
		<div class="card-body d-grid gap-2 justify-content-md-end">
			<h6 class="card-subtitle text-muted">
			${donationDto.donationTime} 작성자 : ${donationDto.donationWriter}
			</h6>
		</div>
		<%-- 이미지가 찍히는 영역 --%>
		<c:if test="${donationImgDtoList ne null}">
			<c:forEach var="donationImgDto" items="${donationImgDtoList}">
				<img src="donaimg?donationImgNo=${donationImgDto.donationImgNo}&donationNo=${donationDto.donationNo}" style="width:100%;">
			</c:forEach>
		</c:if>
		<%-- 글 내용이 찍히는 영역 --%>
		<div class="card-body">
			<p class="card-text">${donationDto.donationContent}</p>
		</div>
		<%-- 각종 정보가 줄 단위로 찍히는 영역 --%>
		<ul class="list-group list-group-flush">
			<li class="list-group-item text-muted">현재 기부 금액 : ${donationDto.donationNowFund}원</li>
			<li class="list-group-item text-muted">목표 기부 금액 : ${donationDto.donationTotalFund}원</li>
			<li class="list-group-item text-muted">
				<%-- 단건 기부시 정보가 필요하므로 폼태그로 감싸넣었다 --%>
				<form action="kakao/fund" method="post">
					<input type="hidden" name="donationNo" value="${donationDto.donationNo}"  id="donationNo">
					<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
					<%-- 텍스트박스와 버튼을 한 줄로 나열하기 위해 div태그를 또 넣었다. --%>
					<div class="row">
						<div class="col-8">
							<input type="number" name="total_amount" class="form-control" min="1000" max="${donationDto.donationTotalFund - donationDto.donationNowFund}">
						</div>
						<div class="col-4">
							<input type="submit" value="1회 기부 하기" class="btn btn-primary">
						</div>
					</div>
				</form>
			</li>
			<li class="list-group-item text-muted">
				<%-- 정기 기부도 마찬가지 --%>
				<form action="kakao/autofund" method="post" id="auto">
					<input type="hidden" name="donationNo" value="${donationDto.donationNo}">
					<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
					<%-- 텍스트박스와 버튼을 한 줄로 나열하기 위해 div태그를 또 넣었다. --%>
					<div class="row">
						<div class="col-8">
							<input type="number" name="total_amount" class="form-control" min="1000" max="${donationDto.donationTotalFund*0.3}">
						</div>
						<div class="col-4">
							<input type="submit" value="정기 기부 신청" class="btn btn-primary agree">
						</div>
					</div>
				</form>
			</li>
		</ul>
	</div>
</div>
</c:forEach>


	<!-- 댓글 입력창 -->    
    <div class="col-12">
        <form action="${pageContext.request.contextPath}/donation_reply/insert" method="post">
           <input type="hidden" name="donationNo"value="${donationNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
            
            댓글 쓰기
            <textarea class="form-control" " row="3" name="donationReplyContent"></textarea> 
            
        <div class="right">
            <input type="submit" class="reply btn btn-primary" value="등록">
        </div>
	</form>

	<!-- 댓글목록 표시 위치 -->		
	<div class="row mt-3 mb-5 result"></div>
	
	<!-- 댓글 더보기 버튼 -->
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	
</div>


</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>