package reservation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dbconfig;

public class available_rooms extends HttpServlet {
	private static final long serialVersionUID = 1L;
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        response.setContentType("text/html;charset=utf-8");
	        request.setCharacterEncoding("utf-8");
	        String pname = request.getParameter("pname");
	        String checkin_date = request.getParameter("checkin_date");

	        dbconfig db = new dbconfig();
	        List<String> available_rooms = new ArrayList<>();

	        String sql = "select rname from pension_list where pname=? and rname not in (select r_room from reserve_data where checkin_date=?)";
	        try {
	        	Connection dbcon = db.getdbconfig();
	            PreparedStatement ps = dbcon.prepareStatement(sql);
	            ps.setString(1, pname);
	            ps.setString(2, checkin_date);
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	            	available_rooms.add(rs.getString("rname"));
	            }
	            rs.close();
	            ps.close();
	            dbcon.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }


	        PrintWriter pw = response.getWriter();

	        
	        StringBuilder json = new StringBuilder();
	        json.append("[");
	        for (int i = 0; i < available_rooms.size(); i++) {
	            json.append("\"").append(available_rooms.get(i)).append("\"");
	            if (i < available_rooms.size() - 1) {
	                json.append(",");
	            }
	        }
	        json.append("]");
	        //System.out.println(json);
	        pw.write(json.toString());
	        pw.flush();
	        pw.close();
	    }
	}