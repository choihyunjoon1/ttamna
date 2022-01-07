<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
	
	//댓글script
	$(function(){
		
		
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
		
		$(".content-change-real").click(function(e){
			e.preventDefault();
			var number = $(this).attr("data-data")
			
			var replyNo = $("#replyNo"+number).val();
			var replyContent = $("#replyContent"+number).val();
			var mybabyNo = $("#mybabyNo"+number).val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/mybaby/reply/edit", 
				type : "post",
				data : {
					replyNo : replyNo ,
					replyContent : replyContent,
					mybabyNo : mybabyNo
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
	});
	

	
</script>
<style>
		.reply{
		margin-top:10px;
		margin-bottom:5px;
		}
</style>
<!-- 댓글 끝 -->


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
	<div class="col-12">
        <form action="reply/edit" method="post">
            <c:forEach var="replyDto" items="${replyDto}">
                <div class="replyDto"><h4>
                ${replyDto.mybabyReplyNo}
                    | ${replyDto.memberId} | <span id="content${replyDto.mybabyReplyNo}">${replyDto.mybabyReplyContent}</span>
                   | ${replyDto.mybabyReplyTime}
                </h4>
                </div>
                    <c:if test="${sessionScope.uid == replyDto.memberId}">
					<div class="edit" style="margin-top:15px;">
						<input type="hidden" value="${replyDto.mybabyNo}" id="mybabyNo${replyDto.mybabyReplyNo}">
						<input type="hidden" value="${replyDto.mybabyReplyNo}" id="replyNo${replyDto.mybabyReplyNo}">
						<textarea class="form-control"  row="3" name="mybabyReplyContent"id="replyContent${replyDto.mybabyReplyNo}">${replyDto.mybabyReplyContent}</textarea> 
            
					</div>
                            <a href="#" class="reply content-change btn btn-primary">수정</a>
                            <a href="#" class="reply content-change-real btn btn-primary" data-data="${replyDto.mybabyReplyNo}">수정하기</a>
                            <a href="#" class="reply change-cancel btn btn-primary">취소</a> 
                            <a href="reply/delete?mybabyReplyNo=${replyDto.mybabyReplyNo}&mybabyNo=${replyDto.mybabyNo}" class="reply btn btn-secondary">삭제하기</a>

                    </c:if>
               
            </c:forEach>
        </form>
    </div>
    <div class="col-12">
        <form action="${root}/reply_mybaby/insert" method="post">
           <input type="hidden" name="mybabyNo" value="${mybaby.mybabyNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
            
            댓글 쓰기
            <textarea class="form-control" row="3" name="mybabyReplyContent"></textarea> 
            
            <div class="right">
            <input type="submit" class="reply btn btn-primary" value="등록">
        </div>
</form>
</div>



</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>