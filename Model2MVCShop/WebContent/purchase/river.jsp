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

//���� ������ 
var icon_url = 'http://openweathermap.org/img/w/' + icon; 

//���� ���� ǥ�� 
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
 
//�� �κ��� ���� ���� �� �Դϴ�! 
//�߾� ��ġ���� ������ �ݴϴ�. 
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
	
     // �� ��Ÿ�� �Ӽ��� �ʿ��� �迭 ���� 
     var styles =[ 
     ]; 
     
     //���ο� styleMapType�� �����ϸ� Ŀ���͸���¡�� ��Ÿ���� ���� ��Ų ��ü�� �����. 
     var styledMap = new google.maps.StyledMapType(styles, {name : "Styled Map"}); 
    
     // �ʿ� ���õ� ���� �ɼ��� ���� ��Ų��. 
     var mapOptions = { 
     //���� �� �ε� �� ��ġ �� ���� 
     center : center, 
     // �� ���� ���� 
     zoom : 11, 
     // ��Ÿ�� �� ���� 
     mapTypeControlOptions : { 
     mapTypeIds : [google.maps.MapTypeId.ROADMAP, 'map_style'] 
     } 
     }; 
     
     // �� ��ü ���� 
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
     
     // ���� ��ܿ� Ŀ���� ����¡�� ���� ������ �� �ִ� â�� �����Ѵ�. 
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
       
    // Ŭ���� �̺�Ʈ ������ ����
   	map.data.addListener('click', function(event) {
   		alert("saesa");
   		getAddress(event);
   	});
    
 // Ŭ���� �̺�Ʈ ������ ����
	google.maps.event.addListener(map, 'click', function(event) {
		getAddress(event);
	});

}//end of initmap();

//���� �����ϴ� �޼ҵ�
function zoomChange(event){
	//�� ��� ����
	if(map.getZoom() < 7){
		map.setZoom(7);
	}
}//end of zoomChange

