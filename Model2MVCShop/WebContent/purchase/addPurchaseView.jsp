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
		alert("주소는 반드시 입력해야합니다!");
		return;
	}
	
	if(purchaseQuantity == null || purchaseQuantity <1 ){
		alert("수량은 반드시 입력해야합니다!");
		return;
	}

	if(divyDate == null || divyDate.length <1 ){
		alert("배송날짜는 반드시 입력해야 합니다!");
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
			 
			 //getProduct를 하는 Ajax를 들려온다.
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
						판매관리 <small>판매목록</small>
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> 판매</a></li>
						<li class="active">목록확인</li>
					</ol>
				</section>
	
	            <div class="box-body">
	            
	            <div class="input-group" >
	            	<input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="상품번호" value="${product.prodNo}" >
	                <input type="hidden" name="prodNo" value="${product.prodNo}" />
	                <input type="hidden" name="lat" value="${sessionScope.user.lat}" />
	                <input type="hidden" name="lng" value="${sessionScope.user.lng}" />
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	              	<input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="상품명" value="${product.prodName}" >
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	               <div class="input-group">
	              	<input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="제조일자" value="${product.manuDate}" >
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="상품상세정보" value="${product.prodDetail}" >
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	               <div class="input-group">
	             	 <input type="text" class="form-control" class="form-control"  placeholder="수량" name="purchaseQuantity"  id="quantity" class="quantity">
	             	 <input	type="hidden" name="productQuantity" value="${product.prodQuantity}">
	                <span class="input-group-addon">
	                	남은수량(<span id="restQuantity" value="">${product.prodQuantity}</span>)
	               </span>
	              </div>
	              <br>
	              
	                <div class="input-group">
	             	 <input type="text" class="form-control"  placeholder="가격" id="purchasePrice" value="" readonly="readonly">
	             	 <input	type="hidden" name="price" value="${product.price}">
	                <span class="input-group-addon"><i class="fa fa-won"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	              	<input type="text" class="form-control" class="form-control"  readonly="readonly" placeholder="구매자아이디" value="${sessionScope.user.userId}" >
	              	<input type="hidden" name="buyerId" value="${sessionScope.user.userId}" />
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <select 	name="paymentOption" class="form-control" >
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
					</select>
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	               <div class="input-group">
	             	 <input type="text" class="form-control" placeholder="구매자이름"  name="receiverName">
	                <span class="input-group-addon"><i class="fa fa-user"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <input type="text" class="form-control" placeholder="구매자연락처"  name="receiverPhone">
	                <span class="input-group-addon"><i class="fa fa-phone"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <input type="text" class="form-control" placeholder="구매자주소"  name="divyAddr">
	                <span class="input-group-addon"><i class="fa fa-home"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	             	 <input type="text" class="form-control" placeholder="구매요청사항"  name="divyRequest">
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	                <input type="text" class="form-control"  readonly="readonly" placeholder="제조일자" name="divyDate" >
	                <span class="input-group-addon">
	                	<img src="../images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.detailForm.divyDate', document.detailForm.divyDate.value)" />
	                </span>
	              </div>
	              <br>      
	  
	          <div class="box-footer">
                     <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> 목록</button>
              	 <div class="pull-right">
                    <button type="reset" class="btn btn-warning" ><i class="fa fa-reply"></i> 취소</button>
                    <button type="button" class="btn btn-success" ><i class="fa fa-save"></i> 저장</button>
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