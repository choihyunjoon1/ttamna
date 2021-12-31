package com.kh.ttamna.entity.cart;

import java.sql.Date;

import lombok.Data;

@Data
public class CartDto {
	private int cartNo;
	private String memberId;
	private int shopNo;
	private String shopGoods;
	private int shopImgNo;
	private Date cartTime;
	private int cartCount;
}
