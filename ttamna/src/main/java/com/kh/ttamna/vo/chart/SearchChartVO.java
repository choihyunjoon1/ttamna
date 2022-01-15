package com.kh.ttamna.vo.chart;

import lombok.Data;

@Data
public class SearchChartVO {

	private String payType;
	private String start;
	private String end;
	private String date; //날짜
	private long dailyAmount; //일별 기부 금액
	private String keyword;
	private long shopDaily; //일별 상품 판매 금액
	private String itemName; //상품 이름
}
