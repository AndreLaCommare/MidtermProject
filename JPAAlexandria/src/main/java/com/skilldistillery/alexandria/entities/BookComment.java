package com.skilldistillery.alexandria.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "book_comment")
public class BookComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "book_comment")
	private String bookComment;

	@Column(name = "comment_date")
	private LocalDateTime commentDate;

	@ManyToOne
	@JoinColumn(name = "book_id")
	private Book book;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="in_reply_to_id")
	private BookComment parentComment;
	
	@OneToMany(mappedBy="parentComment")
	private List<BookComment> replies;
	
	
	
	
	
	
	
	

	public BookComment() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBookComment() {
		return bookComment;
	}

	public void setBookComment(String bookComment) {
		this.bookComment = bookComment;
	}


	public LocalDateTime getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(LocalDateTime commentDate) {
		this.commentDate = commentDate;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	
	public BookComment getParentComment() {
		return parentComment;
	}

	public void setParentComment(BookComment parentComment) {
		this.parentComment = parentComment;
	}

	public List<BookComment> getReplies() {
		return replies;
	}

	public void setReplies(List<BookComment> replies) {
		this.replies = replies;
	}

	

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookComment other = (BookComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("BookComment [id=").append(id).append(", bookComment=").append(bookComment)
				.append(", commentDate=").append(commentDate).append(", book=").append(book).append(", user=")
				.append(user).append(", parentComment=").append(parentComment).append("]");
		return builder.toString();
	}

}
