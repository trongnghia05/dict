<%@page import="com.maitrongnghia.entity.Word"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="ISO-8859-1">
	<title></title>
	<link href="<c:url value="/resources/usercss/style.css" />" rel="stylesheet">
</head>
<body>
	<div class="search">
		<button class="push_button" id="anhviet" onclick="changeColer1()">Anh-Viet</button>
		<button class="push_button" id= "vietanh" onclick="changeColer2()">Viet-Anh</button>
		
		<input id="search" type="text" name="search" placeholder="Search.." onkeypress="return Redirect(event)">
	</div>
	<div>
		<h2>Ket qua tim kiem</h2>
		<div class="table-wrapper">
		    <table class="fl-table">
		        <thead>
		        <tr>
		            <th>STT</th>
		            <th>Tieng Anh</th>
		            <th>Tieng Viet</th>
		        </tr>
		        </thead>
		        <tbody>
		           <%try{ %>
		           <%   ArrayList<Word> arr = (ArrayList<Word>)request.getAttribute("listWord");
		           
		        	    for (int i = 0; i < arr.size(); i++) {
		           %>
						<tr>
				            <td> <%=i+1%></td>
				            <td> <%= arr.get(i).getTienganh() %></td>
				            <td> <%= arr.get(i).getTiengviet()%></td>
		        		</tr>
				        <%}%>
			       <%}catch(NullPointerException e){
			    	   
			       }%>
		        
		        
		        <tbody>
		    </table>
		</div>
	</div>
	<div class="pagination"> 
   	  <a href="#">1</a> 
    </div> 
</body>
<script type="text/javascript">
	function changeColer1(){
		document.getElementById("anhviet").style.background  = '#20B2AA';
		document.getElementById("vietanh").style.background   = '#778899';
		type=1;
	}
	function changeColer2(){
		document.getElementById("vietanh").style.background   = '#20B2AA';
		document.getElementById("anhviet").style.background   = '#778899';
		type=2;
	}
	function Redirect(e) {
		if (e.keyCode == 13) {
	        var word = document.getElementById("search").value;
	 
	        if(type==1)
	        	type="anhviet";
	        else if(type==2)
	        	type="vietanh";
			window.location="http://localhost:8080/dict/search?word="+word+"&type="+type+"&role=user";
			 return false;
		}
		return true;
       
    }
</script>
</html>