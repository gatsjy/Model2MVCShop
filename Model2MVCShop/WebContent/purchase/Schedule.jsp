<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.js"></script>
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.css" />

<script type="text/javascript">
$(function() {
	$('#calendar').tuiCalendar({
		  defaultView: 'day',
		  taskView: true,
		  template: {
		    monthGridHeader: function(model) {
		      var date = new Date(model.date);
		      var template = '<span class="tui-full-calendar-weekday-grid-date">' + date.getDate() + '</span>';
		      return template;
		    }
		  }
		});
});
</script>

<title>Insert title here</title>
</head>
<body>
	<div id="calendar" style="height: 800px;"></div>
</body>
</html>