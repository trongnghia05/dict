package com.maitrongnghia.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

 
@Entity
@Table(name = "user")
public class User {
 
	private Integer id;
	private String username;
	private String password;
	private String fullname;
	private String address;
	private String numberphone;
	private String email;
	private String role;
 
   
	@Id
    @Column(name = "id")
    public Integer getId() {
		return id;
	}

    @Column(name="role")
    public String getRole() {
	    return role;
    }

	public void setRole(String role) {
		this.role = role;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "username")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	@Column(name = "password")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	@Column(name = "fullname")
	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	@Column(name = "address")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "numberphone")
	public String getNumberphone() {
		return numberphone;
	}

	public void setNumberphone(String numberphone) {
		this.numberphone = numberphone;
	}
	
	@Column(name= "email")
	public String getEmail() {
		return email;
	}

 	public void setEmail(String email) {
		this.email = email;
	}
 	

 
}
