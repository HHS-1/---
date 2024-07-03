package qna;

import java.io.File;
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

public class m_qadel extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		try {
			dbconfig db = new dbconfig();
			con = db.getdbconfig();
			
			String qidx = request.getParameter("qidx");
			//Ajax사용 jsp에서 받아오는 변수
			String modfile1 = request.getParameter("modfile1");
			String modfile2 = request.getParameter("modfile2");
			
			String sql = "select qfile from qa_board where qidx=?";
			pst = con.prepareStatement(sql);
			pst.setString(1, qidx);
			rs = pst.executeQuery();
			rs.next();
			
			String qfile = rs.getString("qfile");
			String dbqfile1 = "";
			String dbqfile2 = "";
			
			if(!qfile.equals("")) {
				String url = request.getServletContext().getRealPath("/upload/");
				//첨부파일이 2개인 경우
				if(qfile.contains(",")){
					int i = qfile.indexOf(",");
					
					dbqfile1 = qfile.substring(0,i);
					dbqfile2 = qfile.substring(i+1);
					
					
					
					int id1 = dbqfile1.lastIndexOf("/");
					int id2 = dbqfile2.lastIndexOf("/");
					String filenm1 = dbqfile1.substring(id1+1);
					String filenm2 = dbqfile2.substring(id2+1);
					if(modfile1 != null) {
					File fe1 = new File(url+filenm1); 
					fe1.delete();
					}
					if(modfile2 != null) {
					File fe2 = new File(url+filenm2); 
					fe2.delete();
					}
				}
				//첨부파일이 1개인 경우
				else {
					int id = qfile.lastIndexOf("/");
					String filenm = qfile.substring(id+1);
					
					File fe = new File(url+filenm); 
					fe.delete();
				}
			}
			//DB삭제
			String sql2 = "delete from qa_board where qidx=?";
			pst = con.prepareStatement(sql2);
			pst.setString(1, qidx);
			int result = pst.executeUpdate();
			if(result > 0) {
				response.getWriter().write("<script>"
						+ "alert('정상적으로 삭제되었습니다.');"
						+ "location.href='./m_qalist.jsp';"
						+ "</script>");
			}
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				//rs.close();
				//pst.close();
				con.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
