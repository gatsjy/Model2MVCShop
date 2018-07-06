package com.model2.mvc.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

public class FavoriteInterceptor extends HandlerInterceptorAdapter {

	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	///Constructor
	public FavoriteInterceptor(){
		System.out.println("\nCommon :: "+this.getClass()+"\n");
	}
	
	///Method
	public boolean preHandle(	HttpServletRequest request,
														HttpServletResponse response, 
														Object handler) throws Exception {
		
		HttpSession session = request.getSession(true);
		session.setAttribute("favoriteStarFile", productService.getStarFavorite());
		
		return true;
	}
}//end of class