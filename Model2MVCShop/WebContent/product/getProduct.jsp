<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<html>

<script type="text/javascript">
var prodNo = ${product.prodNo};

	$(function() {
		$("button.btn.btn-success.modalModBtn").on("click", function() {
			$("#cart").attr("method","POST").attr("action" , "/cart/addCart").submit();
		});
		
		$("button.btn.btn-primary").on("click", function() {
			history.go(-1);
		});
		
		$("button.btn.btn-danger").on("click", function() {
			self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
		});

/* 		$("button.btn.btn-info").on("click", function() {
			self.location = "/cart/addCart?prodNo=${product.prodNo}";
		}); */

	});
</script>

<head>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>
<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<form name="form"> 
	<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}" /> 
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
				<h1>��ǰ �󼼺���</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> ��ǰ����</a></li>
					<li class="active">�󼼺���</li>
				</ol>
			</section>

			<%-- Main content --%>
			<section class="content container-fluid">

				<div class="col-lg-12">
					<form role="form">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h5 class="text-muted">
									�����Ͻ� ��ǰ�� <strong class="text-danger">������ </strong>�Դϴ�!
								</h5>
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>��ǰ��ȣ</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.prodNo}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>��ǰ��</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.prodName}</div>
								</div>
							</div>
							<hr />
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>��ǰ�̹���</strong>
									</div>
									<div class="col-xs-8 col-md-4">
										<img src="/images/uploadFiles/${product.fileName}" width="300" height="300" />
									</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>��ǰ������</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>��������</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.manuDate}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>����</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.price}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>����</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.prodQuantity}</div>
								</div>
							</div>

							<hr />


							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>�������</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.regDate}</div>
								</div>
							</div>

							<hr />
					
						</div>
						
					<!-- �������� ���Ÿ��並 �̾Ƴ��� �κ��Դϴ�. -->
					<div class="box box-primary">
							<div class="box-header with-border">
								<h5 class="text-muted">
									�����Ͻ� ��ǰ�� <strong class="text-danger">���� </strong>�Դϴ�!
								</h5>
							</div>
							<div class="box-body">
							<c:set var="i" value="0" />
								<c:forEach var="product" items="${reviewlist}">
								<c:set var="i" value="${i+1 }" />
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>���ž��̵�</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.buyerId}</div>
									<br/>
								<div class="col-xs-4 col-md-2">
										<strong>���Ÿ���</strong>
									</div>
									<div class="col-xs-8 col-md-4"> ${product.review}</div>
								</tr>
								</c:forEach>
								</div>
							</div> 
						
					<!-- ���Ÿ��� �̾Ƴ��� �κ� �������Դϴ�. -->
					
						<div class="box-footer">
			                 <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> ���</button>
			             <div class="pull-right">
			           		<c:if test="${product.prodQuantity!=0}">   
			                  <button type="button" class="btn btn-danger"><i class="fa fa-save"></i> ����</button>
			                  <button type="button" class="btn btn-info" data-toggle='modal' data-target='#modifyModal'>��ٱ���</button>
			                </c:if>
			         	 </div>
					</form>
				</div>
			</section>


			
			
			<%--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --%>
				<!-- ����ۼ� modal â start -->
			<form id=cart>	
			<input type="hidden" name="price" value="${product.price}" />
            <div class="modal fade" id="modifyModal" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">��ٱ��� �߰�</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="prodNo">��ǰ ��ȣ</label>
                                <input class="form-control" id="prodNo" name="prodNo" value="${product.prodNo}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="prodName">��ǰ��</label>
                                <input class="form-control" id="prodName" name="prodName" value="${product.prodName}" readonly >
                            </div>
                            <div class="form-group">
                                <label for="cartQuantity">����</label>
                                ��������(<span id="restQuantity" value="">${product.prodQuantity}</span>)<input	type="hidden" name="productQuantity" value="${product.prodQuantity}">	
                                <input type="text" class="form-control" name="cartQuantity"  id="quantity" class="quantity" value=""/>
                            </div>
                            <div class="form-group">
                                <label for="buyerId">�����ھ��̵�</label>
                                <input class="form-control" id="buyerId" name="buyerId" value="${sessionScope.user.userId}" readonly >
								<input type="hidden" name="prodNo" value="${product.prodNo}" />
								<input type="hidden" name="price" value="${product.price}" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">�ݱ�</button>
                            <button type="button" class="btn btn-success modalModBtn" id="abc">����</button>
                            <button type="button" class="btn btn-danger modalDelBtn">����</button>
                        </div>
                    </div>
                </div>
                </div>
                </form>
                </div>

		<%--plugin_js.jsp--%>
		<%@ include file="../include/plugin_js.jsp"%>
	</div>
</body>

</html>

