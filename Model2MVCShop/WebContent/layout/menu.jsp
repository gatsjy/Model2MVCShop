<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// 로그인시 Forward  /////////////////////////////////////// -->
 <c:if test="${ ! empty user }">
 	<jsp:forward page="main.jsp"/>
 </c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  /////////////////////// 추가된 CSS , js ///////////////////////////////// -->
	<!-- Bootstrap Dropdown Hover CSS -->
    <link href="../css/animate.min.css" rel="stylesheet">
    <link href="../css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    
     <!-- Bootstrap Dropdown Hover JS -->
    <script src="../javascript/bootstrap-dropdownhover.min.js"></script>
	<!--  //////////////////////////////////////////////////////////////////////////////////// -->
	
	<!--  ////////////////////// CSS////////////////////////////////////////////////////// -->
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
		<style>
	        body {
	            padding-top : 100px;
	        }
	                
    	</style>
   	
   	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= 회원원가입 화면이동 =============
		$( function() {
			$("a[href='#' ]:contains('Register')").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		//============= 로그인 화면이동 =============
		$( function() {
			$("a[href='#' ]:contains('Log in')").on("click" , function() {
				self.location = "/user/loginView.jsp"
			});
		});
		
		//============= 내정보 보기로 화면 이동 ===========
		$( function() {
			$("a[href='#' ]:contains('Mypage')").on("click" , function() {
				self.location = "/user/getUser"
			});
		});
		
	</script>	
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-inverse navbar-fixed-top">
		
        <div class="container">
        
        	<a class="navbar-brand" href="/index.jsp">JUAN SHOP</a>
			
			<!-- toolBar Button Start //////////////////////// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			<!-- toolBar Button End //////////////////////// -->
			
			<!-- //////////////////////////// dropdown을 위해서 사용된 부분 ////////////////////////////////////// -->
			<div class="collapse navbar-collapse"  id="target"
						data-hover="dropdown" 
  						data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
  				
  				<!-- Tool Bar 를 다양하게 사용하면.... -->
	                <ul class="nav navbar-nav">
	                
		                <!--  DrowDown 사용 -->
		                <li class="dropdown">
	                        <a  href="#" class="dropdown-toggle" data-toggle="dropdown">
	                            <span>JUAN SHOP</span>
	                            <span class="caret"></span>
	                        </a>
	                        <ul class="dropdown-menu">
	                            <li><a href="#">Web UI</a></li>
	                            <li><a href="#">W3C</a></li>
	                            <li class="divider"></li>
	                            <li><a href="#">Static Contents</a></li>
	                        </ul>
	                    </li>
	                
	                    <li><a href="#">회사소개</a></li>
	                    <li><a href="#">인재영입</a></li>
	                    
	                    <!--  /////////////////////// DropDown 내부에 다시 DropDown///////////////////////////////// -->
	                    <!--  DropDown 사용 -->
		                <li class="dropdown">
	                        <a  href="#" class="dropdown-toggle" data-toggle="dropdown">
	                            <span>걸어온길</span>
	                            <span class="caret"></span>
	                        </a>
	                        <ul class="dropdown-menu">
	                            <li><a href="#">Web UI</a></li>
	                            <li><a href="#">W3C</a></li>
	                            
	                            <!--  DrowDown 사용 -->
				                <li class="dropdown">
			                        <a  href="#" class="dropdown-toggle" data-toggle="dropdown">
			                            <span>회사경영</span>
			                            <span class="caret"></span>
			                        </a>
			                        <ul class="dropdown-menu">
			                            <li><a href="#">Web UI</a></li>
			                            <li><a href="#">W3C</a></li>
			                            <li class="divider"></li>
			                            <li><a href="#">Static Contents</a></li>
			                        </ul>
			                    </li>
	                            
	                            <li class="divider"></li>
	                            <li><a href="#">Static Contents</a></li>
	                        </ul>
	                    </li>
	                    <!--  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	                    
	                </ul>
	                
	                <ul class="nav navbar-nav navbar-right">
	                    <li><a href="#">Register</a></li>
	                    <li><a href="#">Log in</a></li>
	                    <li><a href="#">Mypage</a></li>
	               	</ul>
	               	
				</div>	       
	       
    		</div>
    	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- 다단레이아웃  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu 구성 Start /////////////////////////////////////-->     	
			<div class="col-md-2">
		        
		       	<!--  회원관리 목록에 제목 -->
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-heart"></i> 회원관리
         			</div>
         			<!--  회원관리 아이템 -->
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">개인정보조회</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">회원정보조회</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
					</ul>
		        </div>
               
               
				<div class="panel panel-primary">
					<div class="panel-heading">
							<i class="glyphicon glyphicon-briefcase"></i> 판매상품관리
         			</div>
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">판매상품등록</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">판매상품관리</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
					</ul>
		        </div>
               
               
				<div class="panel panel-primary">
					<div class="panel-heading">
							<i class="glyphicon glyphicon-shopping-cart"></i> 상품구매
	    			</div>
					<ul class="list-group">
						 <li class="list-group-item"><a href="#">상품검색</a></li>
						  <li class="list-group-item">
						  	<a href="#">구매이력조회</a> <i class="glyphicon glyphicon-ban-circle"></i>
						  </li>
						 <li class="list-group-item">
						 	<a href="#">최근본상품</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
					</ul>
				</div>
				
			</div>
			<!--  Menu 구성 end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-10">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>로그인 후 사용가능...</p>
			  		<p>로그인 전 검색만 가능합니다.</p>
			  		<p>회원가입 하세요.</p>
			  		
			  		<div class="text-center">
			  			<a class="btn btn-info btn-lg" href="#" role="button">회원가입</a>
			  			<a class="btn btn-info btn-lg" href="#" role="button">로 그 인</a>
			  		</div>
			  	
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->
		
	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>