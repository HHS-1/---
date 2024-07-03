package sign;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dbconfig;



public class admin_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private dbconfig db = new dbconfig();
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    PrintWriter pw = null;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		String admin_id = request.getParameter("admin_id");
		String admin_pw = request.getParameter("admin_pw");
		this.pw = response.getWriter();
		String sql = "select * from admin_info where admin_id=?";
		
		try {
			this.con = this.db.getdbconfig();
			this.ps = this.con.prepareStatement(sql);
			this.ps.setString(1, admin_id);
			this.rs = this.ps.executeQuery();
			this.rs.next();
			
			System.out.println(this.rs.getString("admin_id"));
			if(admin_id.equals(this.rs.getString("admin_id")) && admin_pw.equals(this.rs.getString("admin_pw"))){
				HttpSession se = request.getSession();
				se.setAttribute("admin_id", admin_id);
				this.pw.write("true");
			}else {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			}
		}catch(Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}finally {
			try {
				pw.close();
				rs.close();
				ps.close();
				con.close();
			}catch(Exception e) {
				
			}
		}
		
		
		
	}

}
