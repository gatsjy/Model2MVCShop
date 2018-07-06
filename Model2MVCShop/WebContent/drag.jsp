<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

  <script type="text/javascript">
    google.charts.load("current", {packages:["timeline"]});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
      var container = document.getElementById('example7.1');
      var chart = new google.visualization.Timeline(container);
      var dataTable = new google.visualization.DataTable();
      dataTable.addColumn({ type: 'string', id: 'Room' });
      dataTable.addColumn({ type: 'string', id: 'Name' });
      dataTable.addColumn({ type: 'date', id: 'Start' });
      dataTable.addColumn({ type: 'date', id: 'End' });
      dataTable.addRows([
        [ '계획표!', '첫번째 도착지', new Date(0,0,0,14,0,0), new Date(0,0,0,14,30,0)],
        [ '계획표!', '자동차',    new Date(0,0,0,14,30,0), new Date(0,0,0,15,30,0)],
        [ '계획표!', '두번째 도착지', new Date(0,0,0,15,30,0), new Date(0,0,0,16,30,0)],
        [ '계획표!', '자동차',    new Date(0,0,0,16,30,0), new Date(0,0,0,17,30,0)],
        [ '계획표!', '세번째 도착지', new Date(0,0,0,17,30,0), new Date(0,0,0,18,30,0)],
        [ '계획표!', '버스',    new Date(0,0,0,18,30,0), new Date(0,0,0,19,30,0)],
        [ '계획표!', '세번째 도착지',    new Date(0,0,0,19,30,0), new Date(0,0,0,24,30,0)]
    ]);

      var options = {
        timeline: { showRowLabels: false },
        avoidOverlappingGridLines: false
      };

      chart.draw(dataTable, options);
    }

  </script>

  <div id="example7.1" style="height: 500px; width:1000px"></div>
