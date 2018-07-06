<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<title>회원 목록 조회</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%--plugin_js.jsp--%>
<%@ include file="../include/plugin_js.jsp"%>
<!-- CDN(Content Delivery Network) 호스트 사용 -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
		//document.detailForm.submit();
		$("form").attr("method", "POST").attr("action", "/user/listUser")
				.submit();
	}
	//===========================================//
	//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
	$(function() {

		$("button").on("click", function() {
			fncGetList(1);
		});

		$("td:nth-child(5) > i").on("click", function() {

					var userId = $(this).next().val();

					$.ajax({
						url : "/user/json/getUser/" + userId,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData, status) {

							var displayValue = "<h6>" + "아이디 : "
									+ JSONData.userId + "<br/>" + "이  름 : "
									+ JSONData.userName + "<br/>" + "이메일 : "
									+ JSONData.email + "<br/>" + "ROLE : "
									+ JSONData.role + "<br/>" + "등록일 : "
									+ JSONData.regDate + "<br/>" + "</h6>";
							$("h6").remove();
							$("#" + userId + "").html(displayValue);
						}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
				});
	});

	/* 	//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		
		//==> 아래와 같이 정의한 이유는 ??
		//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
		console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
		//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
	
		}); */
	////////////////////////////// 이제 부터 오토컴플리트를 해주기 위한 자바스크립트입니다//////////////////////////////////////
	$(function() {
		var availableTags = new Array(); //자바스크립트 내부의 어레이 객체를 만들기 위해서 선언해준다.
		$("#searchKeyword").on("click", function() { //클릭했을때 구동할 수 있도록 동작을 말해준다.
			$.ajax({
				url : "/user/json/listUserAjax", //내가 받고 싶은 rest서버로 응답을 요청한다.
				type : "POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				dataType : "json",
				data : JSON.stringify({ //여기서 조심! 스트링화 시켜줘서 보내줘야지 제대로된 데이터가 전달된다.
					searchCondition : $("#searchCondition").val(),
					searchKeyword : $("#searchKeyword").val(),
				}),
				success : function(list, status) { // 성공했을시 나에게 오는 데이터들.. 여기서 주의해야 할 점은 list라는 이름으로 리턴되는 값은 내가 도메인 객체에 매핑해준것이다!
					for (var i = 0; i < list.list.length; i++) { //리스트 안에있는 list라는 이름의 map에 들어있는 것을 꺼내기 위해서 .으로 접근한다.
						availableTags.push(list.list[i].userId); //list의 크기만큼 for문을 돌린다. 그리고 그 수만큼 push 메서드를 사용해서 배열에 추가시켜준다.
					}
				}
			});
		}) //end of keyup
		$("#searchKeyword").autocomplete({
			source : availableTags
		});
	});

	//////////////////////////////////////////////////// 오토컴플리트를 위한 스크립트 끝!!!!!!!!/////////////////////////////////////////////////////////////////////////////////////
</script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>

</head>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<form name="detailForm">
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
				<h1>
					회원정보리스트
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 회원관리</a></li>
					<li class="active">회원관리조회</li>
				</ol>
			</section>
		
			<%-- Main content --%>
				<section class="content container-fluid">

					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">공지사항 목록</h3>
							</div>
							<div class="col-lg-12 text-left">
								<br />
								<!-- table 위쪽 검색 Start /////////////////////////////////////-->

								<div class="row">

									<div class="col-lg-12 text-left">
										<p class="text-primary">전체 ${resultPage.totalCount } 건수,
											현재 ${resultPage.currentPage} 페이지</p>
									</div>

									<div class="col-lg-12 text-right">
										<form class="form-inline" name="detailForm">

											<div class="form-group">
												<select class="form-control" name="searchCondition">
													<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
													<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
												</select>
											</div>

											<div class="form-group">
												<label class="sr-only" for="searchKeyword">검색어</label> 
													<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어"
													value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
											</div>

											<button type="button" class="btn btn-default">검색</button>

											<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
											<input type="hidden" id="currentPage" name="currentPage" value="" />

										</form>
									</div>

								</div>
								<!-- table 위쪽 검색 Start /////////////////////////////////////-->
							</div>
							<div class="box-body">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<th style="width: 30px">번호</th>
											<th style="width: 30px">이름</th>
											<th style="width: 30px">회원 ID</th>
											<th style="width: 50px">이메일</th>
											<th align="left">간략정보</th>
										</tr>
										<c:set var="i" value="0" />
										<c:forEach var="user" items="${list}">
											<c:set var="i" value="${ i+1 }" />
											<tr>
												<td align="center" style="width: 10px">${ i }</td>
												<td align="left" title="Click : 회원정보 확인" style="width: 10px">${user.userName}</td>
												<td align="left" style="width: 20px">${user.userId}</td>
												<td align="left"  style="width: 50px">${user.email}</td>
												<td align="left"><i class="glyphicon glyphicon-ok" id="${user.userId}"></i> 
														<input type="hidden" value="${user.userId}"></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="box-footer">
								<!-- PageNavigation Start... -->
								<jsp:include page="../common/pageNavigator_new.jsp" />
								<!-- PageNavigation End... -->
						</div>
				</section>
				<%-- / content --%>
			</div>
			<%-- /.content-wrapper --%>

			<%--main_footer.jsp--%>
			<%-- Main Footer --%>
			<%@ include file="../include/main_footer.jsp"%>

		</div>

	</form>
</body>
</html>