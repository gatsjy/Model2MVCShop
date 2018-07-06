<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		 $( "td.ct_btn01:contains('���')" ).on("click" , function() {
			 fnclistCancelPurchase();
		})
		
		 $( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
			 self.location ="/purchase/getPurchase?tranNo="+$(this).text().trim();
			})
		$( ".ct_list_pop td:nth-child(1)" ).css("color", "red")
	});
	
		// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/purchase/listCancelPurchase.do?userId=${purchase.buyer.userId }").submit();
		}
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
						<li class="active">��� ���</li>
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
										<th class="text-center">�ŷ���ȣ</th>
										<th class="text-center">��ǰ��ȣ</th>
										<th class="text-center">��ǰ�̸�</th>
										<th class="text-center">��ҷ�</th>
										<th class="text-center">��ұݾ�</th>
									</tr>
									<c:set var="i" value="0" />
									<c:forEach var="purchase" items="${list}">
										<c:set var="i" value="${i+1 }" />
										<tr class="ct_list_pop">
											<td align="center">${purchase.tranNo}</td>
											<td align="center">${purchase.purchaseProd.prodNo}</td>
											<td align="center">${purchase.purchaseProd.prodName}</td>
											<td align="center">${purchase.purchaseQuantity}</td>
											<td align="center">${purchase.purchasePrice}��</td>
										</tr>
									</c:forEach>
								</table>
								
								<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
								<tr>
									<td align="center">
									   <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
										
										<jsp:include page="../common/pageNavigator.jsp"/>	
										
							    	</td>
								</tr>
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
