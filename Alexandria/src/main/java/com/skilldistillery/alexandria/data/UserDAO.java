package com.skilldistillery.alexandria.data;

import com.skilldistillery.alexandria.entities.User;

public interface UserDAO {

	User login(User user);
	
	User getUserByUserNameAndPassword(String userName, String password);
	User findUserById(int userId);
	User updateUser(int userId, User user);
}





