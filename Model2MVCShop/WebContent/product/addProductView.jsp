<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html>

<%@ include file="../include/plugin_js.jsp"%>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="../javascript/calendar.js"></script>
<script type="text/javascript">

function fncAddProduct() {
	
	var name =$("input[name='prodName']").val();
	var detail =$("input[name='prodDetail']").val();
	var manuDate =$("input[name='manuDate']").val();
	var price = $("input[name='price']").val();

	if (name == null || name.length < 1) {
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if (detail == null || detail.length < 1) {
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if (manuDate == null || manuDate.length < 1) {
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if (price == null || price.length < 1) {
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}

	$("detailForm").attr("method", "POST").attr("action", "/product/addProduct").submit();
}

$(function() {
	$( "button.btn.btn-warning").on("click", function() {
		history.go(-1);
	});
});

$(function() {
	$( "button.btn.btn-success").on("click", function() {
		alert("Qwer");
		fncAddProduct();
	});
});

</script>


<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">

	<form enctype="multipart/form-data" name="detailForm">
	
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
						판매관리 <small>판매상품등록</small>
					</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> 게시판</a></li>
						<li class="active">입력</li>
					</ol>
				</section>
				
				<br/>
	
	            <div class="box-header with-border">
	            </div>
	            <div class="box-body">
	            
	            <div class="input-group">
	                <input type="text" class="form-control" class="form-control" placeholder="상품명" name="prodName">
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
				
				<div class="input-group">
	                <input type="text" class="form-control" class="form-control" placeholder="상품상세정보" name="prodDetail">
	                <span class="input-group-addon"><i class="fa fa-check"></i></span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	                <input type="text" class="form-control" readonly="readonly" placeholder="제조일자" name="manuDate" >
	                <span class="input-group-addon">
	                	<img src="../images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" />
	                </span>
	              </div>
	              <br>
	
	              <div class="input-group">
	                <span class="input-group-addon"><i class="fa fa-won"></i></span>
	                <input type="text" class="form-control" placeholder="가격"  name="price">
	                <span class="input-group-addon">원</span>
	              </div>
	              <br>
	              
	              <div class="input-group">
	                <span class="input-group-addon"><i class="fa fa-bicycle"></i></span>
	                <input type="text" class="form-control" placeholder="수량"  name="prodQuantity">
	                <span class="input-group-addon">개</span>
	              </div>
	              <br>
	
	       	 <!-- 파일업로드 부분입니다. -->
                   <div class="form-group">
    					<label for="InputFile"></label>
  						 <input type="file"  name="file" id="InputFile" >
 				  </div>
	          </div>

	          <div class="box-footer">
                     <button type="button" class="btn btn-primary"><i class="fa fa-list"></i> 목록</button>
              	 <div class="pull-right">
                    <button type="reset" class="btn btn-warning" ><i class="fa fa-reply"></i> 취소</button>
                    <button type="button" class="btn btn-success" ><i class="fa fa-save"></i> 저장</button>
                 </div>
            </div>
                
  </form>

    </div>
    <%-- /.content-wrapper --%>

    <%--main_footer.jsp--%>
    <%-- Main Footer --%>
    <%@ include file="../include/main_footer.jsp" %>

</body>
</html>