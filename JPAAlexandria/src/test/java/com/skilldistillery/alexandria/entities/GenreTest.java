package com.skilldistillery.alexandria.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class GenreTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Genre genre;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABookClub");
	}
	
	@BeforeEach
	void setUp() throws Exception {
	    em = emf.createEntityManager();
	    //grab the Customer that is associated with PK 1
	    genre = em.find(Genre.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    genre = null;
	}
	
	@Test
	void test_InventoryBookList_basic_mappings() {
		assertNotNull(genre);
		assertNotNull(genre.getId());
		assertEquals("Science fiction",genre.getGenre());
	}

	@Test
	void test_Genre_To_Book_ManyToMany_Mapping() {
		assertNotNull(genre);
		assertNotNull(genre.getBooks());
//		
//		assertFalse(genre.getBooks().isEmpty());
//		assertTrue(genre.getBooks().size() > 0);
	}

	
	

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}
}
