package com.customer.care.mysql.connector;

import java.sql.*;

public class ConnectToMYSQL {

	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	private static final String HOST = "localhost";
	private static final String PORT = "3306";
	private static final String DB_URL = "jdbc:mysql://";

	// Database credentials
	private static String USER = "root";
	private static String PASSWORD = "";
	private static String DATABASE_NAME = "";
	
	private static Connection connection = null;

	public ConnectToMYSQL() {
		DATABASE_NAME = "customer_care";
	}
	
	public ConnectToMYSQL(String databaseName) {
		DATABASE_NAME = databaseName;
	}
	
	/**
	 * 
	 * @param username
	 * @param password
	 * @param databaseName
	 */
	public ConnectToMYSQL(String username, String password, String databaseName) {
		USER = username;
		PASSWORD = password;
		DATABASE_NAME = databaseName;
	}

	/**
	 * 
	 * @return - If successful return "java.sql.Connection" else return null; 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		try {
			if(connection==null){
				Class.forName(JDBC_DRIVER);
				connection = DriverManager.getConnection(DB_URL+HOST+":"+PORT+"/"+DATABASE_NAME, USER, PASSWORD);
			}
			return connection;
		} catch (SQLException e) {
			//log exception if needed
			throw e;
		} catch (ClassNotFoundException e) {
			// log exception if needed
			throw e;
		}
	}
	
	/**
	 * 
	 * @return - returns true if connection is closed successfully
	 * @throws SQLException 
	 */
	public boolean closeConnection() throws SQLException{
		try {
			if(connection!=null) {
				connection.close();
				connection = null;
			}
			return true;
		} catch (SQLException e) {
			// log exception if needed
			throw e;
		}
		
	}
	
}
