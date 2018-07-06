<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<html>
  <head>
    <title>Distance Matrix service</title>
    <style>
      #right-panel {
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }

      #right-panel select, #right-panel input {
        font-size: 15px;
      }

      #right-panel select {
        width: 100%;
      }

      #right-panel i {
        font-size: 12px;
      }
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
        width: 50%;
      }
      #right-panel {
        float: right;
        width: 48%;
        padding-left: 2%;
      }
      #output {
        font-size: 11px;
      }
    </style>
  </head>
  <body>
    <div id="right-panel">
      <div id="inputs">
		<button class="btn btn-block btn-danger btn-xs" onclick="getRiverList()">한강</button>
      </div>
      <div>
        <strong>Results</strong>
      </div>
      <div id="output"></div>
    </div>
    <div id="map"></div>
    <script>
    //한강부분 메소드!
  	function getRiverList() {
  		
  } // end of getRiverList()
    
    
    
    
    
    var destinationIcon = 'https://chart.googleapis.com/chart?' +
        'chst=d_map_pin_letter&chld=D|FF0000|000000';
    var originIcon = 'https://chart.googleapis.com/chart?' +
        'chst=d_map_pin_letter&chld=O|FFFF00|000000';
    var origin1 = {lat: 37.494541, lng: 127.02758300000005};
    var destinationA = {lat: 37.57593689999999, lng: 126.97681569999997};
    
    
   
 
      function initMap() {
      var locations=[ {lat: 37.57593689999999, lng: 126.97681569999997}];  
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
 		        var river = result.river 
 		        alert(JSON.stringify(river));
 	          for ( var i = 0 ; i<river.length ; i++){    
 	        	obj = {lat : parseFloat(river[i].spotY), lng : parseFloat(river[i].spotX) };
 			    locations.push(obj);
 	        };
 	}
 });// end of ajax 
 
        var bounds = new google.maps.LatLngBounds;
        var markersArray = [];
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 37.494541, lng: 127.02758300000005},
          zoom: 10
        });
        var geocoder = new google.maps.Geocoder;

        var service = new google.maps.DistanceMatrixService;
        service.getDistanceMatrix({
          origins: [origin1],
          destinations: locations,
          travelMode: 'TRANSIT',
          unitSystem: google.maps.UnitSystem.METRIC,
          avoidHighways: false,
          avoidTolls: false
        }, function(response, status) {
          if (status !== 'OK') {
            alert('Error was: ' + status);
          } else {
            var originList = response.originAddresses;
            var destinationList = response.destinationAddresses;
            var outputDiv = document.getElementById('output');
            outputDiv.innerHTML = '';
            deleteMarkers(markersArray);

            var showGeocodedAddressOnMap = function(asDestination) {
              var icon = asDestination ? destinationIcon : originIcon;
              return function(results, status) {
                if (status === 'OK') {
                  map.fitBounds(bounds.extend(results[0].geometry.location));
                  markersArray.push(new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location,
                    icon: icon
                  }));
                } else {
                  alert('Geocode was not successful due to: ' + status);
                }
              };
            };

            for (var i = 0; i < originList.length; i++) {
              var results = response.rows[i].elements;
              geocoder.geocode({'address': originList[i]},
                  showGeocodedAddressOnMap(false));
              for (var j = 0; j < results.length; j++) {
                geocoder.geocode({'address': destinationList[j]},
                    showGeocodedAddressOnMap(true));
                alert(JSON.stringify(results[j].distance.value));
                if ( parseInt(results[j].distance.value) < 10000){
                outputDiv.innerHTML += originList[i] + ' to ' + destinationList[j] +
                    ': ' + results[j].distance.text + ' in ' +
                    results[j].duration.text + '<br>';
                }
              }
            }
          }
        });
      }

      function deleteMarkers(markersArray) {
        for (var i = 0; i < markersArray.length; i++) {
          markersArray[i].setMap(null);
        }
        markersArray = [];
      }
      
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD7-c6GOHSYIeB4RuWDwIbWPdu2oeRTnpI&callback=initMap">
    </script>
  </body>
</html>