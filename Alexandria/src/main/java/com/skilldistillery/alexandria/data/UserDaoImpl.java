package com.skilldistillery.alexandria.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.Club;
import com.skilldistillery.alexandria.entities.User;

@Transactional
@Service
public class UserDaoImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public User login(User user) {
		String jpql = "SELECT u FROM User u WHERE u.username = :name AND u.password = :pass AND u.enabled = 1";
		try {
			user = em.createQuery(jpql, User.class).setParameter("name", user.getUsername())
					.setParameter("pass", user.getPassword()).getSingleResult();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			user = null;
		}
		return user;
	}

	@Override
	public User getUserByUserNameAndPassword(String username, String password) {
		String jpql = "SELECT u FROM User u WHERE u.username = :name AND u.password = :pass ";
		User user = null;
		try {
			user = em.createQuery(jpql, User.class).setParameter("name", username).setParameter("pass", password)
					.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			user = null;
		}
		return user;
	}

	@Override
	public User createUser(User user) {

		em.persist(user);
		em.flush();
		return user;
	}

	@Override
	public User findUserById(int userId) {

		return em.find(User.class, userId);
	}

	@Override
	public User updateUser(int userId, User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Book> findBooksByTitle(String title) {
		title = "%" + title + "%";
		String jpql = "SELECT b FROM Book b WHERE b.title LIKE :title";
		List<Book> book = em.createQuery(jpql, Book.class).setParameter("title", title).getResultList();
		return book;
	}

	@Override
	public List<Book> findBooksByAuthor(String author) {
		author = "%" + author + "%";
		String jpql = "SELECT b FROM Book b WHERE b.author.name LIKE :author";
		return em.createQuery(jpql, Book.class).setParameter("author", author).getResultList();
	}

	@Override
	public List<Book> findBooksByLanguage(String language) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Book> findBooksByDescription(String description) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Book findBooksByISBN(String isbn) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Club createBookClub(Club bookClub) {
		// TODO Auto-generated method stub
		em.persist(bookClub);
		em.flush();
		return bookClub;
	}
	
	

	@Override
	public boolean deleteBookClub(int id) {
		if (em.contains(em.find(Club.class, id))) {
			em.remove(em.find(Club.class, id));
			return true;
		} else {
			System.out.println("There is no such book Club.");
			return false;
		}
	}

	@Override
	public Club findClubById(int clubId) {
		// TODO Auto-generated method stub
		return em.find(Club.class, clubId);
	}
}
