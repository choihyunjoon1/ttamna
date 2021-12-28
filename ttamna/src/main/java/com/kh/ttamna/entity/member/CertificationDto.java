package com.kh.ttamna.entity.member;

import java.sql.Date;

import lombok.Data;

@Data
public class CertificationDto {

		private String certEmail;
		private String certSerial;
		private Date certTime;

}
