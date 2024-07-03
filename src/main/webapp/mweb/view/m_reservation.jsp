<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dbconfig" %>
<%
	HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	String user_name = (String)se.getAttribute("user_name");
    request.setCharacterEncoding("utf-8");
    dbconfig db = new dbconfig();
    Connection dbcon = db.getdbconfig();
    
    String pname=request.getParameter("hpname");
    String sql="select * from pension_list where pname=?";
    PreparedStatement ps=dbcon.prepareStatement(sql);
    ps.setString(1, pname);
    ResultSet rs=ps.executeQuery();
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
    <script src="../js/m_reservation.js?v=7"></script>
    <style>
        .ui-datepicker-header {
            background-color: #87CEEB !important; 
        }
        .ui-state-highlight {
            color: #0000FF !important;
        }
    </style>
</head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
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
    <form id="form">
    <div class="member_agree">
    <p>펜션 예약하기</p>
    <ol class="reser_ol">
    <li>
    <span class="reser_part1">펜션명</span>
    <span class="reser_part2">
    <%=pname %>
    </span>
    <input type="hidden" name="pname" id="pname" value="<%=request.getParameter("hpname") %>">
    </li>
    <li>
    <span class="reser_part1">객실선택</span>
    <span class="reser_part2">
    <select onchange="rinfo(this.value)" id="selectr" name="selectr" class="reser_select">
    <option value="">객실선택</option>
    <%while(rs.next()){ %>
    <option value="<%=rs.getString("rname") %>"><%=rs.getString("rname") %></option>
    <%} %>
    </select>
    </span>
    </li>
    <li>
    <span class="reser_part1">일자선택</span>
    <span class="reser_part2">
    <input type="text" id="datepicker" name="checkin_date" placeholder="날짜를 선택하세요" readonly>
    </span>
    </li>
    <li>
    <span class="reser_part1">객실구조</span>
    <span id="rdetail" class="reser_part2">
    원하시는 객실을 선택하세요
    </span>
    </li>
    <li>
    <span class="reser_part1">입실인원</span>
    <span id="rsp_rmp" class="reser_part2">
    원하시는 객실을 선택하세요
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
    원하시는 객실을 선택하세요
    </span>
    </li>
    </ol>
    
    <p>예약자정보 입력</p>
        <ol class="reser_ol">
    <li>
    <span class="reser_part1">객실선택</span>
    <span class="reser_part2">
    <input type="text" class="reser_select" id="r_room" name="r_room" value="객실을 선택하세요" readonly>
    </span>
    </li>
    <li>
    <span class="reser_part1">예약자명</span>
    <span class="reser_part2">
    <input type="text" id="r_name" name="r_name" class="reser_input" placeholder="예약자명" maxlength="30">
    </span>
    </li>
    <li>
    <span class="reser_part1">휴대폰</span>
    <span class="reser_part2">
    <input type="number" id="r_tel" name="r_tel" class="reser_input" placeholder="'-'없이 입력하세요" maxlength="11" oninput="tel_maxlength(this)">
    </span>
    </li>
    <li>
    <span class="reser_part1">입실인원</span>
    <span class="reser_part2">
    <select id="pselect" name="r_cp" class="reser_select">
    <option value="">입실 인원선택</option>
    </select>
    </span>
    </li>
    <li>
    <span class="reser_part1">이메일</span>
    <span class="reser_part2">
    <input type="email" id="r_email" name="r_email" class="reser_input" maxlength="50" placeholder="example@pensionlife.com">
    </span>
    </li>
    </ol>
    <div class="member_agreebtn" onclick="reserve_ok()">예약하기</div>
    </div>
    </form>
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