package com.kh.ttamna.vo.chart;

import lombok.Data;

@Data
public class SearchChartVO {

	private String payType;
	private String start;
	private String end;
	private String date; //날짜
	private long dailyAmount; //일별 상품판매 or 기부 금액
	
}
