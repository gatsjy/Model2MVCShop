<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	//////////////////// 이제부터 아이작스를 이용해서 비동기적으로 수정하는 코딩을 실시하겠습니다.////////////////////////////
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
							// cartPrice 바꾸기
							var cartPrice = map.cart.cartPrice;
							var allSum = map.allSum;
							var sumPrice = map.sumPrice;
							var fee = map.fee;
							$($(".ct_list_pop td:nth-child(5)")[index]).html(cartPrice);
							// allSum 갱신해주기
							$("#allSum").html(allSum);
							// sumPrice 갱신해주기
							$("#sumPrice").html(sumPrice);
							// fee 갱신해주기
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
						<li><a href="#"><i class="fa fa-dashboard"></i> 구매</a></li>
						<li class="active">장바구니</li>
					</ol>
				</section>
				<br/>
				
				<%-- Main content --%>
				<section class="content container-fluid">

					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">장바구니 목록</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body table-responsive no-padding">
								<table class="table table-hover">
									<tr>
										<th class="text-center">No</th>
										<th class="text-center">상품명</th>
										<th class="text-center">물품가격</th>
										<th class="text-center">수량</th>
										<th class="text-center">구매금액</th>
										<th class="text-center">비고</th>
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
											<td align="center"><a href="/cart/deleteCart?cartNo=${cart.cartNo}">삭제</a></td>
										</tr>
										<input type="hidden" id="modifyPrice" name="modifyPrice" value="${cart.prodPrice*cart.cartQuantity}">
									</c:forEach>
								</table>
								<!--  2번째 테이블 등장 -->
								<table class="table table-hover">
									<tr>
										<th>장바구니 합계</th>
										<th>배송료</th>
										<th>전체 주문 금액
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
			                           <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> 목록</button>
			              			 <div class="pull-right">
			                    		<button type="reset" class="btn btn-warning"><i class="fa fa-reply"></i> 수정</button>
			                    		<button type="submit" class="btn btn-success"><i class="fa fa-save"></i> 구매</button>
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
