<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dbconfig" %>
 <% //m_reservation
 	request.setCharacterEncoding("utf-8");
	HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	String user_name = (String)se.getAttribute("user_name");
	
 	dbconfig db=new dbconfig();
	Connection dbcon=db.getdbconfig();
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
    <script src="../js/m_index.js?v=3"></script>
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
    <p>펜션 예약하기</p>
    <ol class="reser_ol">
    <li>
    <span class="reser_part1">펜션명</span>
    <span class="reser_part2">
    <%=request.getParameter("hpname") %>
    </span>
    </li>
    <li>
    <span class="reser_part1">객실선택</span>
    <span class="reser_part2">
    <select onchange="rinfo(this.value)" class="reser_select">
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
    <input type="datetime-local" class="reser_input">
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
    <span class="reser_part1">구매금액</span>
    <span id="rprice" class="reser_part2">
    -
    </span>
    </li>
    </ol>
    <p>예약자정보 입력</p>
        <ol class="reser_ol">
    <li>
    <span class="reser_part1">객실선택</span>
    <span class="reser_part2">
    <select class="reser_select">
    <option id="selectroom" value="">객실선택</option>
    </select>
    </span>
    </li>
    <li>
    <span class="reser_part1">예약자명</span>
    <span class="reser_part2">
    <input type="text" class="reser_input" maxlength="30">
    </span>
    </li>
    <li>
    <span class="reser_part1">휴대폰</span>
    <span class="reser_part2">
    <input type="number" class="reser_input" maxlength="11">
    </span>
    </li>
    <li>
    <span class="reser_part1">입실인원</span>
    <span class="reser_part2">
    <select id="pselect" class="reser_select">
    <option value="">입실 인원선택</option>
    </select>
    </span>
    </li>
    <li>
    <span class="reser_part1">이메일</span>
    <span class="reser_part2">
    <input type="email" class="reser_input" maxlength="50">
    </span>
    </li>
    </ol>
    <div class="member_agreebtn" onclick="">예약하기</div>
    </div>
</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
<script src="./m_reservation.js?v=1"></script>
<script>
function rinfo(z) {
    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == 4 && http.status == 200) {
            var responseData = JSON.parse(http.responseText);
            var rdetail = document.getElementById("rdetail");
            var rsp_rmp = document.getElementById("rsp_rmp");
            var rprice = document.getElementById("rprice");
            var pea = "기준" + responseData.rsp + " / 최대" + responseData.rmp + "인";
            rdetail.innerText = responseData.rdetail;
            rsp_rmp.innerText = pea;
            rprice.innerText = responseData.rprice;

            var pselect = document.getElementById("pselect");
            pselect.innerHTML = ""; // 기존 옵션 초기화
            for (var w = parseInt(responseData.rsp); w <= parseInt(responseData.rmp); w++) {
                var option = document.createElement("option");
                option.text = w;
                option.value = w;
                pselect.appendChild(option);
            }
        }
    }
    http.open("POST", "./room_info.do", true);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("rname=" + z);

    var selectroom = document.getElementById("selectroom");
    selectroom.innerText = z;
    selectroom.value = z;
}
</script>
</html>
<%
rs.close();
ps.close();
dbcon.close();
%>