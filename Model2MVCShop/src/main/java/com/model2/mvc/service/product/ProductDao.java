package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDao {
	
	// INSERT
	public void addProduct(Product product) throws Exception ;

	// SELECT ONE
	public Product getProduct(int prodNo) throws Exception ;
	
	// SELECT ONE
	public String getStarFavorite() throws Exception;

	// SELECT LIST
	public List<Product> getProductList(Search search) throws Exception;
	
	// SELECT LIST
	public List<Product> getReviewList(int prodNo) throws Exception;
	
	// product에서 Ajax를 쓰기 위한 데이터
	public List<Product> getProductListAjax(Search search) throws Exception;

	// UPDATE
	public void updateProduct(Product product) throws Exception ;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
	// 상품수량 변경
	public void updateProductQuantity(Product product) throws Exception;
	
}