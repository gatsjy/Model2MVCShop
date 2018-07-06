<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<html>

<script type="text/javascript">
function fncUpdateProduct() {

	$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
}

 $(function() {
		 
		 $( "button.btn.btn-success" ).on("click" , function() {

				fncUpdateProduct();
			});
		 
		 $( "button.btn.btn-warning" ).on("click" , function() {

			 history.go(-1)
		});
		 
		
	});	
 
</script>

<head>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>
<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<form name="form"> 
	<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}" /> 
	 <input type="hidden" name="manuDate" value="${product.manuDate}">
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
				<h1>상품 수정</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 상품관리</a></li>
					<li class="active">수정</li>
				</ol>
			</section>

			<%-- Main content --%>
			<section class="content container-fluid">

				<div class="col-lg-12">
					<form role="form">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h5 class="text-muted">
									선택하신 물품의 <strong class="text-danger">수정하는 란 </strong>입니다!
								</h5>
							</div>
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>상품명</strong>
									</div>
									 <input type="text" class="col-xs-8 col-md-4" placeholder="상품명" name="prodName" value="${product.prodName}">
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>상품상세정보</strong>
									</div>
									 <input type="text" class="col-xs-8 col-md-4" placeholder="상품상세정보" name="prodDetail" value="${product.prodDetail}">
								</div>
							</div>
							
							<hr />
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>가격</strong>
									</div>
									 <input type="text" class="col-xs-8 col-md-4" placeholder="가격" name="price" value="${product.price}" >
								</div>
							</div>

							<hr />
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>상품이미지</strong>
									</div>
									<input type="text" name="fileName" class="col-xs-8 col-md-4" style="width: 200px; height: 19px"
											maxLength="13" value="${product.fileName}" />
								</div>
							</div>

							<hr />
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>상품수량</strong>
									</div>
									 <input type="text" class="col-xs-8 col-md-4" placeholder="상품상세정보" name="prodQuantity" value="${product.prodQuantity}" >
								</div>
							</div>
							
							<hr />

						</div>
						</form>
						<div class="box-footer">
			                 <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> 목록</button>
			             <div class="pull-right">
			           		<c:if test="${product.proTranCode==null|| product.proTranCode=='0' || product.proTranCode=='1' }">  
			                  <button type="button" class="btn btn-success"><i class="fa fa-save"></i> 수정</button>
			                </c:if>
			                 <button type="button" class="btn btn-warning"><i class="fa fa-save"></i> 취소</button>
			         	 </div>
					</form>
				</div>
			</section>
			</div>
			
		<%--main_footer.jsp--%>
		<%-- Main Footer --%>
		<%@ include file="../include/main_footer.jsp"%>

		<%--plugin_js.jsp--%>
		<%@ include file="../include/plugin_js.jsp"%>
	</div>
</body>

</html>

