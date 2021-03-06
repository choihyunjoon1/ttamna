package com.kh.ttamna.vo.shop;

import java.sql.Date;

import lombok.Data;

@Data
public class ShopListByPageVo {
	private int shopNo;
	private String memberId;
	private String shopTitle;
	private String shopGoods;
	private int shopPrice;
	private int shopCount;
	private String shopContent;
	private Date shopTime;
	private int shopRead;
	private int shopImgNo;
}
