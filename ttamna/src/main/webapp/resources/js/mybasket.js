/**
 * 
 */
	$(function(){
			//체크박스
			$("#checkAll").click(function(){
				if($("#checkAll").prop("checked")){
					$("input[name=shopNo]").prop("checked", true);
				}else{
					$("input[name=shopNo]").prop("checked", false);
				}
			});
			
		// 수량이 변동됐는데
		$("input[name=quantity]").change(function(e){
			var quantity = $("input[name=quantity]").val();
			// 수량이 1보다 작거나 999보다 크다면
			if(quantity < 1 || quantity > 999){
				// 알림 메세지 띄우고
				alert("수량은 1개부터 999개까지만 선택 가능합니다.");
				// 페이지 새로고침
				location.reload();
			}
		});
	});