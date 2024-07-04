$(function(){
	//문의 유형 선택, 해당 값 저장
	$("#qa_part>li").click(function(){
		$("#qhead").val($(this).data("value"));
	})
	
	
	//문의등록 클릭
	$("#member_agreebtn").click(function(){
		var qfile1 = document.getElementById("qfile1");
		var qfile2 = document.getElementById("qfile2");
        var file1 = qfile1.files[0];
        var file2 = qfile2.files[0];

		if (file1) {
	        var fileType1 = file1.type;
	        if (file1.size > 2 * 1024 * 1024) { // 2MB
	            alert("파일 용량은 2MB 이하만 가능합니다.");
	            return;
	        } else if (!fileType1.startsWith("image/")) {
	            alert("이미지 파일만 업로드 가능합니다.");
	            return;
	        }
	    }
	
	    if (file2) {
	        var fileType2 = file2.type;
	        if (file2.size > 2 * 1024 * 1024) { // 2MB
	            alert("파일 용량은 2MB 이하만 가능합니다.");
	            return;
	        } else if (!fileType2.startsWith("image/")) {
	            alert("이미지 파일만 업로드 가능합니다.");
	            return;
	        }
	    }

        if (file1 && file1.size > 2 * 1024 * 1024) { // 2MB
            alert("파일 용량은 2MB 이하만 가능합니다.");
        }else if(file2 && file2.size > 2 * 1024 * 1024){
			alert("파일 용량은 2MB 이하만 가능합니다.");
		}else if($("#qhead").val() == ""){
			alert("문의 유형을 선택하셔야 합니다.");
		}else if($("#qtitle").val() == ""){
			alert("제목을 입력하지 않으셨습니다.");
		}else if($("#qtext").val() == ""){
			alert("내용을 입력하지 않으셨습니다.");
		}else{
			$("#frm").attr("method","post");
			$("#frm").attr("action","./m_qawrite.do");
			$("#frm").attr("enctype","multipart/form-data");
			$("#frm").submit();
		}
	})
})