package com.customer.care.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.customer.care.mysql.connector.ConnectToMYSQL;

@WebServlet("/AddComplaint")
public class AddComplaint extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getSession().getAttribute("userid")==null) {
			resp.sendRedirect("login.html");
		}
		
		try {
			String complaintBy = req.getParameter("complaint_by");
			String assignTo = req.getParameter("assign_to");
			String description = req.getParameter("description");
			String category = req.getParameter("category");
			String createdBy = req.getParameter("createdBy");
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("MMddyyyyhhmmss");
			String timestamp = sdf.format(date);
			String complaintID = complaintBy + "_" + timestamp;
			
			PrintWriter writer = resp.getWriter();
			
			ConnectToMYSQL connectToMysql = new ConnectToMYSQL();
			Connection connection = connectToMysql.getConnection();
			String query = "insert into complaint (id, created_by, complaint_by, assigned_to, description, category) values (?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, complaintID);
			//TODO: add login
			ps.setString(2, createdBy);
			ps.setString(3, complaintBy);
			ps.setString(4, assignTo);
			ps.setString(5, description);
			ps.setString(6, category);
			int res = ps.executeUpdate();
			if(res==0) {
				writer.write("error executing insert inot complaint");
				return;
			}
			
			writer.write("<html>");
			writer.write("<head><title>Complaint details</title></head>");
			writer.write("<body bgcolor='#E6E6FA'>");
			
			writer.write("<div align='center' style='margin-top: 5%'>");
			writer.write("Complant raised with below details<br/><br/>");
			writer.write("<form>");
			writer.write("<table>");
				writer.write("<tr>");
					writer.write("<td>Complaint ID: </td>");
					writer.write("<td><input type='text' disabled='disabled' readonly='readonly' style='background-color: #A0BBBB' value='"+complaintID+"'/></td>");
					writer.write("</tr>");
			
				writer.write("<tr>");
					writer.write("<td>Complaint raised by customer: </td>");
					writer.write("<td><input type='text' disabled='disabled' readonly='readonly' style='background-color: #A0BBBB' value='"+complaintBy+"'/></td>");
				writer.write("</tr>");
				
				writer.write("<tr>");
					writer.write("<td>Assigned to: </td>");
					writer.write("<td><input type='text' disabled='disabled' readonly='readonly' style='background-color: #A0BBBB' value='"+assignTo+"'/></td>");
				writer.write("</tr>");
			
				writer.write("<tr>");
					writer.write("<td>Category: </td>");
					writer.write("<td><input type='text' disabled='disabled' readonly='readonly' style='background-color: #A0BBBB' value='"+ category + "'/></td>");
				writer.write("</tr>");

				writer.write("<tr>");
					writer.write("<td>Description: </td>");
					writer.write("<td><input type='text' disabled='disabled' readonly='readonly' style='background-color: #A0BBBB' value='"+ description + "'/></td>");
				writer.write("</tr>");
			
			writer.write("</table>");
			writer.write("</form>");
			writer.write("<a href='index.jsp'>Return to main page</a>");
			writer.write("</div>");
			writer.write("</body>");
			writer.write("</html>");
			
			connectToMysql.closeConnection();
		} catch (ClassNotFoundException e) {
			resp.getWriter().write("Error with database connection: " + e.getMessage());
		} catch (SQLException e) {
			resp.getWriter().write("Error with database connection: " + e.getMessage());
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
