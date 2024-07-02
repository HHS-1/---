<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	
    %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=2">
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
<section>
    <ol class="product">
        <li>
            <div>
                <span><img src="../img/hotel_01.jpg"></span>
                <span>[강원 평창군] 한화리조트 평창</span>
                <span>165,600원</span>
            </div>
        </li>
        <li>
            <div>
                <span><img src="../img/hotel_02.jpg"></span>
                <span>[강원 평창군] 휘닉스 평창</span>
                <span>162,000원</span>
            </div>
        </li>
        <li>
            <div>
                <span><img src="../img/hotel_03.jpg"></span>
                <span>[제주시] 한화리조트 제주</span>
                <span>146,400원</span>
            </div>
        </li>
        <li>
            <div>
                <span><img src="../img/hotel_04.jpg"></span>
                <span>[제주시] 금호제주 리조트</span>
                <span>107,000원</span>
            </div>
        </li>
        <li>
            <div>
                <span><img src="../img/hotel_05.jpg"></span>
                <span>[경남 거제시] 소노캄 거제</span>
                <span>180,000원</span>
            </div>
        </li>
        <li>
            <div>
                <span><img src="../img/hotel_06.jpg"></span>
                <span>[충남 보령시] 보령베이스 리조트</span>
                <span>140,000원</span>
            </div>
        </li>
    </ol>
</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
</html>