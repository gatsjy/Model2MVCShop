<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	$(function() {

		$(".ct_list_pop td:nth-child(3)").on("click", function() {
					self.location = "/purchase/getPurchase?tranNo="+ $(this).text().trim();
		})

		$(".ct_list_pop td:nth-child(3)").css("color", "red");

		$(".ct_list_pop td:nth-child(7):contains('����ϱ�')").css("color", "red");

		var tranNo = $("input[name='tranNo']").val();
		$(".ct_list_pop td:nth-child(7):contains('����ϱ�')").on("click", function() {
					self.location = "/purchase/updateTranCodeByTranNo?tranNo="+ tranNo + "&tranCode=2";
		})

	});
</script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>

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
						�ǸŰ��� <small>���������</small>
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> �Ǹ�</a></li>
						<li class="active">�ǸŸ��</li>
					</ol>
				</section>

				<%-- Main content --%>
				<section class="content container-fluid">

					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">�Խñ� ���</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body table-responsive no-padding">
								<table class="table table-hover">
									<tr>
										<th class="text-center">No</th>
										<th class="text-center">��ǰ��ȣ</th>
										<th class="text-center">�ŷ���ȣ</th>
										<th class="text-center">��ǰ��</th>
										<th class="text-center">���ž�</th>
										<th class="text-center">���Ź���/��������</th>
										<th class="text-center">���</th>
									</tr>
									<c:set var="i" value="0" />
									<c:forEach var="purchase" items="${list}">
										<c:set var="i" value="${i+1 }" />
										<tr class="ct_list_pop">
											<td align="center">${ i }</td>
											<td align="center">${purchase.purchaseProd.prodNo}</td>
											<td align="center">${purchase.tranNo}</td>
											<td align="center">${purchase.purchaseProd.prodName}</td>
											<td align="center">${purchase.purchasePrice}</td>
											<td align="center">${purchase.purchaseQuantity}/${purchase.purchaseProd.prodQuantity }</td>
											<td align="center">
												<c:if test="${purchase.tranCode=='1' }">
													<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}" /> 
      														����ϱ�
	    										 </c:if> <c:if test="${purchase.tranCode=='2' }">
													<a>�����</a>
												</c:if> <c:if test="${purchase.tranCode=='3' }">
													<a>��ۿϷ�!</a>
												</c:if></td>
										</tr>
									</c:forEach>
								</table>
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
