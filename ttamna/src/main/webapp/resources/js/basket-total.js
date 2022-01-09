/*
 * 장바구니에 상품이 담기면 상품 가격 * 수량만큼 계산하고  합산해주는 스크립트
 * 
 */

// 상품 * 수량 = 금액
function calculateOrderPrice() {
	// 테이블 바디와 tr 탐색
    var tbody = document.getElementById("cartBody");
    var rows = tbody.getElementsByTagName("tr");

    for (var i=0; i<rows.length; i++) {
        // tr를 순서대로 하나씩 가져오기
        var tr = rows[i];

        // tr에서 가격이 표시된 td 가져오기 tr로부터 n번째
        var priceTd = tr.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling;

        // 가격표시된 td다음에 있는 구매수량이 표시된 td가져오기
        var qtyTd = priceTd.nextElementSibling;

        // 구매가격(가격*구매수량)을 표시할 td 가져오기
        var orderPriceTd = qtyTd.nextElementSibling;
        
        // td에서 가격 가져오기
        var price = parseInt(priceTd.textContent);

        // td에서 구매수량 가져오기
        var qty = qtyTd.firstElementChild.value == "" ? 0 : parseInt(qtyTd.firstElementChild.value) ;

        // 구매가격 계산하기
        var orderPrice = price * qty;

        // 구매가격 표시 td에 구매가격 넣기
        orderPriceTd.textContent = orderPrice + "원";

    }
    // 총합계 계산하는 함수 실행시키기
    calculateTotalPrice();
}


// 위에서 계산한 상품들의 모든 가격을 합산
function calculateTotalPrice() {

    var span = document.getElementById("order-price");

    // tbody를 찾는다.
    var tbody = document.getElementById("cartBody");

    // tbody안의 모든 tr을 찾는다.
    var rows = tbody.getElementsByTagName("tr");

    // 주문가격의 합계를 저장할 변수 만든다.
    var total = 0;

    // tr을 순서대로 하나씩 뽑아내서 주문가격을 가져오자.
    for (var i=0; i<rows.length; i++) {

        var tr = rows[i];

        // 주문가격이 있는 td 찾기
        var priceTd = tr.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling;

        // 주문가격 가져오기
        var price = parseInt(priceTd.textContent);

        // 합계에 누적시키기
        total += price;

    }

    // 합계가 표시되는 span의 텍스트켄텐츠 변경하기
    span.textContent = total;            
}        