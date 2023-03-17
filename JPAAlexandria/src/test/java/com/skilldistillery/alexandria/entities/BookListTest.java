package com.skilldistillery.alexandria.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BookListTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private BookList bookList;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABookClub");
	}
	
	@BeforeEach
	void setUp() throws Exception {
	    em = emf.createEntityManager();
	    //grab the Customer that is associated with PK 1
	    bookList = em.find(BookList.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    bookList = null;
	}
	
	@Test
	void test_InventoryBookList_basic_mappings() {
		assertNotNull(bookList);
		assertNotNull(bookList.getId());
		assertEquals("Ender's Game",bookList.getName());
	}



	
	

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

}
