<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<html>

<script type="text/javascript">

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
			</section>

			<%-- Main content --%>
			<section class="content container-fluid">
				<head>
 <style>
       #map {
        height: 100%;
       }
    </style>
  </head>
  <body>
    
    <div id="map"></div>
    <div id="dataInfo"></div>
    <script>
  		
    var map;
    var geocoder;
    var infowindow;
    var marker;
    
    var nationName = "";
    var nationCode = "";
    
    function initMap(){
    	// 맵 스타일 속성에 필요한 배열 생성
    	var styles =[
    	];
    	
    	//새로운 styleMapType를 생성하며 커스터마이징한 스타일을 적용 시킨 객체를 만든다.
    	var styledMap = new google.maps.StyledMapType(styles, {name : "Styled Map"});
    	
    	// 맵에 세팅될 각종 옵션을 적용 시킨다.
    	var mapOptions = {
    			//최초 맵 로딩 시 위치 값 셋팅
    			center : {lat : 37.570, lng : 126.990},
    			// 줌 레벨 셋팅
    			zoom : 17,
    			// 스타일 맵 적용
    			mapTypeControlOptions : {
    				mapTypeIds : [google.maps.MapTypeId.ROADMAP, 'map_style']
    			}
    		};
    	
    	// 맵 객체 생성
    	map = new google.maps.Map(document.getElementById('map'), mapOptions);
    	
    	// 좌측 상단에 커스터 마이징한 맵을 선택할 수 있는 창을 셋팅한다.
    	map.mapTypes.set('map_style', styledMap);
    	map.setMapTypeId('map_style');
    	
    	geocoder = new google.maps.Geocoder;
    	infowindow = new google.maps.InfoWindow;
    	
    	// 클릭시 이벤트 리스너 셋팅
    	google.maps.event.addListener(map, 'click', function(event) {
    		getAddress(event);
    	});
    	
    	// 줌 단계 변경시 리스너 셋팅
    	google.maps.event.addListener(map, 'zoom_changed', function (event) {
    		zoomChange(event);
    	});	
    	}
    
    function zoomChange(event){
    	//줌 축소 고정
    	if(map.getZoom() < 7){
    		map.setZoom(7);
    	}
    }
    
    function getAddress(event){
    	var strData = "";
    	nationName = "";
    	nationCode = "";
    	
    	if(geocoder){
    		geocoder.geocode( {'location':event.latLng}, function(results, status){
    			
    			if(status == google.maps.GeocoderStatus.OK){
    				// 상세 주소를 반환하는 형태
    				// 국가명, 국가코드를 반환하는 형태
    				if(results.length > 0 ){
    					for(var i = 0 ; i<results[0].address_components.length; i++){
    						// 다양한 컨텐츠 중 types[0]이 country인 것이 국가명과 국가코드를 가지고 있다.
    						
    						if(results[0].address_components[i].types[0] == "country"){
    							nationName = ""+results[0].address_components[i].long_name;
    							
    							nameCode =""+results[0].address_components[i].short_name;
    						}
    					}
    					// 주소를 가져오는데 시간 시간이 소요 됨으로 가져오고 난 후 마커를 셋팅한다.
    					addMarker(event.latLng, map);
    				}
    			}
    		});
    	}
    	
    	// getJSON 방식으로 데이터를 데이터를 가져오는 방식 파라미터를 설정해서 각종 옵션 변경이 가능하다.
    	// jquery 스크립트 import 필요
    	var lat = ""+event.latLng.lat();
    	var lng =""+event.latLng.lng();
    	var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs";
    	var strData = "";
    	$.getJSON(url, function (data) {
    		if (data.status == google.maps.GeocoderStatus.OK){
    			for(var i = 0 ; i<data.results.length; i++){
    				strData += "<p>results["+i+"].formatted_address : "+data.results[i].formatted_address+"</p>";
    			}
    			document.getElementById("dataInfo").innerHTML = strData;
    		}
    	});
    }
    
    // 지도에 마커 추가
    function addMarker(location, map){
    	//마커는 삭제가 않됨 기존에 생성했던 마커를 null 처리하여 않보이게 한다.
    	if(marker!=null){
    		marker.setMap(null);
    	}
    	//마커를 추가하면서 클릭한 위치와 멘트를 입력
    	marker = new google.maps.Marker({
    		position : location,
    		title : "현재위치",
    		map : map
    	});
    	
    	var latPosition = ""+location.lat(); // 현재 클릭 위도 가져오기
    	latPosition = latPosition.substring(0,6);
    	var lngPosition = ""+location.lng();//현재 클릭 경도 가져오기
    	lngPosition = lngPosition.substring(0,6);
    	
    	var content = "<div style='width:200px; height:100px'>"+
    							"국가명 : "+nationName+
    							"<br/>"+
    							"국가코드 : "+nationCode+
    							"<br/>"+
    							"위도 : "+latPosition+"<br/> 경도 : "+lngPosition +
    							"</div>"; // 말풍선 안에 들어갈 내용
    	// 마커를 클릭했을때 말풍선 표시 이벤트
    	var infowindow = new google.maps.InfoWindow({
    		content : content,
    		maxWidth : 400
    	});
    	
    	// 말풍선 표시
    	infowindow.open(map,marker);
    	
    	// 리스너에 마커 클릭 이벤트를 셋팅
    	google.maps.event.addListener(marker, "click" , function() {
    		marker.setMap(null);
    	});
    }
	</script>
	
	<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap">
    </script>
<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>
<!-- Handlebars -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
<!-- $를 이용할 수 있게 만드는 j-Query -->
	</div>
</body>

</html>

