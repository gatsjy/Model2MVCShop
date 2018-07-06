<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase?userId=${purchase.buyer.userId }" ).submit();
	}
	
 	function fncUpdateReview(tranNo){
	 	popWin = window.open("/purchase/updatePurchaseReview?tranNo="+tranNo,"popWin","left=300, top=200, width=700, height=500, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	} 
	
	$(function() {
		 $( "td.ct_btn01:contains('���')" ).on("click" , function() {
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
										<th class="text-center">�ŷ���ȣ</th>
										<th class="text-center">��ǰ��ȣ</th>
										<th class="text-center">��ǰ�̸�</th>
										<th class="text-center">�������̸�</th>
										<th class="text-center">��������ȭ��ȣ</th>
										<th class="text-center">�����Ȳ</th>
										<th class="text-center">��������</th>
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
												<a>���ſϷ�</a>
												</c:if>
												<c:if test="${purchase.tranCode=='2'}">
												<a>�����</a>
												</c:if>
												<c:if test="${purchase.tranCode=='3'}">
												<a>��ۿϷ�</a>
												<c:if test="${purchase.star=='0' && purchase.review==null}"> 
												<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}" />
													<button type="button" class="btn btn-info" data-toggle='modal' data-target='#modifyModal'>�����ֱ�</button>
												</c:if> 
												</c:if>
											</td>
											<td align="center">
											<c:if test="${purchase.tranCode=='2'}">
												<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}" />
												���ǵ���
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
				<!-- �����ֱ� modal â start -->
		<%-- 	<form id="star">	
		<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}" />
		<input type="hidden" name="buyerId" value="${sessionScope.user.userId}" />
		    <div class="modal fade" id="modifyModal" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">���� ��� �� ��ǰ�ı�</h4>
                        </div>
                        <div class="modal-body">
                             <div class="form-group">
                                <label for="prodNo">�ֹ� ��ȣ</label>
                               <td width="105" name="tranNo"  value="${purchase.tranNo}">${tranNo}</td>
                            </div>
                            <div class="form-group">
                                <label for="prodName">��ǰ��</label>
                                <td>${purchase.purchaseProd.prodName}</td>
                            </div>
                            <div class="form-group">
                                <label for="buyerId">�����ھ��̵�</label>
                                <td class="ct_write01">${sessionScope.user.userId}</td>
                               	<input type="hidden" name="buyerId" value="${sessionScope.user.userId}" />
                            </div> 
                             <div class="form-group">
                                <label for="star">����</label>
                                <td class="ct_write01">
								<select name="star"  class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" >
									<option value=1>�ڡ١١١�</option>
									<option value=2>�ڡڡ١١�</option>
									<option value=3>�ڡڡڡ١�</option>
									<option value=4>�ڡڡڡڡ�</option>
									<option value=5 selected="selected">�ڡڡڡڡ�</option>
								</select>	
							</td>
                            </div>
                            
                            <div class="form-group">
                                <label for="prodNo">�����ı�</label>
                                <input class="form-control" id="review" name="review" >
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">�ݱ�</button>
                            <button type="button" class="btn btn-success modalModBtn">���</button>
                            <button type="button" class="btn btn-danger modalDelBtn">����</button>
                        </div>
                    </div>
                </div>
            </div> --%>
            <!-- ��� �ۼ� modal â end -->
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
