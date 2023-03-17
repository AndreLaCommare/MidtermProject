package com.skilldistillery.alexandria.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class BookReviewId implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Column(name = "book_id")
	private int bookId;

	@Column(name = "user_id")
	private int userId;

	public BookReviewId() {
	}

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(bookId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookReviewId other = (BookReviewId) obj;
		return bookId == other.bookId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "BookReviewId [bookId=" + bookId + ", userId=" + userId + "]";
	}
}
