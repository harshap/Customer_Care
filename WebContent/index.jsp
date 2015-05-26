<%
	if(session.getAttribute("userid")==null) {
		response.sendRedirect("login.html");
	}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome to customer care database manager</title>
<script>
	function showComplaintForm() {
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("form_content").innerHTML = xmlhttp.responseText;
			}
		}
		xmlhttp.open("GET", "add_complaint_ajax.jsp", true);
		xmlhttp.send();
	}
	
	function showEditComplaintForm() {
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("form_content").innerHTML = xmlhttp.responseText;
			}
		}
		xmlhttp.open("GET", "edit_complaint_ajax.jsp", true);
		xmlhttp.send();
	}
	
	function showAddComments() {
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("form_content").innerHTML = xmlhttp.responseText;
			}
		}
		xmlhttp.open("GET", "add_comments_ajax.jsp", true);
		xmlhttp.send();
	}
	
</script>
</head>
<body bgcolor="#E6E6FA">

	<div align="center" style="margin-top: 10%">
		<a href="javascript:showComplaintForm()">Raise complaint</a> <br/><br/>
		<a href="javascript:showEditComplaintForm()">View/Edit complaint</a> <br/><br/>
		<a href="javascript:showAddComments()">View/Add comments</a> <br/><br/>
		<a href="logout.jsp">Logout</a> <br/><br/>
	</div>
	<br/><br/><br/><br/>
	<div id="form_content" align="center">
	</div>
</body>
</html>