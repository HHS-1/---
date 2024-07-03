$(function(){
	$(".qa_view").click(function(){
		var qidx = $(this).data("load");
		$("#hd").val(qidx);
		$("#frm").attr("method","post");
		$("#frm").attr("action","../view/admin_qawrite.jsp");
		$("#frm").submit();
	})
	
	$(".adbtn1").click(function(){
		location.href="./admin_oklist.jsp";
	})
})