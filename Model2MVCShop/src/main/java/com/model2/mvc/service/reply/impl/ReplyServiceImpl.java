package com.model2.mvc.service.reply.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Reply;
import com.model2.mvc.service.reply.ReplyDao;
import com.model2.mvc.service.reply.ReplyService;

@Service("replyServiceImpl")
public class ReplyServiceImpl implements ReplyService{
	
	///Field
	@Autowired
	@Qualifier("replyDaoImpl")//타입외의 정보를 추가해서 자동와이어링을 세밀하게 제어할 수 있는 방식
	
	///Constructor
	private ReplyDao replyDao;
	
	///Method
	public void setreplyDao(ReplyDao replyDao) {
		this.replyDao=replyDao;
	}
	
	///Constructor
	public ReplyServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public List<Reply> getReplyList(int noticeNo) throws Exception {
		return replyDao.getReplyList(noticeNo);
	}

	@Override
	public void addReply(Reply reply) throws Exception {
		replyDao.addReply(reply);
	}

	@Override
	public void updateReply(Reply reply) throws Exception {
		replyDao.updateReply(reply);
	}

	@Override
	public void deleteReply(int replyNo) throws Exception {
		replyDao.deleteReply(replyNo);
	}

	@Override
	public int getTotalList(int noticeNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
