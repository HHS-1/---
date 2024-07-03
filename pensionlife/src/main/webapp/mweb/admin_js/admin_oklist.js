$(function(){
	$(".qa_view").click(function(){
		var qidx = $(this).data("load");
		console.log(qidx);
		$("#hd").val(qidx);
		$("#frm").attr("method","post");
		$("#frm").attr("action","../view/admin_qaview.jsp");
		$("#frm").submit();
	})
	
	$(".adbtn1").click(function(){
		location.href="./admin_qalist.jsp";
	})
})