package com.model2.mvc.web.product;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

//==> 상품관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST)
	public Product AddProduct ( @RequestBody Product product ) throws Exception{
		
		System.out.println("product/json/AddProduct/ : POST");
		
		//Business Logic
		productService.addProduct(product);
		
		return productService.getProduct(product.getProdNo());
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Product getProduct ( @PathVariable int prodNo ) throws Exception{
		
		System.out.println("product/json/getProduct/ : GET");
		
		//Business Logic
		return productService.getProduct(prodNo);
	}																	

	@RequestMapping( value="json/listProduct")
	public Map listProduct(@RequestBody Search search) throws Exception{
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST)
	public Product updateUser ( @RequestBody Product product) throws Exception{
		
		System.out.println("user/json/updateProduct : POST");
		
		//Business Logic
		productService.updateProduct(product);
		
		return productService.getProduct(product.getProdNo());
	}
	
	@RequestMapping( value="json/listProductAjax")
	public Map listProductAjax(@RequestBody Search search) throws Exception{
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
			
		map.put("list", map.get("list"));
		map.put("search", search);
		
		return map;
	}
}