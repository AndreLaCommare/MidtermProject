package com.skilldistillery.alexandria.controllers;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.alexandria.data.BookDAO;
import com.skilldistillery.alexandria.data.ClubDAO;
import com.skilldistillery.alexandria.data.UserDAO;
import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.BookComment;
import com.skilldistillery.alexandria.entities.BookReview;
import com.skilldistillery.alexandria.entities.Club;
import com.skilldistillery.alexandria.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;

	@Autowired
	private BookDAO bookDao;
	@Autowired
	private ClubDAO clubDao;

	@RequestMapping(path = { "/", "home.do" })
	public String home(Model model) {
		System.out.println("***************************Home.do******************************");
		// DEBUG
//		User u = new User();
//		u.setUsername("admin");
//		u.setPassword("admin");
//		u = userDao.login(u);
//		model.addAttribute("SMOKETEST", u);
		// DEBUG

		List<Book> books = bookDao.findAllBooks();
		Collections.shuffle(books);
		books = books.subList(0, 5);
		System.out.println("*****************Books**************");
		System.out.println(books);
		model.addAttribute("booksToDisplay", books);
		return "home";
	}

	@GetMapping(path = "findUserById.do")
	public String findUserById(Integer userId, Model model) {
		User user = userDao.findUserById(userId);
		model.addAttribute("user", user);
		return "otherUserProfile";
	}

	@GetMapping(path = "searchPage.do")
	public String searchPage() {
		return "search";
	}

	@GetMapping(path = "bookByTitle.do")
	public String findBookByKeyword(String title, Model model) {
		model.addAttribute("books", bookDao.findBooksByTitle(title));
		return "booklistsearch";
	}

	@GetMapping(path = "bookByAuthor.do")
	public String findByAuthor(String author, Model model) {
		model.addAttribute("books", bookDao.findBooksByAuthor(author));
		return "booklistsearch";
	}

	@GetMapping(path = "bookByLanguage.do")
	public String findByLanguage(String language, Model model) {
		model.addAttribute("books", bookDao.findBooksByLanguage(language));
		return "booklistsearch";
	}

	@GetMapping(path = "bookByDescription.do")
	public String findByDescription(String description, Model model) {
		model.addAttribute("books", bookDao.findBooksByDescription(description));
		return "booklistsearch";
	}
	
	@GetMapping(path = "findByUsername.do")
	public String findByUsername(String username, Model model) {
		model.addAttribute("user", userDao.findUserByUsername(username));
		return "otherUserProfile";
	}

	@GetMapping(path = "bookByIsbn.do")
	public String findByISBN(String isbn, Model model, HttpSession session) {
		Book book = bookDao.findBookByISBN(isbn);
		if (book != null) {
			model.addAttribute("book", book);
		}
		if (session.getAttribute("loggedInUser") == null) {
			return "showSingleBook";
		} else {
			refreshLoggedInUser(session);
			return "showSingleBook";
		}
	}

	@GetMapping(path = "showById.do")
	public String findById(Integer id, Model model, HttpSession session) {
		Book book = bookDao.findBookById(id);
		model.addAttribute("book", book);
		if (session.getAttribute("loggedInUser") == null) {
			return "showSingleBook";
		} else {
			refreshLoggedInUser(session);
			return "showSingleBook";
		}
	}

	@GetMapping(path = "findBookForHomepage.do")
	public ModelAndView findBookForHomepage(Integer id) {
		ModelAndView mv = new ModelAndView();
		Book book = bookDao.findBookById(id);
		mv.addObject("book", book);
		mv.setViewName("showSingleBook");
		return mv;
	}

	@GetMapping(path = "createClub.do")
	public String createClubPage(HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			return "createBookClub";
		} else {
			return "signup";
		}
	}

	@PostMapping(path = "createBookClub.do")
	public String createBookClub(Model model, Club bookClub, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		try {
			bookClub = userDao.createBookClub(bookClub);
			session.setAttribute("loggedInUser", userDao.findUserById(user.getId()));
			System.out.println(bookClub);
		} catch (RuntimeException e) {
			System.err.println(e);
		}
		if (bookClub != null) {
			model.addAttribute("bookClub", bookClub);
			return "redirect:findClubById.do?clubId=" + bookClub.getId();

		} else {
			return "error";
		}
	}

	@PostMapping(path = "UpdateClub.do")
	public String updateBookClub(Model model, Club bookClub, HttpSession session) {
		
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			
		try {
			bookClub = userDao.updateBookClub(bookClub, user.getId());
			model.addAttribute("bookClub", bookClub);
			session.setAttribute("loggedInUser", userDao.findUserById(user.getId()));
		} catch (RuntimeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}else {
			return "signuppage";
		}
		return "bookclub";
	}

	@PostMapping(path = "joinClub.do")
	public String joinClub(HttpSession session, Integer clubId, Model model) {
		User user = (User) session.getAttribute("loggedInUser");

		if (user != null) {
			try {
				Club club = userDao.joinClub(clubId, user.getId());
				model.addAttribute("bookClub", club);
				session.setAttribute("loggedInUser", userDao.findUserById(user.getId()));
			} catch (RuntimeException e) {
				System.err.println(e);
			}
		} else {
			return "signuppage";
		}
		return "bookclub";
	}
	
	@PostMapping(path="leaveClub.do")
	public String leaveClub(HttpSession session, Integer clubId, Model model) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			try {
				Club club = userDao.leaveClub(clubId, user.getId());
				model.addAttribute("bookClub", club);
				session.setAttribute("loggedInUser", userDao.findUserById(user.getId()));
			}catch (RuntimeException e) {
				System.err.println(e);
			}
		}
		
		return "bookclub";
	}

	@PostMapping(path = "addBookToFavorites.do")
	public String addBookToFavorites(HttpSession session, Integer bookId, Model model, String option) {
		User user = (User) session.getAttribute("loggedInUser");
		if (Character.isDigit(option.charAt(0))) {
			Club club = clubDao.addBookToClub(Integer.parseInt(option), bookId);
			model.addAttribute("bookClub", club);
			return "bookclub";
		}
		if (user != null) {
			try {
				Book book = userDao.addToFavorites(bookId, user.getId());
				model.addAttribute("book", book);
				session.setAttribute("loggedInUser", userDao.findUserById(user.getId()));

			} catch (RuntimeException e) {
				System.err.println(e);
			}
		} else {
			return "signuppage";
		}
		refreshLoggedInUser(session);
		return "showSingleBook";
	}

	@PostMapping(path = "DeleteClub.do")
	public ModelAndView deleteClub(Integer clubId, HttpSession session) {
		boolean isDeleted = userDao.deleteBookClub(clubId);
		refreshLoggedInUser(session);
		ModelAndView mv = new ModelAndView();
		mv.addObject("bookClub", isDeleted);
		mv.setViewName("userprofile");
		return mv;
	}

	@PostMapping(path = "deleteFavoriteBook.do")
	public String removeFromFavorites(HttpSession session, Integer bookId, Model model) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			try {
				userDao.removeFromFavorites(bookId, user.getId());
				session.setAttribute("loggedInUser", userDao.findUserById(user.getId()));

			} catch (RuntimeException e) {
				System.err.println(e);
			}
		} else {
			return "signuppage";
		}
		return "userprofile";
	}

	@GetMapping(path = "findClubById.do")
	public String findClubById(Integer clubId, Model model, HttpSession session) {
		boolean myClub = false;
		Club club = userDao.findClubById(clubId);
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null && club != null) {

			if (club.getOwner().getId() == user.getId()) {
				myClub = true;
			} else {
				for (Club fav : user.getClubMemberships()) {
					if (fav.getId() == clubId) {
						myClub = true;
					}
				}
			}
		}
		bookDao.clubFavorites(clubId);
		model.addAttribute("myClub", myClub);
		model.addAttribute("bookClub", club);
		return "bookclub";
	}

	@GetMapping(path = "loginpage.do")
	public String loginPage(Model model) {
		return "loginpage";
	}

	@PostMapping(path = "review.do")
	public String writeAReview(Model model, BookReview review, HttpSession session) {
	
		User loggedInUser = (User) session.getAttribute("loggedInUser");
	
		if (loggedInUser != null) {

			try {
				
				review = userDao.writeReview(review, loggedInUser.getId());
				System.out.println(review);

				if (review != null) {

					model.addAttribute("book", review.getBook());
					model.addAttribute("review", review);
					refreshLoggedInUser(session);
					return "showSingleBook";

				}
			} catch (RuntimeException e) {
				System.err.println(e);
				return "error";
			}
		}
		return "loginpage";
	}

	@PostMapping(path = "comment.do")
	public String publishAComment(Model model, BookComment comment, HttpSession session) {

		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {

			try {
				comment = userDao.writeComment(comment, loggedInUser.getId());
			} catch (RuntimeException e) {
				System.err.println(e);
			}
			if (comment != null) {

				model.addAttribute("book", comment.getBook());
				model.addAttribute("bookComment", comment);
				refreshLoggedInUser(session);
				return "showSingleBook";
			} else {
				return "error";
			}
		}

		return "loginpage";
	}

	@GetMapping(path = { "updateuserprofile.do" })
	public String updateUserProfile(Model model, Integer userId, User user) {
		user = userDao.findUserById(userId);
		model.addAttribute("update", user);
		return "updateuserprofile";
	}

	@PostMapping(path = { "updateduserprofile.do" })
	public String updatedUserProfile(Model model, Integer userId, User user, HttpSession session) {
		System.out.println("***************************UpdateedUserProfile.do******************************");
		User updatedUserProfile = userDao.updateUser(userId, user);
		System.out.println(userId);
		System.out.println(user);
		model.addAttribute("update", updatedUserProfile);
		refreshLoggedInUser(session);
		return "userprofile";
	}

	@GetMapping(path = "updatereview.do")
	public String updateReview(Model model, BookReview review, HttpSession session) {
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		review = userDao.updateBookReview(review, loggedInUser.getId());
		model.addAttribute("review", review);
		model.addAttribute("book", bookDao.findBookById(review.getBook().getId()));
		refreshLoggedInUser(session);
		return "showSingleBook";
	}

	@GetMapping(path = "replyComment.do")

	public String replyToComment(Model model, BookComment comment, Integer parentCommentId, HttpSession session) {
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {

			comment = userDao.replyComment(comment, parentCommentId, loggedInUser.getId());

			model.addAttribute("bookComment", comment);
			model.addAttribute("book", bookDao.findBookById(comment.getBook().getId()));
			refreshLoggedInUser(session);
			return "showSingleBook";
		}
		return "loginpage";
	}

	public void refreshLoggedInUser(HttpSession session) {
		session.setAttribute("loggedInUser",
				userDao.findUserById(((User) session.getAttribute("loggedInUser")).getId()));
	}

}