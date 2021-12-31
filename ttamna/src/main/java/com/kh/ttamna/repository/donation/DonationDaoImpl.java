package com.kh.ttamna.repository.donation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.donation.DonationDto;

@Repository
public class DonationDaoImpl implements DonationDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override//등록
	public int insert(DonationDto donationDto) {
		int donationNo = sqlSession.selectOne("donation.seq");
		donationDto.setDonationNo(donationNo);
		sqlSession.insert("donation.insert", donationDto);
		
		//작성 후 상세로 가기 위해 게시글 번호 반환
		return donationNo;
	}

	@Override//목록
	public List<DonationDto> list() {
		return sqlSession.selectList("donation.list");
	}
	
	@Override//상세조회 or 검색, 값을 비교할 데이터를 맵에 넣고 그걸 또 맵에 넣어서 비교...
	public List<DonationDto> detailOrSearch(Map<String, Object> data) {
		Map<String, Object> searchData = new HashMap<>();
		//단일조회용 데이터
		searchData.put("donationNo", data.get("donationNo"));
		//검색용 데이터
		searchData.put("column", data.get("column"));
		searchData.put("keyword", data.get("keyword"));
		searchData.put("minPrice", data.get("minPrice"));
		searchData.put("maxPrice", data.get("maxPrice"));
		
		List<DonationDto> donationDto = sqlSession.selectList("donation.search", searchData);
		return donationDto;
	}
	
	@Override//예비 목록 출력
	public DonationDto detail(int donationNo) {
		return sqlSession.selectOne("donation.detail", donationNo);
	}

	@Override//수정
	public boolean edit(DonationDto donationDto) {
		return sqlSession.update("donation.edit", donationDto) > 0;
	}

	@Override//삭제
	public boolean delete(String donationWriter) {
		return sqlSession.delete("donation.delete", donationWriter) > 0;
	}

	@Override//더보기 페이지네이션
	public List<DonationDto> listByPage(int startRow, int endRow) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return sqlSession.selectList("donation.listByPage", map);
	}
	
	@Override//더보기 페이지네이션 검색버전
	public List<DonationDto> listBySearchPage(int startRow, int endRow, String column, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("column", column);
		map.put("keyword", keyword);
		
		return sqlSession.selectList("donation.listByPage", map);
	}
	
	@Override//기부 후 금액 업데이트
	public boolean funding(int donationNo, long price) {
		Map<String, Object> map = new HashMap<>();
		map.put("donationNo", donationNo);
		map.put("price", price);
		return sqlSession.update("donation.funding", map) > 0;
	}
	
}
