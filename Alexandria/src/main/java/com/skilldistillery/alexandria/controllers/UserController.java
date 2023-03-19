package com.skilldistillery.alexandria.controllers;

import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.alexandria.data.UserDAO;
import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.User;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path = {"/", "home.do"})
	public String home(Model model) {
		System.out.println("***************************Home.do******************************");
		//DEBUG
//		User u = new User();
//		u.setUsername("admin");
//		u.setPassword("admin");
//		u = userDao.login(u);
//		model.addAttribute("SMOKETEST", u);
		//DEBUG
		
		return "home";
	}
	
	@GetMapping(path="finduserbyid.do")
	public String findUserById(Integer id, Model model) {
		User user = userDao.findUserById(id);
		model.addAttribute("user", user);
		return "userbyid";
	}
	
	@GetMapping(path="bookbytitle.do")
	public String findBookByKeyword(String title, Model model) {
		model.addAttribute("book", userDao.findBooksByTitle(title));
		return "bookbytitle";
	}
	
	@GetMapping(path="bookbygenre.do")
	public String findBookByGenre(String genre, Model model) {
		model.addAttribute("book", userDao.findBooksByGenre(genre));
		return "bookbygenre";
	}
	
	
	
	
	
	
	
	
	
	
	
}
