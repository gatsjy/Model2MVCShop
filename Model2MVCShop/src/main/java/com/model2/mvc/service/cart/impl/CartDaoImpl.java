package com.model2.mvc.service.cart.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.domain.Cart;


@Repository("cartDaoImpl")
public class CartDaoImpl implements CartDao{
	
		///Field
		@Autowired
		@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession;
		public void setSqlSession(SqlSession sqlSession) {
			this.sqlSession = sqlSession;
		}
		
		///Constructor
		public CartDaoImpl() {
			System.out.println(this.getClass());
		}

		@Override
		public void addCart(Cart cart) throws Exception {
			sqlSession.insert("CartMapper.addCart", cart);
		}

		@Override
		public int countCart(Cart cart) throws Exception {
			return sqlSession.selectOne("CartMapper.countCart", cart);
		}

		@Override
		public void updateCart(Cart cart) throws Exception {
			sqlSession.update("CartMapper.updateCart",cart);
			
		}

		@Override
		public void deleteCart(int cartNo) throws Exception {
			sqlSession.delete("CartMapper.deleteCart", cartNo);
			
		}

		@Override
		public void modifyCart(Cart cart) throws Exception {
			sqlSession.update("CartMapper.modifyCart", cart);
		}

		@Override
		public int sumPrice(String buyerId) throws Exception {
			return sqlSession.selectOne("CartMapper.sumPrice", buyerId);
		}

		@Override
		public List<Cart> getCartlist(String buyerId) throws Exception {
			return sqlSession.selectList("CartMapper.getCartlist", buyerId);
		}

		@Override
		public Cart getCart(int cartNo) throws Exception {
			return sqlSession.selectOne("CartMapper.getCart", cartNo);
		}

		@Override
		public void updatecartCancel(int cartNo) throws Exception {
			sqlSession.update("CartMapper.updatecartCancel", cartNo);	
		}	
		
}