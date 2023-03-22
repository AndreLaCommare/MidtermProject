package com.skilldistillery.alexandria.entities;


import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Language {

	@Id 
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@OneToMany(mappedBy="language")
	private List<Book> books;
	
	public Language() {
		super();
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

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}
	
	public void addBook(Book book) {
		if (books == null) {books = new ArrayList<>(); }
		if ( ! books.contains(book) ) {
			books.add(book);
			if (book.getLanguage() != null) {
				book.getLanguage().removeBook(book);;
			}
			book.setLanguage(this);
		}
	}
	
	public void removeBook(Book book) {
		if (books != null && books.contains(book)) {
			books.remove(book);
			book.setLanguage(null);
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
		Language other = (Language) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return name;
	}
	
	
}
