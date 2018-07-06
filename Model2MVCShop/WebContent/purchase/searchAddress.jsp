<%@ page language="java" contentType="text/html; charset=EUC-KR"  
pageEncoding="EUC-KR"%>  

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 

<head>    
<title>���� �浵 ã��</title>
<meta http-equiv="content-type" content="text/html; charset=euc-kr"/>
<meta name="description" content="�ּҷ� ���� �浵 ã�� " />
<meta name="keywords" content="����, �浵, ���۸�API, �ּҰ˻�"/>
<meta name="author" content="webmaster@iegate.net">
<meta http-equiv="Cache-Control" content="no-cache">

<style>
body { font-family:Tahoma,����; font-size:9pt; color:#222222; }
form { margin:0px; }
</style>
    <script src="http://maps.google.co.kr/maps?file=api&amp;v=2&amp;key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs" type="text/javascript"></script>   
    <script type="text/javascript">

    var map;
    var geocoder;
    var address;

window.onload=load;
window.onunload=GUnload;

	function load()
//	function initialize()
	{
      map = new GMap2(document.getElementById('map_canvas'));
      map.setCenter(new GLatLng(37.566535,126.9779692), 6);
      geocoder = new GClientGeocoder();
      map.disableDoubleClickZoom();
//	  map.addControl(new GNavLabelControl());     
	  map.addControl(new GSmallMapControl());
	  GEvent.addListener(map, "click", getAddress);
      geocoder = new GClientGeocoder();
    }


// ������
    function addAddressToMap(response) {
      map.clearOverlays();
      if (!response || response.Status.code != 200) {
        alert("Sorry, �ּҸ� Ȯ���� �ּ���!!");
      } else {
        place = response.Placemark[0];
        alert(JSON.stringify(place));
        point = new GLatLng(place.Point.coordinates[1],
                            place.Point.coordinates[0]);
        marker = new GMarker(point);
        map.addOverlay(marker);
        marker.openInfoWindowHtml(
        '<b>����,�浵:</b>' + place.Point.coordinates[1] + "," + place.Point.coordinates[0] + '<br>' +
        '<b>�ּ�:</b>' + place.address + '<br>' +
        '<b>����:</b>' + place.name + '<br>' +
        '<b>Country code:</b> ' + place.AddressDetails.Country.CountryNameCode);      }
    }

    function showLocation() {
      var address = document.forms[0].q.value;
      geocoder.getLocations(address, addAddressToMap);
    }

    function findLocation(address) {
      document.forms[0].q.value = address;
      showLocation();
    }
   
    function getAddress(overlay, latlng) {
      if (latlng != null) {
        address = latlng;
        geocoder.getLocations(latlng, showAddress);
      }
    }

    function showAddress(response) {
      map.clearOverlays();
      if (!response || response.Status.code != 200) {
        alert("Status Code:" + response.Status.code);
      } else {
        place = response.Placemark[0];
        point = new GLatLng(place.Point.coordinates[1],
                            place.Point.coordinates[0]);
        marker = new GMarker(point);
        map.addOverlay(marker);
        marker.openInfoWindowHtml(
        '<b>orig latlng:</b>' + response.name + '<br/>' + 
        '<b>latlng:</b>' + place.Point.coordinates[1] + "," + place.Point.coordinates[0] + '<br>' +
        '<b>Address:</b>' + place.address + '<br>' +
        '<b>Country code:</b> ' + place.AddressDetails.Country.CountryNameCode);
      }
    }
    </script>
</head>
  </head>

<body>
<form action="#" onsubmit="showLocation(); return false;">
      <p>
        <b>������ / �ּ��Է�:</b>
        <input type="text" name="q" value="" class="address_input" size="40"  method=post />
        <input type="submit" name="find" value="Search" />
      </p>
</form>

    <div id="map_canvas" style="width: 500px; height: 400px">
 <!--[if lt IE 7]>  
<div style='border: 1px solid #F7941D; background: #FEEFDA; text-align: center; clear: both; height: 50px; position: relative;'>  
<div style='font-size: 12px; font-weight: bold; margin-top: 12px;'>�ֽ� �������� ���� ���׷��̵� ���ּ���.<br/> IE6 ���� ���������� �������� �ʴ� ����� �ֽ��ϴ�.
</div>  
</div>  
<![endif]-->	
	</div>
</body>
</html>