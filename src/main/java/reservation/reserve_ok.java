package reservation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dbconfig;

public class reserve_ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
	 	dbconfig db=new dbconfig();
	 	try {
	 Connection dbcon=db.getdbconfig();
	 String r_pname=request.getParameter("pname");
	 String r_room=request.getParameter("r_room");
	 String checkin_date=request.getParameter("checkin_date");
	 String r_name=request.getParameter("r_name");
	 String r_tel=request.getParameter("r_tel");
	 String r_cp=request.getParameter("r_cp");
	 String r_email=request.getParameter("r_email");
	 
	 
	 String sql="insert into reserve_data values('0',?,?,?,?,?,?,?,now())";
	 PreparedStatement ps=dbcon.prepareStatement(sql);
	 ps.setString(1, r_pname);
	 ps.setString(2, r_room);
	 ps.setString(3, checkin_date);
	 ps.setString(4, r_name);
	 ps.setString(5, r_tel);
	 ps.setString(6, r_cp);
	 ps.setString(7, r_email);
	 int result=ps.executeUpdate();
	 PrintWriter pw=response.getWriter();
	 if(result>0) {
		 pw.write("<script>alert('예약이 완료되었습니다.'); location.href='./m_index.jsp';</script>");
	 }
	 else {
		 pw.write("<script>alert('예약정보를 확인해주세요.'); history.go(-1);");
	 }
	 ps.close();
	 pw.close();
	 dbcon.close();
	 	}catch(Exception e) {
	 		e.printStackTrace();
	 	}
	}
}
