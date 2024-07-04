function openPopup(url) {
        window.open(url, '이미지', 'width=800,height=600'); // 적절한 창 크기로 변경 가능
    }

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