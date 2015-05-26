package com.customer.care.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.customer.care.mysql.connector.ConnectToMYSQL;

@WebServlet("/EditComplaint")
public class EditComplaint extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if(req.getSession().getAttribute("userid")==null) {
			resp.sendRedirect("login.html");
		}
		
		try {
			
			String complaintID = req.getParameter("complaintID");
			String assignTo = req.getParameter("assignedTo");
			String status = req.getParameter("status");
			String description = req.getParameter("description");
			String category = req.getParameter("category");
			
			PrintWriter writer = resp.getWriter();
			
			ConnectToMYSQL connectToMysql = new ConnectToMYSQL();
			Connection connection = connectToMysql.getConnection();
			String query = "update complaint set assigned_to=?, status=?, description=?, category=? where id=?";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, assignTo);
			ps.setString(2, status);
			ps.setString(3, description);
			ps.setString(4, category);
			ps.setString(5, complaintID);
			int res = ps.executeUpdate();
			if(res==0) {
				writer.write("error executing insert into complaint");
				return;
			}
			
			writer.write("<html>");
			writer.write("<head><title>Complaint updated</title></head>");
			writer.write("<body bgcolor='#E6E6FA'>");
			
			writer.write("<div align='center' style='margin-top: 5%'>");
			writer.write("Complaint "+complaintID+" updated...<br/><br/>");
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
