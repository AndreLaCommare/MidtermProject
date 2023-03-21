package com.skilldistillery.alexandria.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

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
	@CreationTimestamp
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

	public void addBookComment(BookComment parentComment) {
		if (replies == null) {replies = new ArrayList<>(); }
		if ( ! replies.contains(parentComment) ) {
			replies.add(parentComment);
			if (parentComment.getBook() != null) {
				parentComment.getBook().removeBookComment(parentComment);
			}
			parentComment.setParentComment(parentComment);
		}
	}
	/////////////// NOTE TO SELF. MIGHT HAVE TO DO MANY TO MANY FOR THE SELF JOIN RELATIONSHIP
	
	public void removeBookComment(BookComment parentComment) {
		if (replies != null && replies.contains(parentComment)) {
			replies.remove(parentComment);
			parentComment.setParentComment(null);
		}
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
