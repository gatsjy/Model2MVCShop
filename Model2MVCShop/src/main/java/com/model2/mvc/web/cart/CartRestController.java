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

//==> ȸ������ Controller
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
	
	
	//setter Method ���� ����
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

		// ����� ��ǰ������ ����մϴ�.
		int cartPrice = prodPrice * cartQuantity;
		
		System.out.println(cartPrice);
		
		// ������ ���ؼ� ���� ���̵� �����ɴϴ�.
		User user =(User) session.getAttribute("user");
		String userId = user.getUserId();
		
		// ��ǰ���� ������ �ٲ��ֱ� ���� �޼ҵ�
		Cart cart = new Cart();
		cart.setBuyer(userService.getUser(userId));
		cart.setCartProd(productService.getProduct(prodNo));
		cart.setCartQuantity(cartQuantity);
		cart.setCartPrice(cartPrice);
		
		cartService.modifyCart(cart);
		
		// ��ü ��ǰ ������ ��ȭ �����ֱ� ���� �޼���
		int sumPrice = cartService.sumPrice(userId); 
		
		// ��ٱ��� ��ü �ݾ׿� ���� ��ۺ� �������ִ� ����Ͻ�����
		// ��ü ���� �ݾ��� 7���� �̻��̸� ��ۺ� 2500���� �ٽ��ϴ�.
		int fee = sumPrice >= 70000 ? 0 : 2500;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sumPrice", sumPrice);
		map.put("fee", fee);
		map.put("allSum", sumPrice+fee);
		map.put("cart", cart);
		
		return map;
	}
}