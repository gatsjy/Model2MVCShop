package com.model2.mvc.web.product;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

//==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
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
	
	@RequestMapping( value="addProduct", method = RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, 
													  @RequestParam("file") MultipartFile multipartFile,
														HttpServletRequest request) throws Exception {

		// 파일명 얻기
		String fileName = multipartFile.getOriginalFilename();
		
		// 파일 객체 생성
		File file = new File("C:\\workspace\\Model2MVCShop\\WebContent\\images\\uploadFiles\\"+fileName);
		
		multipartFile.transferTo(file);
		System.out.println("/addProduct.do");
		
		//Business Logic
		product.setFileName(fileName);
		productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listProduct.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		if(search.getSearchSorting()==null) {
			search.setSearchSorting("0");
		} else {
			search.setSearchSorting(request.getParameter("searchSorting"));
		}

		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct" , method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model, HttpServletRequest request ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		System.out.println("나여기있다.");
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
		Map<String , Object> map=productService.getReviewList(prodNo);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		model.addAttribute("reviewlist", map.get("reviewlist"));
		
		return "forward:/product/getProduct.jsp";
	}
	
	//@RequestMapping("/updateProductView.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateUserView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateProduct : GET");

		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping( value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product , 
															@ModelAttribute("user") User user ,
															Model model , HttpSession session) throws Exception{

		System.out.println("/product/updateProduct : POST");
		//Business Logic
		productService.updateProduct(product);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo();
	}
}