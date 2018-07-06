package com.model2.mvc.service.reply.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Reply;
import com.model2.mvc.service.reply.ReplyDao;


@Repository("replyDaoImpl")
public class ReplyDaoImpl implements ReplyDao{
	
		///Field
		@Autowired
		@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession;
		public void setSqlSession(SqlSession sqlSession) {
			this.sqlSession = sqlSession;
		}
		
		///Constructor
		public ReplyDaoImpl() {
			System.out.println(this.getClass());
		}

		@Override
		public List<Reply> getReplyList(int noticeNo) throws Exception {
			return sqlSession.selectList("ReplyMapper.getReplyList", noticeNo);
		}

		@Override
		public void addReply(Reply reply) throws Exception {
			sqlSession.insert("ReplyMapper.addReply", reply);
		}

		@Override
		public void updateReply(Reply reply) throws Exception {
			sqlSession.update("ReplyMapper.updateReply", reply);
		}

		@Override
		public void deleteReply(int replyNo) throws Exception {
			sqlSession.delete("ReplyMapper.deleteReply",replyNo);
		}

		@Override
		public int getTotalCount(int noticeNo) throws Exception {
			return sqlSession.selectOne("ReplyMapper.getTotalCount", noticeNo);
		}	
}