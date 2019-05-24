package com.model2.mvc.web.user;

import java.util.HashMap;
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


//==> ȸ������ RestController
@RestController // Model�� ��ġ�� �ʰ� �ٷ� body�� ������~
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//////�����ʿ����//////
	@RequestMapping( value="json/addUser" )
	public User addUser( @RequestBody User user ) throws Exception {

		System.out.println("/user/json/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		return userService.getUser(user.getUserId());
	}

	///////�����ʿ����///////
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		
		return userService.getUser(userId);
	}
	
	//////�����ʿ����//////
	@RequestMapping( value="json/updateUser")
	public User updateUser( @RequestBody User user , Model model , HttpSession session) throws Exception{
		//VO�� �ѱ�
		System.out.println("/user/json/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		userService.getUser(user.getUserId());
		
		return userService.getUser(user.getUserId());
	}
	
	
	//////�����ʿ����//////
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
	//�����ʿ�..?
	@RequestMapping( value="json/checkDuplication")
	public Map checkDuplication( @RequestBody User user , Model model ) throws Exception{
	
	System.out.println("/user/json/checkDuplication : POST");
	//Business Logic
	boolean result=userService.checkDuplication(user.getUserId());
	
	Map map = new HashMap();
	map.put("result", result);
	map.put("message", "ok");
	
	return map;
}

	//�����ʿ�......?
	@RequestMapping( value="json/getUserList")
	public Map listUser( @RequestBody Search search , Model model , HttpServletRequest request) throws Exception{
	
	System.out.println("/user/json/getUserList : GET");
	
	if(search.getCurrentPage() ==0 ){
		search.setCurrentPage(1);
	}
	search.setPageSize(pageSize);
	
	// Business logic ����..
	Map<String , Object> map=userService.getUserList(search);
	
	Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
	System.out.println(resultPage);
	
	return map;
}
}