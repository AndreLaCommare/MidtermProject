package com.skilldistillery.alexandria.entities;

import java.util.ArrayList;
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
import javax.persistence.Table;

@Entity
@Table(name = "booklist")
public class BookList {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String description;

	@Column(name = "image_url")
	private String imageUrl;

	@ManyToMany
	@JoinTable(name = "booklist_has_book", joinColumns = @JoinColumn(name = "booklist_id"), inverseJoinColumns = @JoinColumn(name = "book_id"))
	private List<Book> books;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	public BookList() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void addBook(Book book) {
		if (books == null) {
			books = new ArrayList<>();
		}
		if (!books.contains(book)) {
			books.add(book);
			book.addBookList(this);
		}
	}

	public void removeBook(Book book) {
		if (books != null && books.contains(book)) {
			books.remove(book);
			book.removeBookList(this);
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
		BookList other = (BookList) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "BookList id: " + id + ", name: " + name + ", description: " + description + ", imageUrl: " + imageUrl;
	}

}
