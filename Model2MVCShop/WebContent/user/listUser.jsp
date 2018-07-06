<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<title>ȸ�� ��� ��ȸ</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- ���� : http://getbootstrap.com/css/   ���� -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%--plugin_js.jsp--%>
<%@ include file="../include/plugin_js.jsp"%>
<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	//=====����Code �ּ� ó�� ��  jQuery ���� ======//
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
		//document.detailForm.submit();
		$("form").attr("method", "POST").attr("action", "/user/listUser")
				.submit();
	}
	//===========================================//
	//==> �߰��Ⱥκ� : "�˻�" ,  userId link  Event ���� �� ó��
	$(function() {

		$("button").on("click", function() {
			fncGetList(1);
		});

		$("td:nth-child(5) > i").on("click", function() {

					var userId = $(this).next().val();

					$.ajax({
						url : "/user/json/getUser/" + userId,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData, status) {

							var displayValue = "<h6>" + "���̵� : "
									+ JSONData.userId + "<br/>" + "��  �� : "
									+ JSONData.userName + "<br/>" + "�̸��� : "
									+ JSONData.email + "<br/>" + "ROLE : "
									+ JSONData.role + "<br/>" + "����� : "
									+ JSONData.regDate + "<br/>" + "</h6>";
							$("h6").remove();
							$("#" + userId + "").html(displayValue);
						}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
				});
	});

	/* 	//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		
		//==> �Ʒ��� ���� ������ ������ ??
		//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
		console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
		//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
	
		}); */
	////////////////////////////// ���� ���� �������ø�Ʈ�� ���ֱ� ���� �ڹٽ�ũ��Ʈ�Դϴ�//////////////////////////////////////
	$(function() {
		var availableTags = new Array(); //�ڹٽ�ũ��Ʈ ������ ��� ��ü�� ����� ���ؼ� �������ش�.
		$("#searchKeyword").on("click", function() { //Ŭ�������� ������ �� �ֵ��� ������ �����ش�.
			$.ajax({
				url : "/user/json/listUserAjax", //���� �ް� ���� rest������ ������ ��û�Ѵ�.
				type : "POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				dataType : "json",
				data : JSON.stringify({ //���⼭ ����! ��Ʈ��ȭ �����༭ ��������� ����ε� �����Ͱ� ���޵ȴ�.
					searchCondition : $("#searchCondition").val(),
					searchKeyword : $("#searchKeyword").val(),
				}),
				success : function(list, status) { // ���������� ������ ���� �����͵�.. ���⼭ �����ؾ� �� ���� list��� �̸����� ���ϵǴ� ���� ���� ������ ��ü�� �������ذ��̴�!
					for (var i = 0; i < list.list.length; i++) { //����Ʈ �ȿ��ִ� list��� �̸��� map�� ����ִ� ���� ������ ���ؼ� .���� �����Ѵ�.
						availableTags.push(list.list[i].userId); //list�� ũ�⸸ŭ for���� ������. �׸��� �� ����ŭ push �޼��带 ����ؼ� �迭�� �߰������ش�.
					}
				}
			});
		}) //end of keyup
		$("#searchKeyword").autocomplete({
			source : availableTags
		});
	});

	//////////////////////////////////////////////////// �������ø�Ʈ�� ���� ��ũ��Ʈ ��!!!!!!!!/////////////////////////////////////////////////////////////////////////////////////
</script>

<%--head.jsp--%>
<%@ include file="../include/head.jsp"%>

</head>

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
					ȸ����������Ʈ
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> ȸ������</a></li>
					<li class="active">ȸ��������ȸ</li>
				</ol>
			</section>
		
			<%-- Main content --%>
				<section class="content container-fluid">

					<div class="col-lg-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">�������� ���</h3>
							</div>
							<div class="col-lg-12 text-left">
								<br />
								<!-- table ���� �˻� Start /////////////////////////////////////-->

								<div class="row">

									<div class="col-lg-12 text-left">
										<p class="text-primary">��ü ${resultPage.totalCount } �Ǽ�,
											���� ${resultPage.currentPage} ������</p>
									</div>

									<div class="col-lg-12 text-right">
										<form class="form-inline" name="detailForm">

											<div class="form-group">
												<select class="form-control" name="searchCondition">
													<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>ȸ��ID</option>
													<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>ȸ����</option>
												</select>
											</div>

											<div class="form-group">
												<label class="sr-only" for="searchKeyword">�˻���</label> 
													<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="�˻���"
													value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
											</div>

											<button type="button" class="btn btn-default">�˻�</button>

											<!-- PageNavigation ���� ������ ���� ������ �κ� -->
											<input type="hidden" id="currentPage" name="currentPage" value="" />

										</form>
									</div>

								</div>
								<!-- table ���� �˻� Start /////////////////////////////////////-->
							</div>
							<div class="box-body">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<th style="width: 30px">��ȣ</th>
											<th style="width: 30px">�̸�</th>
											<th style="width: 30px">ȸ�� ID</th>
											<th style="width: 50px">�̸���</th>
											<th align="left">��������</th>
										</tr>
										<c:set var="i" value="0" />
										<c:forEach var="user" items="${list}">
											<c:set var="i" value="${ i+1 }" />
											<tr>
												<td align="center" style="width: 10px">${ i }</td>
												<td align="left" title="Click : ȸ������ Ȯ��" style="width: 10px">${user.userName}</td>
												<td align="left" style="width: 20px">${user.userId}</td>
												<td align="left"  style="width: 50px">${user.email}</td>
												<td align="left"><i class="glyphicon glyphicon-ok" id="${user.userId}"></i> 
														<input type="hidden" value="${user.userId}"></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="box-footer">
								<!-- PageNavigation Start... -->
								<jsp:include page="../common/pageNavigator_new.jsp" />
								<!-- PageNavigation End... -->
						</div>
				</section>
				<%-- / content --%>
			</div>
			<%-- /.content-wrapper --%>

			<%--main_footer.jsp--%>
			<%-- Main Footer --%>
			<%@ include file="../include/main_footer.jsp"%>

		</div>

	</form>
</body>
</html>