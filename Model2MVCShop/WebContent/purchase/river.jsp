<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<html>

<style>
body {
	height: 100%
}

#map {
	height: 60%;
	clear: both;
}

#img {
	position: relative;
	height: 30vh;
	background-size: cover;
}

#img-cover {
	position: absolute;
	height: 100%;
	width: 100%;
	background-color: rgba(0, 0, 0, 0.4);
	z-index: 1;
}

#img .content {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 5rem;
	color: white;
	z-index: 2;
	text-align: center;
}

#file {
	display: none;
}

.form-group {
	width: 300px;
	height: 300px;
}

.dropbtn {
	background-color: #4CAF50;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
}

span.dropdown {
	width: 20%;
	float: left;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: #ddd;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: #3e8e41;
}
</style>

<head>
<script>  
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

//날씨 아이콘 
var icon_url = 'http://openweathermap.org/img/w/' + icon; 

//날씨 정보 표시 
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
 
//이 부분은 지도 관련 맵 입니다! 
//중앙 위치값을 세팅해 줍니다. 
    var center = {lat: 37.57593689999999 , lng: 126.97681569999997}; 
   
    var map; 
    var geocoder; 
    var infowindow; 
    var marker= []; 
    var markers = []; 
    var locations = []; 
    var locationsfestival = [];
    var infowindows = [];
    var contents = [];
   
    function initMap(){ 
	
     // 맵 스타일 속성에 필요한 배열 생성 
     var styles =[ 
     ]; 
     
     //새로운 styleMapType를 생성하며 커스터마이징한 스타일을 적용 시킨 객체를 만든다. 
     var styledMap = new google.maps.StyledMapType(styles, {name : "Styled Map"}); 
    
     // 맵에 세팅될 각종 옵션을 적용 시킨다. 
     var mapOptions = { 
     //최초 맵 로딩 시 위치 값 셋팅 
     center : center, 
     // 줌 레벨 셋팅 
     zoom : 11, 
     // 스타일 맵 적용 
     mapTypeControlOptions : { 
     mapTypeIds : [google.maps.MapTypeId.ROADMAP, 'map_style'] 
     } 
     }; 
     
     // 맵 객체 생성 
     map = new google.maps.Map(document.getElementById('map'), mapOptions); 
     
     // Load GeoJSON.
     map.data.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json');
     // Set the stroke width, and fill color for each polygon
     map.data.setStyle(function(feature) {
    	 var color = '#F1F8E0';
    	 if(feature.getProperty('isColorful')){
    		 color = '';
    	 }
    	 return ({
       fillColor: color,
       strokeWeight: 0.2
    	 });
     });
     
     // 좌측 상단에 커스터 마이징한 맵을 선택할 수 있는 창을 셋팅한다. 
     map.mapTypes.set('map_style', styledMap); 
     map.setMapTypeId('map_style'); 
     
     geocoder = new google.maps.Geocoder;  
 
     var marker = new google.maps.Marker({
     	position : locations[0],
     	map : map,
     	title : 'hello'
    });
        
     marker.addListener('click', function() {
 	    map.setZoom(13);
 	    map.setCenter(marker.getPosition());
 	  	 infowindow.open(map, marker);
 	  });
     
     // When the user clicks, set 'isColorful', changing the color of the letters.
     map.data.addListener('click', function(event) {
       event.feature.setProperty('isColorful', true);
     });
     
     map.data.addListener('mouseover', function(event) {
         map.data.revertStyle();
         map.data.overrideStyle(event.feature, {fillColor: '#F2F79B'});
       });

       map.data.addListener('mouseout', function(event) {
         map.data.revertStyle();
       });
       
    // 클릭시 이벤트 리스너 셋팅
   	map.data.addListener('click', function(event) {
   		alert("saesa");
   		getAddress(event);
   	});
    
 // 클릭시 이벤트 리스너 셋팅
	google.maps.event.addListener(map, 'click', function(event) {
		getAddress(event);
	});

}//end of initmap();

