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
		
	/* 	$("button.btn.btn-success").on("click", function() {
			self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
		}); */

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
				<h1>상품 상세보기</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 상품관리</a></li>
					<li class="active">상세보기</li>
				</ol>
			</section>

			<%-- Main content --%>
			<section class="content container-fluid">

				<div class="col-lg-12">
					<form role="form">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h5 class="text-muted">
									선택하신 물품의 <strong class="text-danger">상세정보 </strong>입니다!
								</h5>
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2">
										<strong>상품번호</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.prodNo}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>상품명</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.prodName}</div>
								</div>
							</div>
							<hr />
							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>상품이미지</strong>
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
										<strong>상품상세정보</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>제조일자</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.manuDate}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>가격</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.price}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>개수</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.prodQuantity}</div>
								</div>
							</div>

							<hr />


							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>등록일자</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.regDate}</div>
								</div>
							</div>

							<hr />

							<div class="box-body">
								<div class="row">
									<div class="col-xs-4 col-md-2 ">
										<strong>평점</strong>
									</div>
									<div class="col-xs-8 col-md-4">${product.star}</div>
								</div>
							</div>

							<hr />

						</div>

						<div class="box-footer">
			                 <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> 목록</button>
			             <div class="pull-right">
			           		<c:if test="${product.prodQuantity!=0}">   
			                  <!-- <button type="button" class="btn btn-info"><i class="fa fa-cart-plus"></i> 장바구니</button> -->
			                  <button type="button" class="btn btn-success"><i class="fa fa-save"></i> 구매</button>
			                  <button type="button" class="btn btn-info" data-toggle='modal' data-target='#modifyModal'>장바구니</button>
			                </c:if>
			         	 </div>
					</form>
				</div>
			</section>

			<!-- 이제부터 구매리뷰를 뽑아내는 부분입니다. -->
			<c:set var="i" value="0" />
			<c:forEach var="product" items="${reviewlist}">
				<c:set var="i" value="${i+1 }" />
				<tr class="ct_list_pop" width="150">
					<td align="center">구매아이디 : ${product.buyerId}</td>
					<td></td>
					<td align="center"><a>구매리뷰 : ${product.review}</a></td>
					<td colspan="20" bgcolor="D6D7D6" height="1"></td>
				</tr>
			</c:forEach>
			<!-- 구매리뷰 뽑아내는 부분 마지막입니다. -->
			
			
			<%--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --%>
				<!-- 댓글작성 modal 창 start -->
			<form id=cart>	
			<input type="hidden" name="price" value="${product.price}" />
            <div class="modal fade" id="modifyModal" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">장바구니 추가</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="prodNo">상품 번호</label>
                                <input class="form-control" id="prodNo" name="prodNo" value="${product.prodNo}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="prodName">상품명</label>
                                <input class="form-control" id="prodName" name="prodName" value="${product.prodName}" readonly >
                            </div>
                            <div class="form-group">
                                <label for="cartQuantity">수량</label>
                                남은수량(<span id="restQuantity" value="">${product.prodQuantity}</span>)<input	type="hidden" name="productQuantity" value="${product.prodQuantity}">	
                                <input type="text" class="form-control" name="cartQuantity"  id="quantity" class="quantity" value=""/>
                            </div>
                            <div class="form-group">
                                <label for="buyerId">구매자아이디</label>
                                <input class="form-control" id="buyerId" name="buyerId" value="${sessionScope.user.userId}" readonly >
								<input type="hidden" name="prodNo" value="${product.prodNo}" />
								<input type="hidden" name="price" value="${product.price}" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
                            <button type="button" class="btn btn-success modalModBtn">구매</button>
                            <button type="button" class="btn btn-danger modalDelBtn">삭제</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 댓글 작성 modal 창 end -->
            </form>	
			
			
			
			
			
			
			
			
			
			
			
			
			</form>
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

