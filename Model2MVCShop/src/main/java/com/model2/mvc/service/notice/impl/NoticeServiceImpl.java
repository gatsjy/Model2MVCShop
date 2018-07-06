package com.model2.mvc.service.notice.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Notice;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.notice.NoticeDao;
import com.model2.mvc.service.notice.NoticeService;;


//==> 회원관리 서비스 구현
@Service("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService{
	
	///Field
	@Autowired
	@Qualifier("noticeDaoImpl")
	private NoticeDao noticeDao;
	
	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}
	
	///Constructor
	public NoticeServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addNotice(Notice notice) throws Exception {
		noticeDao.addNotice(notice);
	}

	public Notice getNotice(int noticeNo) throws Exception {
		return noticeDao.getNotice(noticeNo);
	}

	public Map<String , Object > getNoticeList(Search search) throws Exception {
		List<Notice> list= noticeDao.getNoticeList(search);
		int totalCount = noticeDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateNotice(Notice notice) throws Exception {
		noticeDao.updateNotice(notice);
	}


	@Override
	public int getTotalCount(Search search) throws Exception {
		return noticeDao.getTotalCount(search);
	}

	@Override
	public void updateNoticeHits(Notice notice) throws Exception {
		noticeDao.updateNoticeHits(notice);		
	}
	
}