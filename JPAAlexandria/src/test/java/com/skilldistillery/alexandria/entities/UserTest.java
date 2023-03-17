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

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABookClub");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_User_entity_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	
	@Test
	void test_User_to_ListOfClubMemberships_ManyToMany() {
		assertNotNull(user);
		assertNotNull(user.getClubMemberships());
		//assertFalse(book.getClubMemberships().isEmpty());
	}
	
	@Test
	void test_User_ListOfFavoriteBooks_ManyToMany() {
		assertNotNull(user);
		assertNotNull(user.getFavoriteBooks());
		//assertFalse(book.getBookLists().isEmpty());
	}
	
	@Test
	void test_User_ListOfBookComments_OneToMany() {
		assertNotNull(user);
		assertNotNull(user.getUserBookComments());
		assertEquals("Fun to read", user.getUserBookComments().get(0).getBookComment());
	}
	
	@Test
	void test_User_ListOfClubComments_OneToMany() {
		assertNotNull(user);
		assertNotNull(user.getUserClubComments());
		assertNotNull("Great club!",user.getUserClubComments().get(0).getComment());
		
	}
	
	@Test
	void test_User_ListOfBookLists_OneToMany() {
		assertNotNull(user);
		assertNotNull(user.getUserBookLists());
		//assertNotNull("Ender's Game",user.getUserBookLists().get(0).getBooks().get(0).getTitle());
		
	}

}
