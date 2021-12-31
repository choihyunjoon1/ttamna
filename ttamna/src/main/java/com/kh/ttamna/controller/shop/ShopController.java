package com.kh.ttamna.controller.shop;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

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
import com.kh.ttamna.entity.shop.ShopDto;
import com.kh.ttamna.entity.shop.ShopImgDto;
import com.kh.ttamna.repository.shop.ShopDao;
import com.kh.ttamna.repository.shop.ShopImgDao;
import com.kh.ttamna.service.shop.ShopService;
import com.kh.ttamna.vo.shop.ShopImgVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/shop")
@Slf4j
public class ShopController {
		
	@Autowired
	private ShopDao shopDao;
	
	@Autowired
	private ShopImgDao shopImgDao;
	
	@Autowired
	private ShopService shopService;

	@Autowired
	private SqlSession sqlSession;
	
	
//	@RequestMapping("/")
//	public String main(Model model) {
//		model.addAttribute("list", shopDao.list());
//		return "shop/list";
//	}
//	
//	@RequestMapping("/list")
//	public String shop(Model model) {
//		model.addAttribute("list", shopDao.list());
//		return "shop/list";
//	}
	
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
	
//	@GetMapping("/detail")
//	public String detail(@RequestParam int shopNo, Model model) {
//		ShopDto shopDto = shopDao.get(shopNo);
//		model.addAttribute("detail", shopDto);
//		return"shop/detail";
//	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int shopNo, Model model) {
		ShopDto shopDto = shopDao.get(shopNo);
		ShopImgDto shopImgDto = shopImgDao.getBy(shopNo);
		
		shopDao.readUp(shopDto);
		
		model.addAttribute("detail", shopDto);
		model.addAttribute("shopImgDto", shopImgDto);
		
		return"shop/detail";
	}
	
	@GetMapping("/more")
	@ResponseBody
	public List<ShopDto> more(@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "12") int size){
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		
		return shopDao.listByPage(startRow, endRow);	
	}
	
	@GetMapping("/delete")
	public String delete(int shopNo) {
		shopDao.delete(shopNo);
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
	
	
	// 이미지 다운로드
	@GetMapping("/img")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> img(
														@RequestParam int shopImgNo
									) throws IOException {
		
		// 이미지 번호로 이미지 파일 정보 구하기
		ShopImgDto shopImgDto = shopImgDao.get(shopImgNo);
		
		// 이미지 번호로 파일정보 불러오기
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
	
	@PostMapping("/detail/addcart")
	public String addCart(@ModelAttribute CartDto cartDto, HttpSession session) {
		System.out.println("장바구니컨트롤러들어옴");
		if(session.getAttribute("cart") == null) {
			 List<CartDto> cart = new ArrayList<CartDto>();
			session.setAttribute("cart", cart);
			cart.add(cartDto);
		} else {
			List<CartDto> cart = (List<CartDto>)session.getAttribute("cart");
			cart.add(cartDto);
		}
		
		System.out.println(session.getAttribute("cart"));
		System.out.println("장바구니컨트롤러나감");
		return "redirect:/shop/cart/list";
	}
	
}
