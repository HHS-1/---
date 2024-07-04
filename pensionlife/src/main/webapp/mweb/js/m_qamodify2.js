function openPopup(url) {
        window.open(url, '이미지', 'width=800,height=600'); // 적절한 창 크기로 변경 가능
    }

//삭제버튼 클릭시 작동
function filedel_btn(z){
	if(z==1){
		document.getElementById("file1_del").value = "Y";
		document.getElementById("qfile1_val").value = "";
		document.getElementById("qfileview1a").style.display = "block";
		document.getElementById("qfileview1b").style.display = "none";
	}else {
		document.getElementById("file2_del").value = "Y";
		document.getElementById("qfile2_val").value = "";
		document.getElementById("qfileview2a").style.display = "block";
		document.getElementById("qfileview2b").style.display = "none";
	}
}

$(function(){
	//리뷰 삭제
	$("#delete_btn").click(function(){
		if(confirm('리뷰를 삭제하시겠습니까?')){
			$("#frm").attr("method","post");
			$("#frm").attr("action","./m_qadel.do");
			$("#frm").submit();
		}
	})
	//리뷰 수정
	$("#modify_btn").click(function(){
		$.ajax({
			url : "./m_qadel.do",
			type : "POST",
			data : {
				qidx : $("#qidx").val(),
				modfile1 : $("#qfile1_val").val(),
				modfile2 : $("#qfile2_val").val()
			},
			success : function(){
				$("#frm").attr("method","post");
				$("#frm").attr("action","./m_qawrite.do");
				$("#frm").attr("enctype","multipart/form-data");
				$("#frm").submit();
			},
			error : function($data){
				if($data == "error"){
					alert("에러가 발생하였습니다.");
				}
			}
		})
	})
})