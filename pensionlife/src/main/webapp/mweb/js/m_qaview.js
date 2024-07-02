$(function(){
	$(".member_agreebtn").click(function(){
		location.href="../view/m_qalist.jsp";
	})
	
	$(".delete_btn").click(function(){
		if(confirm('리뷰를 삭제하시겠습니까?')){
			$("#frm").attr("method","post");
			$("#frm").attr("action","./m_qadel.do");
			$("#frm").submit();
		}
	})
	
	$(".modify_btn").click(function(){
		
		$("#frm").attr("method","post");
		$("#frm").attr("action","../view/m_qawrite_mod.jsp");
		$("#frm").attr("target","blank");
		$("#frm").submit();
	})
})