package com.model2.mvc.service.cart;

import java.util.List;

import com.model2.mvc.service.domain.Cart;

public interface CartDao {
	
	// 1. 장바구니를 추가합니다.
	public void addCart(Cart cart) throws Exception;
	
	// 2. 장바구니 상품을 확인합니다.
	public int countCart(Cart cart) throws Exception;
	
	// 3. 장바구니 수량을 변경합니다.
	public void updateCart(Cart cart) throws Exception;
	
	// 4. 장바구니 삭제합니다.
	public void deleteCart(int cartNo) throws Exception;
	
	// 5. 장바구니 수정합니다.
	public void modifyCart(Cart cart) throws Exception;
	
	// 6. 장바구니 금액 합계를 구합니다.
	public int sumPrice(String buyerId) throws Exception;
	
	// 7. 장바구니 목록을 불러옵니다.
	public List<Cart> getCartlist (String buyerId) throws Exception;
	
	// 8. 장바구니 하나를 불러옵니다.
	public Cart getCart (int cartNo) throws Exception;
	
	// 9. 장바구니 목록에서 없애기 위한 매서드
	public void updatecartCancel(int cartNo) throws Exception;
	
}