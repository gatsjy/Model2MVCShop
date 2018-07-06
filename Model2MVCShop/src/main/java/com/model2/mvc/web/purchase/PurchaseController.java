package com.model2.mvc.web.purchase;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;



//==> 회원관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	//setter Method 구현 않음
	public PurchaseController(){
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
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public ModelAndView addPurchase(@RequestParam("prodNo") int prodNo) throws Exception{

		System.out.println("/addPurchaseView.jsp");
		
		Product product = productService.getProduct(prodNo);
		
		System.out.println("product : "+product );
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/addPurchaseView.jsp");
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}
	
	@RequestMapping(value="addPurchase" , method=RequestMethod.POST)
	public ModelAndView addPurchase( @ModelAttribute("purchase") Purchase purchase,
																		  @ModelAttribute("product") Product product,
																		  @RequestParam("buyerId") String buyerId,
																		  @RequestParam("purchaseQuantity") int purchaseQuantity,
																		  @RequestParam("productQuantity") int productQuantity,
																		  @RequestParam("prodNo") int prodNo,
																		  @RequestParam("price") int price,
																		  @RequestParam("lat") String lat,
																		  @RequestParam("lng") String lng) throws Exception {

		System.out.println("/addPurchase");
		
		//Business Logic
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setBuyer(userService.getUser(buyerId));
		purchase.setPurchasePrice(purchaseQuantity*price);
		purchase.setLat(lat);
		purchase.setLng(lng);
		
		//다른로직
		product.setProdNo(prodNo);
		product.setProdQuantity(productQuantity-purchaseQuantity);
		
		purchaseService.addPurchase(purchase);
		productService.updateProductQuantity(product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/addPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}
	
	///장바구니 구매를 위한 로직
	@RequestMapping(value="addCartPurchase" , method=RequestMethod.POST)
	public ModelAndView addCartPurchase(
																				 @RequestParam("cartNo") String cartNo,
																		  		 @RequestParam("buyerId") String buyerId,
																		  		 @RequestParam("price") int price,
																		  		 @RequestParam("prodNo") String prodNo,
																		  		 @RequestParam("divyAddr") String divyAddr,
																		  	 	 @RequestParam("divyRequest") String divyRequest,
																		  		 @RequestParam("divyDate") String divyDate,
																				 @RequestParam("receiverPhone") String receiverPhone,
																				 @RequestParam("receiverName") String receiverName,
																				 @RequestParam("paymentOption") String paymentOption,
																				 @RequestParam("lat") String lat,
																				  @RequestParam("lng") String lng) throws Exception {

		System.out.println("/addCartPurchase");
		
		String[] prodNos = prodNo.split(",");
		String[] cartNos = cartNo.split(",");

		//구매를 장바구니의 수 만큼 실시한다.
		for ( int i = 0 ; i <prodNos.length ; i++) {
			/// Business Logic 1 cart
			Cart cart = cartService.getCart(Integer.parseInt(cartNos[i]));
			cartService.updatecartCancel(Integer.parseInt(cartNos[i]));
			
			/// Business Logic 2 purchase
			Purchase purchase = new Purchase();
			purchase.setPurchaseProd(productService.getProduct(Integer.parseInt(prodNos[i])));
			purchase.setBuyer(userService.getUser(buyerId));
			purchase.setPurchasePrice(cart.getCartQuantity()*price);
			purchase.setDivyAddr(divyAddr);
			purchase.setDivyDate(divyDate);
			purchase.setDivyRequest(divyRequest);
			purchase.setPurchaseQuantity(cart.getCartQuantity());
			purchase.setPaymentOption(paymentOption);
			purchase.setReceiverName(receiverName);
			purchase.setReceiverPhone(receiverPhone);
			purchase.setBuyer(userService.getUser(buyerId));
			purchase.setLat(lat);
			purchase.setLng(lng);
			
			/// Business Logic 3 product
			Product product = new Product();
			product.setProdNo(Integer.parseInt(prodNos[i]));
			product.setProdQuantity(productService.getProduct(Integer.parseInt(prodNos[i])).getProdQuantity()-cart.getCartQuantity());
			
			purchaseService.addPurchase(purchase);
		}
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/cart/addPurchase.jsp");

		return modelAndView;
	}
	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping(value="listPurchase")
	public ModelAndView listPurchase( @ModelAttribute("search") Search search, HttpSession session) throws Exception{
		
		System.out.println("/listPurchase.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// userId를 가져오기위한 user Session을 가져옵니다.
		User user = (User)session.getAttribute("user"); 
		
		// Business logic 수행
		Map<String , Object> map=purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public ModelAndView getPurchase( @RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("/getPurchase.do");
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public ModelAndView updateUserView( @RequestParam("tranNo") int tranNo ) throws Exception{

		System.out.println("/purchase/updateProduct : GET");

		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/updatePurchase.jsp");
		modelAndView.addObject("purchase", purchase);
				
		return modelAndView;
	}
	
	//@RequestMapping("/updatePurchase.do")
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public ModelAndView updateProduct( @RequestParam("tranNo") int tranNo,
																			@ModelAttribute("purchase") Purchase purchase , 
																			HttpSession session) throws Exception{

		System.out.println("/purchase/updateProduct : POST");
		
		//Business Logic
		purchaseService.updatePurchase(purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/getPurchase?tranNo="+tranNo);
		modelAndView.addObject("purchase", purchase);
				
		return modelAndView;
		}
	
	//@RequestMapping("/cancelPurchase.do")
	@RequestMapping(value= "cancelPurchase" , method=RequestMethod.GET)
	public ModelAndView cancelPurchase( @RequestParam("tranNo") int tranNo,
																			   @RequestParam("prodNo") int prodNo,
																			   @RequestParam("purchaseQuantity") int purchaseQuantity,
																			   @ModelAttribute("purchase") Purchase purchase, 
																			   @ModelAttribute("product") Product product,
																			HttpSession session) throws Exception{

		System.out.println("/purchase/cancelPurchase");
		
		//Business Logic
		purchase.setTranNo(tranNo);
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		
		int prodQuantity = productService.getProduct(prodNo).getProdQuantity();
		int currentQuantity = purchaseQuantity+prodQuantity;
		product.setProdQuantity(currentQuantity);
		product.setProdNo(prodNo);
		
		//Business Logic 실행
		purchaseService.cancelPurchase(purchase);
		productService.updateProductQuantity(product);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/listPurchase");
				
		return modelAndView;
		}
	
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping(value="updateTranCode",method=RequestMethod.GET)
	public ModelAndView updateTranCode( @RequestParam("tranNo") int tranNo,
																				@RequestParam("tranCode") int tranCode,
																				@ModelAttribute("purchase") Purchase purchase) throws Exception{

		System.out.println("/updateTranCode.do");
		
		//Business Logic
		purchase = purchaseService.getPurchase(tranNo);
		purchaseService.updateTranCode(purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/listPurchase");
				
		return modelAndView;
		}
	
	//@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping(value="updateTranCodeByProd",method=RequestMethod.GET)
	public ModelAndView updateTranCodeByProd( @RequestParam("prodNo") int prodNo,
																				@RequestParam("tranCode") int tranCode,
																				@ModelAttribute("purchase") Purchase purchase) throws Exception{

		System.out.println("/updateTranCodeByProd.do");
		
		//Business Logic
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchaseService.updateTranCodeByProd(purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("redirect:/purchase/listProduct?menu=manage");
				
		return modelAndView;
		}
	
	//@RequestMapping("/updateTranCodeByTranNo.do")
	@RequestMapping(value="updateTranCodeByTranNo",method=RequestMethod.GET)
	public ModelAndView updateTranCodeByTranNo( @RequestParam("tranNo") int tranNo,
																												@RequestParam("tranCode") int tranCode,
																												@ModelAttribute("purchase") Purchase purchase) throws Exception{

		System.out.println("/updateTranCodeByTranNoAction.do");
		
		//Business Logic
		purchase = purchaseService.getPurchase(tranNo);
		purchaseService.updateTranCodeByTranNo(purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/listSale");
				
		return modelAndView;
		}
	
	//@RequestMapping("/listSale.do")
	@RequestMapping(value="listSale")
	public ModelAndView listSale( @ModelAttribute("search") Search search) throws Exception{
		
		System.out.println("/listSale.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String , Object> map=purchaseService.getSaleList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/listSale.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	//@RequestMapping("/listCancelPurchase.do")
	@RequestMapping(value="listCancelPurchase")
	public ModelAndView listCancelPurchase( @ModelAttribute("search") Search search,
																					  HttpSession session) throws Exception{
		
		System.out.println("/listSale.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// userId를 가져오기위한 user Session을 가져옵니다.
		User user = (User)session.getAttribute("user");
		
		// Business logic 수행
		Map<String , Object> map=purchaseService.getCancelPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/listCancelPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	//@RequestMapping("/updatePurchaseReviewView.do")
	@RequestMapping(value="updatePurchaseReview",method=RequestMethod.GET)
	public ModelAndView updatePurchaseReview( @RequestParam("tranNo") int tranNo ) throws Exception{

		System.out.println("/updatePurchaseReview.do");

		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/addPurchaseReviewView.jsp");
		modelAndView.addObject("purchase", purchase);
				
		return modelAndView;
	}
	
	@RequestMapping(value="updatePurchaseReview",method=RequestMethod.POST)
	public ModelAndView updatePurchaseReview( @RequestParam("tranNo") int tranNo,
																							  @RequestParam("star") int star,
			 																                  @RequestParam("review") String review,
			 																                  @ModelAttribute("purchase") Purchase purchase,
																			                   HttpSession session) throws Exception{

		System.out.println("/updatePurchaseReview.do");
		
		//Business Logic
		purchaseService.updatePurchaseReview(purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/listPurchase");
		modelAndView.addObject("purchase", purchase);
				
		return modelAndView;
		}
	
	@RequestMapping(value="listMap" , method=RequestMethod.GET)
	public ModelAndView listMap(ModelAndView modelAndView) throws Exception{

		System.out.println("/listMap");
		
		String clientId = "gbioRljnMrgAiSBccTco";
		String clientSecret = "DsSfeMshDg";
		
		try {
			String addr = URLEncoder.encode("한강 편의점","UTF-8");
			String apiURL = "https://openapi.naver.com/v1/search/local?query=" + addr;
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
	        con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode==200) { //정상호출
	        	br = new BufferedReader(new InputStreamReader(con.getInputStream() , "UTF-8"));
	        } else { //에러발생
	        	br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = br.readLine()) != null)  {
	        	response.append(inputLine);
	        }
	        JSONParser parser = new JSONParser();
	        JSONObject a = (JSONObject)parser.parse(response.toString());
	        System.out.println("a : "+a);
	        
	        br.close();
	        
	        
		// Model 과 View 연결
		modelAndView.setViewName("forward:/purchase/listMap.jsp");
		modelAndView.addObject("purchase", purchaseService.getPurchaseMap());
		modelAndView.addObject("a", a);
		
		return modelAndView;
		} catch( Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	/*@RequestMapping(value="listMap" , method=RequestMethod.GET)
	public ModelAndView listMap(ModelAndView modelAndView) throws Exception{

		System.out.println("/listMap");
		
		String clientId = "gbioRljnMrgAiSBccTco";
		String clientSecret = "DsSfeMshDg";
		
		try {
			String addr = URLEncoder.encode("한강 공원","UTF-8");
			String apiURL = "https://openapi.naver.com/v1/search/local?query=" + addr;
			//String apiURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.494541,127.02758300000005&radius=111&type=restaurant&key=AIzaSyDprTpTKP9yY2_xLHqvY35HqJwIcqCP264";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
	        con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode==200) { //정상호출
	        	br = new BufferedReader(new InputStreamReader(con.getInputStream() , "UTF-8"));
	        } else { //에러발생
	        	br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = br.readLine()) != null)  {
	        	response.append(inputLine);
	        }
	        JSONParser parser = new JSONParser();
	        JSONObject json = (JSONObject)parser.parse(response.toString());
	        
	        System.out.println("json : "+json);
	        
	        br.close();
	        
		// Model 과 View 연결
		modelAndView.setViewName("forward:/purchase/listMap.jsp");
		modelAndView.addObject("purchase", purchaseService.getPurchaseMap());
		modelAndView.addObject("json", json);
		
		return modelAndView;
		} catch( Exception e) {
			System.out.println(e);
		}
		return null;
	}*/
}