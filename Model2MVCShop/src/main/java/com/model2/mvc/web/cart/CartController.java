package com.model2.mvc.web.cart;

import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/cart/*")
public class CartController {
	
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
	public CartController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addCart", method=RequestMethod.GET)
	public ModelAndView addPurchase(@RequestParam("prodNo") int prodNo) throws Exception{

		System.out.println("/addCartView.jsp");
		
		Product product = productService.getProduct(prodNo);
		
		System.out.println("product : "+product );
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/cart/addCartView.jsp");
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}
	
	@RequestMapping(value="addCart" , method=RequestMethod.POST)
	public ModelAndView addCart( 			  @ModelAttribute("cart") Cart cart,
																		  @ModelAttribute("product") Product product,	  
																		  @RequestParam("buyerId") String buyerId,
																		  @RequestParam("cartQuantity") int cartQuantity,
																		  @RequestParam("productQuantity") int productQuantity,
																		  @RequestParam("prodNo") int prodNo,
																		  @RequestParam("price") int price,
																		  @RequestParam("prodName") String prodName,
																		  HttpSession session) throws Exception {

		System.out.println("/addCart");
		
		//Business Logic
		cart.setCartProd(productService.getProduct(prodNo));
		cart.setBuyer(userService.getUser(buyerId));
		cart.setCartPrice(cartQuantity*price);
		cart.setCartQuantity(cartQuantity);
		cart.setProdName(prodName);
		cart.setProdPrice(price);
		
		//장바구니에 기존 상품이 있는지 검사
		if ( cartService.countCart(cart) == 1) {
			cartService.updateCart(cart);
		} else {
			cartService.addCart(cart);
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/cart/addCart.jsp");
		modelAndView.addObject("cart", cart);
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}
	
	@RequestMapping(value="listCart")
	public String listCart( Model model , HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/listCart");
		
		// 세션을 통해서 유저 아이디를 가져옵니다.
		User user =(User) session.getAttribute("user");
		String buyerId = user.getUserId();
		
		// Business logic 수행
		List<Cart> list = cartService.getCartlist(buyerId);
				
		// 전체 장바구니 금액을 불러오는 메소드
		int sumPrice = cartService.sumPrice(buyerId);
		
		// 장바구니 전체 금액에 따라서 배송비를 구분해주는 비즈니스로직
		// 전체 구매 금액이 7만원 이상이면 배송비가 2500원이 붙습니다.
		int fee = sumPrice >= 70000 ? 0 : 2500;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("count", list.size());
		map.put("sumPrice", sumPrice);
		map.put("fee", fee);
		map.put("allSum", sumPrice+fee);
		
		// Model 과 View 연결
		model.addAttribute("map", map);
		model.addAttribute("list", list);
		
		return "forward:/cart/listCart.jsp";
	}
	
	@RequestMapping(value="deleteCart")
	public String deleteCart(Model model, HttpSession session, @RequestParam("cartNo") int cartNo) throws Exception{
		
		System.out.println("/deleteCart");
		
		cartService.deleteCart(cartNo);
		
		return "forward:/cart/listCart";
	}
	
	@RequestMapping(value="modifyCart")
	public String modifyCart(Model model, HttpSession session,
													@RequestParam("prodNo") int[] prodNo,
													@RequestParam("cartQuantity") int[] cartQuantity,
													@RequestParam("modifyPrice") int[] modifyPrice) throws Exception{
		
		System.out.println("/modifyCart");
		
		// 세션을 통해서 유저 아이디를 가져옵니다.
		User user =(User) session.getAttribute("user");
		String userId = user.getUserId();
		
		// 레코드의 갯수 만큼 반복문을 실행
		for ( int i = 0; i<prodNo.length; i++) {
			Cart cart = new Cart();
			cart.setBuyer(userService.getUser(userId));
			cart.setCartQuantity(cartQuantity[i]);
			cart.setCartProd(productService.getProduct(prodNo[i]));
			cart.setCartPrice(modifyPrice[i]);
			cartService.modifyCart(cart);
		}
		
		return "forward:/cart/listCart";
	}
	
	@RequestMapping(value="addPurchaseCartView")
	public String addPurchaseCartView(Model model, HttpSession session, 
																		@RequestParam("prodNo") int[] prodNo,
																		@RequestParam("cartNo") int[] cartNo,
																		@RequestParam("prodName") String[] prodName,
																		@RequestParam("allSum") int allSum) throws Exception{
		
		// 다중 구매를 위해서 아이디를 보여주는 란을 마련합니다.
		String prodNos = "";
		String prodNames ="";
		String cartNos ="";
		for(int i = 0 ; i<prodNo.length; i++) {
			prodNos += (i<prodNo.length-1 ? prodNo[i]+"," : prodNo[i] );
			prodNames += (i<prodNo.length-1 ? prodName[i]+"," : prodName[i] );
			cartNos += (i<prodNo.length-1 ? cartNo[i]+"," : cartNo[i] );
		}
		
		// Model 과 View 연결
		model.addAttribute("prodNo", prodNos);
		model.addAttribute("prodName", prodNames);
		model.addAttribute("cartNo", cartNos);
		model.addAttribute("price", allSum);
		
		return "forward:/cart/addPurchaseCartView.jsp";
	}
}