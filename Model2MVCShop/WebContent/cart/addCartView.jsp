<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<html>
<head>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script type="text/javascript">

function fncAddCart() {
	
	var cartQuantity=$("input[name='cartQuantity']").val();
	
	if(cartQuantity == null || cartQuantity <1 ){
		alert("수량은 반드시 입력해야합니다!");
		return;
	}
	
	$("form").attr("method","POST").attr("action" , "/cart/addCart").submit();
	}

	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 $( "td.ct_btn01:contains('추가')" ).on("click" , function() {
			 fncAddCart();
		 });
	
		 $( "td.ct_btn01:contains('취소')" ).on("click" , function() {
			//Debug..
			history.go(-1);
		});
		 $("tr.price td:nth-child(3)").css("color", "red");
		 var prodNo = $("input[name='prodNo']").val();
		 $(".quantity").css("color", "red");
		 
		 $(".quantity").on("keyup", function() {
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
						$( "#purchasePrice").html(displayValue);
						var restQuantity = product.prodQuantity-ea;
						$( "#restQuantity").html(restQuantity);
						}
					})
		 })
					
	});	

</script>

</head>

<body>

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">장바구니추가</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<!--  hidden 값으로 넘버와 가격을 보내줍니다. -->
<input type="hidden" name="prodNo" value="${product.prodNo}" />
<input type="hidden" name="price" value="${product.price}" />

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="300" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" width="299">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105" name="prodNo" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20"  value="${product.prodNo}">${product.prodNo}</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodName}</td>
		<input	type="hidden" name="prodName" value="${product.prodName}">
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr class="quantity">
		<td width="104" class="ct_write">수량</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="cartQuantity"  id="quantity" class="quantity" style="width: 100px; height: 19px" maxLength="20" value=""/>
		남은수량(<span id="restQuantity" value="">${product.prodQuantity}</span>)<input	type="hidden" name="productQuantity" value="${product.prodQuantity}">			
		</td>
	</tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			구매자아이디 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${sessionScope.user.userId}</td>
		<input type="hidden" name="buyerId" value="${sessionScope.user.userId}" />
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						추가
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						취소
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>

</body>
</html>