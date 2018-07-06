package com.model2.mvc.service.spot.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Park;
import com.model2.mvc.service.domain.Spot;
import com.model2.mvc.service.spot.SpotDao;

@Repository("spotDaoImpl")
public class SpotDaoImpl implements SpotDao{
	
	///Field
		@Autowired
		@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession;
		public void setSqlSession(SqlSession sqlSession) {
			this.sqlSession = sqlSession;
		}
		
		///Constructor
		public SpotDaoImpl() {
			System.out.println(this.getClass());
		}

		@Override
		public List<Park> getParkList() throws Exception {
			
			return sqlSession.selectList("ParkMapper.getParkList");
		}

		@Override
		public List<Spot> getRiverList() throws Exception {
			
			return sqlSession.selectList("SpotMapper.getRiverList");
		}	
}