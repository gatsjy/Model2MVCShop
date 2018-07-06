package com.model2.mvc.service.spot;

import java.util.List;

import com.model2.mvc.service.domain.Park;
import com.model2.mvc.service.domain.Spot;

public interface SpotDao {
	
	public List<Park> getParkList() throws Exception;
	
	public List<Spot> getRiverList() throws Exception;
	
}