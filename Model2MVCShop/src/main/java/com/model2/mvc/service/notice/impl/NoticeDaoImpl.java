package com.model2.mvc.service.notice.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Notice;
import com.model2.mvc.service.notice.NoticeDao;


//==> 회원관리 DAO CRUD 구현
@Repository("noticeDaoImpl")
public class NoticeDaoImpl implements NoticeDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public NoticeDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addNotice(Notice notice) throws Exception {
		sqlSession.insert("NoticeMapper.addNotice", notice);
	}

	@Override
	public Notice getNotice(int noticeNo) throws Exception {
		return sqlSession.selectOne("NoticeMapper.getNotice", noticeNo);
	}

	@Override
	public List<Notice> getNoticeList(Search search) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		
		return sqlSession.selectList("NoticeMapper.getNoticeList", map);
	}

	@Override
	public void updateNotice(Notice notice) throws Exception {
		sqlSession.update("NoticeMapper.updateNotice", notice);
	}
	
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("NoticeMapper.getTotalCount", search);
	}

	@Override
	public void updateNoticeHits(Notice notice) throws Exception {
		sqlSession.update("NoticeMapper.updateNoticeHits", notice);
	}
}