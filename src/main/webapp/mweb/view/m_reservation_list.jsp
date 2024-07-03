<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.dbconfig" %>

<%
	HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	String user_name = (String)se.getAttribute("user_name");
	
	dbconfig db = new dbconfig();
	Connection dbcon = db.getdbconfig();

	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
    String sql="select b.r_idx,a.user_name,b.r_pname,b.r_room,b.checkin_date,c.rdetail,b.r_tel,b.r_cp,c.rprice,b.r_email,b.r_date from user_info as a join reserve_data as b join pension_list as c where a.user_name=b.r_name and b.r_room=c.rname and a.user_id=?";
    PreparedStatement ps=dbcon.prepareStatement(sql);
    ps.setString(1, user_id);
    ResultSet rs=ps.executeQuery();
    
    String sql2="select count(*) as ctn from user_info as a join reserve_data as b on a.user_name = b.r_name join pension_list as c on b.r_room = c.rname where a.user_id=?";
    PreparedStatement ps2=dbcon.prepareStatement(sql2);
    ps2.setString(1, user_id);
    ResultSet rs2=ps2.executeQuery();
    rs2.next();
    int ctn = rs2.getInt("ctn");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=2">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=3">
    <link rel="stylesheet" type="text/css" href="../css/m_qaboard.css?v=4">
    <script src="../js/jquery.js"></script>
    <script src="../js/m_index.js"></script>
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
    <div class="member_agree">
        <p><%= user_name %> 님의 예약리스트</p>
        <span class="sub_titles">예약하신 모든 리스트가 출력됩니다</span>
        <ul class="qa_lists">
            <li>펜션명</li>
            <li>객실명</li>
            <li>예약자</li>
            <li>체크인</li>
        </ul>
        <% if(ctn <= 0) { %>
        <ul class="qa_lists2">
            <li>예약된 정보가 없습니다.</li>
        </ul>
        <% } else { %>
        <%
        while(rs.next()) {
        %>
        <button onclick="re_detail(<%= rs.getString("r_idx") %>)">
        <ul class="qa_lists2">
            <li class="qa_view"><%= rs.getString("r_pname") %></li>
            <li><%= rs.getString("r_room") %></li>
            <li><%= rs.getString("user_name") %></li>
            <li><%= rs.getDate("checkin_date") %></li>
        </ul>
        </button>
        <%
        }
        } %>
    </div>
</section>
<form id="frm">
    <input type="hidden" id="hd" name="ridx" value="">
</form>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
<script>
function re_detail(z){
    var frm = document.getElementById("frm");
    var hd = document.getElementById("hd");
    hd.value = z;
    frm.method = "post";
    frm.action = "./m_reservation_check.jsp";
    frm.submit();
}
</script>
</html>
<%
rs.close();
ps.close();
rs2.close();
ps2.close();
dbcon.close();
%>