<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  el, jstl
	구글에서 찾아보시길...
 -->    
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<h2>댓글목록</h2>
<c:forEach var="asdf" items="${requestScope.list}">

<h2>${asdf.donationReplyNo} ${asdf.memberId} ${asdf.donationReplyContent}</h2>
</c:forEach>