<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, model.dbconfig"%>
<%
    HttpSession se = request.getSession();
    String user_id = (String) se.getAttribute("user_id");
    String user_name = (String) se.getAttribute("user_name");
    dbconfig db = new dbconfig();
    Connection dbcon = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet rsu = null;

    try {
        dbcon = db.getdbconfig();

        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String sql = "select b.r_idx,a.user_name,b.r_pname,b.r_room,b.checkin_date,c.rdetail,b.r_tel,b.r_cp,c.rprice,b.r_email,b.r_date from user_info as a join reserve_data as b join pension_list as c where a.user_name=b.r_name and b.r_room=c.rname and a.user_id=?";
        ps = dbcon.prepareStatement(sql);
        ps.setString(1, user_id);
        rs = ps.executeQuery();

        String sql2 = "select count(*) as ctn from user_info as a join reserve_data as b on a.user_name = b.r_name join pension_list as c on b.r_room = c.rname where a.user_id=?";
        ps = dbcon.prepareStatement(sql2);
        ps.setString(1, user_id);
        rs2 = ps.executeQuery();
        rs2.next();
        int ctn = rs2.getInt("ctn");

        String r_name = request.getParameter("r_name");
        String r_email = request.getParameter("r_email");
        String sqlu = "select b.r_idx,a.user_name,b.r_pname,b.r_room,b.checkin_date,c.rdetail,b.r_tel,b.r_cp,c.rprice,b.r_email,b.r_date from user_info as a join reserve_data as b join pension_list as c where a.user_name=b.r_name and b.r_room=c.rname and a.user_name=? and b.r_email=?";
        ps = dbcon.prepareStatement(sqlu);
        ps.setString(1, r_name);
        ps.setString(2, r_email);
        rsu = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=2">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=3">
    <link rel="stylesheet" type="text/css" href="../css/m_reservation_list.css?v=1">
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
    <!-- 회원 로그인 시 -->
        <% if (user_name != null && rs.next()) {%>
        <p><%= rs.getString("user_name") %> 님의 예약리스트</p>
        <span class="sub_titles">예약하신 모든 리스트가 출력됩니다</span>
        <ul class="qa_lists">
            <li>펜션명</li>
            <li>객실명</li>
            <li>예약자</li>
            <li>체크인</li>
        </ul>
        <% if (ctn <= 0) { %>
        <ul class="reserve_lists">
            <li>예약된 정보가 없습니다.</li>
        </ul>
        <% } else { %>
        <% do { %>
        <button class="reserve_list" onclick="re_detail(<%= rs.getString("r_idx") %>)">
        <ul class="reserve_lists">
            <li class="qa_view"><%= rs.getString("r_pname") %></li>
            <li><%= rs.getString("r_room") %></li>
            <li><%= rs.getString("user_name") %></li>
            <li><%= rs.getDate("checkin_date") %></li>
        </ul>
        </button>
        <% } while (rs.next()); %>
        <% } %>
        
        
        <!-- 비회원 로그인시 -->
        <% } else if (r_name != null && r_email != null && rsu.next()) {%>
        <p><%= rsu.getString("user_name") %> 님의 예약리스트</p>
        <span class="sub_titles">예약하신 모든 리스트가 출력됩니다</span>
        <ul class="qa_lists">
            <li>펜션명</li>
            <li>객실명</li>
            <li>예약자</li>
            <li>체크인</li>
        </ul>
        <% do { %>
        <button class="reserve_list" onclick="re_detail(<%= rsu.getString("r_idx") %>)">
        <ul class="reserve_lists">
            <li class="qa_view"><%= rsu.getString("r_pname") %></li>
            <li><%= rsu.getString("r_room") %></li>
            <li><%= rsu.getString("user_name") %></li>
            <li><%= rsu.getDate("checkin_date") %></li>
        </ul>
        </button>
        <% } while (rsu.next()); %>
        <% } else { %>
        <p>예약된 정보가 없습니다.</p>
        <% } %>
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
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (rs2 != null) try { rs2.close(); } catch (Exception e) {}
        if (rsu != null) try { rsu.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (dbcon != null) try { dbcon.close(); } catch (Exception e) {}
    }
%>
