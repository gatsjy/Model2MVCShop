package com.model2.mvc.service.reply;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Reply;

public interface ReplyService {
	
	// 1. 댓글 목록
	public List<Reply> getReplyList(int noticeNo) throws Exception;
		
	// 2. 댓글을 추가합니다.
	public void addReply(Reply reply) throws Exception;
	
	// 3. 댓글을 수정합니다.
	public void updateReply(Reply reply) throws Exception;
	
	// 4. 댓글을 삭제합니다.
	public void deleteReply(int replyNo) throws Exception;
	
	// 5. 총갯수를 구합니다.
	public int getTotalList(int noticeNo) throws Exception;
}