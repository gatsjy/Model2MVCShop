<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	//////////////////// �������� �����۽��� �̿��ؼ� �񵿱������� �����ϴ� �ڵ��� �ǽ��ϰڽ��ϴ�.////////////////////////////
	function fncmodifyCart() {
		$("form").attr("method", "POST").attr("action", "/cart/modifyCart").submit();
	}

	function fnccartPurchase() {
		$("form").attr("method", "POST").attr("action", "/cart/addPurchaseCartView").submit();
	}

	$(function() {

		$("button.btn.btn-primary").on("click", function() {
			self.location = "/product/listProduct?menu=search";
		})

		$("button.btn.btn-warning").on("click", function() {
			fncmodifyCart();
		})
		
		$("button.btn.btn-success").on("click", function() {
			fnccartPurchase();
		})

		$(".ct_list_pop td:nth-child(4)").on( "keyup", function() {
					var index = $(".ct_list_pop td:nth-child(4)").index(this);
					var cartQuantity = $($("input[name=cartQuantity]")[index]).val();
					var prodPrice = $($("input[name=prodPrice]")[index]).val();
					var prodNo = $($("input[name=prodNo]")[index]).val();
					$.ajax({
						url : "/cart/json/modifyCart/" + prodNo + "/"+ cartQuantity + "/" + prodPrice,
						method : "GET",
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(map) {
							// cartPrice �ٲٱ�
							var cartPrice = map.cart.cartPrice;
							var allSum = map.allSum;
							var sumPrice = map.sumPrice;
							var fee = map.fee;
							$($(".ct_list_pop td:nth-child(5)")[index]).html(cartPrice);
							// allSum �������ֱ�
							$("#allSum").html(allSum);
							// sumPrice �������ֱ�
							$("#sumPrice").html(sumPrice);
							// fee �������ֱ�
							$("#fee").html(fee);
						}
					})
				})
	});
</script>


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
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> ����</a></li>
						<li class="active">��ٱ���</li>
					</ol>
				</section>
				<br/>
				
				<%-- Main content --%>
				<section class="content container-fluid">

					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">��ٱ��� ���</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body table-responsive no-padding">
								<table class="table table-hover">
									<tr>
										<th class="text-center">No</th>
										<th class="text-center">��ǰ��</th>
										<th class="text-center">��ǰ����</th>
										<th class="text-center">����</th>
										<th class="text-center">���űݾ�</th>
										<th class="text-center">���</th>
									</tr>
									<c:set var="i" value="0" />
									<c:forEach var="cart" items="${list}">
										<c:set var="i" value="${i+1 }" />
										<tr class="ct_list_pop">
											<td align="center">${ i }</td>
											<td align="center">${cart.cartProd.prodName}
												<input type="hidden" id="prodName" name="prodName" value="${cart.cartProd.prodName}">
											</td>
											<td align="center">${cart.prodPrice}</td>
											<td align="center"><input type="number" align="center" style="width: 40px" id="cartQuantity" name="cartQuantity" value="${cart.cartQuantity}">
													<input type="hidden" id="prodNo" name="prodNo" value="${cart.cartProd.prodNo}">
													<input type="hidden" id="prodPrice" name="prodPrice" value="${cart.prodPrice}">
													<input type="hidden" id="cartPrice" name="cartPrice" value="${cart.cartPrice}"></td>
											<td align="center"><input type="hidden" id="cartPrice" name="cartPrice" value="${cart.cartPrice}">${cart.cartPrice}</td>
													<input type="hidden" id="cartNo" name="cartNo" value="${cart.cartNo}"></td>
											<td align="center"><a href="/cart/deleteCart?cartNo=${cart.cartNo}">����</a></td>
										</tr>
										<input type="hidden" id="modifyPrice" name="modifyPrice" value="${cart.prodPrice*cart.cartQuantity}">
									</c:forEach>
								</table>
								<!--  2��° ���̺� ���� -->
								<table class="table table-hover">
									<tr>
										<th>��ٱ��� �հ�</th>
										<th>��۷�</th>
										<th>��ü �ֹ� �ݾ�
											<input type="hidden" name="allSum" value="${map.allSum}">
										</th>
									</tr>
									<br/>
									<tr>
										<td id="sumPrice" name="sumPrice" >${map.sumPrice} </td>
										<td id="fee" name="fee">${map.fee}</td>
										<td id="allSum" name="allSum" >${map.allSum}</td>
            						</tr>
									</table>
			                        <div class="box-footer">
			                           <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> ���</button>
			              			 <div class="pull-right">
			                    		<button type="reset" class="btn btn-warning"><i class="fa fa-reply"></i> ����</button>
			                    		<button type="submit" class="btn btn-success"><i class="fa fa-save"></i> ����</button>
			                        </div>
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
