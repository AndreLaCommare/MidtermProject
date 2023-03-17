package com.skilldistillery.alexandria.entities;

import java.time.format.DateTimeFormatter;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class club {
	
	@Id 
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	private int owner_id;
	
	private DateTimeFormatter create_date;
	
	@Column(name="cover_url")
	private String image_url;

	public club() {
		super();
		// TODO Auto-generated constructor stub
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

	public int getOwner_id() {
		return owner_id;
	}

	public void setOwner_id(int owner_id) {
		this.owner_id = owner_id;
	}

	public DateTimeFormatter getCreate_date() {
		return create_date;
	}

	public void setCreate_date(DateTimeFormatter create_date) {
		this.create_date = create_date;
	}

	public String getImage_url() {
		return image_url;
	}

	public void setImage_url(String image_url) {
		this.image_url = image_url;
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
		club other = (club) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("club [id=").append(id).append(", name=").append(name).append(", description=")
				.append(description).append(", owner_id=").append(owner_id).append(", create_date=").append(create_date)
				.append(", image_url=").append(image_url).append("]");
		return builder.toString();
	}
	
}
