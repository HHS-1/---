function filedel_btn(z){
	if(z==1){
		document.getElementById("file1_del").value = "Y";
		document.getElementById("qfileview1a").style.display = "block";
		document.getElementById("qfileview1b").style.display = "none";
	}else {
		document.getElementById("file2_del").value = "Y";
		document.getElementById("qfileview2a").style.display = "block";
		document.getElementById("qfileview2b").style.display = "none";
	}
}


$(function(){
	$("#delete_btn").click(function(){
		if(confirm('리뷰를 삭제하시겠습니까?')){
			$("#frm").attr("method","post");
			$("#frm").attr("action","./m_qadel.do");
			$("#frm").submit();
		}
	})
	
	$("#modify_btn").click(function(){
		var qfile1 = document.getElementById("qfile1");
		var qfile2 = document.getElementById("qfile2");
        var file1 = qfile1.files[0];
        var file2 = qfile2.files[0];
        if (file1 && file1.size > 2 * 1024 * 1024) { // 2MB
            alert("파일 용량은 2MB 이하만 가능합니다.");
        }else if(file2 && file2.size > 2 * 1024 * 1024){
			alert("파일 용량은 2MB 이하만 가능합니다.");
		}else if($("#qtitle").val() == ""){
			alert("제목을 입력하지 않으셨습니다.");
		}else if($("#qtext").val() == ""){
			alert("내용을 입력하지 않으셨습니다.");
		}else{
			$("#frm").attr("method","post");
			$("#frm").attr("action","./m_qamod.do");
			$("#frm").attr("enctype","multipart/form-data");
			$("#frm").submit();
		}
	})
})