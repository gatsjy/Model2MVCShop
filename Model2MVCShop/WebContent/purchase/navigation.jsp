<%@ page language="java" contentType="text/html; charset=EUC-KR" 
pageEncoding="EUC-KR"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>simpleMap</title>
        <script>
      //공원부분 메소드!
    	function getLiverList() {  
    		var headers = {}; 
			headers["appKey"]="81d71b60-e7b0-4a49-8eff-e265fd5a44d1";//실행을 위한 키 입니다. 발급받으신 AppKey를 입력하세요.
			$.ajax({
				method:"POST",
				headers : headers,
				url:"https://api2.sktelecom.com/tmap/routes?version=1&format=xml",//자동차 경로안내 api 요청 url입니다.
				async:false,
				data:{
					//출발지 위경도 좌표입니다.
					startX : "126.9850380932383",
					startY : "37.566567545861645",
					//목적지 위경도 좌표입니다.
					endX : "127.10331814639885",
					endY : "37.403049076341794",
					//출발지, 경유지, 목적지 좌표계 유형을 지정합니다.
					reqCoordType : "WGS84GEO",
					resCoordType : "EPSG3857",
					//각도입니다.
					angle : "172",
					//경로 탐색 옵션 입니다.
					searchOption : 0
				},
				//데이터 로드가 성공적으로 완료되었을 때 발생하는 함수입니다.
				success:function(response){
					prtcl = response;
					
					// 결과 출력
					var innerHtml ="";
					var prtclString = new XMLSerializer().serializeToString(prtcl);//xml to String	
				    xmlDoc = $.parseXML( prtclString ),
				    $xml = $( xmlDoc ),
			    	$intRate = $xml.find("Document");
			    	
			    	var tDistance = "총 거리 : "+($intRate[0].getElementsByTagName("tmap:totalDistance")[0].childNodes[0].nodeValue/1000).toFixed(1)+"km,";
			    	var tTime = " 총 시간 : "+($intRate[0].getElementsByTagName("tmap:totalTime")[0].childNodes[0].nodeValue/60).toFixed(0)+"분,";	
			    	var tFare = " 총 요금 : "+$intRate[0].getElementsByTagName("tmap:totalFare")[0].childNodes[0].nodeValue+"원,";	
			    	var taxiFare = " 예상 택시 요금 : "+$intRate[0].getElementsByTagName("tmap:taxiFare")[0].childNodes[0].nodeValue+"원";	

			    	$("#result").text(tDistance+tTime+tFare+taxiFare);
					
					prtcl=new Tmap.Format.KML({extractStyles:true, extractAttributes:true}).read(prtcl);//데이터(prtcl)를 읽고, 벡터 도형(feature) 목록을 리턴합니다.
					
					routeLayer.removeAllFeatures();//레이어의 모든 도형을 지웁니다.
					
					//표준 데이터 포맷인 KML을 Read/Write 하는 클래스 입니다.
					//벡터 도형(Feature)이 추가되기 직전에 이벤트가 발생합니다.
					routeLayer.events.register("beforefeatureadded", routeLayer, onBeforeFeatureAdded);
					        function onBeforeFeatureAdded(e) {
						        	var style = {};
						        	switch (e.feature.attributes.styleUrl) {
						        	case "#pointStyle":
							        	style.externalGraphic = "http://topopen.tmap.co.kr/imgs/point.png"; //렌더링 포인트에 사용될 외부 이미지 파일의 url입니다.
							        	style.graphicHeight = 16; //외부 이미지 파일의 크기 설정을 위한 픽셀 높이입니다.
							        	style.graphicOpacity = 1; //외부 이미지 파일의 투명도 (0-1)입니다.
							        	style.graphicWidth = 16; //외부 이미지 파일의 크기 설정을 위한 픽셀 폭입니다.
						        	break;
						        	default:
							        	style.strokeColor = "#ff0000";//stroke에 적용될 16진수 color
							        	style.strokeOpacity = "1";//stroke의 투명도(0~1)
							        	style.strokeWidth = "5";//stroke의 넓이(pixel 단위)
						        	};
					        	e.feature.style = style;
					        }
				}
			})
    	} // end of dropPark()
        </script>
        <script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=81d71b60-e7b0-4a49-8eff-e265fd5a44d1"></script>
        <script type="text/javascript">
        $(document).ready(function() {
				var map = new Tmap.Map({
					div:'map_div',
					width:'100%',  // map의 width 설정
					height:'400px' // map의 height 설정
				});
				map.setCenter(new Tmap.LonLat("126.9850380932383", "37.566567545861645").transform("EPSG:4326", "EPSG:3857"), 15);//설정한 좌표를 "EPSG:3857"로 좌표변환한 좌표값으로 즁심점으로 설정합니다.
				var routeLayer = new Tmap.Layer.Vector("route");//벡터 레이어 생성
				var markerLayer = new Tmap.Layer.Markers("start");// 마커 레이어 생성
				map.addLayer(routeLayer);//map에 벡터 레이어 추가
				map.addLayer(markerLayer);//map에 마커 레이어 추가		
        });
		</script>
    </head>
    <body>
        <div id="map_div">
        <button onclick="getLiverList()">한강</button>
		<p id="result"></p>
        </div>        
    </body>
</html>
