$(function(){
	$("#member_agreebtn").click(function(){
		location.href="../view/m_qalist.jsp";
	})
	
	$("#modify_btn").click(function(){
		
		$("#frm").attr("method","post");
		$("#frm").attr("action","./m_qamodify2.jsp");
		$("#frm").attr("target","blank");
		$("#frm").submit();
	})
})