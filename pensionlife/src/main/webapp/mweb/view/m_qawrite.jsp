<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.dbconfig" %>


    <%
  	//session, 자동로그인
  	HttpSession se = request.getSession();
  	String user_id = (String)se.getAttribute("user_id");
  	String user_name = (String)se.getAttribute("user_name");
  	boolean login_check = false;
  	if(se.getAttribute("login_check") != null){
  		login_check = true;
  	};
	
	Connection dbcon = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	
	if(user_id == null){
		out.print("<script>alert('권한이 없습니다.'); history.go(-1);</script>");
	}else{
		try{
		
	dbconfig db = new dbconfig();
	dbcon = db.getdbconfig();
	String sql = "select * from user_info where user_id=?";
	pst = dbcon.prepareStatement(sql);
	pst.setString(1, user_id);
	rs = pst.executeQuery();
	rs.next();
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=2">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=3">
    <link rel="stylesheet" type="text/css" href="../css/m_qaboard.css?v=3">
    <script src="../js/jquery.js"></script>
    <script src="../js/m_index.js"></script>
    <script src="../js/m_qawrite.js?v=1"></script>
</head>
<body>
<!-- 상단 시작 -->
<%@ include file="../top.jsp" %>
<!-- 상단 끝 -->
<main>
<!-- 배너 -->
<%@ include file="../banner.jsp" %>
<!-- 배너 끝-->
<!-- 중단 -->
<section class="subpage">
<form id="frm">
    <div class="member_agree">
        <p>1:1 문의게시판(글쓰기)</p>
        <span class="sub_titles">문의 유형 선택</span>
        <input type="hidden" id="qhead" name="qhead">
        <ol id="qa_part" class="qa_part">
            <li data-value="이용문의">이용문의</li>
            <li data-value="예약 및 취소">예약 및 취소</li>
            <li data-value="환불 및 요금">환불 및 요금</li>
            <li data-value="시설문의">시설문의</li>
            <li data-value="이벤트 문의">이벤트 문의</li>
            <li data-value="기타문의">기타문의</li>
        </ol>
        <ul class="write_ul">
            <li><input type="text" class="w_input1 w_bg" name="user_name" value="<%=rs.getString("user_name") %>" readonly></li>
            <li><input type="text" class="w_input1 w_bg" name="user_tel" value="<%=rs.getString("user_tel") %>" readonly></li>
            <li><input type="text" class="w_input1 w_bg" name="user_email" value="<%=rs.getString("user_email") %>" readonly></li>
            <li><input type="text" class="w_input1" id="qtitle" name="qtitle" placeholder="질문 제목"></li>
            <li><textarea class="w_input2" id="qtext" name="qtext" placeholder="질문 내용"></textarea></li>
            <li><input type="file" id="qfile1" name="qfile1" class="w_li"> * 최대 2MB까지 가능</li>
            <li><input type="file" id="qfile2" name="qfile2" class="w_li"> * 최대 2MB까지 가능</li>
            <li>※ 첨부파일은 이미지만 등록 가능합니다.</li>
        </ul>
        <div class="member_agreebtn" id="member_agreebtn">문의등록</div>
    </div>  
</form>
</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
<%@ include file="../login_auto.jsp" %>
</html>
<%
		}catch(Exception e){
			out.print("<script>alert('세션이 만료되어 메인 페이지로 이동됩니다.'); location.href='./m_index.jsp';</script>");
		}finally{
			if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
		    if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
		    if (dbcon != null) try { dbcon.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
	}
%>