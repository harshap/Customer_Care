<%
	if(session.getAttribute("userid")==null) {
		response.sendRedirect("login.html");
	}
%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.customer.care.mysql.connector.ConnectToMYSQL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="AddComplaint">
		<input type="hidden" name="createdBy" value="<%=session.getAttribute("userid")%>">
		<table>
			<tr>
				<td>Customer ID: </td>
				<td>
					<select style="background-color: #A0A0A0" name="complaint_by">
					<%
						try {
							ConnectToMYSQL connectToMysQL = new ConnectToMYSQL();
							Connection connection = connectToMysQL.getConnection();
							if(connection!=null) {
								String query = "select id, name from customer";
								PreparedStatement ps = connection.prepareStatement(query);
								ResultSet rs = ps.executeQuery();
								while(rs.next()) {
									String id = rs.getString("id");
									String employeeName = rs.getString("name");
									%> <option value="<%out.print(id); %>"> <%out.print(employeeName); %></option> <%
								}
							} else {
								out.print("error connecting to database");
							}
							connectToMysQL.closeConnection();
						}  catch (ClassNotFoundException e) {
							out.print("Error with database connection: " + e.getMessage());
						} catch (SQLException e) {
							out.print("Error with database connection: " + e.getMessage());
						}
					%>
					</select>
			</tr>
			<tr>
				<td>Assign to: </td>
				<td>
					<select style="background-color: #A0A0A0" name="assign_to">
					<%
						try {
							ConnectToMYSQL connectToMysQL = new ConnectToMYSQL();
							Connection connection = connectToMysQL.getConnection();
							if(connection!=null) {
								String query = "select id, name from employee";
								PreparedStatement ps = connection.prepareStatement(query);
								ResultSet rs = ps.executeQuery();
								while(rs.next()) {
									String id = rs.getString("id");
									String employeeName = rs.getString("name");
									%> <option value="<%out.print(id); %>"> <%out.print(employeeName); %></option> <%
								}
							} else {
								out.print("error connecting to database");
							}
							connectToMysQL.closeConnection();
						}  catch (ClassNotFoundException e) {
							out.print("Error with database connection: " + e.getMessage());
						} catch (SQLException e) {
							out.print("Error with database connection: " + e.getMessage());
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td>Description of complaint: </td>
				<td><input type="text" name="description" value="" required="required"/></td>
			</tr>
			<tr>
				<td>Category: </td>
				<td>
					<select style="background-color: #A0A0A0" name="category">
					<%
						try {
							ConnectToMYSQL connectToMysQLCategory = new ConnectToMYSQL();
							Connection connectionCategory = connectToMysQLCategory.getConnection();
							if(connectionCategory!=null) {
								String query = "select id, name from category";
								PreparedStatement ps = connectionCategory.prepareStatement(query);
								ResultSet rs = ps.executeQuery();
								while(rs.next()) {
									String id = rs.getString("id");
									String categoryName = rs.getString("name");
									%> <option value="<%out.print(id); %>"> <%out.print(categoryName); %></option> <%
								}
							} else {
								out.print("error connecting to database");
							}
							connectToMysQLCategory.closeConnection();
						} catch (ClassNotFoundException e) {
							out.print("Error with database connection: " + e.getMessage());
						} catch (SQLException e) {
							out.print("Error with database connection: " + e.getMessage());
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit"></td>
			</tr>
		</table>
	</form>
</body>
</html>