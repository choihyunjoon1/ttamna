<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="login" value="${uid != null}"></c:set>
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
		
		// 비회원일경우 기능 접근 차단
		var login = $("input[name=memberId]").val();
		if(login == ''){
		$(".deny").slideUp();	// 댓글칸
		}

		
		//댓글 목록 더보기 ajax
		var uid = "${sessionScope.uid}";
		var grade="${sessionScope.grade}";
		var page = 1;	
		var size = 12;
		var mybabyNo = $("#mybabyNo").val();
		//더보기 버튼 클릭시 이벤트 발생
		$(".more-btn").click(function(){
			console.log("myBabyNo = ", mybabyNo);
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
					if(uid == resp[i].memberId || grade=='관리자'){
						deleteBtn = "<div class='right'>"+"<a href='${pageContext.request.contextPath}/mybaby_reply/delete?mybabyReplyNo="+resp[i].mybabyReplyNo+"&mybabyNo="+resp[i].mybabyNo+"' class='delete-button reply btn btn-secondary'>삭제하기</a>"+"</div>";
					}else{
						deleteBtn = "";	
					}
					
					if(resp[i].memberId == null){
						resp[i].memberId = "탈퇴한 회원입니다";
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

	//좋아요 등록
	function mybabyinsertlike(mybabyNo){
		var mybabyNo = ${mybabyNo}
		$.ajax({
			url:"${pageContext.request.contextPath}/mybaby/ajax/insert",
			type:"get",
			data:{
				mybabyNo:mybabyNo
			},
			success:function(resp){
				console.log("좋아요누름",resp);
				$(".like").css("color","red");
			},
			error:function(e){}
			
		});
	};
	//좋아요 삭제
	function mybabydeletelike(mybabyNo){
		var mybabyNo=${mybabyNo}
		$.ajax({
			url:"${pageContext.request.contextPath}/mybaby/ajax/delete?mybabyNo="+mybabyNo,
			type:"delete",
			data:{
				mybabyNo:mybabyNo
			},
			success:function(resp){
				console.log("좋아요 취소함",resp);
				$(".like").css("color","black");
			},
			error:function(e){}
		});
	};
	//좋아요 버튼 누를때
	$(function(){
		$(".likebtn").click(function(e){
			if(!${login}){
				e.preventDefault();
			}
			var mybabyNo = "${mybabyNo}";
			
			var stylecolor = $(".like").css("color");
			console.log(stylecolor);
			if(stylecolor=="rgb(0, 0, 0)"){
				mybabyinsertlike(mybabyNo);
			}else{
				mybabydeletelike(mybabyNo);
			}
		});
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
		  <form>
			<input type="hidden" name="mybabyNo" value="${mybabyNo}">			  	
		  </form>
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
			<!-- 버튼 -->	
			<button  id="liveToastBtn" type="button" class="likebtn btn btn-sm btn-outline-secondary">
        	<!-- 좋아요 아이콘 -->
   			<c:choose>
			<c:when test="${mybabyLikeDto == null}">
    			<svg xmlns="http://www.w3.org/2000/svg" style="color:black" width="16" height="16" fill="currentColor" class="like bi bi-heart-fill" viewBox="0 0 16 16">
					<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
				</svg>
			</c:when>
			<c:otherwise>
				<svg xmlns="http://www.w3.org/2000/svg" style="color:red" width="16" height="16" fill="currentColor" class="like bi bi-heart-fill" viewBox="0 0 16 16">
				  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
				</svg>
			</c:otherwise>
		</c:choose>
        			</button>
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
	<div class="row mt-3 mb-5 result"></div>

	<!-- 댓글 입력창 -->    
	<div class="col-12 deny">
      <div class="col-12">
        <form action="${pageContext.request.contextPath}/mybaby_reply/insert" method="post">
           <input type="hidden"   id="mybabyNo"  name="mybabyNo"value="${mybabyNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
 			
	        <i class="bi bi-chat-left-text"> 
	 			댓글 쓰기
		 		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-left-text" viewBox="0 0 16 16">
				  <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
				  <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
				</svg>
	 		</i>
	            <textarea class="form-control" name="mybabyReplyContent"></textarea>
	            
	            <div class="right">
		        	<input type="submit" class="reply btn btn-primary" value="등록">
		        </div>
	  </form>      
	</div> 
	 </div>


	
	
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>