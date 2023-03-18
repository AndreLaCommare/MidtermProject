package com.skilldistillery.alexandria.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

@Entity
public class Genre {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="name")
	private String genre;
	
	@Column(name="image_url")
	private String imageUrl;
	
	
	@ManyToMany(mappedBy="genres")
	private List<Book> books;
	
	public Genre() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
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

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	
	public void addBook(Book book) {
		if (books == null ) {books = new ArrayList<>(); }
		if ( ! books.contains(book) ) {
			books.add(book);
			book.addGenre(this);
		}
	}
	
	public void removeBook(Book book) {
		if (books != null && books.contains(book)) {
			books.remove(book);
			book.removeGenre(this);
		}
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Genre other = (Genre) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Genre id: " + id + ", genre: " + genre + ", imageUrl: " + imageUrl;
	}
	
	
	
	
}
