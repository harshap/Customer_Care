<%
	if(session.getAttribute("userid")==null) {
		response.sendRedirect("login.html");
	}
%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
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
<form action="edit_complaint.jsp">
		<table>
			<%
				try {
					ConnectToMYSQL connectToMysQL = new ConnectToMYSQL();
					Connection connection = connectToMysQL.getConnection();
					if(connection!=null) {
						String query = "select id from complaint";
						PreparedStatement ps = connection.prepareStatement(query);
						ResultSet rs = ps.executeQuery();
						%>
						<tr>
						<td>Ticket ID: </td>
						<td>
						<select style="background-color: #A0A0A0" id="complaint_id" name="complaint_id">
						<%
						while(rs.next()) {
							String id = rs.getString("id");
							%>
								<option value="<%out.print(id);%>"><%out.print(id);%></option>
							<%
						}
						%>
						</select>
						</td>
						</tr>
						<tr>
							<td></td>
							<td><input type="submit"/></td>
						</tr>
						<%
					} else {
						out.print("error connecting to database");
					}
					connectToMysQL.closeConnection();
				} catch (ClassNotFoundException e) {
					out.print("Error with database connection: " + e.getMessage());
				} catch (SQLException e) {
					out.print("Error with database connection: " + e.getMessage());
				}
			%>
		</table>
	</form>
</body>
</html>