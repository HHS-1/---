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

@WebServlet("/check_id")
public class check_id extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	private dbconfig db = new dbconfig();
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    PrintWriter pw = null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String user_id = request.getParameter("user_id");
		this.pw = response.getWriter();
		
		try {
			this.con = this.db.getdbconfig();
			String sql = "select user_id from user_info where user_id=?";
			this.ps = this.con.prepareStatement(sql);
			this.ps.setString(1, user_id);
			this.rs = this.ps.executeQuery();
			if(!this.rs.next()) {
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
