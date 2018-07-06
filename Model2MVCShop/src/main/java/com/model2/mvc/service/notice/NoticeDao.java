package com.model2.mvc.service.notice;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Notice;


//==> ȸ���������� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition
public interface NoticeDao {
	
	// INSERT
	public void addNotice(Notice notice) throws Exception ;

	// SELECT ONE
	public Notice getNotice(int noticeNo) throws Exception ;

	// SELECT LIST
	public List<Notice> getNoticeList(Search search) throws Exception ;

	// UPDATE
	public void updateNotice(Notice notice) throws Exception ;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
	// �Խ����� Ŭ�������� ��ȸ���� 1�� �ö󰡴� ����
	public void updateNoticeHits(Notice notice) throws Exception;
	
}