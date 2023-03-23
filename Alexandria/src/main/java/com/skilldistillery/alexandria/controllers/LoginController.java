package com.skilldistillery.alexandria.controllers;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.alexandria.data.BookDAO;
import com.skilldistillery.alexandria.data.UserDAO;
import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.User;

@Controller
public class LoginController {

	@Autowired
	private UserDAO userdao;

	@Autowired
	private BookDAO bookdao;

//	@GetMapping("login.do")
//	public String goToLogin() {
//		return "signuplogin";
//
//	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String login(String username, String password, HttpSession session) {
		System.out.println("***************************Login.do******************************");
		User user = userdao.getUserByUserNameAndPassword(username, password);
		if (user != null) {
			session.setAttribute("loggedInUser", user);
//			return "userprofile";
			return "redirect:home.do";
		} else {

			return "signup";
		}
	}

	@RequestMapping(path = "signuppage.do", method = RequestMethod.GET)
	public String signup() {
		return "signuppage";
	}

	@RequestMapping(path = "signup.do", method = RequestMethod.POST)
	public String userSignedUp(User user, HttpSession session) {
		System.out.println("***************************Signed Up POST******************************");
		user = userdao.createUser(user);
		if (user != null) {
			session.setAttribute("loggedInUser", user);
			return "redirect:home.do";
		} else {

			return "signup";
		}
	}

	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("loggedInUser");
		return "redirect:home.do";
	}

}
