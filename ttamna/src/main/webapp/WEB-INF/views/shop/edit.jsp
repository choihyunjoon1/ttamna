<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
  <form method="post">
  		<input type="hidden" name="memberId" value="${sessionScope.uid}">
  		<div class="row">
  			<input type="text" name="shopTitle" required class="form-input"  value="${update.shopTitle}">
  		</div>
  		<div class="row">
  			<label>상품 이미지</label>
  			<input type="file" name="attach" class="form-inline">
  		</div>
  		<div class="row">
  			<label>상품명 : </label>
  			<input type="text" name="shopGoods" class="form-input form-inline" readonly value="${update.shopGoods}">
  		</div>
  		<div class="row">
  			<label>판매가 : </label>
  			<input type="number" name="shopPrice" class="form-input form-inline" readonly value="${update.shopPrice}">
  		</div>
  		<div class="row">
  			<label>수량 : </label>
  			<input type="number" name="shopCount" class="form-input form-inline" readonly value="${update.shopCount}">
  		</div>
  		<div class="row">
  			<textarea rows="30" cols="20" name="shopContent" required class="form-input" >${update.shopContent}</textarea>
  		</div>
  		<input type="submit" value="등록" class="form-btn">
  </form>
    
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>