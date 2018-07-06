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
				<h1>�Ǹ���������</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> �ǸŰ���</a></li>
					<li class="active">�Ǹ�����</li>
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
    	// �� ��Ÿ�� �Ӽ��� �ʿ��� �迭 ����
    	var styles =[
    	];
    	
    	//���ο� styleMapType�� �����ϸ� Ŀ���͸���¡�� ��Ÿ���� ���� ��Ų ��ü�� �����.
    	var styledMap = new google.maps.StyledMapType(styles, {name : "Styled Map"});
    	
    	// �ʿ� ���õ� ���� �ɼ��� ���� ��Ų��.
    	var mapOptions = {
    			//���� �� �ε� �� ��ġ �� ����
    			center : {lat : 37.570, lng : 126.990},
    			// �� ���� ����
    			zoom : 17,
    			// ��Ÿ�� �� ����
    			mapTypeControlOptions : {
    				mapTypeIds : [google.maps.MapTypeId.ROADMAP, 'map_style']
    			}
    		};
    	
    	// �� ��ü ����
    	map = new google.maps.Map(document.getElementById('map'), mapOptions);
    	
    	// ���� ��ܿ� Ŀ���� ����¡�� ���� ������ �� �ִ� â�� �����Ѵ�.
    	map.mapTypes.set('map_style', styledMap);
    	map.setMapTypeId('map_style');
    	
    	geocoder = new google.maps.Geocoder;
    	infowindow = new google.maps.InfoWindow;
    	
    	// Ŭ���� �̺�Ʈ ������ ����
    	google.maps.event.addListener(map, 'click', function(event) {
    		getAddress(event);
    	});
    	
    	// �� �ܰ� ����� ������ ����
    	google.maps.event.addListener(map, 'zoom_changed', function (event) {
    		zoomChange(event);
    	});	
    	}
    
    function zoomChange(event){
    	//�� ��� ����
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
    				// �� �ּҸ� ��ȯ�ϴ� ����
    				// ������, �����ڵ带 ��ȯ�ϴ� ����
    				if(results.length > 0 ){
    					for(var i = 0 ; i<results[0].address_components.length; i++){
    						// �پ��� ������ �� types[0]�� country�� ���� ������� �����ڵ带 ������ �ִ�.
    						
    						if(results[0].address_components[i].types[0] == "country"){
    							nationName = ""+results[0].address_components[i].long_name;
    							
    							nameCode =""+results[0].address_components[i].short_name;
    						}
    					}
    					// �ּҸ� �������µ� �ð� �ð��� �ҿ� ������ �������� �� �� ��Ŀ�� �����Ѵ�.
    					addMarker(event.latLng, map);
    				}
    			}
    		});
    	}
    	
    	// getJSON ������� �����͸� �����͸� �������� ��� �Ķ���͸� �����ؼ� ���� �ɼ� ������ �����ϴ�.
    	// jquery ��ũ��Ʈ import �ʿ�
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
    
    // ������ ��Ŀ �߰�
    function addMarker(location, map){
    	//��Ŀ�� ������ �ʵ� ������ �����ߴ� ��Ŀ�� null ó���Ͽ� �ʺ��̰� �Ѵ�.
    	if(marker!=null){
    		marker.setMap(null);
    	}
    	//��Ŀ�� �߰��ϸ鼭 Ŭ���� ��ġ�� ��Ʈ�� �Է�
    	marker = new google.maps.Marker({
    		position : location,
    		title : "������ġ",
    		map : map
    	});
    	
    	var latPosition = ""+location.lat(); // ���� Ŭ�� ���� ��������
    	latPosition = latPosition.substring(0,6);
    	var lngPosition = ""+location.lng();//���� Ŭ�� �浵 ��������
    	lngPosition = lngPosition.substring(0,6);
    	
    	var content = "<div style='width:200px; height:100px'>"+
    							"������ : "+nationName+
    							"<br/>"+
    							"�����ڵ� : "+nationCode+
    							"<br/>"+
    							"���� : "+latPosition+"<br/> �浵 : "+lngPosition +
    							"</div>"; // ��ǳ�� �ȿ� �� ����
    	// ��Ŀ�� Ŭ�������� ��ǳ�� ǥ�� �̺�Ʈ
    	var infowindow = new google.maps.InfoWindow({
    		content : content,
    		maxWidth : 400
    	});
    	
    	// ��ǳ�� ǥ��
    	infowindow.open(map,marker);
    	
    	// �����ʿ� ��Ŀ Ŭ�� �̺�Ʈ�� ����
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
<!-- $�� �̿��� �� �ְ� ����� j-Query -->
	</div>
</body>

</html>

