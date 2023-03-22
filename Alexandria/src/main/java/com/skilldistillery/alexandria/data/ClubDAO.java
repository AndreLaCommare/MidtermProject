package com.skilldistillery.alexandria.data;

import com.skilldistillery.alexandria.entities.Club;

public interface ClubDAO {
	public Club addBookToClub(int clubId, int bookId);
}
