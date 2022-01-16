<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.js" integrity="sha512-7Fh4YXugCSzbfLXgGvD/4mUJQty68IFFwB65VQwdAf1vnJSG02RjjSCslDPK0TnGRthFI8/bSecJl6vlUHklaw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

 <script> 
 
 window.addEventListener("load", function(){
	 
	 var temp = document.querySelector(".temp");
	 var regular = document.querySelector(".regular");
	 var shop = document.querySelector(".shop");

	 //단건 기부금액 . 검색 버튼을 누르면 실행
	 temp.querySelector("#search").addEventListener("click",function(){
		 var start = temp.querySelector("input[name=start]").value;
		 var end = temp.querySelector("input[name=end]").value;
			 
		 $.ajax({
			 url : "${root}/ajax/search",
			 type : "post",
			 data : {
				 start : start,
				 end : end
			 },
			 dataType: "json",
			 success:function(resp){
					console.log("단건 기부의 일별 누적 금액 불러오기 성공");
					//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
		 			dateSearch("#result", resp);
		 		},
		 		error:function(e){
		 			console.log("단건 기부의 일별 누적 금액 불러오기 실패", e);
		 		}
		  });
  	 });
	 
	 $("button[type=reset]").click(function(){
		 location.reload();
	 });
	 
	 //정기 기부금액. 검색 버튼을 누르면 실행
	 regular.querySelector("#regular-search").addEventListener("click",function(){
		 var start = regular.querySelector("input[name=start]").value;
		 var end = regular.querySelector("input[name=end]").value;
			 
		 $.ajax({
			 url : "${root}/ajax/regular_search",
			 type : "post",
			 data : {
				 start : start,
				 end : end
			 },
			 dataType: "json",
			 success:function(resp){
					console.log("일별 누적 정기 기부금액 불러오기 성공");
					//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
		 			regularSearch("#regular-result", resp);
		 		},
		 		error:function(e){
		 			console.log("일별 누적 정기 기부금액 불러오기 실패", e);
		 		}
		  });
  	 });
	
	 //후원상품 판매금액. 검색 버튼을 누르면 실행
	 shop.querySelector("#shop-search").addEventListener("click",function(){
		 var keyword = shop.querySelector("input[name=itemName]").value;
		 var start = shop.querySelector("input[name=start]").value;
		 var end = shop.querySelector("input[name=end]").value;
			 
		 $.ajax({
			 url : "${root}/ajax/shop_search",
			 type : "post",
			 data : {
				 keyword : keyword,
				 start : start,
				 end : end
			 },
			 dataType: "json",
			 success:function(resp){
					console.log("일별 누적 후원상품 판매금액 불러오기 성공");
					//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
		 			shopSearch("#shop-result", resp);
		 		},
		 		error:function(e){
		 			console.log("일별 누적 후원상품 판매금액 불러오기 실패", e);
		 		}
		  });
  	 });
 });
	
 	//단건결제 기간 검색
	 function dateSearch(selector, data){
			
		 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
		 	var ctx = $(selector)[0].getContext("2d");
		 	var dateArray = [];//날짜(문자열)만 모아둘 배열
			var dailyAmountArray = [];//기부 금액만 모아둘 배열
			
			//SearchChartVO에서 가져온 데이터를 각 배열에 넣어준다
			for(var i=0; i < data.searchDataset.length; i++){
				dateArray.push(data.searchDataset[i].date);
				dailyAmountArray.push(data.searchDataset[i].dailyAmount);
			}
		 	
		 	//var chart = new Chart(펜객체, 차트옵션);
		 	var daily = new Chart(ctx, {
		 		type: 'line', //차트 유형
		 		data: { //차트에 들어가는 데이터
		 			labels: dateArray,
		 			datasets: [{
		 				label: data.label,
		 				data: dailyAmountArray,
		 				backgroundColor: [
			                'rgba(153, 102, 255, 0.2)'
			               
		 				],
		 				borderColor: [
		 		            'rgba(75, 192, 192, 1)'
		 				],
		 				borderWidth: 1
		 			}]
		 		},
			    options: {
			    	responsive: true,
			  		plugins: {
						legend: {
							position: 'top',
						},
			          	title: {
			            	display: true,
			            	text: data.title
			          	}
					}
		     	 }
		 	
		 	});
		 }
	 
	 //정기결제 기간 검색
	 function regularSearch(selector, data){
			
		 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
		 	var ctx = $(selector)[0].getContext("2d");
		 	var dateArray = [];//날짜(문자열)만 모아둘 배열
			var dailyAmountArray = [];//기부 금액만 모아둘 배열
			
			//RegularChartVO에서 가져온 데이터를 각 배열에 넣어준다
			for(var i=0; i < data.regularDataset.length; i++){
				dateArray.push(data.regularDataset[i].date);
				dailyAmountArray.push(data.regularDataset[i].dailyAmount);
			}
		 	
		 	//var chart = new Chart(펜객체, 차트옵션);
		 	var daily = new Chart(ctx, {
		 		type: 'line', //차트 유형
		 		data: { //차트에 들어가는 데이터
		 			labels: dateArray,
		 			datasets: [{
		 				label: data.label,
		 				data: dailyAmountArray,
		 				backgroundColor: [
			                'rgba(153, 102, 255, 0.2)'
			               
		 				],
		 				borderColor: [
		 		            'rgba(75, 192, 192, 1)'
		 				],
		 				borderWidth: 1
		 			}]
		 		},
			    options: {
			    	responsive: true,
			  		plugins: {
						legend: {
							position: 'top',
						},
			          	title: {
			            	display: true,
			            	text: data.title
			          	}
					}
		     	 }
		 	
		 	});
		 }
	 
	//후원상품 판매금액 기간 검색
	 function shopSearch(selector, data){
			
		 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
		 	var ctx = $(selector)[0].getContext("2d");
		 	var dateArray = [];//날짜(문자열)만 모아둘 배열
			var shopDailyArray = [];//상품 판매 금액만 모아둘 배열
			
			//DonationChartVO에서 가져온 데이터를 각 배열에 넣어준다
			for(var i=0; i < data.searchDataset.length; i++){
				dateArray.push(data.searchDataset[i].date);
				shopDailyArray.push(data.searchDataset[i].shopDaily);
			}
		 	
		 	//var chart = new Chart(펜객체, 차트옵션);
		 	var daily = new Chart(ctx, {
		 		type: 'line', //차트 유형
		 		data: { //차트에 들어가는 데이터
		 			labels: dateArray,
		 			datasets: [{
		 				label: data.label,
		 				data: shopDailyArray,
		 				backgroundColor: [
			                'rgba(153, 102, 255, 0.2)'
			               
		 				],
		 				borderColor: [
		 		            'rgba(75, 192, 192, 1)'
		 				],
		 				borderWidth: 1
		 			}]
		 		},
			    options: {
			    	responsive: true,
			  		plugins: {
						legend: {
							position: 'top',
						},
			          	title: {
			            	display: true,
			            	text: data.title
			          	}
					}
		     	 }
		 	
		 	});
		 }
