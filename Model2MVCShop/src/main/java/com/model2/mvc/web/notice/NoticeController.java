package com.model2.mvc.web.notice;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Notice;
import com.model2.mvc.service.notice.NoticeService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	///Field
	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService noticeService;
	//setter Method 구현 않음
		
	public NoticeController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping(value="addNotice" , method=RequestMethod.POST)
	public String addNotice( @ModelAttribute("notice") Notice notice,
													@RequestParam("file") MultipartFile multipartFile) throws Exception {

		System.out.println("/addNotice.do");
		
		// 파일명 얻기
		String fileName = multipartFile.getOriginalFilename();
		
		// 파일 객체 생성
		File file = new File("C:\\workspace\\Model2MVCShop\\WebContent\\images\\uploadFiles\\"+fileName);
		multipartFile.transferTo(file);
		
		//Business Logic
		notice.setFileName(fileName);
		noticeService.addNotice(notice);
		
		return "forward:/notice/listNotice";
	}
	
	//@RequestMapping("/listNotice.do")
	@RequestMapping(value="listNotice")
	public String listNotice( @ModelAttribute("search") Search search ,
												Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listNoticedo.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=noticeService.getNoticeList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/notice/listNotice.jsp";
	}
	
	//@RequestMapping("/getNotice.do")
	@RequestMapping(value="getNotice", method=RequestMethod.GET)
	public String getUser( @RequestParam("noticeNo") int noticeNo , Model model, HttpServletRequest request ) throws Exception {
		
		System.out.println("/getNotice.do");
		
		//Business Logic
		Notice notice = noticeService.getNotice(noticeNo);
		
		notice.setNoticeHits(notice.getNoticeHits()+1);
		
		noticeService.updateNoticeHits(notice);
		
		// Model 과 View 연결
		model.addAttribute("notice", notice);
		
		return "forward:/notice/getNotice.jsp";
	}
	
	//@RequestMapping("/updateNoticeView.do")
	@RequestMapping(value="updateNotice", method=RequestMethod.GET)
	public String updateNotice(  @RequestParam("noticeNo") int noticeNo , Model model ) throws Exception{

		System.out.println("/notice/updateNotice");

		//Business Logic
		Notice notice = noticeService.getNotice(noticeNo);
		
		// Model 과 View 연결
		model.addAttribute("notice", notice);
		
		return "forward:/notice/updateNotice.jsp";
	}

	//@RequestMapping("/updateNotice.do")
	@RequestMapping(value="updateNotice", method=RequestMethod.POST)
	public String updateNotice( @ModelAttribute("notice") Notice notice
																																			) throws Exception{

		System.out.println("/updateNotice.do");
		
		//Business Logic
		noticeService.updateNotice(notice);
		
		
		return "redirect:/notice/listNotice?noticeNo="+notice.getNoticeNo();
	}
}