//줌을 변경하는 메소드
function zoomChange(event){
	//줌 축소 고정
	if(map.getZoom() < 7){
		map.setZoom(7);
	}
}//end of zoomChange

//주소를 가져오는 메소드
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
     strData += "<p>results[0].formatted_address : "+data.results[0].formatted_address+"</p>"; 
     document.getElementById("dataInfo").innerHTML = strData; 
     } 
     }); 
    } 
     
    	
    //마커를 생성하는 메소드
    	 // 지도에 마커 추가
        function addMarker(location, map){
        	marker = new google.maps.Marker({
        		position : location,
        		title : "현재위치",
        		map : map
        	});
        	
        	var latPosition = ""+location.lat(); // 현재 클릭 위도 가져오기
        	latPosition = latPosition.substring(0,10);
        	var lngPosition = ""+location.lng();//현재 클릭 경도 가져오기
        	lngPosition = lngPosition.substring(0,10);
        	
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
    
	
	//공원부분 메소드!
	function dropPark() {  
		clearMarkers();
		clearlocationsfestival();
		// .parkImg를 비운다.
		$('.parkImg').empty(); 
		 $.ajax({ 
	         type : "post", 
	         url : "/spot/park/listPark", 
	         headers : { 
	             "Content-type" : "application/json", 
	             "X-HTTP-Method-Override" : "POST" 
	         }, 
	         dataType : "text", 
	         success : function (result) { 
	          var result = JSON.parse(result); 
	          var park = result.park 
	          for ( var i = 0 ; i<park.length ; i++){ 
	          obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail }; 
	          locations.push(obj); 
	          //alert(JSON.stringify(locations)); 
	 		 //alert( '넘버' + park[i].parkName + '이름' + park[i].parkDetail + ' Img ' + park[i].parkImg + 'parkAddress' + park[i].parkAddress ); 
	   $('.parkImg').append(function (index){ 
	   // 변수를 선언합니다. 
		      var item = park[index]; 
		      var output = ''; 
		      output += '<h1>' + park[i].parkName + '</h1>'; 
		      output += '<img src=" ' + park[i].parkImg + ' " height="100" width="100" />'; 
		      output += '<h2> 위도 : '  + park[i].parkX + '</h1>'; 
		      output += '<h2> 경도 : '  + park[i].parkY + '</h1>'; 
		      return output; 
		      }) 
	     } 
	  } 
	});// end of ajax 
		
		for ( var i = 0 ; i < locations.length; i++){ 
			addMarkerWithTimeout(locations[i], i * 100); 
		} 
      
		function addMarkerWithTimeout(position, timeout) { 
	        window.setTimeout(function() { 
	        	
	          markers.push(new google.maps.Marker({ 
	            position: position, 
	            map: map, 
	            animation: google.maps.Animation.DROP 
	          }));// end of markerpush 
	        }, timeout); 
	} // end of addMarkerWithTimeout
	} // end of dropPark()
	
	//공원부분 메소드!
	function getLiverList() {  
		clearMarkers();
		$('.parkImg').empty(); 
		 $.ajax({ 
	         type : "post", 
	         url : "/spot/getRiverList", 
	         headers : { 
	             "Content-type" : "application/json", 
	             "X-HTTP-Method-Override" : "POST" 
	         }, 
	         dataType : "text", 
	         success : function (result) {
	          var result = JSON.parse(result); 
	          alert(JSON.stringify(result));
	          var river = result.River 
	          for ( var i = 0 ; i<river.length ; i++){ 
	          obj = {lat : parseFloat(river[i].spotY), lng : parseFloat(river[i].spotX), detail : river[i].spotDetail }; 
	          locations.push(obj); 
	   $('.parkImg').append(function (index){ 
	   // 변수를 선언합니다. 
		      var output = ''; 
		      output += '<h1>' + river[i].spotTitle + '</h1>'; 
		      output += '<img src=" ' + river[i].spotImg + ' " height="100" width="100" />'; 
		      output += '<h2> 위도 : '  + river[i].spotX + '</h1>'; 
		      output += '<h2> 경도 : '  + river[i].spotY + '</h1>'; 
		      return output; 
		      })  
	     } 
	  } 
	});// end of ajax 
		
		for ( var i = 0 ; i < locations.length; i++){ 
			addMarkerWithTimeout(locations[i], i * 100); 
		} 
      
		function addMarkerWithTimeout(position, timeout) { 
			clearMarkers();
	        window.setTimeout(function() { 
	        	
	          markers.push(new google.maps.Marker({ 
	            position: position, 
	            map: map, 
	            animation: google.maps.Animation.DROP 
	          }));// end of markerpush 
	        }, timeout); 
	} // end of addMarkerWithTimeout
	} // end of dropPark()
	
	
	function aaa() {
		alert("장바구니추가완료!")
	}	
	
	function marking() {
		alert("이곳을 마킹합니다!")
	}	
	
	function dropFestival() {  
		// 컨트롤 단에서 돌리고 난 후 정보를 가져와보기!!
		clearMarkers();
		// .parkImg를 비운다.
		$('.parkImg').empty(); 
		var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&MobileOS=ETC&areaCode=1&numOfRows=999&MobileApp=AppTest&arrange=A&listYN=Y&eventStartDate=20180625&&_type=json";
		$.getJSON(url , function(data){
			var data = JSON.parse(JSON.stringify(data));
			var festival = data.response.body.items.item;
			for ( var i = 0 ; i < festival.length; i++){ 
				obj = {lat : parseFloat(festival[i].mapy), lng : parseFloat(festival[i].mapx), img : festival[i].firstimage, title :festival[i].title , tel : festival[i].tel, addr : festival[i].addr1, readcount :festival[i].readcount   }; 
		          locationsfestival.push(obj);
		          // 이부분은 마커를 추가해주는 부분입니다.
		  			for ( var i = 0 ; i < locationsfestival.length; i++){ 
						//마커 각각의 ID를 설정
						//locationsfestival[i].index = i;
		  	          	marker[i] = new google.maps.Marker({
		  	            position: locationsfestival[i],
		  	            map: map
		  	          });
		  	          //인덱스를 꺼내오기.. 중요!!
		  	          marker[i].index = i

		  	        contents[i] = '<div class="box box-primary">'+ 
		            '<div class="box-body box-profile">'+ 
		              '<img class="profile-user-img img-responsive img-circle" src=" ' + locationsfestival[i].img + ' " alt="User profile picture">'+ 
		              '<h3 class="profile-username text-center">' + locationsfestival[i].title + '</h3>'+  
		              '<ul class="list-group list-group-unbordered">'+ 
		                '<li class="list-group-item">'+ 
		               '   <b>위치</b> <a class="pull-right">' + locationsfestival[i].addr + '</a>'+ 
		                '</li>'+ 
		              '  <li class="list-group-item">'+ 
		                  '<b>대표전화</b> <a class="pull-right">' + locationsfestival[i].tel + '</a>'+ 
		                '</li>'+ 
		                '<li class="list-group-item">'+ 
		                 ' <b>조회수</b> <a class="pull-right">' + locationsfestival[i].readcount + '</a>'+ 
		               ' </li>'+ 
		             ' </ul>'+ 
		             '<span> '+
		             ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>상세보기</b></a>'+ 
		             '<span>'+
		             '<span> '+
		             ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>장소바구니추가</b></a>'+ 
		             '</span>'+
		            '</div>';
  
		  	          	
			  	       // 이벤트 정보 넣기
			  	      infowindows[i] = new google.maps.InfoWindow({
			                 content: contents[i],
			                 removeable : true
			               });
  	          
		  	        // 마커를 클릭했을때 이벤트 발생 시키기
		  	        google.maps.event.addListener(marker[i], 'click', function() {
		  	       		// 일단 마커를 모두 닫고
		  	         	for ( var i = 0; i < marker.length ; i++) {
		  	        	 	infowindows[i].close();
		  	        	 } 
		  	        	 infowindows[this.index].open(map, marker[this.index]);
		  	        	map.panTo(marker[this.index].getPosition());
		  	        });

		  	      // 마커를 클릭했을때 이벤트 발생 시키기
		  	        google.maps.event.addListener(marker[i], 'rightclick', function() {
		  	       		alert("이곳의 위치가 궁금한가?!");
		  	        });
		  	        
		  	        
		  	        }
				 //obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail }; 
		         // locations.push(obj);
		          $('.parkImg').append(function (index){ 
		       	   // 변수를 선언합니다. 
		       		      var output = '';
/* 		       		      output += '<img src=" ' + festival[i].firstimage + ' " height="100" width="100" />'; 
		       		      output += '<h2> 제목 : '  + festival[i].title + '</h1>'; 
		       		      output += '<h2> 전화번호 : '  + festival[i].tel + '</h1>'; */
		       		      output += ' <div class="col-lg-12"> ';
		       	           output += ' <div class="box box-danger"> ';
		       	        	output += '<div class="box-header with-border">';
		       	        		output += ' <div class="box-tools pull-right">';
		       	        				output += '   <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>';
		       	        					output += '   </button>';
		       	        						output += '    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i>';
		       	        							output += '   </button>';
		       	        								output += '  </div>';
		       	        									output += '   </div>';
		                    <!-- /.box-header -->
		                    output += '    <div class="box-body no-padding">';
		                    	output += '  <ul class="users-list clearfix">';
		                    		output += '     <li>';
		                    			if(typeof  festival[i].firstimage==="undefined"){
		                    			output += '       <img src="http://tong.visitkorea.or.kr/cms/resource/61/2541361_image2_1.JPG" height="100" width="100">';
		                    			} else {
		                    				output += '       <img src=" ' + festival[i].firstimage + ' " height="100" width="100">';
		                    			}
		                    				output += '       <a class="users-list-name" href="#">Alexander Pierce</a>';
		                    					output += '       <span class="users-list-date">Today</span>';
		                    						output += '     </li>';
		                    							output += '   </ul>';
		                      <!-- /.users-list -->
		                      output += '    </div>';
		                    <!-- /.box-body -->
		                    output += '  <div class="box-footer text-center">';
		                    	output += '<a href="javascript:void(0)" class="uppercase">장소 상세보기</a>';
		                    		output += '</div>';
		                    <!-- /.box-footer -->
		                    output += '</div>';
		                  <!--/.box -->
		                  output += '</div>';
		                <!-- /.col -->
		                output += ' </div>';
		              <!-- /.row -->
		       		      return output; 
		       		      }) 
			} 
		});// end of getJSON
	} // end of dropFestival()
	
	function clearMarkers() { 
	        for (var i = 0; i < markers.length; i++) { 
	          markers[i].setMap(null); 
	        } 
	        markers = []; 
	      }
	
	function clearlocationsfestival() { 
        for (var i = 0; i < marker.length; i++) { 
        	marker[i].setMap(null); 
        } 
        marker = []; 
      } 
	</script>