</script>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center mt-5 mb-5">
	 
	 <div class="mt-5 mb-1"><h3>SEARCH</h3></div>
	 
	 <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-2 mb-5">
		<a type="button" class="btn btn-sm btn-outline-dark" href="${root}/admin/statistics/menu">Back to Statistics Menu</a>
		<a type="button" class="btn btn-sm btn-outline-dark" href="${root}/admin/main">Back to Admin Menu</a>
	</div>
	 
	<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-2 mb-5">
		 <button type="reset" class="btn btn-sm btn-outline-dark">reset</button>
	</div>

	<!-- 검색창 -->
	<!-- 셀렉트 : 단건 기부금액-->
	<div class="container-600">
	<div class="mb-1"><h5><strong>단건 기부금액에 대한 일별 누적금액 기간 검색</strong></h5></div> 
			<form action="${root}/ajax/search" method="post" class="temp">
				<div class="input-group">
					<div class="input-group input-group-sm mb-3">
						<input type="date" name="start" required class="form-control">
						<input type="date" name="end" required class="form-control">
						<button type="button" id="search" class="btn btn-dark btn-sm">search</button>
					</div>
				</div>			
			</form>
	
	<div class="mt-5 mb-5">
		<canvas id="result" width="50%"></canvas>
	</div>
	</div>	
	
	
	<!-- 정기 기부금액 검색창 -->
	<div class="container-600">
	<div class="mb-1"><h5><strong>정기 기부금액에 대한 일별 누적금액 기간 검색</strong></h5></div> 
			<form action="${root}/ajax/regular_search" method="post" class="regular">
				<div class="input-group">
					<div class="input-group input-group-sm mb-3">
						<input type="date" name="start" required class="form-control">
						<input type="date" name="end" required class="form-control">
						<button type="button" id="regular-search" class="btn btn-dark btn-sm">search</button>
					</div>
				</div>			
			</form>
	
	<div class="mt-5 mb-5">
		<canvas id="regular-result" width="50%"></canvas>
	</div>
	</div>	
	
	
	<!-- 후원상품 판매금액 검색창 -->
	<div class="container-600">
	<div class="mb-1"><h5><strong>후원상품 판매금액에 대한 일별 누적금액 기간 검색</strong></h5></div> 
			<form action="${root}/ajax/shop_search" method="post" class="shop">
				<div class="input-group">
					 <div class="input-group input-group-sm mb-3">
						<input type="text" name="itemName" required class="form-control" placeholder="검색할 상품의 이름을 입력해 주세요">
					</div>
					<div class="input-group input-group-sm mb-3">
						<input type="date" name="start" required class="form-control">
						<input type="date" name="end" required class="form-control">
						<button type="button" id="shop-search" class="btn btn-dark btn-sm">search</button>
					</div>
				</div>			
			</form>
	
	<div class="mt-5 mb-5">
		<canvas id="shop-result" width="50%"></canvas>
	</div>
	</div>	
	
	<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-2 mb-5">
		 <button type="reset" class="btn btn-sm btn-outline-dark">reset</button>
	</div>
	 

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>