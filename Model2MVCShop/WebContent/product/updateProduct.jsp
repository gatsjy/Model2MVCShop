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
				<h1>��ǰ ����</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> ��ǰ����</a></li>
					<li class="active">����</li>
				</ol>
			</section>

			<%-- Main content --%>
			<section class="content container-fluid">

				<div class="col-lg-12">
					<form role="form">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h5 class="text-muted">
									�����Ͻ� ��ǰ�� <strong class="text-danger">�����ϴ� �� </strong>�Դϴ�!
								</h5>
							</div>
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>��ǰ��</strong>
									</div>
									 <input type="text" class="col-xs-8 col-md-4" placeholder="��ǰ��" name="prodName" value="${product.prodName}">
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>��ǰ������</strong>
									</div>
									 <input type="text" class="col-xs-8 col-md-4" placeholder="��ǰ������" name="prodDetail" value="${product.prodDetail}">
								</div>
							</div>
							
							<hr />
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>����</strong>
									</div>
									 <input type="text" class="col-xs-8 col-md-4" placeholder="����" name="price" value="${product.price}" >
								</div>
							</div>

							<hr />
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>��ǰ�̹���</strong>
									</div>
									<input type="text" name="fileName" class="col-xs-8 col-md-4" style="width: 200px; height: 19px"
											maxLength="13" value="${product.fileName}" />
								</div>
							</div>

							<hr />
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>��ǰ����</strong>
									</div>
									 <input type="text" class="col-xs-8 col-md-4" placeholder="��ǰ������" name="prodQuantity" value="${product.prodQuantity}" >
								</div>
							</div>
							
							<hr />

						</div>
						</form>
						<div class="box-footer">
			                 <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> ���</button>
			             <div class="pull-right">
			           		<c:if test="${product.proTranCode==null|| product.proTranCode=='0' || product.proTranCode=='1' }">  
			                  <button type="button" class="btn btn-success"><i class="fa fa-save"></i> ����</button>
			                </c:if>
			                 <button type="button" class="btn btn-warning"><i class="fa fa-save"></i> ���</button>
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

