package com.skilldistillery.alexandria.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.alexandria.data.UserDAO;
import com.skilldistillery.alexandria.entities.Club;
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
	@GetMapping(path="searchpage.do")
	public String searchPage() {
		return "search";
	}
	
	@GetMapping(path="bookbytitle.do")
	public String findBookByKeyword(String title, Model model) {
		model.addAttribute("book", userDao.findBooksByTitle(title));
		return "bookbytitle";
	}
	
//	@GetMapping(path="bookbygenre.do")
//	public String findBookByGenre(String genre, Model model) {
//		model.addAttribute("book", userDao.findBooksByGenre(genre));
//		return "bookbygenre";
//	}
	
	
	
	@GetMapping(path="createClub.do")
	public String createClubPage(HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
		return "createBookClub";
		}else {
			return "signup";
		}
	}
	
	@PostMapping(path="createBookClub.do")
		public String createBookClub(Model model, Club bookClub) {
		try {
			bookClub = userDao.createBookClub(bookClub);
		}catch(RuntimeException e){
			System.err.println(e);
		}
		if (bookClub != null) {
			model.addAttribute("bookClub", bookClub);
			return "bookclub";
		}else {
			return "error";
		}
	}
	
	 @RequestMapping(path = "DeleteClub.do")
		public ModelAndView deleteClub(@RequestParam("id") int id) {
			boolean isDeleted = userDao.deleteBookClub(id);
			ModelAndView mv = new ModelAndView();
			mv.addObject("bookClub", isDeleted);
			mv.setViewName("home");
			return mv;
			}
	
	
	
	
	
	
	
	
	
	
	
	
}
