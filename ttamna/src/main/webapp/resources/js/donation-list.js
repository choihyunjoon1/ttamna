$(function(){
	var page = 1;
	var size = 12;
	
	
	
	$(".more-btn").click(function(){
		var column = $("#column option:selected").val();
		var keyword = $("input[name=keyword]").val();
		loadData(page, size, column, keyword);
		page++;
	});
	
	//여러가지 방법이 있다
	//여기선 더보기 버튼을 강제1회 클릭(트리거)
	$(".more-btn").click();
	
	//이렇게 캡슐화를 하는데 이걸 중첩클래스라고한다
	function loadData(page, size, column, keyword){
		
		$.ajax({
			url : "more?column="+column+"&keyword="+keyword,
			type : "get",
			data : {
				page : page,
				size : size
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
	
				//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
				if(resp.length < size){
					$(".more-btn").remove();
				}
				
				//데이터 출력
				for(var i=0; i < resp.length; i++){
					var donationWriter = resp[i].donationWriter;
					var imgLocation= "이미지위치";
					if(donationWriter == null){
						donationWriter = "탈퇴한 회원입니다";
					}
					var divCol = "<div class='page card text-gray bg-light mb-5 ms-2' style='width:18rem;'>"+
						imgLocation + 
						"<div class='card-body'>" +
						"<h5 class='card-title'>"+resp[i].donationTitle+"</h5>" +
						"<div class='card-text'>"+resp[i].donationContent+"</div>"+
						"<div class='card-text'>"+resp[i].donationNowFund+"원</div>"+
						"<div class='card-text'>"+(resp[i].donationNowFund/resp[i].donationTotalFund)*100+"%------"+resp[i].donationTotalFund+"원</div>"+
						"<span><a href=detail?donationNo="+resp[i].donationNo+">"+resp[i].donationTitle+"</a></span>" +
					+"</div>";
					$(".result").append(divCol);
					$(".page").addClass("col-3 mt-3");
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
});