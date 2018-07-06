package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;

public interface PurchaseDao {
	
	public void addPurchase(Purchase purchase) throws Exception ;
	
	public Purchase getPurchase(int tranNo) throws Exception;
	
	public List<Purchase> getPurchaseList(Search search,String buyerId) throws Exception;
	
	public List<Purchase> getCancelPurchaseList(Search search, String buyerId) throws Exception;
	
	public List<Purchase> getSaleList(Search search) throws Exception;
	
	public int getTotalCount1(String buyerId) throws Exception;
	
	public int getTotalCount2(String buyerId) throws Exception;
	
	public int getTotalCount3(Search search) throws Exception;
	
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	public void updateTranCodeByTranNo(Purchase purchase) throws Exception;
	
	public void updateTranCodeByProd(Purchase purchase) throws Exception;
	
	public void cancelPurchase(Purchase purchase) throws Exception;
	
	public void updatePurchaseReview(Purchase purchase) throws Exception;
	
	public List<Purchase> getPurchaseMap() throws Exception;
}