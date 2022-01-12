package com.kh.ttamna.vo.shop;

import java.sql.Date;

import lombok.Data;

@Data
public class ShopVO {
	private int shopNo;
	private String memberId;
//	private String shopTitle;
	private String shopGoods;
	private int shopPrice;
	private int shopImgNo;
	private int quantity; 
	private int cartNo;
}
