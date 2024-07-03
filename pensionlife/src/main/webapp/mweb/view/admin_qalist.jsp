<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	HttpSession se = request.getSession();
    	String admin_id = (String)se.getAttribute("admin_id");
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="../admin_css/index.css?v=5">
    <script src="../js/jquery.js"></script>
    <script src="../admin_js/admin_login.js?v=1"></script>
</head>
<body>
<header class="admin_header"><img src="../img/header_logo.png"></header>
<aside class="admin_qa">
    <p><img src="../admin_img/logo.png"><span id="admin_logout"><%=admin_id%>님 환영합니다.[로그아웃]</span></p>
</aside>
<article class="admin_lists">
    <p>QA 문의 게시판 리스트</p>
    <ul class="lists_uls color1">
        <li>제목</li>
        <li>글쓴이</li>
        <li>등록일</li>
    </ul>
    <!--qa 데이터 출력 리스트 부분 -->
    <ul class="lists_uls">
        <li style="text-align: left;">결제관련 사항 때문에 문의 드립니다. 이번주에...</li>
        <li>홍길동</li>
        <li>2024-07-02</li>
    </ul>
    <!--qa 데이터 출력 리스트 부분 -->
</article>
<input type="button" class="adbtn1" value="답변등록">
<br><br>
<footer>
    <ul>
    <li><img src="../img/footer_logo.png"></li>
    <li>상호명 : (주)플레이스엠 |  대표이사 : 송재철</li>
    <li>사업자등록번호 : 120-86-43350[사업자등록번호 확인]</li>
    <li>통신판매신고번호 : 제2012-서울강남 00160호</li>
    <li>주소 : 서울 강남구 테헤란로 79길 6,5층(삼성동,제이에스타워)</li>
    <li>펜션 고객센터 : 1544-7317</li>
    <li>개인정보담당자 : </li>
    <li>Copyright (c) 2024 PLACEM CO.LTD. All Rights Reserved</li>
    </ul>
</footer>
</body>
</html>