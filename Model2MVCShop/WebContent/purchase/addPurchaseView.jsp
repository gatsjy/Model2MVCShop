<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html>

<%@ include file="../include/plugin_js.jsp"%>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="../javascript/calendar.js"></script>
<script type="text/javascript">



function fncAddPurchase() {
	
	var divyAddr=$("input[name='divyAddr']").val();
	var purchaseQuantity=$("input[name='purchaseQuantity']").val();
	var divyDate = $("input[name='divyDate']").val();
	
	if(divyAddr == null || divyAddr.length <1 ){
		alert("�ּҴ� �ݵ�� �Է��ؾ��մϴ�!");
		return;
	}
	
	if(purchaseQuantity == null || purchaseQuantity <1 ){
		alert("������ �ݵ�� �Է��ؾ��մϴ�!");
		return;
	}

	if(divyDate == null || divyDate.length <1 ){
		alert("��۳�¥�� �ݵ�� �Է��ؾ� �մϴ�!");
		return;
	}
	
	$("form").attr("method","POST").attr("action" , "/purchase/addPurchase").submit();
	}

	$(function() {
		 $( "button.btn.btn-success" ).on("click" , function() {
			 fncAddPurchase();
		 });
	
		 $( "button.btn.btn-warning" ).on("click" , function() {
			history.go(-1);
		});
		 
		 $( "button.btn.btn-primary" ).on("click" , function() {
			 self.location ="/product/listProduct?menu=search";
		});
		 
		 $("#purchasePrice").css("color", "red");
		 
		 $("#restQuantity").css("color", "red");
		 
		 var prodNo = $("input[name='prodNo']").val();
		 
		 $("#quantity").css("color", "red");
		 
		 $("#quantity").on("keyup", function() {
			 var ea = $("#quantity").val();
			 
			 //getProduct�� �ϴ� Ajax�� ����´�.
			 $.ajax(
					{
						url : "/product/json/getProduct/"+prodNo,
						method : "GET" ,
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(product, status) {
						var displayValue = product.price * ea;
						$( "#purchasePrice").val(displayValue);
						var restQuantity = product.prodQuantity-ea;
						$( "#restQuantity").html(restQuantity);
						}
					})
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
						�ǸŰ��� <small>�ǸŸ��</small>
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> �Ǹ�</a></li>
						<li class="active">���Ȯ��</li>
					</ol>
				</section>
	
	            <div class="box-body">
	            
	            <div class="input-group" >
	            	<input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="��ǰ��ȣ" value="${product.prodNo}" >
	                <input type="hidden" name="prodNo" value="${product.prodNo}" />
	                <input type="hidden" name="lat" value="${sessionScope.user.lat}" />
	                <input type="hidden" name="lng" value="${sessionScope.user.lng}" />
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	              	<input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="��ǰ��" value="${product.prodName}" >
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	               <div class="input-group">
	              	<input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="��������" value="${product.manuDate}" >
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="��ǰ������" value="${product.prodDetail}" >
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	               <div class="input-group">
	             	 <input type="text" class="form-control" class="form-control"  placeholder="����" name="purchaseQuantity"  id="quantity" class="quantity">
	             	 <input	type="hidden" name="productQuantity" value="${product.prodQuantity}">
	                <span class="input-group-addon">
	                	��������(<span id="restQuantity" value="">${product.prodQuantity}</span>)
	               </span>
	              </div>
	              <br>
	              
	                <div class="input-group">
	             	 <input type="text" class="form-control"  placeholder="����" id="purchasePrice" value="" readonly="readonly">
	             	 <input	type="hidden" name="price" value="${product.price}">
	                <span class="input-group-addon"><i class="fa fa-won"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	              	<input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="�����ھ��̵�" value="${sessionScope.user.userId}" >
	              	<input type="hidden" name="buyerId" value="${sessionScope.user.userId}" />
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <select 	name="paymentOption" class="form-control" >
						<option value="1" selected="selected">���ݱ���</option>
						<option value="2">�ſ뱸��</option>
					</select>
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	               <div class="input-group">
	             	 <input type="text" class="form-control" placeholder="�������̸�"  name="receiverName">
	                <span class="input-group-addon"><i class="fa fa-user"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <input type="text" class="form-control" placeholder="�����ڿ���ó"  name="receiverPhone">
	                <span class="input-group-addon"><i class="fa fa-phone"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <input type="text" class="form-control" placeholder="�������ּ�"  name="divyAddr">
	                <span class="input-group-addon"><i class="fa fa-home"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <input type="text" class="form-control" placeholder="���ſ�û����"  name="divyRequest">
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	                <input type="text" class="form-control"  readonly="readonly" placeholder="��������" name="divyDate" >
	                <span class="input-group-addon">
	                	<img src="../images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.detailForm.divyDate', document.detailForm.divyDate.value)" />
	                </span>
	              </div>
	              <br>      
	  
	          <div class="box-footer">
                     <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> ���</button>
              	 <div class="pull-right">
                    <button type="reset" class="btn btn-warning" ><i class="fa fa-reply"></i> ���</button>
                    <button type="button" class="btn btn-success" ><i class="fa fa-save"></i> ����</button>
                 </div>
            </div>
    
    </div>
        
 </div>   

    <%--main_footer.jsp--%>
    <%-- Main Footer --%>
    <%@ include file="../include/main_footer.jsp" %>
  </form>

</body>
</html>