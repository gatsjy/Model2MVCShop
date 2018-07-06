<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Data Layer: Styling</title>
    <meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
    <div id="map"></div>
    <script>
      var map;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: {lat: -28, lng: 137}
        });

        // Load GeoJSON.
        map.data.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json');
        // Set the stroke width, and fill color for each polygon
        map.data.setStyle({
          fillColor: '#F2F79B',
          strokeWeight: 1.5
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDprTpTKP9yY2_xLHqvY35HqJwIcqCP264&callback=initMap">
    </script>
  </body>
</html>