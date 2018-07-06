package com.model2.mvc.web.spot;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Spot;
import com.model2.mvc.service.spot.SpotService;

//==> 회원관리 RestController
@RestController
@RequestMapping("/spot/*")
public class SpotRestController {
	
	///Field
	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;
	//setter Method 구현 않음
		
	public SpotRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="park/listPark", method=RequestMethod.POST)
	public Map listPark() throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("park", spotService.getParkList());
		
		return map;
	}
	
	/*@RequestMapping( value="getRiverList", method=RequestMethod.POST)
	public Map getLiverList(Spot spot) throws Exception{

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("river", spotService.getRiverList());
		
		return map;
	}*/
	
	@RequestMapping( value="getRiverList", method=RequestMethod.POST)
	public String getLiverList(Spot spot) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Spot> list = spotService.getRiverList();
		JSONArray jsonArray = new JSONArray();
		
		for ( Spot a : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("x", a.getSpotX());
			jsonObject.put("y", a.getSpotY());
			jsonArray.add(jsonObject);
		}
		
		System.out.println("QWeqwewqeqweqwe"+jsonArray.toString());
		
		return jsonArray.toString();
	}

	
}