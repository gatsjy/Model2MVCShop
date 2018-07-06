package com.model2.mvc.service.cart;

import java.util.List;

import com.model2.mvc.service.domain.Cart;

public interface CartDao {
	
	// 1. ��ٱ��ϸ� �߰��մϴ�.
	public void addCart(Cart cart) throws Exception;
	
	// 2. ��ٱ��� ��ǰ�� Ȯ���մϴ�.
	public int countCart(Cart cart) throws Exception;
	
	// 3. ��ٱ��� ������ �����մϴ�.
	public void updateCart(Cart cart) throws Exception;
	
	// 4. ��ٱ��� �����մϴ�.
	public void deleteCart(int cartNo) throws Exception;
	
	// 5. ��ٱ��� �����մϴ�.
	public void modifyCart(Cart cart) throws Exception;
	
	// 6. ��ٱ��� �ݾ� �հ踦 ���մϴ�.
	public int sumPrice(String buyerId) throws Exception;
	
	// 7. ��ٱ��� ����� �ҷ��ɴϴ�.
	public List<Cart> getCartlist (String buyerId) throws Exception;
	
	// 8. ��ٱ��� �ϳ��� �ҷ��ɴϴ�.
	public Cart getCart (int cartNo) throws Exception;
	
	// 9. ��ٱ��� ��Ͽ��� ���ֱ� ���� �ż���
	public void updatecartCancel(int cartNo) throws Exception;
	
}