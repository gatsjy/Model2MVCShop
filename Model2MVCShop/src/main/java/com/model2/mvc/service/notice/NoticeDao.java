package com.model2.mvc.service.notice;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Notice;


//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface NoticeDao {
	
	// INSERT
	public void addNotice(Notice notice) throws Exception ;

	// SELECT ONE
	public Notice getNotice(int noticeNo) throws Exception ;

	// SELECT LIST
	public List<Notice> getNoticeList(Search search) throws Exception ;

	// UPDATE
	public void updateNotice(Notice notice) throws Exception ;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
	// 게시판을 클릭했을때 조회수가 1씩 올라가는 쿼리
	public void updateNoticeHits(Notice notice) throws Exception;
	
}