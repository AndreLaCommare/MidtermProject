package com.skilldistillery.alexandria.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.skilldistillery.alexandria.entities.User;

@Controller
public class AccountController {
  
	@GetMapping("account.do")
	public String goToProfile(HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			return "userprofile";
			
		}else {
			return "signuplogin";
		}
	}

}