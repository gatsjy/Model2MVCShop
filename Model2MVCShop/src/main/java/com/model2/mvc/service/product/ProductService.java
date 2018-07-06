package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;


//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface ProductService {
	
	public void addProduct(Product product) throws Exception ;

	public Product getProduct(int prodNo) throws Exception;
	
	public String getStarFavorite() throws Exception;
	
	public Map<String , Object> getProductList(Search search) throws Exception;
	
	public Map<String , Object> getProductListAjax(Search search) throws Exception;
	
	public Map<String, Object> getReviewList(int prodNo) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	public void updateProductQuantity(Product product) throws Exception;
		
}