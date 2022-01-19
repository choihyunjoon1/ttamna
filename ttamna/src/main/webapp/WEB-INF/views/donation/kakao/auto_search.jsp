<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">
	<div class="row mt-3">
	<div class="col">
		<h2>결제코드 : ${searchList.sid}</h2>
		<h2>기부유형 : ${searchList.item_name}</h2>
		<h2>시작날짜 : ${searchList.created_at}</h2>
		<h2>정기기부 상태 : 
			<c:if test="${searchList.status eq 'ACTIVE'}">
				진행중
			</c:if>
			<c:choose>
				<c:when test="${searchList.status eq 'ACTIVE'}">
					진행중
				</c:when>
				<c:otherwise>
					중단됨
				</c:otherwise>
			</c:choose>
		</h2>
	</div>
	</div>
</div>
