<%@ page contentType="text/html; charset=euc-kr"  %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

    <title>Document</title>
    <link href="/css/index.css" rel="stylesheet" type="text/css">
   <script src="/javascript/jquery-1.12.4.min.js"></script>
<!-- bxSlider Javascript file -->
<script src="/javascript/jquery.bxslider.min.js"></script>
<!-- bxSlider CSS file -->
<link href="/css/jquery.bxslider.css" rel="stylesheet" />
</head>
<body>
   <div id="wrap">
       <div id="header" class="center-wrapper">
          <div id="topgnb">
              <ul>
                  <li><a href="#">Log in</a></li>
                  <li><a href="#">| Register | </a></li>
                  <li><a href="#">Mypage</a></li>
              </ul>
          </div>
           <div class="line"></div>
           <div id="gnb">
               <ul>
                   <li><a href="#">��õ��ǰ &nbsp;&nbsp;</a></li>
                   <li><a href="/product/listProduct?menu=search">��ǰ��� &nbsp;&nbsp; </a></li>
                   <li><a href="/cart/listCart">��ٱ��� &nbsp;&nbsp; </a></li>
               </ul>
           </div>
           <!--//gnb-->
       </div>
       <!--//header-->
       <div id="main" class="center-wrapper">
           <ul class="items">
               <li class="item-wide">
               <span class="item-on-hover1"></span>
               <div class="item-box">
                   <h2>�ְ��� ���� ��ǰ</h2>
                   <p><br><br><br><br><br></p>
               </div>
       		   <c:if test="${favoriteStarFile==null}">
       		   <a href="#"><img src="/images/uploadFiles/macbookair.jpg" class="item-wide"></a>
       		   </c:if>
       		   <c:if test="${favoriteStarFile!=null}">
               <a href="#"><img src="/images/uploadFiles/${favoriteStarFile}" class="item-wide"></a>
              </c:if>
               </li>
               <!----//1---->>
               <li class="item-small"><span class="item-on-hover"></span><a href="#"><img src="/images/right/macbookair.jpg" class="item-small"></a></li>
               <!----//2---->
               <li class="item-small"><span class="item-on-hover"></span><a href="#"><img src="/images/right/main3.png" class="item-small"></a></li>
               <!----//3---->
 			   <li>    
                 <ul class="bxslider" >
                  <li class="item-long"><img src="/images/right/main4.png" class="item-small"></li>
                  <li class="item-long"><img src="/images/right/main4.png" class="item-small"></li>
                  <li class="item-long"><img src="/images/right/main4.png" class="item-small"></li>
                </ul>
               </li>
           </ul>
           
           <ul class="events">
                <li class="box1">
                    <h1>��������</h1>
                    <p id="event1"><b>���� �� �佺Ƽ��</b><br>���� ������ �� �÷��ּ���
                    <br>9.14 (��)~ 9.29(��)</p>
                    <p><b>���� ���� ȭ��</b><br>�ڱⰡ ���� �Ƹ��ٿ� ȭ�縦 SNS�� �������ֽð� <br>���������� �޾ư�����!<br>
                    9.19 (ȭ)~ 10.6(��)</p>
                    <p><b>���� ������ ���� ȭ��</b><br>�ڱⰡ ���� ���� ȭ�縦 �������� �÷θ���Ʈ���� <br>���� �����Ͻð� �ı⸦ �����ּ���<br>
                    9.19 (ȭ)~ 10.6(��)</p>
                </li> 
                <li class="box2">   
                    <h1>ȸ�� ��ġ</h1>
                    <h2 id="map"><script> 
                            function initMap() {
                            var uluru = {lat: 36.791760, lng: 127.127186};
                                var map = new google.maps.Map(document.getElementById('map'), {
                                    zoom: 4,
                                    center: uluru});
                                    var marker = new google.maps.Marker({
                                        position: uluru,
                                        map: map
                                            });
                                                    }
                        </script>
                    </h2>
                </li>
                <li class="box1">
                  
                    <h1>�츮���� ������ �ƴ϶� ��ġ�� �Ǹ��մϴ�.</h1>
                    <iframe width="390" height="280" src="https://www.youtube.com/embed/AFZ2Mq02-_4" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                </li>
           </ul>
   
       <script async defer  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAqkrjfpXx3eZStb6iKNrixAM2wZGazKes&callback=initMap"></script>
    
    <script> 
            $('.bxslider').bxslider({
                 auto:true,
                 pager:false,
                mode:'fade',
                auto: true,
  				autoControls: true,
        })//bx
        
    </script>
</body>
</html>