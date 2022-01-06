<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="container">
	<div class="row mt-3">
	<div class="col">
		<h2>기부한 사이트 : ${searchList.partner_order_id}</h2>
		<h2>기부자 아이디 : ${searchList.partner_user_id}</h2>
		<h2>기부 금액 : ${searchList.amount.total}원</h2>
		<h2>기부 유형 : ${searchList.item_name}</h2>
	</div>
	</div>
</div>

