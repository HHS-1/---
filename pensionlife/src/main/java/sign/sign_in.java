package sign;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dbconfig;


public class sign_in extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private dbconfig db = new dbconfig();
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    PrintWriter pw = null;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 	request.setCharacterEncoding("utf-8");
	     	response.setContentType("text/html; charset=utf-8");
	        
	        //String[] login_info = request.getParameterValues("login_info");
	     	String user_id = request.getParameter("user_id");
	     	String user_pw = request.getParameter("user_pw");
	        String login_auto = request.getParameter("login_auto");
	        System.out.println(user_id);
	        HttpSession se = request.getSession();
	        se.setAttribute("login_check", true);
	        
	        try {
	        	this.pw = response.getWriter();
	            this.con = this.db.getdbconfig();
	            
	            //일반 로그인
	            String sql1 = "SELECT * FROM user_info WHERE user_id=?";
	            this.ps = this.con.prepareStatement(sql1);
	            this.ps.setString(1, user_id);
	            this.rs = this.ps.executeQuery();
	            rs.next();
	            
	            if(user_pw.equals(rs.getString("user_pw"))) {
	            	
	            	se.setAttribute("user_id", rs.getString("user_id"));
	            	se.setAttribute("user_name", rs.getString("user_name"));
	            	se.setAttribute("login_auto", login_auto);
	            	
	            	this.pw.write("true");
	            }else {
	            	response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	            }
	          
	        }catch(Exception e) {
	        	response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        }finally {
	        	try {
	        		this.pw.close();
		        	this.rs.close();
		        	this.ps.close();
		        	this.con.close();
	        	}catch(Exception e) {
	        		
	        	}
	        	
	        	
	        }
	        
	}

}
