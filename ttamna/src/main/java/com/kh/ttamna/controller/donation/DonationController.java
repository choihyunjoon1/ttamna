package com.kh.ttamna.controller.donation;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

import com.kh.ttamna.entity.donation.DonationDto;
import com.kh.ttamna.entity.donation.DonationImgDto;
import com.kh.ttamna.repository.donation.DonationDao;
import com.kh.ttamna.repository.donation.DonationImgDao;
import com.kh.ttamna.repository.donation.DonationReplyDao;
import com.kh.ttamna.service.donation.DonationFileService;
import com.kh.ttamna.service.pagination.PaginationService;
import com.kh.ttamna.vo.donation.DonationUploadVo;

@Controller
@RequestMapping("/donation")
public class DonationController {

	
	@Autowired
	private DonationDao donationDao;
	
	@Autowired
	private DonationImgDao donationImgDao;
	
	@Autowired
	private DonationFileService donationService;
	
	@Autowired
	private DonationReplyDao donationReplyDao;
	
	@Autowired
	private PaginationService paginationService;
	
	
	
	@RequestMapping("/")//목록페이지
	public String defaultList(@RequestParam(required = false) String column,
										@RequestParam(required = false) String keyword,
			Model model) {
		
		if(column != null && keyword != null) {
			Map<String, Object> data = new HashMap<>();
			data.put("column", column);
			data.put("keyword", keyword);
			
			model.addAttribute("list", donationDao.detailOrSearch(data));
			model.addAttribute("column", column);
			model.addAttribute("keyword", keyword);
		} else {
			model.addAttribute("list", donationDao.list());
		}
		
		return "donation/list";
	}
	@RequestMapping("/list")//목록페이지
	public String list(@RequestParam(required = false) String column,
							@RequestParam(required = false) String keyword,
			Model model) {
		
		if(column != null && keyword != null) {
			Map<String, Object> data = new HashMap<>();
			data.put("column", column);
			data.put("keyword", keyword);
			
			model.addAttribute("list", donationDao.detailOrSearch(data));
		} else {
			model.addAttribute("list", donationDao.list());
		}
		
		return "donation/list";
	}
	
	@GetMapping("/detail")//상세보기페이지로이동
	public String detail(@RequestParam int donationNo, Model model) throws Exception {
		Map<String, Object> data = new HashMap<>();
		data.put("donationNo", donationNo);
		model.addAttribute("donationNo", donationNo);
		model.addAttribute("donationDto", donationDao.detailOrSearch(data));
		model.addAttribute("donationImgDtoList", donationImgDao.getList(donationNo));
		return "donation/detail";
		
	}

	
	
	@GetMapping("/delete")//삭제요청
	public String delete(@RequestParam int donationNo,
							HttpSession session) {
		donationService.delete(donationNo);
		donationDao.delete((String)session.getAttribute("uid"));
		
		return "redirect:/donation/list";
	}
	
	@GetMapping("/file/delete")//수정페이지에서 이미지 삭제를 요청했을 때
	public String fileDelete(@RequestParam int imgNo) {
		donationImgDao.fileOneDelete(imgNo);
		donationService.fileOneDelete(imgNo);
		return "donation/list";
	}
	
	@GetMapping("/edit")//수정페이지로이동
	public String edit(@RequestParam int donationNo, Model model) {
		Map<String, Object> data = new HashMap<>();
		data.put("donationNo", donationNo);
		model.addAttribute("donationDto", donationDao.detailOrSearch(data));
		model.addAttribute("imgDtoList", donationImgDao.getList(donationNo));
		return "donation/edit";
	}
	
	@PostMapping("/edit")//수정요청
	public String edit(@ModelAttribute DonationUploadVo donationUploadVo) throws IllegalStateException, IOException {
		
		System.out.println("정보 : " + donationUploadVo);
		donationService.updateAddFile(donationUploadVo);
		
		
		return "redirect:/donation/detail?donationNo="+donationUploadVo.getDonationNo();
	}
	
	@GetMapping("/insert")//등록페이지
	public String insert() {
		return "donation/insert";
	}
	
//	@PostMapping("/insert")//등록요청 - 파일업로드 x버전
//	public String insert(@ModelAttribute DonationDto donationDto) {
//		int donationNo = donationDao.insert(donationDto);
//		
//		return "redirect:/donation/detail?donationNo=" + donationNo;
//	}
	
	@PostMapping("/insert")//등록요청 - 단일파일업로드
	public String insert(@ModelAttribute DonationUploadVo donationUploadVo) throws IllegalStateException, IOException {
//		int donationNo = donationDao.insert(donationDto);
		int donationNo = donationService.insert(donationUploadVo);
		return "redirect:/donation/detail?donationNo=" + donationNo;
	}
	
	//더보기 페이지네이션 기능 처리
	@GetMapping("/more")
	@ResponseBody
	public List<DonationDto> more(
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size,
				@RequestParam(required =false, defaultValue = "") String column,
				@RequestParam(required =false, defaultValue = "") String keyword
			){
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		if(column != null && keyword != null && !column.equals("") && !keyword.equals("")) {
			return donationDao.listBySearchPage(startRow, endRow, column, keyword);
		} else {
			return donationDao.listByPage(startRow, endRow);
		}
		
	}
	
	//파일 다운로드처리
	@GetMapping("/donaimg")
	@ResponseBody
	public  ResponseEntity<ByteArrayResource> imgFile(
														@RequestParam int donationImgNo) throws IOException{

		DonationImgDto donationImgDto = donationImgDao.getFile(donationImgNo);
		
		byte[] data = donationImgDao.load(donationImgNo);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		String encodeName = URLEncoder.encode(String.valueOf(donationImgNo), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.contentLength(donationImgDto.getDonationImgSize())
				.body(resource);
	}
}
