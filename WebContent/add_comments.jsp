<%
	if(session.getAttribute("userid")==null) {
		response.sendRedirect("login.html");
	}
%>
<%@page import="java.sql.Timestamp"%>
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
<title>Edit complaint</title>
</head>
<body bgcolor="#E6E6FA">
<div align="center" style="margin-top: 5%">
	<form action="AddComplaintComment">
		<textarea rows="5" cols="40" placeholder="Please enter your comment.." name="comment"></textarea>
		<input type="hidden" name="commentID" value="<%=request.getParameter("complaint_id")%>"/>
		<!-- Add user name -->
		<input type="hidden" name="commentBy" value="<%=session.getAttribute("userid")%>"/>
		<br/>
		<input type="submit">
	</form>
	<br/><br/>
	<table border="1">
		<%
			String complaintID = request.getParameter("complaint_id");
			ConnectToMYSQL connectToMysQL = new ConnectToMYSQL();
			Connection connection = connectToMysQL.getConnection();
			if(connection!=null && complaintID!=null && complaintID.trim().length()>0) {
				String query = "select comment_by, comment, comment_time from complaint_comments where complaint_id=?";
				PreparedStatement ps = connection.prepareStatement(query);
				ps.setString(1, complaintID);
				ResultSet rs = ps.executeQuery();
				%>
				<tr><td>Comment</td><td>Commented by</td><td>Commented at</td></tr>
				<%
				while(rs.next()){
					String commentBy = rs.getString("comment_by");
					String comment = rs.getString("comment");
					Timestamp timestamp = rs.getTimestamp("comment_time");
					%><tr>
						<td><%=comment %></td>
						<td><%=commentBy %></td>
						<td><%=timestamp %></td>
					</tr><%
				}
			} else {
				out.print("error connecting to database");
			}
			connectToMysQL.closeConnection();
		%>
	</table>
	<br/><br/>
	<a href='index.jsp'>Return to main page</a>
</div>
</body>
</html>