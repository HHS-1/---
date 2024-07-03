<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dbconfig" %>
<%
	HttpSession se = request.getSession();
	String admin_id = (String)se.getAttribute("admin_id");

	dbconfig db = new dbconfig();
	Connection dbcon = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	
	try{
	dbcon = db.getdbconfig();
	
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
	String qidx = request.getParameter("qidx");
	
	String sql = "select * from qa_board where qidx=?";
	pst = dbcon.prepareStatement(sql);
	pst.setString(1, qidx);
	rs = pst.executeQuery();
	rs.next();

	String qfile = rs.getString("qfile");
	String dbqfile1 = "";
	String dbqfile2 = "";
	String qfile1 = "";
	String qfile2 = "";
	//첨부파일 1개인지 2개인지 파악후 파일명만 갖고옴
	if(qfile.contains(",")){
		int i = qfile.indexOf(",");
		
		dbqfile1 = qfile.substring(0,i);
		int li = dbqfile1.lastIndexOf("/");
		int li2 = dbqfile1.lastIndexOf("_");
		qfile1 = dbqfile1.substring(li2+1);
		
		dbqfile2 = qfile.substring(i+1);
		li = dbqfile2.lastIndexOf("/");
		li2 = dbqfile2.lastIndexOf("_");
		qfile2 = dbqfile2.substring(li2+1);
	}else{
		int li = qfile.lastIndexOf("/");
		int li2 = qfile.lastIndexOf("_");
		qfile1 = qfile.substring(li+1);
		dbqfile1 = "/upload/"+qfile1;
		qfile1 = qfile.substring(li2+1);
	}
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=2">
    <link rel="stylesheet" type="text/css" href="../admin_css/index.css?v=7">
    <script src="../js/jquery.js"></script>
    <script src="../admin_js/admin_qawrite.js"></script>
</head>
<body>
<header class="admin_header"><img src="../img/header_logo.png"></header>
<aside class="admin_qa">
    <p><img src="../admin_img/logo.png"><span id="admin_logout"><%=admin_id%>님 환영합니다.[로그아웃]</span></p>
</aside>
<form id="frm">
<input type="hidden" name="qidx" value=<%=qidx %>>
<article class="admin_lists">
    <p>QA 문의 내용</p>
    <ul class="qa_write">
        <li>고객명</li>
        <li><%=rs.getString("user_name") %></li>
        <li>제목</li>
        <li><%=rs.getString("qtitle") %></li>
        <li>내용</li>
        <li class="view1"><%=rs.getString("qtext") %></li>
        <li>등록일</li>
        <li><%=rs.getDate("qdate") %></li>
        <li>첨부파일</li>
        <li>
        <%if(qfile.equals("")){ %>
        첨부파일이 없습니다.
        <%}else{ %>
        <a href="<%out.print(dbqfile1);%>" target="_blank"><%out.print(qfile1); %></a>
        <a href="<%out.print(dbqfile2);%>" target="_blank"><%out.print(qfile2); %></a>
        <%} %>
        </li>
        <li>답변</li>
        <li><textarea placeholder="답변내용을 입력하세요" class="answer" id="qadmin" name="qadmin"></textarea></li>
    </ul>
    <input type="button" class="adbtn1" value="답변등록">
</article>
</form>
<%@ include file="../copyright.jsp" %>
</body>
</html>
<%
	} catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (dbcon != null) try { dbcon.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>