package com.model2.mvc.service.spot.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Park;
import com.model2.mvc.service.domain.Spot;
import com.model2.mvc.service.spot.SpotDao;
import com.model2.mvc.service.spot.SpotService;

@Service("spotServiceImpl")
public class SpotServiceImpl implements SpotService{
	
	///Field
	@Autowired
	@Qualifier("spotDaoImpl")//Ÿ�Կ��� ������ �߰��ؼ� �ڵ����̾�� �����ϰ� ������ �� �ִ� ���
	
	///Constructor
	private SpotDao spotDao;
	
	///Method
	public void setmapDao(SpotDao spotDao) {
		this.spotDao=spotDao;
	}
	
	///Constructor
	public SpotServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public List<Park> getParkList() throws Exception {
		
		return spotDao.getParkList();
	
	}

	@Override
	public List<Spot> getRiverList() throws Exception {
		
		return spotDao.getRiverList();
	}

}
