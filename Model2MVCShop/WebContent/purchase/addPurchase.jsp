<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>
<body class="hold-transition skin-blue sidebar-mini layout-boxed">
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
				<h1>구매 이후 페이지입니다.</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 판매관리</a></li>
					<li class="active">상세보기</li>
				</ol>
			</section>

			<%-- Main content --%>
			<section class="content container-fluid">

				<div class="col-lg-12">
					<form role="form" id="writeForm" method="post"
						action="/notice/addNotice">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h5 class="text-muted">
									구매하신 물품의 <strong class="text-danger">상세정보 </strong>입니다!
								</h5>
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>상품번호</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>상품명</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodName}</div>
								</div>
							</div>
							<hr />
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>구매자아이디</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.buyer.userId}
									</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>구매방법</strong>
									</div>
									<div class="col-xs-8 col-md-4">
									<c:if test="${purchase.paymentOption=='1'}">
										현금구매
									</c:if>
									<c:if test="${purchase.paymentOption=='2' }">
										신용구매
									</c:if> 
									</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>구매자이름</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>구매수량</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.purchaseQuantity}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>구매액</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.purchasePrice}</div>
								</div>
							</div>

							<hr />


							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>구매자연락처</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>구매자주소</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
								</div>
							</div>

							<hr />
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>구매요청사항</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
								</div>
							</div>

							<hr />
							
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>배송희망일자</strong>
									</div>
									<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
								</div>
							</div>

							<hr />

						</div>

						<div class="box-footer">
							<button type="button" class="btn btn-primary">
								<i class="fa fa-list"></i> 목록
							</button>
						</div>
					</form>
				</div>
			</section>

					</td>
				</tr>
			</table>
		</div>
		<%--main_footer.jsp--%>
		<%-- Main Footer --%>
		<%@ include file="../include/main_footer.jsp"%>

		<%--plugin_js.jsp--%>
		<%@ include file="../include/plugin_js.jsp"%>
	</div>
</body>
</html>

