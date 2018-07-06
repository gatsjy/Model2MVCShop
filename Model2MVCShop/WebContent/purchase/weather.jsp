<%@ page language="java" contentType="text/html; charset=EUC-KR" 
pageEncoding="EUC-KR"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> 
<html> 

<script type="text/javascript"> 
 //자기가 접속한 장소의 날씨 정보 가져오기 
 $(document).ready(function() { 
	if (navigator.geolocation) { // GPS를 지원하면 
	navigator.geolocation.getCurrentPosition( 

function nowLocation(position) { 
	var lat = position.coords.latitude; 
	var lon = position.coords.longitude; 


var url = 'http://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&APPID=d73798daf28862c3603a20903b4e74f5'; 

$.getJSON(url, function(data) { 
var sys = data.sys; // 국가명, 일출, 일몰 
var city = data.name; // 도시명 
var weather = data.weather // 날씨 객체 
var main = data.main; // 온도, 기압 관련 객체 

var wmain = weather[0].main; // 구름 상태 (Cloudiness) 
var w_id = weather[0].id; // 날씨 상태 id 정보코드 
var icon = weather[0].icon; // 날씨 아이콘 정보 
var country = sys.country // 국가명 
var temp = main.temp; // 현재온도 
var temp_min = main.temp_min; // 최저 온도 
var temp_max = main.temp_max; // 최고온도 

// 날씨 아이콘 
var icon_url = 'http://openweathermap.org/img/w/' + icon; 

// 날씨 정보 표시 
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
alert("오류?"); 
}, { 
      enableHighAccuracy: false, 
      maximumAge: 0, 
      timeout: Infinity 
    }); 
} 
}); 

/* enableHighAccuracy : false, // 배터리를 소모해서 더 정확한 위치를 찾음 
timeout : 0, // 주어진 초안에 정보를 찾지 못하면 error 
maximumAge : Infinity// 한번 찾은 위치 정보를 해당 초만큼 캐싱  */ 

//API 요청 URL 변수 
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
<h1>판매지도보기</h1> 
<ol class="breadcrumb"> 
<li><a href="#"><i class="fa fa-dashboard"></i> 판매관리</a></li> 
<li class="active">판매지도</li> 
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

//location안에 집어 넣기 
$(function() { 
<c:forEach items="${purchase}" var="purchase"> 
var json = new Array(); 
json.push("${purchase.lat}"); 
json.push("${purchase.lng}"); 
locations.push(json); 
</c:forEach> 
}); 

//중앙 위치값을 세팅해 줍니다. 
var bitcamp = { 
lat : 37.494541, 
lng : 127.02758300000005 
}; 

var map = new google.maps.Map(document 
.getElementById('map'), { 
zoom : 15, 
center : bitcamp 
}); 

//마커를 여러개 만드는 코딩 
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
data-dismiss="modal">닫기</button> 
<button type="button" class="btn btn-success modalModBtn" id="abc">구매</button> 
<button type="button" class="btn btn-danger modalDelBtn">삭제</button> 
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
<!-- $를 이용할 수 있게 만드는 j-Query --> 
</div> 
</body> 

</html> 