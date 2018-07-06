package com.model2.mvc.web.notice;

import java.io.File;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Notice;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.notice.NoticeService;

//==> 회원관리 Controller
@RestController
@RequestMapping("/notice/*")
public class NoticeRestController {
	
	///Field
	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService noticeService;
	//setter Method 구현 않음
		
	public NoticeRestController(){
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
	
	@RequestMapping( value="json/AddNoticeImage", method=RequestMethod.POST)
	public Iterator<String> AddNoticeImage ( MultipartHttpServletRequest req ) throws Exception{
		
		System.out.println("notice/json/addNoticeImage : POST");
		
		// 파일 객체 생성
		
		
		return null;
	}
	
	@RequestMapping( value="json/summerNote", method=RequestMethod.POST)
	public String  summerNote ( @RequestParam("file") MultipartFile multipartFile ) throws Exception{
		System.out.println("notice/json/addNoticeImage : POST");
		
		// 파일명 생성
		String fileName = multipartFile.getOriginalFilename();
		
		// 파일 객체 생성
		File file = new File("C:\\workspace\\Model2MVCShop\\WebContent\\images\\uploadFiles\\"+fileName);
		multipartFile.transferTo(file);
		
		return null;
	}

}