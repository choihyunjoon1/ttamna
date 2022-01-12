<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="member" value="${member !=null }"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 댓글 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	//삭제script
	$(function(){
		$(".delete-btn").click(function(){
			var choice = window.confirm("${mybaby.mybabyNo}번 ${mybaby.mybabyTitle}. 게시글을 삭제하시겠습니까?");
			if(choice){
				location.href = "${root}/mybaby/delete?mybabyNo=${mybaby.mybabyNo}";
			}else{
				location.reload();
			}
		});
	});		
</script>
<script>
	
	$(function(){
		
		
		//댓글 목록 더보기 ajax
		var uid = "${sessionScope.uid}";
		var page = 1;	
		var size = 12;
		var mybabyNo = parseInt($("#mybabyNo").val());;
		//더보기 버튼 클릭시 이벤트 발생
		$(".more-btn").click(function(){
			loadList(page, size, mybabyNo);
			page++;
		});
		
		//강제 1회 클릭
		$(".more-btn").click();
		
		function loadList(pageValue, sizeValue){
			$.ajax({
				url : "${pageContext.request.contextPath}/mybaby_reply/more",	
				type : "post",
				data : {
					page : pageValue,
					size : sizeValue,
					mybabyNo : mybabyNo
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
						deleteBtn = "<div class='right'>"+"<a href='${pageContext.request.contextPath}/mybaby_reply/delete?mybabyReplyNo="+resp[i].mybabyReplyNo+"&mybabyNo="+resp[i].mybabyNo+"' class='delete-button reply btn btn-secondary'>삭제하기</a>"+"</div>";
					}else{
						deleteBtn = "";	
					}
					//시간형식 포멧 
					var date = new Date(resp[i].mybabyReplyTime);
					
					var divCol = "<div class='card border-primary mb-3' style='width: 966px; padding: 0px;'>" 
						+"<div class='card-header id-font'>"+ resp[i].memberId
						+"<div class='right' style='font-size:13px;'>"+date.getFullYear()+"년"+date.getMonth()+1+"월"+date.getDate()+"일"+date.getHours()+"시"+date.getMinutes()+"분" +"</div>"
						+"</div>"
						+"<div class='card-body'>"
						+"<p class='card-text'>"+ resp[i].mybabyReplyContent+"</p>"
						+ "</div>"
						+deleteBtn
						+ "</div>";
							
							
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
		
		.id-font{
		font-size: medium;
		font-weight: bold;
		}
		
		.delete-button{
		margin:8px;
		width: 92px;
		}
		
		
</style>


<div class="container-700 container-center">

	<div class="mt-5 mb-5"><h3>내새끼자랑 상세</h3></div>
<%-- 	<c:if test="${param.success != null}"> --%>
<!-- 		<div class=" mb-3"><h6>입양공고 수정 완료</h6></div> -->
<%-- 	</c:if> --%>
<%-- 	<c:if test="${param.invalid != null}"> --%>
<!-- 		<div class=" mb-3"><h6>수정 권한이 없습니다</h6></div> -->
<%-- 	</c:if>	 --%>
	
	<div class="container-500 container-center">
		<div class="card mb-5">
		  <div class="card-header d-grid gap-2 justify-content-center mt-2">	
		    <h3> ${mybaby.mybabyTitle}</h3>
		  </div>
		  <div class="card-body d-grid gap-2 justify-content-md-end">
		    <h6 class="card-subtitle text-muted">
		    ${mybaby.mybabyTimeString()}  작성자 : ${mybaby.mybabyWriter}   댓글수 : ${mybaby.mybabyReply }
		    </h6>
		  </div>
		 <c:if test="${mybabyImgDtoList != null}">
			<div class="card-body d-grid gap-2">
				<c:forEach var="mybabyImgDto" items="${mybabyImgDtoList}">
					<img class="mx-auto" src="mybabyImg?mybabyImgNo=${mybabyImgDto.mybabyImgNo}&mybabyNo=${mybaby.mybabyNo}" style="width:60%;">
				</c:forEach>
			</div>
		  </c:if>
		  <div class="card-body">
		    <p class="card-text">${mybaby.mybabyContent}</p>
		  </div>
		  <div class="card-footer text-muted">
			<!-- 작성자 또는 관리자에게만 수정 삭제 버튼 보여주기 -->
			<c:set var="valid" value="${grade == '관리자' or uid == mybaby.mybabyWriter}"></c:set>
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a type="button" href="${root}/mybaby/" class="btn btn-outline-primary">목록</a>
			<c:if test="${valid}">
				<a href="${root}/mybaby/edit?mybabyNo=${mybaby.mybabyNo}" type="button" class="btn btn-outline-warning">수정</a>
				<button type="button" class="btn btn-outline-secondary delete-btn">삭제</button>
			</c:if>	
			</div>
		  </div>
		</div>
	</div>

	

</div>
	
	<!-- 댓글 자리 -->
	<!-- 댓글목록 표시 위치 -->	
	<div class="row mt-3 mb-5 result mx-auto"></div>

	<!-- 댓글 입력창 -->    

	<c:if test="${member }"> 
    <div class="col-12 mx-auto" >
        <form action="${pageContext.request.contextPath}/mybaby_reply/insert" method="post">
           <input type="hidden"   id="mybabyNo"  name="mybabyNo"value="${mybabyNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
 			<div class="mx-auto">
	            <label>댓글 쓰기</label>
	            <textarea class="form-control mx-auto" name="mybabyReplyContent"></textarea>
	            <div class="right">
		        	<input type="submit" class="reply btn btn-primary" value="등록">
		        </div>
            </div> 
            
        
	</form>
</div>
</c:if>
	
	
		<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>