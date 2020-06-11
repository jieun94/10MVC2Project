package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@RequestMapping( value="json/addUser", method=RequestMethod.POST )
	public Map addUser(@RequestBody User user) throws Exception{
		System.out.println("/user/json/addUser : POST");
		
		System.out.println("::"+user);
		
		userService.addUser(user);
		
		Map map = new HashMap();
		map.put("user", user);
		
		return map;
	}
	
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
	
	@RequestMapping( value="json/updateUser/{userId}", method=RequestMethod.GET )
	public User updateUser( @PathVariable String userId) throws Exception {
		
		System.out.println("/json/updateUser : GET");
		
		
		return userService.getUser(userId);
	}
	
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST )
	public User updateUser( @RequestBody User user) throws Exception {
		
		System.out.println("/json/updateUser : POST");
		
		userService.updateUser(user);
		
		return user;
	}
	
	@RequestMapping( value="json/logout", method=RequestMethod.POST )
	public Map logout( HttpSession session) throws Exception {
		
		System.out.println("/json/logout : POST");
		
		session.invalidate();
		Boolean result = true ;
		
		Map map = new HashMap();
		map.put("result", new Boolean(result));
		
		return map;
	}
	
	@RequestMapping( value="json/checkDuplication/{userId}", method=RequestMethod.GET )
	public Map checkDuplication( @PathVariable("userId") String userId) throws Exception{
		
		System.out.println("/json/checkDuplication : GET");
		
		boolean result=userService.checkDuplication(userId);
		
		Map map = new HashMap();
		map.put("result", new Boolean(result));
		map.put("userId", userId);
		
		return map;
	}
	
	@RequestMapping( value="json/listUser", method=RequestMethod.GET )
	public Map listUser() throws Exception{
		
		System.out.println("/json/listUser : GET");
		
		Search search = new Search();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		Map map01 = new HashMap();
		map01.put("list", map.get("list"));
		map01.put("resultPage", resultPage);
		map01.put("search", search);
		
		return map01;
	}
	
	@RequestMapping( value="json/listUser", method=RequestMethod.POST )
	public Map listUser(@RequestBody Search search) throws Exception{
		
		System.out.println("/json/listUser : POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		Map map01 = new HashMap();
		map01.put("list", map.get("list"));
		map01.put("resultPage", resultPage);
		map01.put("search", search);
		
		return map01;
	}
}