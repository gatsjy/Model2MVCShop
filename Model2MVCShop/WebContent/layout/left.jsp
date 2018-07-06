<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>

	<link href="/css/left.css" rel="stylesheet" type="text/css">

	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	function history(){
		popWin = window.open("/history.jsp",
													  "popWin",
												  	"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}

	//==> jQuery ���� �߰��� �κ�
	$(function() {
		// ��������
		$( ".Depth03:contains('��������')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/notice/listNotice");
		});
		
		// ����������ȸ
		$( ".Depth03:contains('����������ȸ')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/user/getUser?userId=${user.userId}");
		});
		
		// ȸ��������ȸ
		$( ".Depth03:contains('ȸ��������ȸ')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/user/listUser");
		});
		
		// �ǸŻ�ǰ���
		$( ".Depth03:contains('�ǸŻ�ǰ���')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "../product/addProductView.jsp");
		});
		
		// �ǸŻ�ǰ����
		$( ".Depth03:contains('�ǸŻ�ǰ����')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listProduct?menu=manage");
		});
		
		// �ǸŸ��
		$( ".Depth03:contains('�ǸŸ��')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listSale");
		});
		
		// �� ǰ �� ��
		$( ".Depth03:contains('�� ǰ �� ��')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listProduct?menu=search");
		});
		
		// �����̷���ȸ
		$( ".Depth03:contains('�����̷���ȸ')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listPurchase");
		});
		
		// ����̷���ȸ
		$( ".Depth03:contains('����̷���ȸ')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listCancelPurchase");
		});
		
		// ��ٱ���
		$( ".Depth03:contains('��ٱ���')" ).on("click", function() {
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/cart/listCart" );
		});
		
		// �ֱ� �� ��ǰ
		$( ".Depth03:contains('�ֱ� �� ��ǰ')" ).on("click", function() {
			
			history()
		});
		
	});

</script>
</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="159" border="0" cellspacing="0" cellpadding="0">

<!--menu 01 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159" >
			<tr>
   				<td class="Depth03">
    				(�ʵ�)��������
   				</td>
  			</tr>	
			<tr>
				<c:if test="${ !empty user }">
					<tr>
						<td class="Depth03">
							����������ȸ
						</td>
					</tr>
				</c:if>
			
				<c:if test="${user.role == 'admin'}">
					<tr>
						<td class="Depth03" >
							ȸ��������ȸ
						</td>
					</tr>
				</c:if>
			
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
		</table>
	</td>
</tr>

<!--menu 02 line-->
<c:if test="${user.role == 'admin'}">
	<tr>
		<td valign="top"> 
			<table  border="0" cellspacing="0" cellpadding="0" width="159">
				<tr>
					<td class="Depth03">
						�ǸŻ�ǰ���
					</td>
				</tr>
				<tr>
					<td class="Depth03">
						�ǸŻ�ǰ����
					</td>
				</tr>
					<td class="Depth03">
     					�ǸŸ��
    				</td>
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</c:if>

<!--menu 03 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<td class="Depth03">
					�� ǰ �� ��
				</td>
			</tr>
			
			<c:if test="${ !empty user && user.role == 'user'}">
			<tr>
				<td class="Depth03">
					�����̷���ȸ
				</td>
			</tr>
			<tr>
    			<td class="Depth03">
     				����̷���ȸ
    			</td>
   			</tr>
   				<td class="Depth03">
     				��ٱ���
    			</td>
			</c:if>	
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
			
			<tr>
				<td class="Depth03">
					�ֱ� �� ��ǰ
				</td>
			</tr>
		</table>
	</td>
</tr>

</table>

</body>
</html>
