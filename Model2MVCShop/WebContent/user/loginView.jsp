<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<title>로그인 화면</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
		<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type="text/javascript">
	
		function fnckakaoLogin(){
			 Kakao.init('82d52d1fbb53bb61fc8423c163252a11');
			    Kakao.Auth.login({
			      success: function(authObj) {
			    	Kakao.API.request({
			    		url : '/v1/user/me',
			    			success: function(res) {
			    				 var kakao = JSON.parse(JSON.stringify(res));
			    				 id = kakao.id;
			    				 name = kakao.properties.nickname;
			    				 email = kakao.kaccount_email;
			    				//ajax		
					    		$.ajax({
					    			url :"/user/json/kakaologin",
					    			method:"POST",
					    			dataType:"json",
					    			headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
					    			data : JSON.stringify({
					    				userId : id,
					    				userName : name,
					    				email : email
					    				}),
					    			success : function(dbUser, status){
					    				 if(dbUser.password != null ){
					    					 self.location ="/index.jsp";
					    					//$(window.parent.document.location).attr("href","/index.jsp");		
					    				}else{
					    					alert("가입을 위한 페이지로 넘어가겠습니다!!");
					    					 self.location ="/user/addKakaoUserView.jsp";
					    				}
					    			}
					    		}); //ajax 끝
			      },
			      fail: function(err) {
			         alert(JSON.stringify(err));
			      }
			    });
			      },
			      fail : function(err){
			    	  alert(JSON.stringify(err));
			      }
			    });	
		} //카카오 함수 끝	
		
		//카카오 함수를 시작해내기 위함
		$( function() {
			$("img[src='/images/kakao/kakao_login_btn_small.png']").on("click" , function() {
				alert("hello!");
				fnckakaoLogin();
			});	
		});	
		
		$( function() {
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#userId").focus();
			
			//==> 추가된부분 : "Login"  Event 연결
			$("button").on("click" , function() {

				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("input:text").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("input:password").focus();
					return;
				}
				
				//$("form").attr("method" , "POST");
				//$("form").attr("action" , "/login.do");
				//$("form").attr("target" , "_parent");
			    //$("form").submit();
			    
				//==> 위의 4실행문과 같은의미			    
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();		
			});
		});
		
		
		//*=============jQuery 추가된부부분 : 회원원가입화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
	</script>		
	
</head>

<body bgcolor="#ffffff" text="#000000" >

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="">JUAN Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					      <!-- 카카오톡 로그인 버튼 -->
                  		 	<img src="/images/kakao/kakao_login_btn_small.png" width="56" height="20" border="0"/>
					    </div>
					  </div>
			
					</form>
			   	 </div>
			
			</div>
			
  	 	</div>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>