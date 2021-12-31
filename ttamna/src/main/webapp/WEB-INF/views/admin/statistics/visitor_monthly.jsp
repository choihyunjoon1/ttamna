<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.js" integrity="sha512-7Fh4YXugCSzbfLXgGvD/4mUJQty68IFFwB65VQwdAf1vnJSG02RjjSCslDPK0TnGRthFI8/bSecJl6vlUHklaw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

 <script> 

 $(function(){// 화면이 시작될때 통계자료를 불러오도록 해야 한다
 
 	//이번달 누적 방문자
	 $.ajax({
	 		url : "${root}/ajax/thisMonth",
	 		type : "get",
	 		dataType : "json",
			success:function(resp){
				console.log("이번달 누적 방문자 수 통계 불러오기 성공");
				//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
	 			thisMonth("#this-month", resp);
	 		},
	 		error:function(e){
	 			console.log("이번달 누적 방문자 수 통계 불러오기 실패", e);
	 		}
	 	});
 
 	//이번달 부터 6개월전까지의 월별 누적 방문자
 	$.ajax({
 		url : "${root}/ajax/monthly",
 		type : "get",
 		dataType : "json",
		success:function(resp){
			console.log("6개월전까지의 월별 누적 방문자 수 통계 불러오기 성공");
			//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
 			monthly("#monthly", resp);
 		},
 		error:function(e){
 			console.log("6개월전까지의 월별 누적 방문자 수 통계 불러오기 실패", e);
 		}
 	});

 	 //최근 12개월간의 월별 방문자수
 	$.ajax({
 		url : "${root}/ajax/moy",
 		type : "get",
 		dataType : "json",
		success:function(resp){
			console.log("최근 12개월간의 월별 방문자수 월별 누적 방문자 수 통계 불러오기 성공");
			//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
 			moy("#moy", resp);
 		},
 		error:function(e){
 			console.log("최근 12개월간의 월별 방문자수 월별 누적 방문자 수 통계 불러오기 실패", e);
 		}
 	});
 });

 
 //이번달 누적 방문자
 function thisMonth(selector, data){
		
	 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
	 	var ctx = $(selector)[0].getContext("2d");
	 	var thisMonthArray = [];//날짜(문자열)만 모아둘 배열
		var thisMonthCountArray = [];//방문자수만 모아둘 배열
		
		//VisitChartVO에서 가져온 데이터를 각 배열에 넣어준다
		for(var i=0; i < data.dataset.length; i++){
			thisMonthArray.push(data.dataset[i].thisMonth);
			thisMonthCountArray.push(data.dataset[i].thisMonthCount);
		}
	 	
	 	//var chart = new Chart(펜객체, 차트옵션);
	 	var thisMonth = new Chart(ctx, {
	 		type: 'bar', //차트 유형
	 		data: { //차트에 들어가는 데이터
	 			labels: thisMonthArray,
	 			datasets: [{
	 				label: data.label,
	 				data: thisMonthCountArray,
	 				backgroundColor: [
	 				    'rgba(255, 99, 132, 0.2)'
	 				],
	 				borderColor: [
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
 
 
//이번달 부터 6개월전까지의 월별 누적 방문자
 function monthly(selector, data){
		
	 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
	 	var ctx = $(selector)[0].getContext("2d");
	 	var monthlyArray = [];//날짜(문자열)만 모아둘 배열
		var monthlyCountArray = [];//방문자수만 모아둘 배열
		
		//VisitChartVO에서 가져온 데이터를 각 배열에 넣어준다
		for(var i=0; i < data.dataset.length; i++){
			monthlyArray.push(data.dataset[i].monthly);
			monthlyCountArray.push(data.dataset[i].monthlyCount);
		}
	 	
	 	//var chart = new Chart(펜객체, 차트옵션);
	 	var monthly = new Chart(ctx, {
	 		type: 'bar', //차트 유형
	 		data: { //차트에 들어가는 데이터
	 			labels: monthlyArray,
	 			datasets: [{
	 				label: data.label,
	 				data: monthlyCountArray,
	 				backgroundColor: [
	 					'rgba(255, 99, 132, 0.2)',
	 	                'rgba(54, 162, 235, 0.2)',
	 	                'rgba(255, 206, 86, 0.2)',
	 	                'rgba(75, 192, 192, 0.2)',
	 	                'rgba(153, 102, 255, 0.2)',
	 	                'rgba(255, 159, 64, 0.2)',
	 	                'rgba(255, 206, 86, 0.2)'
	 				],
	 				borderColor: [
	 					'rgba(255, 99, 132, 1)',
	 		            'rgba(54, 162, 235, 1)',
	 		            'rgba(255, 206, 86, 1)',
	 		            'rgba(75, 192, 192, 1)',
	 		            'rgba(153, 102, 255, 1)',
	 		            'rgba(255, 159, 64, 1)',
	 		            'rgba(255, 206, 86, 1)'
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
	 
 // 최근 12개월간의 월별 방문자수
 function moy(selector, data){
		
	 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
	 	var ctx = $(selector)[0].getContext("2d");
	 	var moyArray = [];//날짜(문자열)만 모아둘 배열
		var moyCountArray = [];//방문자수만 모아둘 배열
		
		//VisitChartVO에서 가져온 데이터를 각 배열에 넣어준다
		for(var i=0; i < data.dataset.length; i++){
			moyArray.push(data.dataset[i].moy);
			moyCountArray.push(data.dataset[i].moyCount);
		}
	 	
	 	//var chart = new Chart(펜객체, 차트옵션);
	 	var moy = new Chart(ctx, {
	 		type: 'line', //차트 유형
	 		data: { //차트에 들어가는 데이터
	 			labels: moyArray,
	 			datasets: [{
	 				label: data.label,
	 				data: moyCountArray,
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
	 
	 <div class="mt-5 mb-5"><h3>VISITOR MONTHLY</h3></div>

	<div class="mt-5 mb-5">
		<canvas id="this-month" width="30%"></canvas>
	</div>
	
	<div class="mt-5 mb-5">
		<canvas id="monthly" width="30%"></canvas>
	</div>
	
	<div class="mt-5 mb-5">
		<canvas id="moy" width="30%"></canvas>
	</div>
	
	
	<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5 mb-5">
		<a type="button" class="btn btn-outline-primary" href="${root}/admin/statistics/menu">Back to Statistics Menu</a>
		<a type="button" class="btn btn-outline-primary" href="${root}/admin/main">Back to Admin Menu</a>
	</div>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>