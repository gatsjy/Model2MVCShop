package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao{
	
	///Field
		@Autowired
		@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession;
		public void setSqlSession(SqlSession sqlSession) {
			this.sqlSession = sqlSession;
		}
		
		///Constructor
		public PurchaseDaoImpl() {
			System.out.println(this.getClass());
		}

		///Method
		public void addPurchase(Purchase purchase) throws Exception {
			sqlSession.insert("PurchaseMapper.addPurchase", purchase);
		}

		@Override
		public Purchase getPurchase(int tranNo) throws Exception {
			return sqlSession.selectOne("PurchaseMapper.getPurchase",tranNo);
		}

		@Override
		public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception {
			
			Map<String , Object>  map = new HashMap<String, Object>();
			
			map.put("search", search);
			map.put("buyerId", buyerId);
			
			return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
		}
		

		@Override
		public List<Purchase> getCancelPurchaseList(Search search, String buyerId) throws Exception {
			
			Map<String , Object> map = new HashMap<String, Object>();
			
			map.put("search", search);
			map.put("buyerId", buyerId);
			
			return sqlSession.selectList("PurchaseMapper.getCancelPurchaseList",map);
		}
		
		@Override
		public List<Purchase> getSaleList(Search search) throws Exception {
			return sqlSession.selectList("PurchaseMapper.getSaleList",search);
		}
		
		@Override
		public void updatePurchase(Purchase purchase) throws Exception {
			sqlSession.update("PurchaseMapper.updatePurchase",purchase);
		}

		@Override
		public void updateTranCode(Purchase purchase) throws Exception {
			sqlSession.update("PurchaseMapper.updateTranCode",purchase);
		}

		@Override
		public void updateTranCodeByTranNo(Purchase purchase) throws Exception {
			sqlSession.update("PurchaseMapper.updateTranCodeByTranNo",purchase);
		}

		@Override
		public void updateTranCodeByProd(Purchase purchase) throws Exception {
			sqlSession.update("PurchaseMapper.updateTranCodeByProd",purchase);
		}

		@Override
		public int getTotalCount1(String buyerId) throws Exception {
			return sqlSession.selectOne("PurchaseMapper.getTotalCount1", buyerId);
		}

		@Override
		public int getTotalCount2(String buyerId) throws Exception {
			// TODO Auto-generated method stub
			return sqlSession.selectOne("PurchaseMapper.getTotalCount2", buyerId);
		}

		@Override
		public int getTotalCount3(Search search) throws Exception {
			// TODO Auto-generated method stub
			return sqlSession.selectOne("PurchaseMapper.getTotalCount3", search);
		}

		@Override
		public void cancelPurchase(Purchase purchase) throws Exception {
			sqlSession.update("PurchaseMapper.cancelPurchase",purchase);
		}

		@Override
		public void updatePurchaseReview(Purchase purchase) throws Exception {
			sqlSession.update("PurchaseMapper.updatePurchaseReview",purchase);	
		}

		@Override
		public List<Purchase> getPurchaseMap() throws Exception {
			return sqlSession.selectList("PurchaseMapper.getPurchaseMap");
		}

}