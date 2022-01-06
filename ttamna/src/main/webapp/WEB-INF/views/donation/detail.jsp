<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
	$(function(){
		
<<<<<<< HEAD
		var uid = "${sessionScope.uid}";
=======
		
		$(".edit").hide();
		$(".change-cancel").hide();
		$(".content-change-real").hide();
		$(".content-change").click(function(e){
			e.preventDefault();
			$(this).prev().show();
			$(this).next().next().show();
			$(this).prev().prev().hide();
			$(this).next().show();
			$(this).hide();
		});
		$(".change-cancel").click(function(e){
			e.preventDefault();
			$(".content-change").show();
			$(".edit").hide();
			$(".replyDto").show();
			$(".change-cancel").hide();
			$(".content-change-real").hide();
		});
		
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
		
		$(".content-change-real").click(function(e){
			e.preventDefault();
			var number = $(this).attr("data-data")
			
			var replyNo = $("#replyNo"+number).val();
			var replyContent = $("#replyContent"+number).val();
			var donationNo = $("#donationNo"+number).val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/donation/reply/edit", 
				type : "post",
				data : {
					replyNo : replyNo ,
					replyContent : replyContent,
					donationNo : donationNo
				},
				success:function(resp){
					$("#content"+replyNo).text("");
					$("#content"+replyNo).text(resp[0]);
					$(".change-cancel").click();
				},
				error:function(e){
					console.log("실패했어용");
				}
			});
		});
		

>>>>>>> branch 'main' of https://github.com/choihyunjoon1/ttamna
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

<div class="container">
	<div class="row">
		<div class="col">
			<c:forEach var="donationDto" items='${donationDto}'>
				<div class="row">
				<input type="hidden" class="donation-no" value="${donationDto.donationNo}">
					<div class="col-5">
					<c:if test="${donationImgDtoList ne null}">
						<c:forEach var="donationImgDto" items="${donationImgDtoList}">
							<img src="donaimg?donationImgNo=${donationImgDto.donationImgNo}&donationNo=${donationDto.donationNo}" style="width:100%;">
						</c:forEach>
					</c:if>
					</div>
				</div>
				<div class="cols-12 mt-3">
				<p>
					${donationDto.donationContent}
				</p>
				</div>
				<div class="col-12 mt-3">
				현재후원금액 : ${donationDto.donationNowFund}원
				</div>
				<div class="col-12 mt-3">
				목표후원금액 : ${donationDto.donationTotalFund}원
				</div>
				<div class="col-8 mt-3">
				<c:if test="${sessionScope.uid eq donationDto.donationWriter}">
					<a href="edit?donationNo=${donationDto.donationNo}" class="btn btn-primary">수정</a>
					<a href="delete?donationNo=${donationDto.donationNo}&donationWriter=${sessionScope.uid}" class="btn btn-primary">삭제</a>
				</c:if>
				</div>
			</c:forEach>
		</div>
		<div class="col-12 mt-5">
			<form action="kakao/fund" method="post">
				<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo" value="${donationDto.donationNo}"  id="donationNo">
				<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
				<input type="number" name="total_amount" class="form-control" min="1000" max="${donationDto.donationTotalFund - donationDto.donationNowFund}">
				<input type="submit" value="기부하기" class="btn btn-primary">
				</c:forEach>
			</form>
		</div>
		<div class="col-12 mt-5">
			<form action="kakao/autofund" method="post" id="auto">
				<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo" value="${donationDto.donationNo}">
				<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
				<input type="number" name="total_amount" class="form-control" min="1000" max="${donationDto.donationTotalFund*0.3}">
				<input type="submit" value="정기기부하기" class="btn btn-primary agree">
				</c:forEach>
			</form>
		</div>
		

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