<script> 
$(document).ready(function (){ 
//이벤트를 연결합니다. 
	$('#img').on('click', function() { 
		$('#myModal').modal("hide"); 
		}) 
	}); 

	$(function() { 
	 	$( '#abc' ).on("click" , function() { 
	 		alert("장바구니추가완료!");
	 });  	
	  
}); 
	
	//드래그앤 드랍 파일 업로드 부분
	$(function () {
    var obj = $("#dropzone");
    var a = $("#img");
    var upload = $('input:file')[0]
    
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px solid #5272A0');
    });

    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');
    });

    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
    
    $(obj).on("click" , function name() {
		$(upload).click();
	})
    
    /////1. 터치해서 업로드/////
    $(upload).on("change", function (e) {
		e.preventDefault();  // 기본적인 서브밋 행동을 취소합니다
		
	
		var file = upload.files[0]
		
		var reader = new FileReader();
	
		reader.onload = function (event) {
			obj.text("");
			var img = new Image();
			img.src = event.target.result;
			var a = (img.src).split(',');
			
			//obj.append(img);
			//$("#img").css("background-image","url(image)");
			$("#img").append(img);
			}
		reader.readAsDataURL(file);// File에서 읽어 오는 역할
		
		return false;
         
         if(file.length < 1)
              return;
    });
	////////////////////////////////////////////////
	
	
	////2. 드래그앤 드롭 업로드 /////
    obj.on('drop', function (e) {
    	console.log(obj.text())
    	obj.text("");
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');

         var file = e.originalEvent.dataTransfer.files[0];
         var reader = new FileReader();
         
		reader.onload = function (event) {
			var img = new Image();
			img.src = event.target.result;
			
			//obj.append(img);
			$("#img").css("background-image","url(image)");
			$("#img").append(img);
		}
         //})
		reader.readAsDataURL(file);// File에서 읽어 오는 역할
		
		return false;
         
         if(file.length < 1)
              return;

    });

});

