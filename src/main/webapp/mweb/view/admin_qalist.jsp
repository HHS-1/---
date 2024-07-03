<%@page import="org.apache.tomcat.dbcp.dbcp2.PStmtKey"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dbconfig" %>
<%
	dbconfig db = new dbconfig();
	Connection dbcon = db.getdbconfig();
	
	//리스트 10개씩 출력
	int pno = 1;
	if(request.getParameter("pno") != null){
		pno = Integer.parseInt(request.getParameter("pno")); 
	}
	
	int pages = (pno-1)*10;
	int list = 10;
	
	//DB데이터 역순으로 10개씩 가져옴
	String sql = "select * from qa_board where qhandle='미답변' order by qidx desc limit ?,?";
	PreparedStatement pst = dbcon.prepareStatement(sql);
	pst.setInt(1, pages);
	pst.setInt(2, list);
	ResultSet rs = pst.executeQuery();
	
	//DB qa_board 데이터개수 파악
	String sql2 = "select count(*) as ctn from qa_board";
	pst = dbcon.prepareStatement(sql2);
	ResultSet rs2 = pst.executeQuery();
	rs2.next();
	int ctn = rs2.getInt("ctn");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="../css/index.css?v=5">
    <script src="../js/jquery.js"></script>
    <script src="../js/admin_qalist.js"></script>
</head>
<body>
<form id="frm">
<input type="hidden" id="hd" name="qidx" value="">
</form>
<header class="admin_header"><img src="../img/header_logo.png"></header>
<aside class="admin_qa">
    <p><img src="../img/logo.png"><span>님 환영합니다.[로그아웃]</span></p>
</aside>
<article class="admin_lists">
    <p>QA 문의 게시판 미답변 리스트</p>
    <ul class="lists_uls color1">
        <li>제목</li>
        <li>글쓴이</li>
        <li>등록일</li>
    </ul>
    <!--qa 데이터 출력 리스트 부분 -->
    <%if(ctn<=0){ %>
    <ul class="lists_uls">
	    <li style="text-align: left;">
	    문의한 내용이 없습니다.
	    </li>
	</ul>
    <%}else{while(rs.next()){ %>
    <ul class="lists_uls">
        <li style="text-align: left;" class="qa_view" data-load="<%=rs.getString("qidx")%>">
        <%
            	//15자 초과하면 ...으로 처리
				if(rs.getString("qtitle").length() > 15){
					out.print(rs.getString("qtitle").substring(0,15)+"...");
				}else{
					out.print(rs.getString("qtitle"));
				}
		%>
		</a>
		</li>
        <li><%=rs.getString("user_name") %></li>
        <li><%=rs.getDate("qdate") %></li>
    </ul>
    <%}} %>
    <!--qa 데이터 출력 리스트 부분 -->
</article>
    <table border="1" cellpadding="0" cellspacing="0">
			<tr>
				<% 
				double alldata = rs2.getInt("ctn");
				int pg = (int)Math.ceil(alldata/list);
				for(int f=1; f<=pg; f++){ 
				%>
				<!-- 5개 리스트 출력 페이지 넘버 -->
				<td width="20" align="center"><a href="./admin_qalist.jsp?pno=<%=f %>"><%=f %></a></td>
				<%
				} 
				%>
			</tr>
		</table>
<input type="button" class="adbtn1" value="답변완료 리스트">
<br><br>
<%@ include file="../copyright.jsp" %>
</body>
</html>
<%
rs2.close();
rs.close();
pst.close();
dbcon.close();
%>