//문의하기 버튼 클릭시 글쓰기 페이지로 이동
function member_agreebtn(){
	location.href="./m_qawrite.jsp";
}
window.onload = function(){
	let page = window.location.search.split("=")[1];
	if(page == undefined) page = 1;
	let page_btn = document.getElementById(page);
	page_btn.style.color = "skyblue";
	page_btn.style.textDecoration = "underline"
	
}
//글 제목 클릭시 qaview(내용확인) 페이지로 이동
$(function(){
	$(".qa_view").click(function(){
		var qidx = $(this).data("load");
		$("#hd").val(qidx);
		$("#frm").attr("method","post");
		$("#frm").attr("action","../view/m_qaview.jsp");
		$("#frm").submit();
	})
})

