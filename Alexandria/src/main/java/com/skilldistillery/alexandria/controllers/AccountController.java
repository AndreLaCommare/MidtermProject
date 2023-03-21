package com.skilldistillery.alexandria.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.skilldistillery.alexandria.data.UserDAO;
import com.skilldistillery.alexandria.entities.User;

@Controller
public class AccountController {
	
	@Autowired
	private UserDAO userDao;
  
	@GetMapping("account.do")
	public String goToProfile(HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			user = userDao.findUserById(user.getId());
			session.setAttribute("loggedInUser", user);
			return "userprofile";
			
		}else {
			return "signup";
		}
	}

}