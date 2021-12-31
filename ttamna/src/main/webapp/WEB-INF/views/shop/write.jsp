<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
  <form method="post" enctype="multipart/form-data">
  		<input type="hidden" name="memberId" value="${sessionScope.uid}">
  		<div class="row">
  			<input type="text" name="shopTitle" required class="form-input" placeholder="제목을 입력해 주세요.">
  		</div>
  		<div class="row">
  			<label>상품 이미지</label>
  			<input type="file" name="attach" class="form-inline" required>
  		</div>
  		<div class="row">
  			<label>상품명 : </label>
  			<input type="text" name="shopGoods" class="form-input form-inline" required>
  		</div>
  		<div class="row">
  			<label>판매가 : </label>
  			<input type="number" name="shopPrice" class="form-input form-inline" required>
  		</div>
  		<div class="row">
  			<label>수량 : </label>
  			<input type="number" name="shopCount" class="form-input form-inline" required>
  		</div>
  		<div class="row">
  			<textarea rows="30" cols="20" name="shopContent" required class="form-input" placeholder="내용을 입력해주세요."></textarea>
  		</div>
  		<input type="submit" value="등록" class="form-btn">
  </form>
    
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>