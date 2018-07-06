<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<html>

<script type="text/javascript">

	$(function() {
	
		$("button.btn.btn-primary").on("click", function() {
			self.location = "/product/listProduct?menu=search";
		});
		
		$("button.btn.btn-success").on("click", function() {
			self.location = "/purchase/listPurchase";
		});

	});
</script>

<head>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>
<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<form name="form">
		<input type="hidden" id="prodNo" name="prodNo"
			value="${product.prodNo}" />
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
					<h1>상품 상세보기</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> 상품관리</a></li>
						<li class="active">상세보기</li>
					</ol>
				</section>

				<div class="col-md-12">
					<div class="jumbotron">
						<h1>장바구니 구매 완료되었습니다!</h3>
						<br/>
						<br/>
						
						<div class="box-footer">
							<button type="button" class="btn btn-primary">
								<i class="fa fa-list"></i> 목록
							</button>
							<div class="pull-right">
								<button type="button" class="btn btn-success">
									<i class="fa fa-save"></i> 구매 확인
								</button>
							</div>

						</div>
					</div>
				</div>
			</div>
			<%--main_footer.jsp--%>
			<%-- Main Footer --%>
			<%@ include file="../include/main_footer.jsp"%>

			<%--plugin_js.jsp--%>
			<%@ include file="../include/plugin_js.jsp"%>
		</div>
</body>

</html>

