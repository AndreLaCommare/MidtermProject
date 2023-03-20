package com.skilldistillery.alexandria.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Table(name = "book_review")
@Entity
public class BookReview {

	@EmbeddedId
	private BookReviewId id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	@MapsId(value="userId")
	private User user;
	@ManyToOne
	@JoinColumn(name = "book_id")
	@MapsId(value="bookId")
	private Book book;

	@Column(name = "rating")
	private int rating;

	@Column(name = "review")
	private String review;

	@Column(name = "create_date")
	@CreationTimestamp
	private LocalDateTime createDate;

	@Column(name = "last_update")
	@UpdateTimestamp
	private LocalDateTime lastUpdate;
	
	


	public BookReviewId getId() {
		return id;
	}

	public void setId(BookReviewId id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	@Override
	public int hashCode() {
		return Objects.hash(createDate, id, lastUpdate, rating, review, user);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookReview other = (BookReview) obj;
		return Objects.equals(createDate, other.createDate) && Objects.equals(id, other.id)
				&& Objects.equals(lastUpdate, other.lastUpdate) && rating == other.rating
				&& Objects.equals(review, other.review) && Objects.equals(user, other.user);
	}

	@Override
	public String toString() {
		return "BookReview [id=" + id + ", user=" + user + ", rating=" + rating + ", review=" + review + ", createDate="
				+ createDate + ", lastUpdate=" + lastUpdate + "]";
	}
}