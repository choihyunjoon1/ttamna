//package com.kh.ttamna.controller.donation;
//
//import java.io.IOException;
//import java.net.URLEncoder;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.core.io.ByteArrayResource;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.MediaType;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.kh.ttamna.entity.donation.DonationDto;
//import com.kh.ttamna.entity.donation.DonationImgDto;
//import com.kh.ttamna.repository.donation.DonationDao;
//import com.kh.ttamna.repository.donation.DonationImgDao;
//import com.kh.ttamna.service.donation.DonationUploadService;
//import com.kh.ttamna.vo.donation.DonationUploadVo;
//
//@Controller
//@RequestMapping("/donation")
//public class DonationController_backup2 {
//
//	
//	@Autowired
//	private DonationDao donationDao;
//	
//	@Autowired
//	private DonationImgDao donationImgDao;
//	
//	
//	@RequestMapping("/")//목록페이지
//	public String defaultList(Model model) {
//		model.addAttribute("list", donationDao.list());
//		
//		return "donation/list";
//	}
//	@RequestMapping("/list")//목록페이지
//	public String list(Model model) {
//		model.addAttribute("list", donationDao.list());
//		
//		return "donation/list";
//	}
//	
//	@GetMapping("/detail")//상세보기페이지로이동
//	public String detail(@RequestParam int donationNo, Model model) {
//		Map<String, Object> data = new HashMap<>();
//		data.put("donationNo", donationNo);
//		System.out.println("donationNo = "+ donationNo);
//		DonationImgDto donationImgDto = donationImgDao.get(donationNo);
//		model.addAttribute("donationDto", donationDao.detailOrSearch(data));
//		System.out.println("donationImgDto = " + donationImgDto);
//		model.addAttribute("donationImgDto", donationImgDto);
//		return "donation/detail";
//	}
//	
//	@GetMapping("/delete")//삭제요청
//	public String delete(@RequestParam int donationNo) {
//		donationDao.delete(donationNo);
//		
//		return "redirect:/donation/list";
//	}
//	
//	@GetMapping("/edit")//수정페이지로이동
//	public String edit(@RequestParam int donationNo, Model model) {
//		Map<String, Object> data = new HashMap<>();
//		data.put("donationNo", donationNo);
//		model.addAttribute("donationDto", donationDao.detailOrSearch(data));
//		return "donation/edit";
//	}
//	
//	@PostMapping("/edit")//수정요청
//	public String edit(@ModelAttribute DonationDto donationDto) {
//		donationDao.edit(donationDto);
//		
//		return "redirect:/donation/detail?donationNo="+donationDto.getDonationNo();
//	}
//	
//	@GetMapping("/insert")//등록페이지
//	public String insert() {
//		return "donation/insert";
//	}
//	
////	@PostMapping("/insert")//등록요청 - 파일업로드 x버전
////	public String insert(@ModelAttribute DonationDto donationDto) {
////		int donationNo = donationDao.insert(donationDto);
////		
////		return "redirect:/donation/detail?donationNo=" + donationNo;
////	}
//	@Autowired
//	private DonationUploadService donationService;
//	@PostMapping("/insert")//등록요청 - 단일파일업로드
//	public String insert(@ModelAttribute DonationUploadVo donationUploadVo) throws IllegalStateException, IOException {
//		int donationNo = donationService.insert(donationUploadVo);
//		return "redirect:/donation/detail?donationNo=" + donationNo;
//	}
//	
//	//더보기 페이지네이션 기능 처리
//	@GetMapping("/more")
//	@ResponseBody
//	public List<DonationDto> more(
//				@RequestParam(required =false, defaultValue = "1") int page,
//				@RequestParam(required =false, defaultValue = "12") int size
//			){
//		int endRow = page* size;
//		int startRow = endRow - (size - 1);
//		
//		return donationDao.listByPage(startRow, endRow);
//	}
//	
//	//파일 다운로드처리
//	@GetMapping("/donaimg")
//	@ResponseBody
//	public  ResponseEntity<ByteArrayResource> imgFile(@RequestParam int donationNo,
//														@RequestParam int donationImgNo) throws IOException{
//		//donationNo로 파일을 불러온다
//		DonationImgDto donationImgDto = donationImgDao.get(donationNo);
//		
//		//donationImgNo로 실제 파일을 불러온다.
//		byte[] data = donationImgDao.load(donationImgNo);
//		ByteArrayResource resource = new ByteArrayResource(data);
//		
//		String encodeName = URLEncoder.encode(String.valueOf(donationImgDto.getDonationImgNo()), "UTF-8");
//		encodeName = encodeName.replace("+", "%20");
//		
//		return ResponseEntity.ok()
//					//.header("Content-Type", "application/octet-stream")
//					.contentType(MediaType.APPLICATION_OCTET_STREAM)
//					//.header("Content-Disposition", "attachment; filename=\""+이름+"\"")
//					.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
//					//.header("Content-Encoding", "UTF-8")
//					.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
//					//.header("Content-Length", String.valueOf(memberProfileDto.getMemberFileSize()))
//					.contentLength(donationImgDto.getDonationImgSize())
//				.body(resource);
//	}
//}
