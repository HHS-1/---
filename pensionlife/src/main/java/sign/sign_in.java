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
	        
	        String[] login_info = request.getParameterValues("login_info");
	        
	        System.out.println(Arrays.toString(login_info));
	        
	        try {
	        	this.pw = response.getWriter();
	            this.con = this.db.getdbconfig();
	            String sql1 = "SELECT * FROM user_info WHERE user_id=?";
	            this.ps = this.con.prepareStatement(sql1);
	            this.ps.setString(1, login_info[0]);
	            this.rs = this.ps.executeQuery();
	            rs.next();
	            
	            if(login_info[0].equals(rs.getString("user_id")) && login_info[1].equals(rs.getString("user_pw"))) {
	            	HttpSession se = request.getSession();
	            	se.setAttribute("user_id", login_info[0]);
	            	se.setAttribute("user_pw", login_info[1]);
	            	this.pw.write("<script>"
	            			+ "alert('로그인 성공');"
	            			+ "location.href='./m_index.jsp';"
	            			+ "</script>");
	            }else {
	            	this.pw.write("<script>"
	            			+ "alert('로그인 실패');"
	            			+ "history.go(-1);"
	            			+ "</script>");
	            }
	        }catch(Exception e) {
	        	
	        }
	        
	}

}
