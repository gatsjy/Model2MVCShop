<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="UTF-8">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap CDN ////////////////////////// -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!--  ///////////////////////// jQuery CDN ////////////////////////// -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified JavaScript  : -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {

		$(".card").on("mouseover", function() {
			$(this).css('cursor', 'pointer');
		});

		$('.box1').on('click', function() {
			$('.header').css('background-color', 'skyblue');
			$('.box1 h1').text('4');
			$('.box2 h1').text('5');
			$('.box3 h1').text('6');
			$('.box1 p').text('card 4');
			$('.box2 p').text('card 5');
			$('.box3 p').text('card 6');
			$('.active').css('width', '35%');
		})

		$('.box2').on('click', function() {
			$('.header').css('background-color', 'pink');
			$('.box1 h1').text('7');
			$('.box2 h1').text('8');
			$('.box3 h1').text('9');
			$('.box1 p').text('card 7');
			$('.box2 p').text('card 8');
			$('.box3 p').text('card 9');
			$('.active').css('width', '70%');
		})

		$('.box3').on('click', function() {
			$('.header').css('background-color', 'lightgrey');
			$('.box1 h1').text('10');
			$('.box2 h1').text('11');
			$('.box3 h1').text('12');
			$('.box1 p').text('card 10');
			$('.box2 p').text('card 11');
			$('.box3 p').text('card 12');
			$('.active').css('width', '100%');
		})
		
		$('.btn').on('click',function(){
			$('.header').css('background-color', '#4CAF50');
			$('.box1 h1').text('1');
			$('.box2 h1').text('2');
			$('.box3 h1').text('3');
			$('.box1 p').text('card 1');
			$('.box2 p').text('card 2');
			$('.box3 p').text('card 3');
			$('.active').css('width', '');
		})

	});
</script>
<style>
body {
	margin-top: 100px;
}

div.card {
	width: 250px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
	text-align: center;
	display: inline-block;
	margin-right: 65px;
	margin-left: 60px;
	margin-top: 30px;
}

div.header {
	background-color: #4CAF50;
	color: white;
	padding: 10px;
	font-size: 40px;
}

div.container2 {
	padding: 10px;
}

.btn {
	margin-top: 30px;
	margin-left: 47%;
}
</style>
</head>

<body>

	<div class="container">
		<div class="progress">
			<div class="progress-bar progress-bar-striped active"
				role="progressbar" aria-valuemin="0" aria-valuemax="100" style=""></div>
		</div>

		<div class="card box1">
			<div class="header">
				<h1>1</h1>
			</div>

			<div class="container2">
				<p>card 1</p>
			</div>
		</div>

		<div class="card box2">
			<div class="header">
				<h1>2</h1>
			</div>

			<div class="container2">
				<p>card 2</p>
			</div>
		</div>

		<div class="card box3">
			<div class="header">
				<h1>3</h1>
			</div>

			<div class="container2">
				<p>card 3</p>
			</div>
		</div>

		<button type="button" class="btn btn-default">Reset</button>

	</div>



	<!--  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
</body>
</html>