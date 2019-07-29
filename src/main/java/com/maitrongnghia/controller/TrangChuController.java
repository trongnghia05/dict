package com.maitrongnghia.controller;

import java.awt.List;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.security.KeyStore.Entry;
import java.util.ArrayList;

import javax.persistence.NoResultException;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.MatrixVariable;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.maitrongnghia.entity.User;
import com.maitrongnghia.entity.Word;



@Controller
public class TrangChuController {
	
	@Autowired
	SessionFactory sessionFactory;
	
	@RequestMapping(path="/",method=RequestMethod.GET)
	public String trangChu(ModelMap modelMap){
		return "login";
	}

	@RequestMapping(path="/add",method=RequestMethod.POST)
	@Transactional
	public boolean add(@RequestParam String tienganh,@RequestParam String tiengviet,ModelMap modelMap) {
		Session session = sessionFactory.getCurrentSession();
		String sql;
		Query query;
		sql = String.format("INSERT INTO Word(tienganh,tiengviet) VALUES('"+tienganh+"','"+tiengviet+"')");
		try {
			query = session.createQuery(sql);
//			query.setParameter("tienganh1",tienganh);
//			query.setParameter("tiengviet1",tiengviet);
			query.executeUpdate();
			
		}catch(NullPointerException e) {
			modelMap.addAttribute("status","Them phan tu that bai !");
			return false;
		}
		modelMap.addAttribute("status","Them phan tu thanh cong !");
		return true;
	}
	@RequestMapping(path="/trangchinh",method=RequestMethod.POST)
	@Transactional
	public String checkLogin(@RequestParam String username,@RequestParam String password,ModelMap modelMap) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM User WHERE username =:username1 and  password =:password1";
		Query query = session.createQuery(hql);
		query.setParameter("username1",username);
		query.setParameter("password1",password);
		User user;
		try {
			user =  (User) query.getSingleResult();
		}catch(NoResultException e) {
			return "login";
		} 
		
		if(user!=null) {
			if(user.getRole().equals("1")){
			
				return "adminSearch";
			}else if(user.getRole().equals("2")){
				return "userSearch";
			}
		}
		
		return "login";
		
		
	}
	
	
	@RequestMapping(path="/delete",method=RequestMethod.GET)
	@Transactional
	public String delete(@RequestParam Integer id,@RequestParam String word,@RequestParam String type,@RequestParam String role,ModelMap modelMap) {
		Session session = sessionFactory.getCurrentSession();
		String sql;
		Query query;
		sql = "DELETE FROM Word WHERE id =:id1" ;
		try {
			query = session.createQuery(sql);
			query.setParameter("id1",id);
			query.executeUpdate();
			
		}catch(NullPointerException e) {
			
		}
		
		return "redirect:search?word="+word+"&type="+type+"&role="+role;
	}
	
	
	@RequestMapping(path="/search",method=RequestMethod.GET)
	@Transactional
	public String search(@RequestParam String word,@RequestParam String type,@RequestParam String role,ModelMap modelMap) {
		Session session = sessionFactory.getCurrentSession();
		ArrayList<Word> arr = new ArrayList<Word>();
		Word wordObject;
		String sql1,sql2;
		long count = 0 ;
		Query query1,query2;
		if(type.equals("anhviet")) {
			sql1 = "FROM Word WHERE tienganh like '%" + word+"%'" ;
			query1 = session.createQuery(sql1);
			
			sql2 = "SELECT Count(*)FROM Word WHERE tienganh like '%" + word+"%'";
			query2 = session.createQuery(sql2);
			try {
				arr = (ArrayList<Word>) query1.getResultList();
				count = (Long) query2.getSingleResult();
			}catch(NoResultException e) {
				if(role.equals("admin")) {
					return "adminSearch";
				}else {
					return "userSearch";
				}
				
			} 
		}else if(type.equals("vietanh")) {
			
		}else {
			sql1 = "FROM Word";
			query1 = session.createQuery(sql1);
			try {
				arr = (ArrayList<Word>) query1.getResultList();
			}catch(NoResultException e) {
				if(role.equals("admin")) {
					return "adminSearch";
				}else {
					return "userSearch";
				}
			} 
		}
		modelMap.addAttribute("listWord",arr);
		modelMap.addAttribute("word",word);
		modelMap.addAttribute("type",type);
		
		if(role.equals("admin")) {
			return "adminSearch";
		}else {
			return "userSearch";
		}
	}
}