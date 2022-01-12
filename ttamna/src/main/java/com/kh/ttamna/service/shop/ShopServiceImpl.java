package com.kh.ttamna.service.shop;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.shop.ShopDto;
import com.kh.ttamna.entity.shop.ShopImgDto;
import com.kh.ttamna.repository.shop.ShopDao;
import com.kh.ttamna.repository.shop.ShopImgDao;
import com.kh.ttamna.vo.shop.ShopImgVO;

@Service
public class ShopServiceImpl implements ShopService{
	
	@Autowired
	private ShopDao shopDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ShopImgDao shopImgDao;

	@Override
	public void insert(ShopImgVO shopImgVO) throws IllegalStateException, IOException {
		// 게시글 정보
		// ShopImgVO에서 정보를 뽑아서 ShopDto를 생성하고 설정해주기
		ShopDto shopDto = new ShopDto();
		
		int seq = sqlSession.selectOne("shop.seq");
		
		shopDto.setShopNo(seq);
		System.out.println("게시글 정보의 글번호 : "+seq);
		shopDto.setMemberId(shopImgVO.getMemberId());
		shopDto.setShopTitle(shopImgVO.getShopTitle());
		shopDto.setShopContent(shopImgVO.getShopContent());
		shopDto.setShopPrice(shopImgVO.getShopPrice());
		shopDto.setShopCount(shopImgVO.getShopCount());
		shopDto.setShopTime(shopImgVO.getShopTime());
		shopDto.setShopRead(shopImgVO.getShopRead());
		shopDto.setShopGoods(shopImgVO.getShopGoods());

		shopDao.insert(shopDto);
		
//		// 파일 저장
//		MultipartFile multipartFile = shopImgVO.getAttach();
//		if(!multipartFile.isEmpty()) { // 파일이 있으면 = multipartFile이 비어있지 않다면
//			ShopImgDto shopImgDto = new ShopImgDto();
//			shopImgDto.setShopNo(seq);
//			System.out.println("게시글 번호 = "+seq);
//			shopImgDto.setShopImgUpload(multipartFile.getOriginalFilename());
//			System.out.println("파일 이름 = "+multipartFile.getOriginalFilename());
//			shopImgDto.setShopImgType(multipartFile.getContentType());
//			shopImgDto.setShopImgSize(multipartFile.getSize());
//			
//			shopImgDao.save(shopImgDto, multipartFile);	
//			
//		}
		
		// 파일 저장(여러장)
		int i = 0;
		for(MultipartFile multipartFile : shopImgVO.getAttach()) {
			if(multipartFile != null) {//파일이 있으면
				ShopImgDto shopImgDto = new ShopImgDto();
				shopImgDto.setShopNo(seq);
				System.out.println("게시글 번호 = "+seq);
				shopImgDto.setShopImgUpload(multipartFile.getOriginalFilename());
				System.out.println("파일 이름 = "+multipartFile.getOriginalFilename());
				shopImgDto.setShopImgType(multipartFile.getContentType());
				shopImgDto.setShopImgSize(multipartFile.getSize());
				
				shopImgDao.save(shopImgDto, multipartFile);	
			} else break;//없으면 종료
		}
	}
}
