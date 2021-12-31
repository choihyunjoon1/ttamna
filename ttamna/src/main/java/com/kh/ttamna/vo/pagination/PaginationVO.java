package com.kh.ttamna.vo.pagination;

import java.util.ArrayList;
import java.util.List;

import com.kh.ttamna.entity.member.MemberDto;

import lombok.Data;

@Data
public class PaginationVO {
	
	private int page;
	private String column;
	private String keyword;
	private int count;
	private int pageSize;
	private int blockSize;
	private Integer startRow;
	private Integer endRow;
	private int startBlock, finishBlock, lastBlock;
	private List<MemberDto> listOfMember = new ArrayList<>(); //Member

	
	public void calculator() throws Exception {
		//rownum 계산
		if(this.page <= 0) this.page = 1;
		
		this.endRow = this.page * this.pageSize;
		this.startRow = this.endRow - (this.pageSize - 1);
		
		//block 계산
		this.lastBlock = (this.count - 1) / this.pageSize + 1;
		this.startBlock = (this.page - 1) / this.blockSize * this.blockSize + 1;
		this.finishBlock = this.startBlock + (this.blockSize - 1);
	}
	
	//추가 : 이전이 존재하나요?
	public boolean isPreviousExist() {
		return this.startBlock > 1;
	}
	//추가 : 다음이 존재하나요?
	public boolean isNextExist() {
		return this.finishBlock < this.lastBlock; 
	}
	//추가 : 검색모드인가요?
	public boolean isSearch() {
		return this.column != null && !this.column.equals("") && this.keyword != null && !this.keyword.equals("");
	}
	//추가 : 진짜 마지막 블록 번호 반환
	public int getRealLastBlock() {
		return Math.min(this.finishBlock, this.lastBlock);
	}
	//추가 : 이전을 누르면 나오는 블록 번호
	public int getPreviousBlock() {
		return this.startBlock - 1;
	}
	//추가 : 다음을 누르면 나오는 블록 번호
	public int getNextBlock() {
		return this.finishBlock + 1;
	}
	public boolean columnIs(String column) {
		return this.column != null && this.column.equals(column);
	}
}
