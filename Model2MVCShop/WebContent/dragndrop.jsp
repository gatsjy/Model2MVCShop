<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	$(function() {

		$('.husky').draggable({
		    revert:true,
		    proxy:'clone',
		    onStartDrag:function(){
		        $(this).draggable('options').cursor = 'not-allowed';
		        $(this).draggable('proxy').css('z-index',10);
		    },
		    onStopDrag:function(){
		        $(this).draggable('options').cursor='move';
		    }
		});
		
		$('.dropbox').droppable({
		    drop:function(){
		    	$('.dropbox').html('<img src="/images/uploadFiles/aaa.jpg">');
		    }
		});

	});
</script>
<title>Insert title here</title>
<style>
body {
	margin-top: 100px;
}

.left {
	margin-left: 20px;
}

div>img {
	width: 300px;
}

.dropbox {
	margin-top: 20px;
	width: 100%;
	height: 200px;
	border: 1px solid grey;
	background-color: white;
	width: 100%;
}

</style>
</head>
<body>

	<div class="container">
		<div class="husky">
			<img src="/images/uploadFiles/aaa.jpg"> 
		</div>
		<div class="dropbox"></div>
	</div>





	<!--  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
</body>
</html>