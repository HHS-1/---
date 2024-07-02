package qna;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.dbconfig;
@MultipartConfig(
		fileSizeThreshold = 1024*1024*2,
		maxFileSize = 1024*1024*4,
		maxRequestSize = 1024*1024*100
		)
public class m_qamod extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		HttpSession se = request.getSession();
		String file1_del = request.getParameter("file1_del");
		String file2_del = request.getParameter("file2_del");
		String qidx = request.getParameter("qidx");		
		String qtitle = request.getParameter("qtitle");
		String qtext = request.getParameter("qtext");
		Part qfile1 = request.getPart("qfile1"); 
		Part qfile2 = request.getPart("qfile2");
		String qfile = "";
		dbconfig db = new dbconfig();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		
		try {
			con = db.getdbconfig();
			String sql = "select * from qa_board where qidx=?";
			pst = con.prepareStatement(sql);
			pst.setString(1, qidx);
			rs = pst.executeQuery();
			rs.next();
			qfile = rs.getString("qfile");
			String dbfile = rs.getString("qfile");
			
			//서버의 IP주소를 받아서 경로 저장
			InetAddress localHost = InetAddress.getLocalHost();
	        String localIPAddress = localHost.getHostAddress();
			String filedburl = "http://"+localIPAddress+":8080/upload/";
			String fileSaveUrl = request.getServletContext().getRealPath("/upload/");
			
			System.out.println(file1_del);
			System.out.println(file2_del);
			//실제 파일 삭제
			if(!qfile.equals("")) {
				//첨부파일이 2개인 경우
				if(qfile.contains(",")){
					int i = qfile.indexOf(",");
					
					String dbqfile1 = qfile.substring(0,i);
					String dbqfile2 = qfile.substring(i+1);
					
					int id1 = dbqfile1.lastIndexOf("/");
					int id2 = dbqfile2.lastIndexOf("/");
					String filenm1 = dbqfile1.substring(id1+1);
					String filenm2 = dbqfile2.substring(id2+1);
					
					if(file1_del.equals("Y")) {
						qfile = "";
						File fe1 = new File(fileSaveUrl+filenm1); 
						fe1.delete();
					}
					if(file2_del.equals("Y")) {
						qfile = "";
						File fe2 = new File(fileSaveUrl+filenm2); 
						fe2.delete();
					}
				}
				//첨부파일이 1개인 경우
				else {
					int id = qfile.lastIndexOf("/");
					String filenm = qfile.substring(id+1);
					if(file1_del.equals("Y")) {
						qfile = "";
						File fe = new File(fileSaveUrl+filenm); 
						fe.delete();
					}
				}
			}
			
			
			//파일저장
			//첫번째 첨부파일이 있는경우
			if(qfile1.getSize()>0) {
				String fileName = qfile1.getSubmittedFileName();
				rename rn = new rename(fileName);
				String refilename = rn.filenm;
				qfile1.write(fileSaveUrl+refilename);
				qfile = filedburl + refilename;
				
				//첨부파일이 두개인 경우
				if(qfile2.getSize()>0) {
					String fileName2 = qfile2.getSubmittedFileName();
					rename rn2 = new rename(fileName2);
					String refilename2 = rn2.filenm;
					qfile2.write(fileSaveUrl+refilename2);
					qfile += ","+filedburl + refilename2;
				}
			}
			//두번째 첨부파일에만 파일이 있는 경우
			else if(qfile2.getSize()>0) {
				String fileName2 = qfile2.getSubmittedFileName();
				rename rn2 = new rename(fileName2);
				String refilename2 = rn2.filenm;
				qfile2.write(fileSaveUrl+refilename2);
				if(file1_del.equals("N")) {
					qfile =  dbfile + "," + filedburl + refilename2;
				}else {
					qfile = filedburl + refilename2;
				}
			}
			
			
			System.out.println(qfile);
			String sql2 = "update qa_board set qtitle=? , qtext=? , qfile=? where qidx=?";
			pst = con.prepareStatement(sql2);
			pst.setString(1, qtitle);
			pst.setString(2, qtext);
			pst.setString(3, qfile);
			pst.setString(4, qidx);
		
			int result = pst.executeUpdate();
			if(result > 0) {
				response.getWriter().write("<script>"
						+ "alert('문의내용이 수정되었습니다.');"
						+ "location.href='./m_qalist.jsp';"
						+ "</script>");	
			}
			
			
		}catch(Exception e) {
			System.out.println(e);
			response.getWriter().write("<script>"
					+ "alert('수정에 실패하였습니다.');"
					+ "location.href='./m_qalist.jsp';"
					+ "</script>");
		}finally {
			try {
				pst.close();
				rs.close();
				con.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}