</script>
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
			<div id="weather_info">
				<h1 class="city"></h1>
				<section>
					<p class="w_id"></p>
					<div class="icon"></div>
					<span class="temp"></span> <span class="temp_max"></span> <span
						class="temp_min"></span>
				</section>
			</div>

			<%-- Main content --%>
			<section class="content container-fluid">
				<body>
					<div id="img" style="background-image: url(../images/park01.png)">
						<div class="content">
							<h1>Hello!</h1>
							<h2>Where are you going?</h2>
							<div id="dropzone">사진을 드래그 하거나 터치하세요</div>
							<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="dropzone">섬네일 바꾸시기 원하시면 클릭하세요!</button>  -->
							<input style="display: none;" type="file" id="testfile"
								name="testfile">
						</div>
						<div id="img-cover"></div>
					</div>
					<br />
					<br />

					<span class="dropdown">
						<button class="btn btn-block btn-info btn-xs" onclick="dropPark()">공원</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>

					<span class="dropdown">
						<button class="btn btn-block btn-success btn-xs"
							onclick="dropFestival()">축제/전시</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>

					<span class="dropdown">
						<button class="btn btn-block btn-info btn-xs">맛집</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>

					<span class="dropdown">
						<button class="btn btn-block btn-danger btn-xs"
							onclick="getLiverList()">한강</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>

					<span class="dropdown">
						<button class="btn btn-block btn-warning btn-xs"
							onclick="dropBicycle()">편의시설</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>


					<div id="map">
						<br /> <br />
					</div>
					<div class="parkImg"></div>
					<p></p>
					<div id="dataInfo"></div>
					<br />
					<br />
					<br />
					<br />
					<br />
					<!--  클릭시 모달창을 띄우는 코딩 -->
					<!-- Modal -->


					<!-- 댓글작성 modal 창 start -->
					<div class="modal fade" id="myModal" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">어느 피크닉 장소를 가세요?</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label for="replyDetail">장소를 간단히 설명해주세요!!</label> <input
											class="form-control" id="replyDetail" name="replyDetail"
											placeholder="댓글 내용을 입력해주세요">
									</div>
									<div class="form-group">
										<label for="InputFile">썸네일로 쓰실 사진을 올려주세요</label> <input
											type="file" id="InputFile">
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default pull-left"
										data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-danger modalModBtn">수정</button>
								</div>
							</div>
						</div>
					</div>
		</div>
</body>


<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"> 
	    </script>
<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>
<!-- Handlebars -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
<!-- $를 이용할 수 있게 만드는 j-Query -->
<!-- Bootstrap 3.3.7 -->
<script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
</div>
</body>

</html>
