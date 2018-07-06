<%@ page language="java" contentType="text/html; charset=EUC-KR" 
pageEncoding="EUC-KR"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> 
<html> 

<script type="text/javascript"> 
 //�ڱⰡ ������ ����� ���� ���� �������� 
 $(document).ready(function() { 
	if (navigator.geolocation) { // GPS�� �����ϸ� 
	navigator.geolocation.getCurrentPosition( 

function nowLocation(position) { 
	var lat = position.coords.latitude; 
	var lon = position.coords.longitude; 


var url = 'http://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&APPID=d73798daf28862c3603a20903b4e74f5'; 

$.getJSON(url, function(data) { 
var sys = data.sys; // ������, ����, �ϸ� 
var city = data.name; // ���ø� 
var weather = data.weather // ���� ��ü 
var main = data.main; // �µ�, ��� ���� ��ü 

var wmain = weather[0].main; // ���� ���� (Cloudiness) 
var w_id = weather[0].id; // ���� ���� id �����ڵ� 
var icon = weather[0].icon; // ���� ������ ���� 
var country = sys.country // ������ 
var temp = main.temp; // ����µ� 
var temp_min = main.temp_min; // ���� �µ� 
var temp_max = main.temp_max; // �ְ�µ� 

// ���� ������ 
var icon_url = 'http://openweathermap.org/img/w/' + icon; 

// ���� ���� ǥ�� 
//$('#weather_info > .city').html(city + "/" + country); 
$('#weather_info .icon').html("<img src=' " + icon_url + ".png'>"); 
$('#weather_info .w_id').html(wmain); 
$('#weather_info .temp_min').html(  ' min : ' + parseInt(temp_min - 273.15) + '&deg;'); 
$('#weather_info .temp_max').html(  ' max : '+ parseInt(temp_max - 273.15) + '&deg;' ); 
$('#weather_info .temp').html('temp : ' +parseInt(temp - 273.15) + '&deg;'); 

}); 






////////////////////////////////////////////////////////////////////////////////////////////// 
}, 
function(error){ 
alert("����?"); 
}, { 
      enableHighAccuracy: false, 
      maximumAge: 0, 
      timeout: Infinity 
    }); 
} 
}); 

/* enableHighAccuracy : false, // ���͸��� �Ҹ��ؼ� �� ��Ȯ�� ��ġ�� ã�� 
timeout : 0, // �־��� �ʾȿ� ������ ã�� ���ϸ� error 
maximumAge : Infinity// �ѹ� ã�� ��ġ ������ �ش� �ʸ�ŭ ĳ��  */ 

//API ��û URL ���� 
//var url = 'http://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&APPID=d73798daf28862c3603a20903b4e74f5'; 

</script> 

<head> 

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> 

<%--head.jsp--%> 
<%@ include file="../include/head.jsp"%> 
<body class="hold-transition skin-blue sidebar-mini layout-boxed"> 
<div class="wrapper"> 

<%--main_header.jsp--%> 
<%-- Main Header --%> 
<%@ include file="../include/main_header.jsp"%> 

<%--left_column.jsp--%> 
<%-- Left side column. contains the logo and sidebar --%> 
<%@ include file="../include/left_column.jsp"%> 

<%-- Content Wrapper. Contains page content --%> 
<div class="content-wrapper"> 
<%-- Content Header (Page header) --%> 
<section class="content-header"> 
<h1>�Ǹ���������</h1> 
<ol class="breadcrumb"> 
<li><a href="#"><i class="fa fa-dashboard"></i> �ǸŰ���</a></li> 
<li class="active">�Ǹ�����</li> 
</ol> 

<div id="weather_info"> 
<h1 class="city"></h1> 
<section> 
<p class="w_id"></p> 
<div class="icon"> </div> 
<span class="temp"></span>
<span class="temp_max"></span> 
<span  class="temp_min"></span> 
</section> 
</div> 
</section> 

<%-- Main content --%> 
<section class="content container-fluid"> 
<head> 
<style> 
#map { 
height: 400px; 
width: 100%; 
} 
</style> 
</head> 
<body> 

<div id="map"></div> 
<script> 
function initMap() { 
var locations = [ 
[ '36.8364042', '127.13022509999996' ] , 
]; 

alert(locations); 

//location�ȿ� ���� �ֱ� 
$(function() { 
<c:forEach items="${purchase}" var="purchase"> 
var json = new Array(); 
json.push("${purchase.lat}"); 
json.push("${purchase.lng}"); 
locations.push(json); 
</c:forEach> 
}); 

//�߾� ��ġ���� ������ �ݴϴ�. 
var bitcamp = { 
lat : 37.494541, 
lng : 127.02758300000005 
}; 

var map = new google.maps.Map(document 
.getElementById('map'), { 
zoom : 15, 
center : bitcamp 
}); 

//��Ŀ�� ������ ����� �ڵ� 
for (i = 0; i < locations.length; i++) { 
marker = new google.maps.Marker({ 
position : new google.maps.LatLng( 
locations[i][0], locations[i][1]), 
map : map 
}); 
} 
} 
</script> 
<script async defer 
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"> 

</script> 

<div class="modal-footer"> 
<button type="button" class="btn btn-default pull-left" 
data-dismiss="modal">�ݱ�</button> 
<button type="button" class="btn btn-success modalModBtn" id="abc">����</button> 
<button type="button" class="btn btn-danger modalDelBtn">����</button> 
</div> 
</div> 
</div> 
</div> 
</form> 
</div> 

<%--plugin_js.jsp--%> 
<!-- Bootstrap 3.3.7 --> 
<script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script> 
<!-- AdminLTE App --> 
<script src="/dist/js/adminlte.min.js"></script> 
<!-- Handlebars --> 
<script 
src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script> 
<!-- $�� �̿��� �� �ְ� ����� j-Query --> 
</div> 
</body> 

</html> 