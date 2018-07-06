package com.model2.mvc.service.reply;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Reply;

public interface ReplyService {
	
	// 1. ��� ���
	public List<Reply> getReplyList(int noticeNo) throws Exception;
		
	// 2. ����� �߰��մϴ�.
	public void addReply(Reply reply) throws Exception;
	
	// 3. ����� �����մϴ�.
	public void updateReply(Reply reply) throws Exception;
	
	// 4. ����� �����մϴ�.
	public void deleteReply(int replyNo) throws Exception;
	
	// 5. �Ѱ����� ���մϴ�.
	public int getTotalList(int noticeNo) throws Exception;
}