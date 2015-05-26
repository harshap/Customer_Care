<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.customer.care.mysql.connector.ConnectToMYSQL"%>
<%
	String user=request.getParameter("username");
	String password=request.getParameter("password");
	ConnectToMYSQL connectToMYSQL = new ConnectToMYSQL();
	Connection conn = connectToMYSQL.getConnection();
	
	String query = "Select name from employee where id=? and password=?";
	PreparedStatement ps = conn.prepareStatement(query);
	ps.setString(1, user);
	ps.setString(2, password);
	ResultSet rs = ps.executeQuery();
	if(rs.next()){
		session.setAttribute("userid", user);
		response.sendRedirect("index.jsp");
	}
	else
		response.sendRedirect("login.html");
	connectToMYSQL.closeConnection();
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>