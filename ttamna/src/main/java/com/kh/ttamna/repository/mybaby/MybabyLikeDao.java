package com.kh.ttamna.repository.mybaby;

import java.util.List;

import com.kh.ttamna.entity.mybaby.MybabyLikeDto;

public interface MybabyLikeDao {

	void insert(int mybabyNo, String memberId);

	void delete(int mybabyNo, String memberId);

	MybabyLikeDto get(int mybabyNo,String memberId);

	
}