//�ּҸ� �������� �޼ҵ�
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
     strData += "<p>results[0].formatted_address : "+data.results[0].formatted_address+"</p>"; 
     document.getElementById("dataInfo").innerHTML = strData; 
     } 
     }); 
    } 
     
    	
    //��Ŀ�� �����ϴ� �޼ҵ�
    	 // ������ ��Ŀ �߰�
        function addMarker(location, map){
        	marker = new google.maps.Marker({
        		position : location,
        		title : "������ġ",
        		map : map
        	});
        	
        	var latPosition = ""+location.lat(); // ���� Ŭ�� ���� ��������
        	latPosition = latPosition.substring(0,10);
        	var lngPosition = ""+location.lng();//���� Ŭ�� �浵 ��������
        	lngPosition = lngPosition.substring(0,10);
        	
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
    
	
	//�����κ� �޼ҵ�!
	function dropPark() {  
		clearMarkers();
		clearlocationsfestival();
		// .parkImg�� ����.
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
	 		 //alert( '�ѹ�' + park[i].parkName + '�̸�' + park[i].parkDetail + ' Img ' + park[i].parkImg + 'parkAddress' + park[i].parkAddress ); 
	   $('.parkImg').append(function (index){ 
	   // ������ �����մϴ�. 
		      var item = park[index]; 
		      var output = ''; 
		      output += '<h1>' + park[i].parkName + '</h1>'; 
		      output += '<img src=" ' + park[i].parkImg + ' " height="100" width="100" />'; 
		      output += '<h2> ���� : '  + park[i].parkX + '</h1>'; 
		      output += '<h2> �浵 : '  + park[i].parkY + '</h1>'; 
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
	
	//�����κ� �޼ҵ�!
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
	   // ������ �����մϴ�. 
		      var output = ''; 
		      output += '<h1>' + river[i].spotTitle + '</h1>'; 
		      output += '<img src=" ' + river[i].spotImg + ' " height="100" width="100" />'; 
		      output += '<h2> ���� : '  + river[i].spotX + '</h1>'; 
		      output += '<h2> �浵 : '  + river[i].spotY + '</h1>'; 
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
		alert("��ٱ����߰��Ϸ�!")
	}	
	
	function marking() {
		alert("�̰��� ��ŷ�մϴ�!")
	}	
	
	function dropFestival() {  
		// ��Ʈ�� �ܿ��� ������ �� �� ������ �����ͺ���!!
		clearMarkers();
		// .parkImg�� ����.
		$('.parkImg').empty(); 
		var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&MobileOS=ETC&areaCode=1&numOfRows=999&MobileApp=AppTest&arrange=A&listYN=Y&eventStartDate=20180625&&_type=json";
		$.getJSON(url , function(data){
			var data = JSON.parse(JSON.stringify(data));
			var festival = data.response.body.items.item;
			for ( var i = 0 ; i < festival.length; i++){ 
				obj = {lat : parseFloat(festival[i].mapy), lng : parseFloat(festival[i].mapx), img : festival[i].firstimage, title :festival[i].title , tel : festival[i].tel, addr : festival[i].addr1, readcount :festival[i].readcount   }; 
		          locationsfestival.push(obj);
		          // �̺κ��� ��Ŀ�� �߰����ִ� �κ��Դϴ�.
		  			for ( var i = 0 ; i < locationsfestival.length; i++){ 
						//��Ŀ ������ ID�� ����
						//locationsfestival[i].index = i;
		  	          	marker[i] = new google.maps.Marker({
		  	            position: locationsfestival[i],
		  	            map: map
		  	          });
		  	          //�ε����� ��������.. �߿�!!
		  	          marker[i].index = i

		  	        contents[i] = '<div class="box box-primary">'+ 
		            '<div class="box-body box-profile">'+ 
		              '<img class="profile-user-img img-responsive img-circle" src=" ' + locationsfestival[i].img + ' " alt="User profile picture">'+ 
		              '<h3 class="profile-username text-center">' + locationsfestival[i].title + '</h3>'+  
		              '<ul class="list-group list-group-unbordered">'+ 
		                '<li class="list-group-item">'+ 
		               '   <b>��ġ</b> <a class="pull-right">' + locationsfestival[i].addr + '</a>'+ 
		                '</li>'+ 
		              '  <li class="list-group-item">'+ 
		                  '<b>��ǥ��ȭ</b> <a class="pull-right">' + locationsfestival[i].tel + '</a>'+ 
		                '</li>'+ 
		                '<li class="list-group-item">'+ 
		                 ' <b>��ȸ��</b> <a class="pull-right">' + locationsfestival[i].readcount + '</a>'+ 
		               ' </li>'+ 
		             ' </ul>'+ 
		             '<span> '+
		             ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>�󼼺���</b></a>'+ 
		             '<span>'+
		             '<span> '+
		             ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>��ҹٱ����߰�</b></a>'+ 
		             '</span>'+
		            '</div>';
  
		  	          	
			  	       // �̺�Ʈ ���� �ֱ�
			  	      infowindows[i] = new google.maps.InfoWindow({
			                 content: contents[i],
			                 removeable : true
			               });
  	          
		  	        // ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
		  	        google.maps.event.addListener(marker[i], 'click', function() {
		  	       		// �ϴ� ��Ŀ�� ��� �ݰ�
		  	         	for ( var i = 0; i < marker.length ; i++) {
		  	        	 	infowindows[i].close();
		  	        	 } 
		  	        	 infowindows[this.index].open(map, marker[this.index]);
		  	        	map.panTo(marker[this.index].getPosition());
		  	        });

		  	      // ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
		  	        google.maps.event.addListener(marker[i], 'rightclick', function() {
		  	       		alert("�̰��� ��ġ�� �ñ��Ѱ�?!");
		  	        });
		  	        
		  	        
		  	        }
				 //obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail }; 
		         // locations.push(obj);
		          $('.parkImg').append(function (index){ 
		       	   // ������ �����մϴ�. 
		       		      var output = '';
/* 		       		      output += '<img src=" ' + festival[i].firstimage + ' " height="100" width="100" />'; 
		       		      output += '<h2> ���� : '  + festival[i].title + '</h1>'; 
		       		      output += '<h2> ��ȭ��ȣ : '  + festival[i].tel + '</h1>'; */
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
		                    	output += '<a href="javascript:void(0)" class="uppercase">��� �󼼺���</a>';
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
//�̺�Ʈ�� �����մϴ�. 
	$('#img').on('click', function() { 
		$('#myModal').modal("hide"); 
		}) 
	}); 

	$(function() { 
	 	$( '#abc' ).on("click" , function() { 
	 		alert("��ٱ����߰��Ϸ�!");
	 });  	
	  
}); 
	
	//�巡�׾� ��� ���� ���ε� �κ�
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
    
    /////1. ��ġ�ؼ� ���ε�/////
    $(upload).on("change", function (e) {
		e.preventDefault();  // �⺻���� ����� �ൿ�� ����մϴ�
		
	
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
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
		return false;
         
         if(file.length < 1)
              return;
    });
	////////////////////////////////////////////////
	
	
	////2. �巡�׾� ��� ���ε� /////
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
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
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
				<h1>�Ǹ���������</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> �ǸŰ���</a></li>
					<li class="active">�Ǹ�����</li>
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
							<div id="dropzone">������ �巡�� �ϰų� ��ġ�ϼ���</div>
							<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="dropzone">������ �ٲٽñ� ���Ͻø� Ŭ���ϼ���!</button>  -->
							<input style="display: none;" type="file" id="testfile"
								name="testfile">
						</div>
						<div id="img-cover"></div>
					</div>
					<br />
					<br />

					<span class="dropdown">
						<button class="btn btn-block btn-info btn-xs" onclick="dropPark()">����</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>

					<span class="dropdown">
						<button class="btn btn-block btn-success btn-xs"
							onclick="dropFestival()">����/����</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>

					<span class="dropdown">
						<button class="btn btn-block btn-info btn-xs">����</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>

					<span class="dropdown">
						<button class="btn btn-block btn-danger btn-xs"
							onclick="getLiverList()">�Ѱ�</button>
						<div class="dropdown-content">
							<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
								3</a>
						</div>
					</span>

					<span class="dropdown">
						<button class="btn btn-block btn-warning btn-xs"
							onclick="dropBicycle()">���ǽü�</button>
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
					<!--  Ŭ���� ���â�� ���� �ڵ� -->
					<!-- Modal -->


					<!-- ����ۼ� modal â start -->
					<div class="modal fade" id="myModal" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">��� ��ũ�� ��Ҹ� ������?</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label for="replyDetail">��Ҹ� ������ �������ּ���!!</label> <input
											class="form-control" id="replyDetail" name="replyDetail"
											placeholder="��� ������ �Է����ּ���">
									</div>
									<div class="form-group">
										<label for="InputFile">����Ϸ� ���� ������ �÷��ּ���</label> <input
											type="file" id="InputFile">
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default pull-left"
										data-dismiss="modal">�ݱ�</button>
									<button type="button" class="btn btn-danger modalModBtn">����</button>
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
<!-- $�� �̿��� �� �ְ� ����� j-Query -->
<!-- Bootstrap 3.3.7 -->
<script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
</div>
</body>

</html>
