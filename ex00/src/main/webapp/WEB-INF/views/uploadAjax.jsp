<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<style type="text/css">
.show {
	width: 100%;
	background-color: gray;
}

.uploadResult {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}
.uploadResult li {
	list-style: none;
	padding: 10px;
}
.uploadResult li img {
	width: 100px;	
}
.bigPictureWrapper {
	position: absolute;
	display: none; /* 처음에는 안보여주는 설정 */
	justify-content: center; /* 가로축 기준 : center */
	align-items: center; /* 세로축 기준 : center */
	top: 0%; /* div의 최상단 */
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100; /* 여러 구성요소 중 화면 중복 우선순위 설정하는거 값이 클수록 위에 나옴*/
	background: rgba(255,255,255,0.5); /* a 는 투명도를 설정하는거 0.5로 설정함*/
}
.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;	
}
.bigPicture img {
	width: 600px;	
}
</style>

<script type="text/javascript">
	// exe|sh|zip|alz 이 확장자들은 업로드하지말라고 제한하는거
	let regex  = new RegExp("(.*?)\.(exe|sh|zip|alz)"); // . 전체 *여러개 ? 시스템 부화안걸릴정도찾기 . 문자를 쓰고싶음 \ 써야함
	let maxSize = 1024* 1024 * 5; // 5MB(5242880)
	function checkExtension(fileName, fileSize) {
		// 파일 용량 체크
		if (fileSize > maxSize) {
			alert("파일 용량 초과 - 업로드 할 수 없습니당.");
			return false;
		}
		// 확장자 체크
		if (regex.test(fileName)) {
			alert("이 파일 확장자는 업로드할수없습니다.")
			return false;			
		}
		return true;
	}
	
	function showUploadFile(list) {
		let str = "";
		
		$(list).each(function(i,obj){
			
			if (!obj.image) {
				
				let fileCallPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
				let filePath = fileCallPath.replaceAll("\\","/");
				filePath = filePath.substring(9);
				
				str += "<li><a href='/download?fileName=" + filePath + "'>"
					+ "<img src='/upload/image/attach.png'>" 
					+ obj.fileName + "</a></li>";
			}
			else {
				// str += "<li>" + obj.fileName + "</li>";
				// thumbnail 이미지
				let fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;
				// windows os에서 폴더사이가 \ 로 되어있어서 url에서 사용할려면 / 로 변경해야한다
				//console.log(obj.uploadPath);
				//console.log(fileCallPath);
				let filePath = fileCallPath.replaceAll("\\","/");
				// vo에 C:/upload/~~~로 저장되어있어서 'C:/upload'를 제거하고 하위경로에서 파일이름까지만 저장
				filePath = filePath.substring(9);
				console.log(filePath);
				
				// 오리지널 이미지
				let originalPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
				originalPath = originalPath.replaceAll("\\","/");
				originalPath = originalPath.substring(9);
				
				str += "<li><a href='javascript:showImage(\"" + originalPath + "\")'><img src='/display?fileName=" 
						+ filePath + "'></a></li>";
			}			
		});
		console.log(str);
		$(".uploadResult").html(str);
	}
function showImage(fileCallPath) {
	//alert(fileCallPath);
	$(".bigPictureWrapper").css("display", "flex").show();
	let str = '<img src="/display?fileName=' + fileCallPath + '">';
	$(".bigPicture").html(str).animate({width:'100%', height:'100%'}, 1000);
}
</script>
	
<script type="text/javascript">
$(function(){
	// body가 올라오고 난 이후 들어옵니다.
	console.log("jquery 확인");
	// body에 있는 부분을 복제하는 것이라 이곳에 있어야 합니다. 
	let cloneObj = $(".uploadDiv").clone();
	
	// 이벤트 처리
	$("#uploadBtn").click(function(){
		let formData = new FormData(); // 가상의 폼
		let inputFile = $("input[name='uploadFile']");
		let files = inputFile[0].files;
		console.log(files);
		for (let i = 0 ; i < files.length ; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		$.ajax({
			type: "post",
			url: "/uploadAjaxAction",
			processData: false,
			contentType: false,
			data: formData,
			dataType: 'json',
			success: function(result) {
				//alert("업로드가 되었습니당.")
				console.log(result);
				
				// 파일 업로드 후 초기화
				$(".uploadDiv").html(cloneObj.html());
				showUploadFile(result);
			}
		});
	}); // E $("#uploadBtn").click
	// 큰 이미지 클릭시 닫는 처리
	$(".bigPictureWrapper").on("click", function() {
		$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
		setTimeout(()=>{$(this).hide();}, 1000);
	});
});
</script>
</head>
<body>
<h2>Upload with Ajax</h2>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple> <!-- multiple: 여러개 파일을 동시에 실행할수있게해주는거 -->
</div>

<button id="uploadBtn">Upload</button>
<div class="show">
<ul class="uploadResult">
	<li>이미지파일이 없습니다.</li>
</ul>
</div>
<!-- 원본이미지를 보여줄 구간 -->
<div class="bigPictureWrapper">
	<div class="bigPicture">
		<!-- 이 부분을 javascript로 구현함 -->
		
	</div>
</div>
</body>
</html>