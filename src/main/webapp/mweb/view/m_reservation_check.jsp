<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dbconfig" %>
<%
    request.setCharacterEncoding("utf-8");
    dbconfig db = new dbconfig();
    Connection dbcon = db.getdbconfig();
    
    HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	String user_name = (String)se.getAttribute("user_name");
	
    String ridx=request.getParameter("ridx");
    String sql="select a.user_name,b.r_pname,b.r_room,b.checkin_date,c.rdetail,b.r_tel,b.r_cp,c.rprice,b.r_email,b.r_date from user_info as a join reserve_data as b join pension_list as c where a.user_name=b.r_name and b.r_room=c.rname and a.user_id=? and r_idx=?";
    PreparedStatement ps=dbcon.prepareStatement(sql);
    ps.setString(1, user_id);
    ps.setString(2, ridx);
    ResultSet rs=ps.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=2">
    <link rel="stylesheet" type="text/css" href="../css/m_reservation.css?v=2">
    <script src="../js/jquery.js"></script>
    <script src="../js/m_index.js?v=4"></script>
</head>
<body>
<!-- 상단 시작 -->
<%--@ include file="../top.jsp" --%>
<!-- 상단 끝 -->
<main>
<!-- 배너 -->
<%@ include file="../banner.jsp" %>
<!-- 배너 끝-->
<!-- 중단 -->
<section class="subpage">
    <div class="member_agree">
    <p>펜션 예약확인</p>
    <ol class="reser_ol">
    <li>
    <span class="reser_part1">펜션명</span>
    <span class="reser_part2">
<%out.print(rs.getString("r_pname")); %>
    </span>
    </li>
    <li>
    <span class="reser_part1">객실명</span>
    <span class="reser_part2">
<% out.print(rs.getString("r_room"));%>
    </span>
    </li>
    <li>
    <span class="reser_part1">예약일자</span>
    <span class="reser_part2">
<% out.print(rs.getString("checkin_date"));%>
    </span>
    </li>
    <li>
    <span class="reser_part1">객실구조</span>
    <span id="rdetail" class="reser_part2">
<% out.print(rs.getString("rdetail"));%>
    </span>
    </li>
    <li>
    <span class="reser_part1">입실인원</span>
    <span id="rsp_rmp" class="reser_part2">
<% out.print(rs.getString("r_cp"));%>
    </span>
    </li>
    <li>
    <span class="reser_part1">추가인원</span>
    <span class="reser_part2">
    기준인원 초과시 추가요금이 발생합니다.
    </span>
    </li>
    <li>
    <span class="reser_part1">객실요금</span>
    <span id="rprice" class="reser_part2">
<% out.print(rs.getString("rprice"));%>
    </span>
    </li>
    </ol>
    
    <p>예약자정보</p>
        <ol class="reser_ol">
    <li>
    <span class="reser_part1">객실명</span>
    <span class="reser_part2">
<% out.print(rs.getString("r_room"));%>
    </span>
    </li>
    <li>
    <span class="reser_part1">예약자명</span>
    <span class="reser_part2">
<%out.print(rs.getString("user_name")); %>
    </span>
    </li>
    <li>
    <span class="reser_part1">휴대폰</span>
    <span class="reser_part2">
<% out.print(rs.getString("r_tel"));%>
    </span>
    </li>
    <li>
    <span class="reser_part1">입실인원</span>
    <span class="reser_part2">
<% out.print(rs.getString("r_cp"));%>
    </span>
    </li>
    <li>
    <span class="reser_part1">이메일</span>
    <span class="reser_part2">
<% out.print(rs.getString("r_email"));%>
    </span>
    </li>
    </ol>
    <div class="member_agreebtn" onclick="reserve_cancel()">예약취소</div>
    </div>
</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
</html>
<%
rs.close();
ps.close();
dbcon.close();
%>