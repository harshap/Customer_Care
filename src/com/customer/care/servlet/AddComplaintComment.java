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

/**
 * Servlet implementation class AddComplaintComment
 */
@WebServlet("/AddComplaintComment")
public class AddComplaintComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getSession().getAttribute("userid")==null) {
			response.sendRedirect("login.html");
		}
		
		try {
			String comment = request.getParameter("comment");
			String commentBy = request.getParameter("commentBy");
			String commentComplaintID = request.getParameter("commentID");
			PrintWriter writer = response.getWriter();
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("MMddyyyyhhmmss");
			String timestamp = sdf.format(date);
			
			ConnectToMYSQL connectToMysql = new ConnectToMYSQL();
			Connection connection = connectToMysql.getConnection();
			String query = "insert into complaint_comments (id, complaint_id, comment_by, comment, comment_time) values (?, ?, ?, ?, now())";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, commentComplaintID+"_"+timestamp);
			ps.setString(2, commentComplaintID);
			ps.setString(3, commentBy);
			ps.setString(4, comment);
			int result = ps.executeUpdate();
			writer.write("<html>");
			writer.write("<head><title>Complaint updated</title></head>");
			writer.write("<body bgcolor='#E6E6FA'>");

			writer.write("<div align='center' style='margin-top: 5%'>");
			
			if(result!=0)
				writer.write("Comment uploaded succesfully...");
			else
				writer.write("Error uploading comment, please try again..");
			writer.write("<br/><br/><br/>");
			writer.write("<a href='index.jsp'>Return to main page</a>");
			writer.write("</div>");
			writer.write("</body>");
			writer.write("</html>");
			connectToMysql.closeConnection();
		} catch (ClassNotFoundException e) {
			response.getWriter().write("Error uploading comment, please try again. Error: "+e.getMessage() + request.getParameter("complaint_id"));
		} catch (SQLException e) {
			response.getWriter().write("Error uploading comment, please try again. Error: "+e.getMessage() + request.getParameter("complaint_id"));
		}
	}

}
