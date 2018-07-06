package com.model2.mvc.web.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//setter Method 구현 않음
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping( value="json/kakaologin", method=RequestMethod.POST )
	public User kakaologin(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		System.out.println(dbUser);
		
		if( dbUser != null ){
			session.setAttribute("user", dbUser);
			return dbUser;
		} else {
			session.setAttribute("user", user);
			return user;
		}
	}
	
	@RequestMapping( value="json/addUser", method=RequestMethod.POST)
	public User addUser ( @RequestBody User user) throws Exception{
		
		System.out.println("user/json/addUser : POST");
		
		//Business Logic
		userService.addUser(user);
		
		return userService.getUser(user.getUserId());
	}
	
	@RequestMapping( value="json/listUser", method=RequestMethod.POST)
	public Map listUser(@RequestBody Search search) throws Exception{
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST)
	public User updateUser ( @RequestBody User user) throws Exception{
		
		System.out.println("user/json/updateUser : POST");
		
		//Business Logic
		userService.updateUser(user);
		
		return userService.getUser(user.getUserId());
	}
	
	@RequestMapping( value="json/listUserAjax", method=RequestMethod.POST)
	public Map listUserAjax(@RequestBody Search search) throws Exception{
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserListAjax(search);
			
		map.put("list", map.get("list"));
		
		return map;
	}
	
}