<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Creating a School Timetable - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/demo/demo.css">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.1.min.js"></script>
	<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
</head>
<body>
	<h2>Creating a School Timetable</h2>
	<div class="demo-info" style="margin-bottom:10px">
		<div class="demo-tip icon-tip">&nbsp;</div>
		<div>Click and drag a class to timetable.</div>
	</div>

	<div style="width:700px;">
		<div class="left">
			<table>
				<tr>
					<td><div class="item">English</div></td>
				</tr>
				<tr>
					<td><div class="item">Science</div></td>
				</tr>
				<tr>
					<td><div class="item">Music</div></td>
				</tr>
				<tr>
					<td><div class="item">History</div></td>
				</tr>
				<tr>
					<td><div class="item">Computer</div></td>
				</tr>
				<tr>
					<td><div class="item">Mathematics</div></td>
				</tr>
				<tr>
					<td><div class="item">Arts</div></td>
				</tr>
				<tr>
					<td><div class="item">Ethics</div></td>
				</tr>
			</table>
		</div>
		<div class="right">
			<table>
				<tr>
					<td class="blank"></td>
					<td class="title">Monday</td>
					<td class="title">Tuesday</td>
					<td class="title">Wednesday</td>
					<td class="title">Thursday</td>
					<td class="title">Friday</td>
				</tr>
				<tr>
					<td class="time">08:00</td>
					<td class="drop">1</td>
					<td class="drop">2</td>
					<td class="drop">3</td>
					<td class="drop">4</td>
					<td class="drop">5</td>
				</tr>
				<tr>
					<td class="time">09:00</td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
				</tr>
				<tr>
					<td class="time">10:00</td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
				</tr>
				<tr>
					<td class="time">11:00</td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
				</tr>
				<tr>
					<td class="time">12:00</td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
				</tr>
				<tr>
					<td class="time">13:00</td>
					<td class="lunch" colspan="5">Lunch</td>
				</tr>
				<tr>
					<td class="time">14:00</td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
				</tr>
				<tr>
					<td class="time">15:00</td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
				</tr>
				<tr>
					<td class="time">16:00</td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
					<td class="drop"></td>
				</tr>
			</table>
		</div>
	</div>
	<style type="text/css">
		.left{
			width:120px;
			float:left;
		}
		.left table{
			background:#E0ECFF;
		}
		.left td{
			background:#eee;
		}
		.right{
			float:right;
			width:570px;
		}
		.right table{
			background:#E0ECFF;
			width:100%;
		}
		.right td{
			background:#fafafa;
			color:#444;
			text-align:center;
			padding:2px;
		}
		.right td{
			background:#E0ECFF;
		}
		.right td.drop{
			background:#fafafa;
			width:100px;
		}
		.right td.over{
			background:#FBEC88;
		}
		.item{
			text-align:center;
			border:1px solid #499B33;
			background:#fafafa;
			color:#444;
			width:100px;
		}
		.assigned{
			border:1px solid #BC2A4D;
		}
		.trash{
			background-color:red;
		}
		
	</style>
	<script>
		$(function(){
			$('.left .item').draggable({
				revert:true,
				proxy:'clone'
			});
			$('.right td.drop').droppable({
				accept: '.item',
				onDragEnter:function(){
					$(this).addClass('over');
				},
				onDragLeave:function(){
					$(this).removeClass('over');
				},
				onDrop:function(e,source){
					$(this).removeClass('over');
					if ($(source).hasClass('assigned')){
						$(this).append(source);
					} else {
						var c = $(source).clone().addClass('assigned');
						$(this).empty().append(c);
						c.draggable({
							revert:true
						});
					}
				}
			});
			$('.left').droppable({
				accept:'.assigned',
				onDragEnter:function(e,source){
					$(source).addClass('trash');
				},
				onDragLeave:function(e,source){
					$(source).removeClass('trash');
				},
				onDrop:function(e,source){
					$(source).remove();
				}
			});
		});
	</script>
</body>
</html>