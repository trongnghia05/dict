package com.maitrongnghia.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "word")
public class Word {
	private Integer id;
	private String tienganh;
	private String tiengviet;
	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
    @Column(name = "id")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name="tienganh")
	public String getTienganh() {
		return tienganh;
	}
	public void setTienganh(String tienganh) {
		this.tienganh = tienganh;
	}
	@Column(name="tiengviet")
	public String getTiengviet() {
		return tiengviet;
	}
	public void setTiengviet(String tiengviet) {
		this.tiengviet = tiengviet;
	}
	
}
