package com.skilldistillery.alexandria.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.Club;


@Transactional
@Service
public class ClubDaoImpl implements ClubDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Club addBookToClub(int clubId, int bookId) {
		Club club = em.find(Club.class, clubId);
		Book book = em.find(Book.class, bookId);
		
		club.addBook(book);
		book.addClub(club);
		club.getClubBooks().size();
		em.persist(club);
		em.flush();
		return club;
	}
	
	

}
