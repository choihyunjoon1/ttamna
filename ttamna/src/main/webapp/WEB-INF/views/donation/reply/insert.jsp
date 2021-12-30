<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>

<html>
<head>
    <link rel="stylesheet" href="/css/bootstrap.css">
</head>
<body>
<div class="container">
    <form id="replyForm" name="replyForm" method="post">
<br><br>
        <div>
         <div>
                <span><strong>댓글</strong></span> <span id="reply"></span>
            </div>
            <div>
                <table class="table">                    
                    <tr>
                        <td>
                            <textarea style="width: 1100px" rows="3" cols="30"  name="donationReplyContent" placeholder="댓글을 입력하세요"></textarea>
                            <br>
                            <div>
    <input type="hidden" name="memberId" value="${sessionScope.uid}">
     <input type="submit" value="등록">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        </form>
</div>

<div class="container">
    <form id="commentListForm" name="commentListForm" method="post">
        <div id="commentList">
        </div>
    </form>
</div>
 
<script>
/*
 * 댓글 등록하기(Ajax)
 */
function fn_comment(code){
    
    $.ajax({
        type:'POST',
        url : "<c:url value='/donation/detail'/>",
        data:$("#replyForm").serialize(),
        success : function(data){
            if(data=="success")
            {
                getCommentList();
                $("#donation_reply").val("");
            }
        },
        error:function(request,status,error){
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }
        
    });
}
/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function(){
    
    getDonationReplyList();
    
});
 
/**
 * 댓글 불러오기(Ajax)
 */
function getDonationReplyList(){
    
    $.ajax({
        type:'GET',
        url : "<c:url value='/donation/reply/list'/>",
        dataType : "json",
        data:$("#replyForm").serialize(),
        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
        success : function(data){
            
            var html = "";
            var reply = data.length;
            
            if(data.length > 0){
                
                for(i=0; i<data.length; i++){
                    html += "<div>";
                    html += "<div><table class='table'><h6><strong>"+data[i].writer+"</strong></h6>";
                    html += data[i].comment + "<tr><td></td></tr>";
                    html += "</table></div>";
                    html += "</div>";
                }
                
            } else {
                
                html += "<div>";
                html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                html += "</table></div>";
                html += "</div>";
                
            }
            
            $("#reply").html(reply);
            $("#donationReplyList").html(html);
            
        },
        error:function(request,status,error){
            
       }
        
    });
}
 
</script>
 
</body>
</html>