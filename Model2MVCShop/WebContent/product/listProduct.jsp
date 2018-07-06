<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<style> 
	.table.table-hover td { vertical-align: middle; }
</style>


<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	 $(function() {
			var productNo = $( ".ct_list_pop td:nth-child(3)")
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
			 
		var search = '${param.menu}';
		var searchSorting = "0";
			if( search=="search" ){
			 	$( ".ct_list_pop td:nth-child(2)").on("click", function() {
					 self.location = "/product/getProduct?prodNo="+$(this).text().trim();
			 	})
			 }else{
				 $( ".ct_list_pop td:nth-child(2)").on("click", function() {
					 self.location = "/product/updateProduct?prodNo="+$(this).text().trim();
				 })
			 }; 
	 
			 $( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
				$("h7").css("color" , "red")
			
			 $( ".ct_list_pop td:nth-child(15)").on("click", function() {
					 self.location = "/product/listProduct?menu=search&searchSorting=1";
				})	
				
			$( ".ct_list_pop td:nth-child(15)").css("color", "red");		
				
			$( ".starview th:nth-child(8)").css("color", "red");		
				
			});	
	
	 //////////////////////////////////////// 상품 이름별로 에이잭스로 출력해주는 자바스크립트/////////////////////	
	$( function() {
		$( "#searchKeyword" ).on("keyup" , function() {
			$.ajax({
				url:"/product/json/listProduct",
				type:"POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				dataType:"json",
				data : {
					searchCondition : $("#searchCondition").val(),
					searchKeyword :  $("#searchKeyword").val(),
					searchSorting : '0'
				},
					success : function(list, status){
						fncGetList(1);
					}
		});
	}) //end of keyup
	});
	
</script>

<c:if test="${param.menu=='search' }">
<%--head.jsp--%>
<%@ include file="/include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<form name="form">
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
						상품관리 <small>목록페이지</small>
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> 상품</a></li>
						<li class="active">상품검색</li>
					</ol>
				</section>

				<%-- Main content --%>
				<section class="content container-fluid">	
					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">상품검색</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body table-responsive no-padding">
							
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
					style="margin-top: 10px;">
					<tr>
						<td align="right">
						<select name="searchCondition" id="searchCondition"  class="ct_input_g" style="width: 80px">
								<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
								<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
								<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
						</select> 
						<input type="text" id ="searchKeyword" name="searchKeyword" value="${search.searchKeyword }" class="ct_input_g" style="width: 200px; height: 20px" />
						</td>
						<td align="right" width="70">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<button type="button" class="btn btn-default">검색</button>
								</tr>
							</table>
						</td>
					</tr>
				</table>
								<table class="table table-hover" >
									<tr class="starview">
										<th class="text-center">No</th>
										<th class="text-center">상품번호</th>
										<th class="text-center">상품이미지</th>
										<th class="text-center">상품명</th>
										<th class="text-center">가격</th>
										<th class="text-center">현재상태</th>
										<th class="text-center">수량</th>
										<th class="text-center">
											<a href="/product/listProduct?menu=search&searchSorting=1">평점(별점순나열)</a>
										</th>
									</tr>
									<c:set var="i" value="0" />
									<c:forEach var="product" items="${list}">
										<c:set var="i" value="${i+1 }" />
										<tr class="ct_list_pop">
											<td align="center" valign="middle">${ i }</td>
											<td align="center">${product.prodNo}</td>
											<td align="center"><img src="/images/uploadFiles/${product.fileName}" width="200" height="100" /></td>
											<td align="center">${product.prodName}</td>
											<td align="center">${product.price}</td>
											<td align="center">
												<c:if test="${product.prodQuantity==0}">
													<a>재고없음</a>
												</c:if> 
												<c:if test="${product.prodQuantity!=0}">
													<a>판매중</a>
												</c:if> 
										   </td>
										   <td align="center">${product.prodQuantity}</td>	
										   <td align="center">${product.star}</td>
										</tr>
									</c:forEach>
								</table>
						
							<!-- PageNavigation Start... -->
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									style="margin-top: 10px;">
									<tr>
										<td align="center">
											<input type="hidden" id="currentPage" name="currentPage" value="" /> 
											<jsp:include page="../common/pageNavigator_new.jsp" />
										</td>
									</tr>
								</table>
						<!-- PageNavigation End... -->
		
							</div>
							<div class="box-footer">
				</section>
				<%-- /.content --%>
			</div>
			<%-- /.content-wrapper --%>

			<%--main_footer.jsp--%>
			<%-- Main Footer --%>
			<%@ include file="../include/main_footer.jsp"%>

		</div>
		<%-- ./wrapper --%>

		<%--plugin_js.jsp--%>
		<%@ include file="../include/plugin_js.jsp"%>
	</form>
</body>
</html>
</c:if>

<!--  여기부터 manage 부분입니다!!!!!!!!!!!!!!!!!!!!!!! -->
<c:if test="${param.menu=='manage' }">
<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<form name="form">
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
						상품관리 <small>목록페이지</small>
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> 상품</a></li>
						<li class="active">상품관리</li>
					</ol>
				</section>

				<%-- Main content --%>
				<section class="content container-fluid">	
					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">상품관리</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body table-responsive no-padding">			
							<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					<tr>
						<td align="right">
						<select name="searchCondition" id="searchCondition"  class="ct_input_g" style="width: 80px">
								<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
								<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
								<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
						</select> 
						<input type="text" id ="searchKeyword" name="searchKeyword" value="${search.searchKeyword }" class="ct_input_g" style="width: 200px; height: 20px" />
						</td>
						<td align="right" width="70">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
									<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
										검색
									</td>
									<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
								<table class="table table-hover">
									<tr>
										<th class="text-center">No</th>
										<th class="text-center">상품가격</th>
										<th class="text-center">가격</th>
										<th class="text-center">등록일</th>
										<th class="text-center">현재상태</th>
										<th class="text-center">남은물량</th>
									</tr>
									<c:set var="i" value="0" />
									<c:forEach var="product" items="${list}">
										<c:set var="i" value="${i+1 }" />
										<tr class="ct_list_pop">
											<td align="center">${ i }</td>
											<td align="center">
												<c:if test="${product.proTranCode==null || product.proTranCode=='0' || product.proTranCode=='1' || product.proTranCode=='2'}">
													${product.prodNo}
												</c:if> 
												 <c:if test="${product.proTranCode=='3' }">
													<a>${product.prodName}</a>
												</c:if> 
											</td>
											<td align="center">${product.price}</td>
											<td align="center">${product.regDate}</td>
											<td align="center">
												<c:if test="${product.prodQuantity > 0}">
												<a>판매중</a>
												</c:if>
												<c:if test="${product.prodQuantity <= 0}">
												<a>재고관리요망!</a>
												</c:if>
											</td align="center">
											<td align="center">${product.prodQuantity }</td>
										</tr>
									</c:forEach>
								</table>
						
							<!-- PageNavigation Start... -->
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									style="margin-top: 10px;">
									<tr>
										<td align="center">
											<input type="hidden" id="currentPage" name="currentPage" value="" /> 
											<jsp:include page="../common/pageNavigator_new.jsp" />
										</td>
									</tr>
								</table>
						<!-- PageNavigation End... -->
		
							</div>
							<div class="box-footer">
				</section>
				<%-- /.content --%>
			</div>
			<%-- /.content-wrapper --%>

			<%--main_footer.jsp--%>
			<%-- Main Footer --%>
			<%@ include file="../include/main_footer.jsp"%>

		</div>
		<%-- ./wrapper --%>

		<%--plugin_js.jsp--%>
		<%@ include file="../include/plugin_js.jsp"%>
	</form>
</body>
</html>
</c:if>
