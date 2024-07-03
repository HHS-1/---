$(function(){
	$(".adbtn1").click(function(){
		if($("#qadmin").val() == ""){
			alert("답변 내용을 입력하지 않으셨습니다.");
		}else{
			$("#frm").attr("method","post");
			$("#frm").attr("action","./admin_qawrite.do");
			$("#frm").submit();
		}
	})
})