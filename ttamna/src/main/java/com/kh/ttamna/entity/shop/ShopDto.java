package com.kh.ttamna.entity.shop;

import java.sql.Date;

import lombok.Data;

@Data
public class ShopDto {
	
	private int shopNo;
	private String memberId;
	private String shopTitle;
	private String shopContent;
	private int shopPrice;
	private int shopCount;
	private Date shopTime;
	private int shopRead;
	private String shopGoods;
}
