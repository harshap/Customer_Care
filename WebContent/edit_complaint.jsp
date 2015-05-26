<%
	if(session.getAttribute("userid")==null) {
		response.sendRedirect("login.html");
	}
%>
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
	<form action="EditComplaint">
		<table>
			<%
				String complaintID = request.getParameter("complaint_id");
				ConnectToMYSQL connectToMysQL = new ConnectToMYSQL();
				Connection connection = connectToMysQL.getConnection();
				if(connection!=null && complaintID!=null && complaintID.trim().length()>0) {
					String query = "select customer.name, created_by, complaint_by, assigned_to, status, description, category from complaint, customer where complaint.id=? and customer.id=complaint.complaint_by";
					PreparedStatement ps = connection.prepareStatement(query);
					ps.setString(1, complaintID);
					ResultSet rs = ps.executeQuery();
					rs.next();
					String createdBy = rs.getString("created_by");
					String complaintBy = rs.getString("complaint_by");
					String assignedTo = rs.getString("assigned_to");
					String status = rs.getString("status");
					String descriptopn = rs.getString("description");
					String category = rs.getString("category");
					String customerName = rs.getString("name");
					if(assignedTo==null)
						assignedTo="";
					%>
					<tr>
						<td>Ticket ID: </td>
						<td><input type="text" readonly="readonly" style="background-color: #A0A0A0" name="complaintID" value="<%=complaintID%>" <%=status.equalsIgnoreCase("closed")?"disabled='disabled'":"" %>/></td>
					</tr>
					<tr>
						<td>Created By:</td>
						<td><input type="text" readonly="readonly" style="background-color: #A0A0A0" value="<%=createdBy %>" id="created_by" style="background-color: #A0A0A0" <%=status.equalsIgnoreCase("closed")?"disabled='disabled'":"" %>></td>
					</tr>
					<tr>
						<td>Complaint By:</td>
						<td><input type="text" readonly="readonly" style="background-color: #A0A0A0" value="<%out.print(customerName+" ("+complaintBy+")");%>" style="background-color: #A0A0A0" <%=status.equalsIgnoreCase("closed")?"disabled='disabled'":"" %>></td>
					</tr>
					<tr>
						<td>Assigned To:</td>
						<td>
							<select name="assignedTo" <%=status.equalsIgnoreCase("closed")?"disabled='disabled'":"" %> >
								<option selected="selected" value="" disabled="disabled">Select...</option>
								<%
								String query1 = "select id, name from employee";
								PreparedStatement ps1 = connection.prepareStatement(query1);
								ResultSet rs1 = ps1.executeQuery();
								while(rs1.next()) {
									%> <option value="<%out.print(rs1.getString("id")); %>" <%=assignedTo.equals(rs1.getString("id"))?"selected='selected'":"" %>> <%out.print(rs1.getString("name")); %></option> <%
								}
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td>Status:</td>
						<td>
							<select name="status" <%=status.equalsIgnoreCase("closed")?"disabled='disabled'":"" %>>
								<option value="open" <%=status.equalsIgnoreCase("open")?"selected='selected'":"" %>>Open</option>
								<option value="closed" <%=assignedTo.equalsIgnoreCase("closed")?"selected='selected'":"" %>>Closed</option>
							</select>
						</td>
					</tr>
				<tr>
					<td>Description:</td>
					<td><input type="text" value="<%=descriptopn %>" name="description" <%=status.equalsIgnoreCase("closed")?"disabled='disabled'":"" %>></td>
				</tr>
				<tr>
					<td>Category:</td>
					<td>
						<select name="category" <%=status.equalsIgnoreCase("closed")?"disabled='disabled'":"" %>>
							<%
							String query2 = "select id, name from category";
							PreparedStatement ps2 = connection.prepareStatement(query2);
							ResultSet rs2 = ps2.executeQuery();
							while(rs2.next()) {
								%> <option value="<%out.print(rs2.getString("id")); %>" <%=category.equals(rs2.getString("id"))?"selected='selected'":"" %>> <%out.print(rs2.getString("name")); %></option> <%
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" <%=status.equalsIgnoreCase("closed")?"disabled='disabled'":"" %>/></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="hidden" value="<%=complaintBy %>" id="complaint_by"></td>
				</tr>
					<%
				} else {
					out.print("error connecting to database");
				}
				connectToMysQL.closeConnection();
			%>
			</table>
			<a href='index.jsp'>Return to main page</a>
	</form>
</div>
</body>
</html>