package qna;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.dbconfig;
@MultipartConfig(
		fileSizeThreshold = 1024*1024*2,
		maxFileSize = 1024*1024*4,
		maxRequestSize = 1024*1024*100
		)
public class m_qawrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String qhead = request.getParameter("qhead");		
		String user_id = request.getParameter("qname");
		String user_name = request.getParameter("qname");
		String user_tel = request.getParameter("qtel");
		String user_email = request.getParameter("qemail");
		String qtitle = request.getParameter("qtitle");
		String qtext = request.getParameter("qtext");
		Part qfile1 = request.getPart("qfile1"); 
		Part qfile2 = request.getPart("qfile2");
		String qfile = "";
		
		InetAddress localHost = InetAddress.getLocalHost();
        String localIPAddress = localHost.getHostAddress();
		String filedburl = "http://"+localIPAddress+":8080/upload/";
		String fileSaveUrl = request.getServletContext().getRealPath("/upload/");
		if(qfile1.getSize()>0) {
			String fileName = qfile1.getSubmittedFileName();
			rename rn = new rename(fileName);
			String refilename = rn.filenm;
			qfile1.write(fileSaveUrl+refilename);
			qfile = filedburl + refilename;
			
			if(qfile2.getSize()>0) {
				String fileName2 = qfile2.getSubmittedFileName();
				rename rn2 = new rename(fileName2);
				String refilename2 = rn2.filenm;
				qfile2.write(fileSaveUrl+refilename2);
				qfile += ","+filedburl + refilename2;
			}
		}else if(qfile2.getSize()>0) {
			String fileName2 = qfile2.getSubmittedFileName();
			rename rn2 = new rename(fileName2);
			String refilename2 = rn2.filenm;
			qfile2.write(fileSaveUrl+refilename2);
			qfile = filedburl + refilename2;
		}

		
		PreparedStatement pst = null;
		Connection con = null;
		
		try {
			dbconfig db = new dbconfig();
			con = db.getdbconfig();
			
			String sql = "insert into qa_board values('0',?,?,?,?,?,?,?,?,'미답변',now())";
			pst = con.prepareStatement(sql);
			pst.setString(1, qhead);
			pst.setString(2, user_id);
			pst.setString(3, user_name);
			pst.setString(4, user_tel);
			pst.setString(5, user_email);
			pst.setString(6, qtitle);
			pst.setString(7, qtext);
			pst.setString(8, qfile);
		
			int result = pst.executeUpdate();
			if(result > 0) {
				response.getWriter().write("<script>"
						+ "alert('문의가 정상적으로 등록되었습니다.');"
						+ "location.href='./m_qalist.jsp';"
						+ "</script>");	
			}
			
			pst.close();
			con.close();
		}catch(Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
	}
}
