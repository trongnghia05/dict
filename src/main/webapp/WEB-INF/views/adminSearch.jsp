<%@page import="com.maitrongnghia.entity.Word"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css"  rel="stylesheet" id="bootstrap-css">
    <link href="resources/admincss/style.css"  rel="stylesheet">
	<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"/></script>
	<script src=/resources/vendor/jquery/jquery-3.2.1.min.js" />"></script>
</head>


<body>
<div id="text-boxx">
<div class="container" >
    <div class="row">

        <div class="col-md-2">
            <button class="push_button" id="anhviet" onclick="changeColer1()">Anh-Viet</button>
        </div>
        <div class="col-md-2">
            <button class="push_button" id= "vietanh" onclick="changeColer2()">Viet-Anh</button>
        </div>
        <div class="col-md-8" id="a">
            <input id="search" type="text" name="search" placeholder="Search.." onkeypress="return Redirect(event)">
        </div>
           
    </div>
    <div class="row">
        <div class="row col-md-12 col-md-offset-2 custyle">
            <table class="table table-striped custab" id="tableb">
                <thead>
                <a href="#" class="btn btn-primary btn-xs pull-right open-button" onclick="openForm()"><b>+</b> Them tu</a>
                    <tr>
                        <th>STT</th>
                        <th>Tieng anh</th>
                        <th>Tieng viet</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <%try{ %>
		           <%   ArrayList<Word> arr = (ArrayList<Word>)request.getAttribute("listWord");
		        	    String word = (String)request.getAttribute("word");
		        	    String type = (String)request.getAttribute("type");
		        	    String statusInsert= (String)request.getAttribute("status");
		           		for (int i = 0; i < arr.size(); i++) {
		           %>
						 <tr id = "<%= arr.get(i).getId()%>">
		                    <td><%=i+1%></td>
		                    <td><%= arr.get(i).getTienganh() %></td>
		                    <td><%= arr.get(i).getTiengviet()%></td>
		                    <td class="text-center">
			                    <a class='btn btn-info btn-xs open-button' href="#" onclick="edit('<%= arr.get(i).getTienganh() %>','<%= arr.get(i).getTiengviet()%>',<%= arr.get(i).getId()%>,'<%=word%>','<%=type%>')">
				                    <span class="glyphicon glyphicon-edit">
				                    </span> Edit
			                    </a> 
			                    <a href="http://localhost:8080/dict/delete?id=<%= arr.get(i).getId()%>&word=<%=word%>&type=<%=type%>&role=admin" class="btn btn-danger btn-xs">
				                    <span class="glyphicon glyphicon-remove">
				                    </span> Del
				                </a>
		                    </td>
		                </tr>
				        <%}%>
			       <%}catch(NullPointerException e){
			    	   
			       }%>
            </table>
        </div>
    </div>
</div>
</div>
<div class="form-popup" id="myForm">
<%  try{
		ArrayList<Word> arr = (ArrayList<Word>)request.getAttribute("listWord");
	
		String word = (String)request.getAttribute("word");
		String type = (String)request.getAttribute("type");
%>
  <form action="add?word=<%=word%>&type=<%=type%>&role=admin" class="form-container" method="POST">
    <h1>Them tu moi</h1>

    <label for="email"><b>Tieng anh</b></label>
    <input type="text" placeholder="Enter word" name="tienganh" required>

    <label for="psw"><b>Tieng viet</b></label>
    <input type="text" placeholder="Enter word" name="tiengviet" required>

    <button type="submit" class="btn" id="btn-edit" onclick="alertInsert()">Them moi</button>
    <button type="button" class="btn cancel" onclick="closeForm()">Thoat</button>
  </form>
  
  <%
}catch(NullPointerException e){
	
}
  %>
</div>

<div class="form-popup" id="myFormEdit">
<%  try{
		ArrayList<Word> arr = (ArrayList<Word>)request.getAttribute("listWord");
	
		String word = (String)request.getAttribute("word");
		String type = (String)request.getAttribute("type");
%>
  <form action="#" class="form-container" method="POST">
    <h1>Sua</h1>

    <label for="email"><b>Tieng anh</b></label>
    <input id ="tienganhEdit" type="text" placeholder="Enter word" name="tienganh" required>

    <label for="psw"><b>Tieng viet</b></label>
    <input id="tiengvietEdit" type="text" placeholder="Enter word" name="tiengviet" required>

    <button type="button" class="btn" id="btn-edit" onclick="update()">Cap nhat</button>
    <button type="button" class="btn cancel" onclick="closeFormEdit()">Thoat</button>
  </form>
  
  <%
}catch(NullPointerException e){
	
}
  %>
</div>

</body>
<script type="text/javascript">
   var str;
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
			window.location="http://localhost:8080/dict/search?word="+word+"&type="+type+"&role=admin";
			 return false;
		}
		return true;
       
    }
	function openForm() {
	      document.getElementById("myForm").style.display = "block";
	      document.getElementById("text-boxx").style.webkitFilter = "blur(6px)";
    }

    function closeForm() {
      	document.getElementById("myForm").style.display = "none";
        document.getElementById("text-boxx").style.webkitFilter = "blur(0px)";
    }
    
    function openFormEdit() {
	      document.getElementById("myFormEdit").style.display = "block";
	      document.getElementById("text-boxx").style.webkitFilter = "blur(6px)";
  }
  function alertInsert(){
	  alert("Them thanh cong !")
  }
  function closeFormEdit() {
    	document.getElementById("myFormEdit").style.display = "none";
        document.getElementById("text-boxx").style.webkitFilter = "blur(0px)";
  }
  function update(){
	   var tienganh = document.getElementById("tienganhEdit").value;
	   var tiengviet= document.getElementById("tiengvietEdit").value;
	   window.location=str+"&tienganh="+tienganh+"&tiengviet="+tiengviet;
	   alert("Cap nhat thanh cong !")
  }
   function edit(tienganh,tiengviet,id,word,type){
   	
   	console.log(tienganh);
   	document.getElementById("tienganhEdit").value = tienganh;
   	document.getElementById("tiengvietEdit").value = tiengviet;
   	openFormEdit();
   	str="http://localhost:8080/dict/update?&word="+word+"&type="+type+"&role=admin"+"&id="+id;
   	
   }
   
</script>
</html>







