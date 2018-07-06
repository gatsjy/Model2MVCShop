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

		$(".ct_list_pop td:nth-child(7):contains('배송하기')").css("color", "red");

		var tranNo = $("input[name='tranNo']").val();
		$(".ct_list_pop td:nth-child(7):contains('배송하기')").on("click", function() {
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
						판매관리 <small>목록페이지</small>
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> 판매</a></li>
						<li class="active">판매목록</li>
					</ol>
				</section>

				<%-- Main content --%>
				<section class="content container-fluid">

					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">게시글 목록</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body table-responsive no-padding">
								<table class="table table-hover">
									<tr>
										<th class="text-center">No</th>
										<th class="text-center">상품번호</th>
										<th class="text-center">거래번호</th>
										<th class="text-center">상품명</th>
										<th class="text-center">구매액</th>
										<th class="text-center">구매물량/남은물량</th>
										<th class="text-center">배송</th>
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
      														배송하기
	    										 </c:if> <c:if test="${purchase.tranCode=='2' }">
													<a>배송중</a>
												</c:if> <c:if test="${purchase.tranCode=='3' }">
													<a>배송완료!</a>
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
