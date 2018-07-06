package com.model2.mvc.service.cart.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;

@Service("cartServiceImpl")
public class CartServiceImpl implements CartService{
	
	///Field
	@Autowired
	@Qualifier("cartDaoImpl")//타입외의 정보를 추가해서 자동와이어링을 세밀하게 제어할 수 있는 방식
	
	///Constructor
	private CartDao cartDao;
	
	///Method
	public void setcartDao(CartDao cartDao) {
		this.cartDao=cartDao;
	}
	
	///Constructor
	public CartServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addCart(Cart cart) throws Exception {
		cartDao.addCart(cart);
	}

	@Override
	public int countCart(Cart cart) throws Exception {
		return cartDao.countCart(cart);
	}

	@Override
	public void updateCart(Cart cart) throws Exception {
		cartDao.updateCart(cart);
	}

	@Override
	public void deleteCart(int cartNo) throws Exception {
		cartDao.deleteCart(cartNo);
	}

	@Override
	public void modifyCart(Cart cart) throws Exception {
		cartDao.modifyCart(cart);
	}

	@Override
	public int sumPrice(String buyerId) throws Exception {
		return cartDao.sumPrice(buyerId);
	}

	@Override
	public List<Cart> getCartlist(String buyerId) throws Exception {
		return cartDao.getCartlist(buyerId);
	}

	@Override
	public Cart getCart(int cartNo) throws Exception {
		return cartDao.getCart(cartNo);
	}

	@Override
	public void updatecartCancel(int cartNo) throws Exception {
		cartDao.updatecartCancel(cartNo);
	}

}
