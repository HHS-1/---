package sign;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dbconfig;

@WebServlet("/sign_up")
public class sign_up extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private dbconfig db = new dbconfig();
    private Connection con = null;
    private PreparedStatement ps = null;
    PrintWriter pw = null;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        
        String[] userInfo = request.getParameterValues("u_info");
        System.out.println(Arrays.toString(userInfo));
        ResultSet rs = null;

        try {
        	this.pw = response.getWriter();
            this.con = this.db.getdbconfig();
            String sql1 = "SELECT * FROM user_info WHERE user_id=?";
            this.ps = this.con.prepareStatement(sql1);
            this.ps.setString(1, userInfo[0]);
            rs = this.ps.executeQuery();
            if(rs.next() == true) {
            	this.pw.append("<script>"
            			+ "alert('아이디가 중복됩니다.');"
            			+ "history.go(-1);"
            			+ "</script>");
            }else {
            	String sql2 = "insert into user_info values('0',?,?,?,?,?,?,?,?,?,?,now())";
            	this.ps = this.con.prepareStatement(sql2);
            	
            	for(int f = 0 ; f < userInfo.length ; f++) {
            		this.ps.setString(f+1, userInfo[f]);
            	}
            	int result = this.ps.executeUpdate();        	
    
            	if(result > 0) {
            		this.pw.append("<script>"
                			+ "alert('회원가입이 완료되었습니다.');"
                			+ "location.href = './m_index.jsp';"
                			+ "</script>");
            	}else {
            		this.pw.append("<script>"
                			+ "alert('회원가입 정보를 확인해주세요.');"
                			+ "history.go(-1);"
                			+ "</script>");
            	}
            }
          
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database connection failed: " + e.getMessage());
        } finally {
            try {
            	pw.close();
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
