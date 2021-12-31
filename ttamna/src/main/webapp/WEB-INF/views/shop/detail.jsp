<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="row form">
	<span>${detail.shopTitle}</span>
	<span>${detail.shopRead}</span>
</div>
<div class="row">
	<span>상품명 : ${detail.shopGoods}</span>
</div>
<div class="row">
	<span>판매가 : ${detail.shopPrice}원</span>
</div>
<div class="row">
	<span>남은 수량 : ${detail.shopCount}</span>
</div>
<div class="row">
	<span>${detail.shopContent}</span>
</div>
<a href="edit?shopNo=${detail.shopNo}">수정</a>
<a href="delete?shopNo=${detail.shopNo}">삭제</a>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>