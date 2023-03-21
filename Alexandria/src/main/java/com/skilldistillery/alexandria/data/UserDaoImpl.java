package com.skilldistillery.alexandria.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.alexandria.entities.Book;

import com.skilldistillery.alexandria.entities.BookList;

import com.skilldistillery.alexandria.entities.BookComment;

import com.skilldistillery.alexandria.entities.BookReview;
import com.skilldistillery.alexandria.entities.BookReviewId;
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
	public User updateUser(int userId, User updatedUser) {
		User managed = em.find(User.class, userId);
		managed.setUsername(updatedUser.getUsername());
		managed.setPassword(updatedUser.getPassword());
		managed.setImageUrl(updatedUser.getImageUrl());
		managed.setFirstName(updatedUser.getFirstName());
		managed.setLastName(updatedUser.getLastName());
		managed.setAboutMe(updatedUser.getAboutMe());
		em.close();
		return managed;
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
		language = "%" + language + "%";
		String jpql = "SELECT b FROM Book b WHERE b.language.name LIKE :language";
		return em.createQuery(jpql, Book.class).setParameter("language", language).getResultList();
	}

	@Override
	public List<Book> findBooksByDescription(String description) {
		// TODO Auto-generated method stub
		description = "%" + description + "%";
		String jpql = "SELECT b FROM Book b WHERE b.description LIKE :description";
		return em.createQuery(jpql, Book.class).setParameter("description", description).getResultList();
	}

	@Override
	public Book findBookByISBN(String isbn) {
		// TODO Auto-generated method stub
		String jpql = "SELECT b FROM Book b WHERE b.isbn = :isbn";
		return em.createQuery(jpql, Book.class).setParameter("isbn", isbn).getSingleResult();
	}

	@Override
	public Club createBookClub(Club bookClub) {
		// TODO Auto-generated method stub

		em.persist(bookClub);
		em.flush();
		System.out.println("in book club");
		return bookClub;
	}

	@Override
	public BookList createBookList(BookList booklist) {
		em.persist(booklist);
		em.flush();
		return booklist;
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

		return em.find(Club.class, clubId);
	}

	@Override
	public BookReview writeReview(BookReview review, int userId) {
		System.out.println("#################################################################################");
		BookReviewId reviewId = new BookReviewId();
		reviewId.setBookId(review.getBook().getId());
		reviewId.setUserId(userId);
		review.setId(reviewId);
		Book reviewed = em.find(Book.class, review.getBook().getId());
		review.setBook(reviewed);
		reviewed.getBookComments().size();
		User reviewer = em.find(User.class, userId);
		review.setUser(reviewer);
		review.setBook(reviewed);
		em.persist(review);
		em.flush();
		System.out.println(review);
		System.out.println(review.getBook());
		System.out.println("in write review");
		return review;
	}

	@Override
	public BookReview updateBookReview(BookReview review, int userId) {
		System.out.println("#################################################################################");
		System.out.println(review);
		System.out.println(review.getId());

		review.getId().setUserId(userId);
		review.setUser(em.find(User.class, userId));

		BookReview updateReview = em.find(BookReview.class, review.getId());
		System.out.println(updateReview);
		System.out.println(updateReview.getUser());
		if (updateReview.getUser().getId() == userId) {

			updateReview.setReview(review.getReview());
			updateReview.setRating(review.getRating());

			return updateReview;
		} else {
			return null;
		}
	}

	@Override
	public BookReview bookReviewExistsForUser(int bookId, int userId) {
		BookReviewId id = new BookReviewId();
		id.setBookId(bookId);
		id.setUserId(userId);
		return em.find(BookReview.class, id);
	}

	@Override
	public Book findBookById(int id) {
		return em.find(Book.class, id);
	}

	@Override
	public BookComment writeComment(BookComment comment, int userId) {
		// TODO Auto-generated method stub
		comment.setBook(em.find(Book.class, comment.getBook().getId()));
		comment.setUser(em.find(User.class, userId));
		em.persist(comment);
		em.flush();
		System.out.println("in write Comment");
		return comment;
	}

	@Override
	public BookComment replyComment(BookComment comment, int parentCommentId, int userId) {
		// TODO Auto-generated method stub
		BookComment parent = em.find(BookComment.class, parentCommentId);
		if (parent != null) {
			comment.setParentComment(parent);
			comment.setBook(em.find(Book.class, comment.getBook().getId()));
			comment.setUser(em.find(User.class, userId));
			em.persist(comment);
			em.flush();
			return comment;

		} else {

			return null;
		}
	}

}
