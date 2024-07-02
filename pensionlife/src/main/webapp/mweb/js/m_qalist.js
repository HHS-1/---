function member_agreebtn(){
	location.href="./m_qawrite.jsp";
}

$(function(){
	$(".qa_view").click(function(){
		var qidx = $(this).data("load");
		$("#hd").val(qidx);
		$("#frm").attr("method","post");
		$("#frm").attr("action","../view/m_qaview.jsp");
		$("#frm").submit();
	})
})