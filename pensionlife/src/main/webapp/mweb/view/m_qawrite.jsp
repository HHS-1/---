<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
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
            <li><input type="text" class="w_input1 w_bg" name="qname" value="홍길동" readonly></li>
            <li><input type="text" class="w_input1 w_bg" name="qtel" value="01012345678" readonly></li>
            <li><input type="text" class="w_input1 w_bg" name="qemail" value="hong@nate.com" readonly></li>
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
</html>