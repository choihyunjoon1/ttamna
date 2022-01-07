<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 댓글 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
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


<div class="container-500 bg-white container-center" align="center">
	<div class="card mb-3">
	  <h3 class="card-header">DETAIL</h3>
	  <div class="card-body">
	    <h5 class="card-title">${mybaby.mybabyTitle }</h5>
	    <h6 class="card-subtitle text-muted">
	    	${mybaby.mybabyWriter }
	    	|
	    	${mybaby.mybabyTimeString() }
	    	|
	    	${mybaby.mybabyReply }
	    	</h6>
	  </div>
	  <!-- 이미지 자리 -->
	  <c:forEach var="mybabyImgDto" items="${mybabyImgDtoList}">
		  <svg xmlns="http://www.w3.org/20/svg" class="d-block user-select-none" width="100%" height="50" aria-label="Placeholder: Image cap" focusable="false" role="img" preserveAspectRatio="xMidYMid slice" viewBox="0 0 318 180" style="font-size:1.125rem;text-anchor:middle">
		    <rect width="100%" height="100%" fill="#868e96"></rect>
		    <text x="100%" y="100%" fill="#dee2e6" dy=".3em"><img src="mybabyImg?mybabyImgNo=${mybabyImgDto.mybabyImgNo}&mybabyNo=${mybaby.mybabyNo}" style="width:100%;height:50%;"></text>
<%-- 			<img src="mybabyImg?mybabyImgNo=${mybabyImgDto.mybabyImgNo}&mybabyNo=${mybaby.mybabyNo}" style="width:100%;"> --%>
		  </svg>
	  </c:forEach>
	  <div class="card-body">
	    <p class="card-text">${mybaby.mybabyContent}</p>
	  </div>
<!-- 	  <ul class="list-group list-group-flush"> -->
<!-- 	    <li class="list-group-item">Cras justo odio</li> -->
<!-- 	    <li class="list-group-item">Dapibus ac facilisis in</li> -->
<!-- 	    <li class="list-group-item">Vestibulum at eros</li> -->
<!-- 	  </ul> -->
	  <div class="card-body">
	    <a href="${root }/mybaby/list" class="card-link">목록으로</a>
	    <c:if test="${uid eq mybaby.mybabyWriter}">
			<a href="edit?mybabyNo=${mybaby.mybabyNo }" class="card-link">수정</a>
			<a href="delete?mybabyNo=${mybaby.mybabyNo}" class="card-link">삭제</a>
		</c:if>
	  </div>
<!-- 	  <div class="card-footer text-muted"> -->
<!-- 	    2 days ago -->
<!-- 	  </div> -->
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