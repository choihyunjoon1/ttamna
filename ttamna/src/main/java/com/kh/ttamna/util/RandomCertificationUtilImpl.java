package com.kh.ttamna.util;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class RandomCertificationUtilImpl implements RandomCertificationUtil{
	
	private Random r = new Random();

	@Override
	public String generator(int size) {
	
		int range = (int)Math.pow(10, size);
		int number = r.nextInt(range);
		StringBuffer buffer = new StringBuffer();
		for(int i=0 ; i<size; i++) {
			buffer.append("0");
		}
		Format f = new DecimalFormat("000000");
		return f.format(number);
	}
	
	
	
}
