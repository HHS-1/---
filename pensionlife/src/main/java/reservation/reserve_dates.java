package reservation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dbconfig;

public class reserve_dates extends HttpServlet {
    private static final long serialVersionUID = 1L;
//예약된 날짜의 객실정보를 업데이트 하기 위한 json배열화 (달력 선택시 작동)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        request.setCharacterEncoding("utf-8");

        String rname = request.getParameter("rname");

        try {
            dbconfig db = new dbconfig();
            Connection dbcon = db.getdbconfig();
            String sql = "select checkin_date from reserve_data where r_room = ?";
            PreparedStatement ps = dbcon.prepareStatement(sql);
            ps.setString(1, rname);
            ResultSet rs = ps.executeQuery();

            ArrayList<String> reserved_dates = new ArrayList<String>();
            while (rs.next()) {
                reserved_dates.add(rs.getString("checkin_date"));
            }

            StringBuilder datesJson = new StringBuilder("[");
            for (int i = 0; i < reserved_dates.size(); i++) {
                datesJson.append("\"").append(reserved_dates.get(i)).append("\"");
                if (i < reserved_dates.size() - 1) {
                    datesJson.append(",");
                }
            }
            datesJson.append("]");

            PrintWriter pw = response.getWriter();
            pw.write(datesJson.toString());
            
            pw.close();
            rs.close();
            ps.close();
            dbcon.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
