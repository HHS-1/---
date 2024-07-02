package page;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//page3.jsp로드 및 데이터 전달
public class page4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String room = "조선호텔";
		String room_info = "중앙 402호";
		request.setAttribute("room", room);
		request.setAttribute("room_info", room_info);
		
		//view(jsp를 단 한 개만 로드 가능)ㄴ
		RequestDispatcher rd = request.getRequestDispatcher("./page3.jsp");
		rd.forward(request, response);
	}

}
