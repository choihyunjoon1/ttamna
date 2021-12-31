package com.kh.ttamna.vo.shop;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.shop.ShopDto;

import lombok.Data;

@Data
public class ShopImgVO {

	private int shopNo;
	private String memberId;
	private String shopTitle;
	private String shopContent;
	private int shopPrice;
	private int shopCount;
	private Date shopTime;
	private int shopRead;
	private String shopGoods;
	private MultipartFile attach;

}
