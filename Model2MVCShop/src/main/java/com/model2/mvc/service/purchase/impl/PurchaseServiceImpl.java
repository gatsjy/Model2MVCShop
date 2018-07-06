package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{
	
	///Field
	@Autowired
	@Qualifier("purchaseDaoImpl")//타입외의 정보를 추가해서 자동와이어링을 세밀하게 제어할 수 있는 방식
	
	///Constructor
	private PurchaseDao purchaseDao;
	
	///Method
	public void setpurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao=purchaseDao;
	}
	
	///Constructor
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}
	
	public void addPurchase(Purchase purchase) throws Exception {
		purchaseDao.addPurchase(purchase);
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDao.getPurchase(tranNo);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", purchaseDao.getPurchaseList(search, buyerId));
		map.put("totalCount", purchaseDao.getTotalCount1(buyerId));
		
		return map;
	}
	
	@Override
	public Map<String, Object> getCancelPurchaseList(Search search, String buyerId) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", purchaseDao.getCancelPurchaseList(search, buyerId));
		map.put("totalCount", purchaseDao.getTotalCount2(buyerId));
		
		return map;
	}

	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", purchaseDao.getSaleList(search));
		map.put("totalCount",	purchaseDao.getTotalCount3(search));
		
		return map;
	}
	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}
	
	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
	}

	@Override
	public void updateTranCodeByTranNo(Purchase purchase) throws Exception {
		purchaseDao.updateTranCodeByTranNo(purchase);
		
	}

	@Override
	public void updateTranCodeByProd(Purchase purchase) throws Exception {
		purchaseDao.updateTranCodeByProd(purchase);
	}

	@Override
	public void cancelPurchase(Purchase purchase) throws Exception {
		purchaseDao.cancelPurchase(purchase);
	}

	@Override
	public void updatePurchaseReview(Purchase purchase) throws Exception {
		purchaseDao.updatePurchaseReview(purchase);
	}

	@Override
	public List<Purchase> getPurchaseMap() throws Exception {
		return purchaseDao.getPurchaseMap();
	}

}
