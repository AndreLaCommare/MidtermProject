package com.skilldistillery.alexandria.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.alexandria.entities.User;

import net.bytebuddy.matcher.ElementMatcher;

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
			user = em.createQuery(jpql, User.class).setParameter("name", username)
					.setParameter("pass", password).getSingleResult();
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
		
		return null;
	}

	@Override
	public User updateUser(int userId, User user) {
		// TODO Auto-generated method stub
		return null;
	}
}
