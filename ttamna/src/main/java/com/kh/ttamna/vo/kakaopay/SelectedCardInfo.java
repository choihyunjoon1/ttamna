package com.kh.ttamna.vo.kakaopay;

import lombok.Data;

@Data
public class SelectedCardInfo {

	private String card_bin; //카드 Bin
	private int install_month; //할부 개월 수
	private String card_corp_name;//카드사 정보
	private String interest_free_install;//무이자 할부 여부(Y/N)
}