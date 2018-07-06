package com.model2.mvc.service.reply;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Reply;

public interface ReplyDao {
	
	// 1. 댓글 목록
	public List<Reply> getReplyList(int noticeNo) throws Exception;
	
	// 2. 댓글을 추가합니다.
	public void addReply(Reply reply) throws Exception;
	
	// 3. 댓글을 수정합니다.
	public void updateReply(Reply reply) throws Exception;
	
	// 4. 댓글을 삭제합니다.
	public void deleteReply(int replyNo) throws Exception;
	
	// 5. 전체 게시물수를 구합니다.
	public int getTotalCount(int noticeNo) throws Exception;
}