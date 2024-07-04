package reservation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dbconfig;

public class room_info extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 	response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
	 	dbconfig db=new dbconfig();
	 	try {
	 Connection dbcon=db.getdbconfig();
	 String rname=request.getParameter("rname");
	 String sql="select * from pension_list where rname=?";
	 PreparedStatement ps=dbcon.prepareStatement(sql);
	 ps.setString(1, rname);
	 ResultSet rs=ps.executeQuery();
	 rs.next();
	 PrintWriter pw=response.getWriter();
		 String rdetail=rs.getString("rdetail");
		 String rsp=rs.getString("rsp");
		 String rmp=rs.getString("rmp");
		 String rprice=rs.getString("rprice");
		 String jsonData = "{"
                 + "\"rdetail\": \"" + rdetail + "\","
                 + "\"rsp\": \"" + rsp + "\","
                 + "\"rmp\": \"" + rmp + "\","
                 + "\"rprice\": \"" + rprice + "\""
                 + "}";
		 pw.write(jsonData);
		 
	 pw.close();
	 rs.close();
	 ps.close();
	 dbcon.close();
	 	}catch(Exception e) {
	 		e.printStackTrace();
	 	}
	}
}