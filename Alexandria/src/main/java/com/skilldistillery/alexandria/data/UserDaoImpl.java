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
			user.getClubMemberships().size();
			user.getFavoriteBooks().size();
		} catch (Exception e) {
			
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
			user.getClubMemberships().size();
			user.getFavoriteBooks().size();
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
		User user = em.find(User.class, userId);
		if (user != null) {
			user.getFavoriteBooks().size();
			user.getClubMemberships().size();
			user.getOwnedClubs().size();
		}
		return user;
	}
	
	@Override
	public User findUserByUsername(String username) {
		
		username = "%" + username + "%";
		String jpql = "SELECT u FROM User u WHERE u.username LIKE :user";
		User user = em.createQuery(jpql, User.class).setParameter("user", username).getSingleResult();
	
		return user;
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
	public Club createBookClub(Club bookClub) {
		// TODO Auto-generated method stub

		em.persist(bookClub);
		em.flush();
		System.out.println("in book club");
		return bookClub;
	}
	@Override
	public Club joinClub(int clubId, int userId) {
		User user = em.find(User.class, userId);
		Club club = em.find(Club.class, clubId);
		
		user.addClub(club);
		em.flush();
		return club;
	}

	@Override
	public Book addToFavorites(int bookId, int userId) {
		Book book = em.find(Book.class, bookId);
		User user = em.find(User.class, userId);
		user.addFavoriteBook(book);
		em.flush();
		return book;
	}

	@Override
	public boolean removeFromFavorites(int bookId, int userId) {
		Book book = em.find(Book.class, bookId);
		User user = em.find(User.class, userId);
		if (user.getFavoriteBooks().contains(book)) {
			user.removeFavoriteBook(book);
			em.flush();
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean deleteBookClub(int clubId) {
		if (em.contains(em.find(Club.class, clubId))) {
			em.remove(em.find(Club.class, clubId));
			return true;
		} else {
			System.out.println("There is no such book Club.");
			return false;
		}
	}

	@Override
	public Club findClubById(int clubId) {

		Club bookClub = em.find(Club.class, clubId);
		if (bookClub != null) {
			bookClub.getClubMembers().size();
		}
		return bookClub;
	}

	@Override
	public BookReview writeReview(BookReview review, int userId) {
		
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
		review.getBook().getBookComments().sort(BookDaoImpl.COMMENT_COMPARATOR);
		
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

	@Override
	public Club updateBookClub(Club bookClub, int userId) {
		// TODO Auto-generated method stub

		//bookClub.setOwner(em.find(User.class, userId));

		Club updatedClub = em.find(Club.class, bookClub.getId());
		if (updatedClub.getOwner().getId() == userId) {

			updatedClub.setName(bookClub.getName());
			updatedClub.setImageURL(bookClub.getImageURL());
			updatedClub.setDescription(bookClub.getDescription());

			return updatedClub;
		} else {

			return null;
		}

	}

	@Override
	public Club leaveClub(int clubId, int userId) {
		
		Club club = em.find(Club.class, clubId);
		User user = em.find(User.class, userId);
		
		if (club.getClubMembers().contains(user)) {
			club.getClubMembers().remove(user);
		}
		return club;
	}
}
