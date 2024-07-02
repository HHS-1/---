<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=2">
    <link rel="stylesheet" type="text/css" href="../css/m_qaboard.css?v=2">
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
        <p>1:1 문의게시판</p>
        <span class="sub_titles">질문하신 리스트가 출력 됩니다.</span>
        <ul class="qa_lists">
            <li>질문제목</li>
            <li>글쓴이</li>
            <li>등록일</li>
            <li>처리</li>
        </ul>
        <ul class="qa_lists2">
            <li>질문제목이 출력 됩니다 15자까지만...</li> 
            <li>홍길동</li>
            <li>2024-07-02</li>
            <li>미답변</li>
        </ul>
        <ul class="qa_lists2">
            <li>질문제목이 출력 됩니다 15자까지만...</li> 
            <li>홍길동</li>
            <li>2024-07-01</li>
            <li style="color: red;">답변완료</li>
        </ul>
        <div class="member_agreebtn">문의하기</div>
    </div>  
</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
</html>