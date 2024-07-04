function openPopup(url) {
        window.open(url, '이미지', 'width=800,height=600'); // 적절한 창 크기로 변경 가능
    }

$(function(){
	//문의 리스트 클릭
	$("#member_agreebtn").click(function(){
		location.href="../view/m_qalist.jsp";
	})
	
	//문의 수정 클릭
	$("#modify_btn").click(function(){
		
		$("#frm").attr("method","post");
		$("#frm").attr("action","./m_qamodify2.jsp");
		$("#frm").attr("target","blank");
		$("#frm").submit();
	})
})