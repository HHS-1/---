package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class dbconfig {
	public Connection getdbconfig() throws Exception{
			String db_driver = "com.mysql.jdbc.Driver";
			String db_url = "jdbc:mysql://webmiwon.co.kr:3306/hsm_402";
			String db_id = "hsm_402";
			String db_pass = "402hsm";
			Class.forName(db_driver);
			Connection dbcon = DriverManager.getConnection(db_url, db_id, db_pass);
			
			return dbcon;
	}
}
