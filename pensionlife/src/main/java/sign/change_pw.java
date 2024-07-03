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


@WebServlet("/change_pw")
public class change_pw extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private dbconfig db = new dbconfig();
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    PrintWriter pw = null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		this.pw = response.getWriter();
		String user_id = request.getParameter("user_id");
		String user_name = request.getParameter("user_name");
		String user_tel = request.getParameter("user_tel");
		
		try {
			String sql = "select * from user_info where user_id=? and user_name=? and user_tel=?";
			this.con = this.db.getdbconfig();
			this.ps = this.con.prepareStatement(sql);
			this.ps.setString(1, user_id);
			this.ps.setString(2, user_name);
			this.ps.setString(3, user_tel);
			this.rs = this.ps.executeQuery();
			if(this.rs.next()) {
				this.pw.write("true");
			}else {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			}
		}catch(Exception e) {
			System.out.println(("비밀번호 변경 part - " + e));
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
		
	}

}
