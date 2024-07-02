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

import model.dbconfig;

@WebServlet("/find_id")
public class find_id extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	private dbconfig db = new dbconfig();
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    PrintWriter pw = null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String user_name = request.getParameter("user_name");
		String user_tel = request.getParameter("user_tel");
		String user_email = request.getParameter("user_email"); 

		String sql = "select user_id from user_info where user_name=? and user_tel=?";
		try {
			this.con = db.getdbconfig();
			this.ps = this.con.prepareStatement(sql);
			this.ps.setString(1, user_name);
			this.ps.setString(2, user_tel);
			this.rs = this.ps.executeQuery();
			this.rs.next();
			
			this.pw = response.getWriter();
			System.out.println(this.rs.getString("user_id"));
			this.pw.write(this.rs.getString("user_id"));
			
		}catch(Exception e) {
			System.out.println(e);
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
