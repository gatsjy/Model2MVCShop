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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@RestController
@RequestMapping("/cart/*")
public class CartRestController {
	
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
	public CartRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/modifyCart/{prodNo}/{cartQuantity}/{prodPrice}", method=RequestMethod.GET)
	public Map modifyCart(HttpSession session,
												@PathVariable int prodNo,
												@PathVariable int cartQuantity,
												@PathVariable int prodPrice
											) throws Exception{
		
		System.out.println("/modifyCart");
		
		System.out.println(prodNo);
		
		System.out.println(cartQuantity);
		
		System.out.println(prodPrice);

		// 변경된 상품가격을 계산합니다.
		int cartPrice = prodPrice * cartQuantity;
		
		System.out.println(cartPrice);
		
		// 세션을 통해서 유저 아이디를 가져옵니다.
		User user =(User) session.getAttribute("user");
		String userId = user.getUserId();
		
		// 상품값과 수량을 바꿔주기 위한 메소드
		Cart cart = new Cart();
		cart.setBuyer(userService.getUser(userId));
		cart.setCartProd(productService.getProduct(prodNo));
		cart.setCartQuantity(cartQuantity);
		cart.setCartPrice(cartPrice);
		
		cartService.modifyCart(cart);
		
		// 전체 물품 가격을 변화 시켜주기 위한 메서드
		int sumPrice = cartService.sumPrice(userId); 
		
		// 장바구니 전체 금액에 따라서 배송비를 구분해주는 비즈니스로직
		// 전체 구매 금액이 7만원 이상이면 배송비가 2500원이 붙습니다.
		int fee = sumPrice >= 70000 ? 0 : 2500;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sumPrice", sumPrice);
		map.put("fee", fee);
		map.put("allSum", sumPrice+fee);
		map.put("cart", cart);
		
		return map;
	}
}