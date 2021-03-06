package com.kh.ttamna.controller.shop;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttamna.entity.cart.CartDto;
import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.entity.shop.ShopDto;
import com.kh.ttamna.entity.shop.ShopImgDto;
import com.kh.ttamna.repository.cart.CartDao;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.repository.shop.ShopDao;
import com.kh.ttamna.repository.shop.ShopImgDao;
import com.kh.ttamna.service.shop.ShopService;
import com.kh.ttamna.vo.shop.ShopImgVO;
import com.kh.ttamna.vo.shop.ShopJoinVO;
import com.kh.ttamna.vo.shop.ShopListByPageVo;
import com.kh.ttamna.vo.shop.ShopListVO;
import com.kh.ttamna.vo.shop.ShopVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/shop")
@Slf4j
public class ShopController {
		
	@Autowired
	private ShopDao shopDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ShopImgDao shopImgDao;
	
	@Autowired
	private ShopService shopService;

	@Autowired
	private SqlSession sqlSession;

	
	@RequestMapping("/")
	public String main(Model model) {
		model.addAttribute("list", sqlSession.selectList("shop.listByImgNo"));
		
		return "shop/list";
	}
	@RequestMapping("/list")
	public String shop(Model model) {
		model.addAttribute("list", sqlSession.selectList("shop.listByImgNo"));
		
		return "shop/list";
	}
	
	@GetMapping("/write")
	public String insert() {
		return "shop/write";
	}
	
	@PostMapping("/write")
	public String insert(@ModelAttribute ShopImgVO shopImgVO) throws IllegalStateException, IOException {
		shopService.insert(shopImgVO);
		
		return "redirect:/shop/list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int shopNo, Model model) {
		ShopDto shopDto = shopDao.get(shopNo);
//		ShopImgDto shopImgDto = shopImgDao.getBy(shopNo);
		List<ShopImgDto> shopImgDto = shopImgDao.getBys(shopNo);
		
		shopDao.readUp(shopDto);
		
		model.addAttribute("detail", shopDto);
		model.addAttribute("shopImgDto", shopImgDto);
		model.addAttribute("shopNo", shopNo);
		return"shop/detail";
	}
	
	@GetMapping("/more")
	@ResponseBody
	public List<ShopListByPageVo> more(@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "12") int size){
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		
		return shopDao.listByPage(startRow, endRow);	
	}
	
	@GetMapping("/delete")
	public String delete(int shopNo) {
		shopDao.delete(shopNo);
		shopService.delete(shopNo);
		return"redirect:/shop/";
	}
	
	@GetMapping("/edit")
	public String update(@RequestParam int shopNo, Model model) {
		ShopDto shopDto = shopDao.get(shopNo);
		model.addAttribute("update", shopDto);
		return "shop/edit";
	}
	
	@PostMapping("/edit")
	public String update(@ModelAttribute ShopDto shopDto) {
		shopDao.update(shopDto);
		
		return "redirect:/shop/detail?shopNo="+shopDto.getShopNo();
	}
	
	
	// ????????? ????????????
	@GetMapping("/img")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> img(
														@RequestParam int shopImgNo
									) throws IOException {
		
		// ????????? ????????? ????????? ?????? ?????? ?????????
		ShopImgDto shopImgDto = shopImgDao.get(shopImgNo);
		
		// ????????? ????????? ???????????? ????????????
		byte[] data = shopImgDao.load(shopImgNo);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		String encodeName = URLEncoder.encode(shopImgDto.getShopImgUpload(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
				.header("Content-Encoding", "UTF-8")
				.contentLength(shopImgDto.getShopImgSize())
				
				.body(resource);
	}
	
	// ?????? ?????? ?????????
	@RequestMapping("/order")
	public String order(@ModelAttribute ShopListVO listVO, HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("uid");
		MemberDto memberDto = memberDao.get(memberId);
		
		System.out.println("????????? ????????? : " +listVO.getList());
		
		List<CartDto> list = new ArrayList<>();
		for(ShopVO shopVO : listVO.getList()) {
			CartDto cartDto = new CartDto();
			cartDto.setMemberId(shopVO.getMemberId());
			cartDto.setShopNo(shopVO.getShopNo());
			cartDto.setShopGoods(shopVO.getShopGoods());
			cartDto.setShopImgNo(shopVO.getShopImgNo());
			cartDto.setCartCount(shopVO.getQuantity());
			cartDto.setShopPrice(shopVO.getShopPrice());
			cartDto.setCartNo(shopVO.getCartNo());
			list.add(cartDto);
			System.out.println("???????????????" + cartDto); // CartDto(cartNo=0, memberId=jammin, shopNo=79, shopGoods=????????? ?????????, shopImgNo=40, cartTime=null, cartCount=1, shopPrice=20000)
			model.addAttribute("cartDto", cartDto);
		}
		model.addAttribute("list", list);
		model.addAttribute("memberDto", memberDto);
		
		
		return "shop/order";
	}
	
}
