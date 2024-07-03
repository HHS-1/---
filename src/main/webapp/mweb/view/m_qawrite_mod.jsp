<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dbconfig" %>
<%
	HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	String user_name = (String)se.getAttribute("user_name");
	String qidx = request.getParameter("qidx");
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	boolean mod = false;
	//문의유형에 onselect를 적용하기 위해 만든 리스트
	List<String> pt = new ArrayList<String>();
	for(int f=0; f<6; f++){
		pt.add("");
	}
	
	
	String qfile = "";
	String qfile1 = "";
	String qfile2 = "";
	//파일이 존재할 경우
	if(qidx != null){
		//파일이 1개 이상 존재할 경우 mod = true
		mod = true;
		dbconfig db = new dbconfig();
		con = db.getdbconfig();
		String sql = "select * from qa_board where qidx=?";
		pst = con.prepareStatement(sql);
		pst.setString(1, qidx);
		rs = pst.executeQuery();
		rs.next();
		//db에 저장된 문의유형
		String qh = rs.getString("qhead");
		qfile = rs.getString("qfile");
		//db에 저장된 파일url에서 파일명만 갖고옴
		if(qfile.contains(",")){
			int id = qfile.indexOf(",");
			qfile1 = qfile.substring(0,id);
			qfile2 = qfile.substring(id+1);
			qfile1 = qfile1.substring(qfile1.lastIndexOf("_")+1);
			qfile2 = qfile2.substring(qfile2.lastIndexOf("_")+1);
		}else{
			qfile1 = qfile.substring(qfile1.lastIndexOf("_")+1);
		}
		//문의유형에 onselect를 적용하기 위함
		if(qh.equals("이용문의")){
			pt.set(0, "onselect");
		}else if(qh.equals("예약 및 취소")){
			pt.set(1, "onselect");
		}else if(qh.equals("환불 및 요금")){
			pt.set(2, "onselect");
		}else if(qh.equals("시설문의")){
			pt.set(3, "onselect");
		}else if(qh.equals("이벤트 문의")){
			pt.set(4, "onselect");
		}else if(qh.equals("기타문의")){
			pt.set(5, "onselect");
		}
	}else{
		//수정버튼이 아닌 주소로 직접 접근 막음
		out.print("<script>alert('올바른 접근이 아닙니다.');</script>");
	}
%>
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
        <p>1:1 문의게시판(수정하기)</p>
        <span class="sub_titles">문의 유형 변경</span>
        <input type="hidden" id="qhead" name="qhead">
        <ol id="qa_part" class="qa_part">
            <li data-value="이용문의" class="<%=pt.get(0)%>">이용문의</li>
            <li data-value="예약 및 취소" class="<%=pt.get(1)%>">예약 및 취소</li>
            <li data-value="환불 및 요금" class="<%=pt.get(2)%>">환불 및 요금</li>
            <li data-value="시설문의" class="<%=pt.get(3)%>">시설문의</li>
            <li data-value="이벤트 문의" class="<%=pt.get(4)%>">이벤트 문의</li>
            <li data-value="기타문의" class="<%=pt.get(5)%>">기타문의</li>
        </ol>
        <ul class="write_ul">
            <li><input type="text" class="w_input1 w_bg" name="qname" value="홍길동" readonly></li>
            <li><input type="text" class="w_input1 w_bg" name="qtel" value="01012345678" readonly></li>
            <li><input type="text" class="w_input1 w_bg" name="qemail" value="hong@nate.com" readonly></li>
            <%if(mod){%>
            <li><input type="text" class="w_input1" id="qtitle" name="qtitle" value="<%= rs.getString("qtitle")%>" placeholder="질문 제목"></li>
            <li><textarea class="w_input2" id="qtext" name="qtext" placeholder="질문 내용"><%=rs.getString("qtext")%></textarea></li>
	            <%
				if(qfile.equals("") || qfile==""){
				%>
				<li><input type="file" id="qfile1" name="qfile1" class="w_li"> * 최대 2MB까지 가능</li>
	            <li><input type="file" id="qfile2" name="qfile2" class="w_li"> * 최대 2MB까지 가능</li>
				<%
				}else{
				%>
				<li><%=qfile1 %></li>
				<li><%=qfile2 %></li>
				<%
				}
				%>
            <%}else{ %>
            <li><input type="text" class="w_input1" id="qtitle" name="qtitle" placeholder="질문 제목"></li>
            <li><textarea class="w_input2" id="qtext" name="qtext" placeholder="질문 내용"></textarea></li>
            <li><input type="file" id="qfile1" name="qfile1" class="w_li"> * 최대 2MB까지 가능</li>
            <li><input type="file" id="qfile2" name="qfile2" class="w_li"> * 최대 2MB까지 가능</li>
            <%} %>
            <li>※ 첨부파일은 이미지만 등록 가능합니다.</li>
        </ul>
        <div class="member_agreebtn" id="member_agreebtn">문의수정</div>
    </div>  
</form>
</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
</html>