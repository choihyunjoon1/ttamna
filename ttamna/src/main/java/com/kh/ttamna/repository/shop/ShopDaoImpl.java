package com.kh.ttamna.repository.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.shop.ShopDto;
import com.kh.ttamna.vo.shop.ShopListByPageVo;
import com.kh.ttamna.vo.shop.ShopOrderVO;

@Repository
public class ShopDaoImpl implements ShopDao{

		@Autowired
		private SqlSession sqlSession;
		
	// 등록	
	@Override
	public void insert(ShopDto shopDto) {
		sqlSession.insert("shop.insert", shopDto);

	}

	// 상세조회
	@Override
	public ShopDto get(int shopNo) {
		return sqlSession.selectOne("shop.get", shopNo);
	}

	// 글 목록
	@Override
	public List<ShopDto> list() {
		return sqlSession.selectList("shop.listByImgNo");
	}
	
	// 목록 더보기
	@Override
	public List<ShopListByPageVo> listByPage(int startRow, int endRow) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return sqlSession.selectList("shop.listByPage", map);
	}

	// 삭제
	@Override
	public boolean delete(int shopNo) {
		
		return sqlSession.delete("shop.delete", shopNo) > 0;
	}
	
	// 수정
	@Override
	public boolean update(ShopDto shopDto) {
	
		return sqlSession.update("shop.update", shopDto) > 0;
		
	}

	@Override
	public List<ShopDto> search(List<Integer> shopNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("list", shopNo);
		return sqlSession.selectList("shop.search", param);
	}
	@Override
	public ShopDto search(int shopNo) {
		return sqlSession.selectOne("shop.searchOne", shopNo);
	}
	// 조회수 증가
	@Override
	public boolean readUp(ShopDto shopDto) {
		return sqlSession.update("shop.read", shopDto) > 0;
	}
	// 재고량  감소
	@Override
	public boolean sell(ShopDto shopDto) {
		return sqlSession.update("shop.sell", shopDto) > 0;
	}

	//메인페이지에 3개 띄우기
	@Override
	public List<ShopListByPageVo> mainList() {
		return sqlSession.selectList("shop.mainBoard");
	}
}
