<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.js" integrity="sha512-7Fh4YXugCSzbfLXgGvD/4mUJQty68IFFwB65VQwdAf1vnJSG02RjjSCslDPK0TnGRthFI8/bSecJl6vlUHklaw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

 <script> 

 $(function(){// 화면이 시작될때 통계자료를 불러오도록 해야 한다

	//기부금액 최근 7일간 일별 통계
	 $.ajax({
 		url : "${root}/ajax/donation_daily",
 		type : "get",
 		dataType : "json",
		success:function(resp){
			console.log("기부금액 최근 7일 일별 통계 불러오기 성공");
			//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
 			dailyOfDonation("#daily", resp);
 		},
 		error:function(e){
 			console.log("기부금액 최근 7일 일별 통계 불러오기 실패", e);
 		}
 	});
	
	//기부금액 이번달 일별 통계
	 $.ajax({
	 	url : "${root}/ajax/donation_thisMonth_daily",
	 	type : "get",
	 	dataType : "json",
		success:function(resp){
			console.log("이번달 일별 기부금액 통계 불러오기 성공");
			//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
	 		thisMonthDaily("#month-daily", resp);
	 	},
	 	error:function(e){
	 		console.log("이번달 일별 기부금액  통계 불러오기 실패", e);
	 	}
	 });
	
 });

 //selector : 선택자, data : JSON(ChartVO)
 //최근 7일간의 기부금액 통계를 가져오는 함수
 function dailyOfDonation(selector, data){
	
 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
 	var ctx = $(selector)[0].getContext("2d");
 	var dateArray = [];//날짜(문자열)만 모아둘 배열
	var dailyAmountArray = [];//기부 금액만 모아둘 배열
	
	//DonationChartVO에서 가져온 데이터를 각 배열에 넣어준다
	for(var i=0; i < data.donationDataset.length; i++){
		dateArray.push(data.donationDataset[i].date);
		dailyAmountArray.push(data.donationDataset[i].dailyAmount);
	}
 	
 	//var chart = new Chart(펜객체, 차트옵션);
 	var daily = new Chart(ctx, {
 		type: 'bar', //차트 유형
 		data: { //차트에 들어가는 데이터
 			labels: dateArray,
 			datasets: [{
 				label: data.label,
 				data: dailyAmountArray,
 				backgroundColor: [
 				    'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
 				    'rgba(255, 99, 132, 0.2)'
 				],
 				borderColor: [
 					'rgba(255, 99, 132, 1)',
 		            'rgba(54, 162, 235, 1)',
 		            'rgba(255, 206, 86, 1)',
 		            'rgba(75, 192, 192, 1)',
 		            'rgba(153, 102, 255, 1)',
 		            'rgba(255, 159, 64, 1)',		
 					'rgba(255, 99, 132, 1)'
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
 
//이번달 일별 기부금액을 가져오는 함수
 function thisMonthDaily(selector, data){
		
	 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
	 	var ctx = $(selector)[0].getContext("2d");
	 	var monthDateArray = [];//날짜(문자열)만 모아둘 배열
		var monthDailyAmountArray = [];//방문자수만 모아둘 배열
		
		//VisitChartVO에서 가져온 데이터를 각 배열에 넣어준다
		for(var i=0; i < data.donationDataset.length; i++){
			monthDateArray.push(data.donationDataset[i].thisMonthDate);
			monthDailyAmountArray.push(data.donationDataset[i].thisMonthDailyAmount);
		}
	 	
	 	//var chart = new Chart(펜객체, 차트옵션);
	 	var thisMonthdaily = new Chart(ctx, {
	 		type: 'line', //차트 유형
	 		data: { //차트에 들어가는 데이터
	 			labels: monthDateArray,
	 			datasets: [{
	 				label: data.label,
	 				data: monthDailyAmountArray,
	 				backgroundColor: [
		                'rgba(54, 162, 235, 0.2)'
	 				],
	 				borderColor: [
	 		            'rgba(54, 162, 235, 1)'
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
	 
	 <div class="mt-5 mb-5"><h3>DONATION DAILY</h3></div>
	 
	 <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-2 mb-5">
		<a type="button" class="btn btn-sm btn-outline-dark" href="${root}/admin/statistics/menu">Back to Statistics Menu</a>
		<a type="button" class="btn btn-sm btn-outline-dark" href="${root}/admin/main">Back to Admin Menu</a>
	</div>

	<div class="mt-2 mb-5">
		<canvas id="daily" width="30%"></canvas>
	</div>
	
	<div class="mt-5 mb-5">
		<canvas id="month-daily" width="30%"></canvas>
	</div>
	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>