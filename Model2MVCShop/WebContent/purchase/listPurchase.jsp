<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase?userId=${purchase.buyer.userId }" ).submit();
	}
	
 	function fncUpdateReview(tranNo){
	 	popWin = window.open("/purchase/updatePurchaseReview?tranNo="+tranNo,"popWin","left=300, top=200, width=700, height=500, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	} 
	
	$(function() {
		 $( "td.ct_btn01:contains('등록')" ).on("click" , function() {
			 fnclistCancelPurchase();
		})
		
		 $( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
			 self.location ="/purchase/getPurchase?tranNo="+$(this).text().trim();
		})
		
		$( ".ct_list_pop td:nth-child(1)" ).css("color", "red")	
		
		var tranNo = $("input[name='tranNo']").val();
		
		$( ".ct_list_pop td:nth-child(6)" ).on("click" , function() {
			fncUpdateReview(tranNo);
		})
		
		 $( ".ct_list_pop td:nth-child(7)" ).on("click" , function() {
			 var tranNo = $("input[name='tranNo']").val();
			 self.location =  "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3";
		})
		
		$( ".ct_list_pop td:nth-child(7)" ).css("color","red")
		
		$("button.btn.btn-success.modalModBtn").on("click", function() {
			$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchaseReview?tranNo=${purchase.tranNo}" ).submit();
		});
		
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
										<th class="text-center">거래번호</th>
										<th class="text-center">상품번호</th>
										<th class="text-center">상품이름</th>
										<th class="text-center">수취인이름</th>
										<th class="text-center">수취인전화번호</th>
										<th class="text-center">배송현황</th>
										<th class="text-center">정보수정</th>
									</tr>
									<c:set var="i" value="0" />
									<c:forEach var="purchase" items="${list}">
										<c:set var="i" value="${i+1 }" />
										<tr class="ct_list_pop">
											<td align="center">${purchase.tranNo}</td>
											<td align="center">${purchase.purchaseProd.prodNo}</td>
											<td align="center">${purchase.purchaseProd.prodName}</td>
											<td align="center">${purchase.receiverName}</td>
											<td align="center">${purchase.receiverPhone}</td>
											<td align="center">
												<c:if test="${purchase.tranCode=='1'}">
												<a>구매완료</a>
												</c:if>
												<c:if test="${purchase.tranCode=='2'}">
												<a>배송중</a>
												</c:if>
												<c:if test="${purchase.tranCode=='3'}">
												<a>배송완료</a>
												<c:if test="${purchase.star=='0' && purchase.review==null}"> 
												<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}" />
													<button type="button" class="btn btn-info" data-toggle='modal' data-target='#modifyModal'>별점주기</button>
												</c:if> 
												</c:if>
											</td>
											<td align="center">
											<c:if test="${purchase.tranCode=='2'}">
												<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}" />
												물건도착
												</c:if>	
											</td>
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
				
				
				<%--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --%>
				<!-- 별점주기 modal 창 start -->
		<%-- 	<form id="star">	
		<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}" />
		<input type="hidden" name="buyerId" value="${sessionScope.user.userId}" />
		    <div class="modal fade" id="modifyModal" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">별점 등록 및 물품후기</h4>
                        </div>
                        <div class="modal-body">
                             <div class="form-group">
                                <label for="prodNo">주문 번호</label>
                               <td width="105" name="tranNo"  value="${purchase.tranNo}">${tranNo}</td>
                            </div>
                            <div class="form-group">
                                <label for="prodName">상품명</label>
                                <td>${purchase.purchaseProd.prodName}</td>
                            </div>
                            <div class="form-group">
                                <label for="buyerId">구매자아이디</label>
                                <td class="ct_write01">${sessionScope.user.userId}</td>
                               	<input type="hidden" name="buyerId" value="${sessionScope.user.userId}" />
                            </div> 
                             <div class="form-group">
                                <label for="star">별점</label>
                                <td class="ct_write01">
								<select name="star"  class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" >
									<option value=1>★☆☆☆☆</option>
									<option value=2>★★☆☆☆</option>
									<option value=3>★★★☆☆</option>
									<option value=4>★★★★☆</option>
									<option value=5 selected="selected">★★★★★</option>
								</select>	
							</td>
                            </div>
                            
                            <div class="form-group">
                                <label for="prodNo">한줄후기</label>
                                <input class="form-control" id="review" name="review" >
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
                            <button type="button" class="btn btn-success modalModBtn">등록</button>
                            <button type="button" class="btn btn-danger modalDelBtn">삭제</button>
                        </div>
                    </div>
                </div>
            </div> --%>
            <!-- 댓글 작성 modal 창 end -->
            </form>	
				
				
				
				
				
				
				
				
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
