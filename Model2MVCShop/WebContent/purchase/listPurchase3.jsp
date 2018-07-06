<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<html>
<head>
<title>구매 목록조회</title>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

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
		
		$( ".ct_list_pop td:nth-child(11)" ).on("click" , function() {
			fncUpdateReview(tranNo);
		})
		
		 $( ".ct_list_pop td:nth-child(13)" ).on("click" , function() {
			 var tranNo = $("input[name='tranNo']").val();
			 alert(tranNo);
			 self.location =  "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3";
		})
		
		$( ".ct_list_pop td:nth-child(13)" ).css("color","red")
		
	});
	
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<%-- <form name="detailForm" action="/purchase/listPurchase?userId=${purchase.buyer.userId }" method="post"> --%>
<form name="detailForm">
<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="12" >전체 ${resultPage.totalCount}건수, 현재${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="50">거래번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="50">상품번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이름</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">수취인이름</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">수취인전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">정보수정</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="20" bgcolor="808285" height="1"></td>
	</tr>

	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
	<tr class="ct_list_pop">
		<td align="center">${purchase.tranNo}</td>
		<td></td>
		<td align="center">${purchase.purchaseProd.prodNo}</td>
		<td></td>
		<td align="center">${purchase.purchaseProd.prodName}</td>
		<td></td>
		<td align="center">${purchase.receiverName}</td>
		<td></td>
		<td align="center">${purchase.receiverPhone}</td>
		<td></td>
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
				* 별점주기
			</c:if> 
			</c:if>
			</td>
		<td></td>
		<td align="center">
		<c:if test="${purchase.tranCode=='2'}">
			<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}" />
			물건도착
			</c:if>	
		</td>
		<td></td>
	</tr>
		</c:forEach>
	<tr>
		<td colspan="20" bgcolor="D6D7D6" height="1"></td>
	</tr>
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->
<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>