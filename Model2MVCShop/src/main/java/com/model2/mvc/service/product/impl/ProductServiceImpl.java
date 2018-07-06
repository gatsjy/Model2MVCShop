package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 서비스 구현
@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{
	
	///Field
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	///Constructor
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}
	
	///Method
	public void setUserDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	///Method
	public void addProduct(Product product) throws Exception {
		productDao.addProduct(product);
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		return productDao.getProduct(prodNo);
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
	
		List<Product> list= productDao.getProductList(search);
		
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return productDao.getTotalCount(search);
	}

	@Override
	public void updateProductQuantity(Product product) throws Exception {
		productDao.updateProductQuantity(product);
	}

	@Override
	public Map<String, Object> getReviewList(int prodNo) throws Exception {
		
		List<Product> reviewlist = productDao.getReviewList(prodNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reviewlist", reviewlist);
		
		return map;
	}

	@Override
	public String getStarFavorite() throws Exception {
		return productDao.getStarFavorite();
	}

	@Override
	public Map<String, Object> getProductListAjax(Search search) throws Exception {
		
		List<Product> list= productDao.getProductListAjax(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		
		return map;
	}

}