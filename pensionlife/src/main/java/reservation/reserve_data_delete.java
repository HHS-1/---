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

public class reserve_data_delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
	 	dbconfig db=new dbconfig();
	 	try {
	 		Connection dbcon=db.getdbconfig();
	 		String ridx=request.getParameter("ridx");
	 		String sql="delete from reserve_data where r_idx=?";
	 		PreparedStatement ps=dbcon.prepareStatement(sql);
	 		ps.setString(1, ridx);
	 		PrintWriter pw=response.getWriter();
	 		int result=ps.executeUpdate();
	 		if(result>0) {
	 			pw.write("<script> alert('예약 취소 완료'); location.href='./m_reservation_list.jsp'</script>");
	 		}
	 		else {
	 			pw.write("<script> alert('예약 취소 실패. 고객센터로 문의 바랍니다.');location.href='./m_reservation_list.jsp';</script>");
	 		}
	 		 ps.close();
	 		 pw.close();
	 		 dbcon.close();
	 	}catch(Exception e) {
	 		System.out.println(e);
	 	}
	 	
	}

}
