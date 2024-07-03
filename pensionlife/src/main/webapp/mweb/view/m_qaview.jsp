<%@page import="java.sql.SQLException"%>
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
	Connection dbcon = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	try{
	dbcon = db.getdbconfig();
	
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
	String qidx = request.getParameter("qidx");
	
	String sql = "select * from qa_board where qidx=?";
	pst = dbcon.prepareStatement(sql);
	pst.setString(1, qidx);
	rs = pst.executeQuery();
	rs.next();
	
	String qfile = rs.getString("qfile");
	String dbqfile1 = "";
	String dbqfile2 = "";
	String qfile1 = "";
	String qfile2 = "";
	//첨부파일 1개인지 2개인지 파악후 파일명만 갖고옴
	if(qfile.contains(",")){
		int i = qfile.indexOf(",");
		
		dbqfile1 = qfile.substring(0,i);
		int li = dbqfile1.lastIndexOf("/");
		int li2 = dbqfile1.lastIndexOf("_");
		qfile1 = dbqfile1.substring(li2+1);
		
		dbqfile2 = qfile.substring(i+1);
		li = dbqfile2.lastIndexOf("/");
		li2 = dbqfile2.lastIndexOf("_");
		qfile2 = dbqfile2.substring(li2+1);
	}else{
		int li = qfile.lastIndexOf("/");
		int li2 = qfile.lastIndexOf("_");
		qfile1 = qfile.substring(li+1);
		dbqfile1 = "/upload/"+qfile1;
		qfile1 = qfile.substring(li2+1);
	}
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=3">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=4">
    <link rel="stylesheet" type="text/css" href="../css/m_qaboard.css?v=4">
    <script src="../js/jquery.js"></script>
    <script src="../js/m_index.js"></script>
    <script src="../js/m_qaview.js?v=3"></script>
</head>
<body>
<form id="frm">
<input type="hidden" name="qidx" value="<%=qidx%>">
    <div class="menus_bar" id="menus_bar">
        <div class="load_menus" id="load_menus">
            <ul>
                <li>팬션 예약확인</li>
                <li>팬션 예약취소</li>
                <li>1:1문의 게시판</li>
            </ul>
        </div>
    </div>    
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
        <p>1:1 문의게시판(내용확인)</p>
        <span class="sub_titles">빠르게 궁금한 사항을 답변 드리도록 하겠습니다.</span>
        <ul class="write_ul">
            <li class="cate_txt"><a style="color:red; font-size:15px">질문항목 : <%=rs.getString("qhead") %></a></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("user_name")%>" readonly></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("user_tel")%>" readonly></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("user_email")%>" readonly></li>
            <li><input type="text" class="w_input1" value="<%=rs.getString("qtitle") %>" placeholder="질문 제목" readonly></li>
            <li><textarea class="w_input2" placeholder="질문 내용" readonly><%=rs.getString("qtext") %></textarea></li>
            <%
            //DB에 첨부파일 존재여부 파악
            if(qfile.equals("")){ 
            %>
            <li class="fileview">첨부파일이 없습니다.</li>
            <%
            }else{ 
            %>
            <li class="fileview">첨부파일 : <a href="<%out.print(dbqfile1);%>" target="_blank"><%out.print(qfile1); %></a> </li>
            <li class="fileview">첨부파일 : <a href="<%out.print(dbqfile2);%>" target="_blank"><%out.print(qfile2); %></a> </li>
            <%
            }
            %>
        </ul>
        <!--관리자 답변사항-->
        
        <!--관리자 답변사항-->
        <%if(rs.getString("qhandle").equals("미답변")){ %>
        <div class="member_agreebtn" id="modify_btn">문의수정</div>
        <%}else{%>
        <!-- <span class="admin_view" style="display: block;">관리자 답변내용</span><br>
        <ul class="answer_admin" style="display: block;">
            <li><%=rs.getString("qadmin") %></li>
        </ul>  -->
        <span class="admin_view" style="display: block;">관리자 답변내용</span>
        <ul class="write_ul">
        	<li><input type="text" class="w_input1" value="<%=rs.getString("qadmin") %>" readonly></li>
        </ul>
        <%} %>
        <div class="member_agreebtn" id="member_agreebtn" style="background-color: darkblue; color:white;">문의 리스트</div>
    </div>  

</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</form>
</body>
</html>
<%
	} catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (dbcon != null) try { dbcon.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>