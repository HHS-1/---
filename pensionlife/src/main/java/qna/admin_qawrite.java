package qna;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dbconfig;

public class admin_qawrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String qadmin = request.getParameter("qadmin");
		String qidx = request.getParameter("qidx");
		String qhandle = "답변완료";
		
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		try {
			dbconfig db = new dbconfig();
			con = db.getdbconfig();
			String sql = "update qa_board set qadmin=? ,qhandle=? where qidx=?";
			pst = con.prepareStatement(sql);
			pst.setString(1, qadmin);
			pst.setString(2, qhandle);
			pst.setString(3, qidx);
			int result = pst.executeUpdate();
			if(result > 0) {
				response.getWriter().write("<script>"
						+ "alert('답변이 등록되었습니다.');"
						+ "location.href='./admin_qalist.jsp';"
						+ "</script>");
			}
			

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				pst.close();
				con.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
	}
}
